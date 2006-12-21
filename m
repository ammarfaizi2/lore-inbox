Return-Path: <linux-kernel-owner+w=401wt.eu-S1422673AbWLUDvz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422673AbWLUDvz (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 22:51:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422672AbWLUDvz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 22:51:55 -0500
Received: from smtp.osdl.org ([65.172.181.25]:35311 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422673AbWLUDvy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 22:51:54 -0500
Date: Wed, 20 Dec 2006 19:51:17 -0800
From: Andrew Morton <akpm@osdl.org>
To: David Brownell <david-b@pacbell.net>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       gregkh@suse.de
Subject: Re: Changes to sysfs PM layer break userspace
Message-Id: <20061220195117.4d12dee7.akpm@osdl.org>
In-Reply-To: <200612191929.14524.david-b@pacbell.net>
References: <20061219185223.GA13256@srcf.ucam.org>
	<200612191334.49760.david-b@pacbell.net>
	<20061219181524.c15c02af.akpm@osdl.org>
	<200612191929.14524.david-b@pacbell.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Dec 2006 19:29:13 -0800
David Brownell <david-b@pacbell.net> wrote:

> On Tuesday 19 December 2006 6:15 pm, Andrew Morton wrote:
> > On Tue, 19 Dec 2006 13:34:49 -0800
> > David Brownell <david-b@pacbell.net> wrote:
> > 
> > > Documentation/feature-removal-schedule.txt has warned about this since
> > > August
> > 
> > Nobody reads that.
> > 
> > Please, wherever possible, put a nice printk("this is going away") in the code
> > when planning these things.
> 
> 
> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> 
> Index: g26/drivers/base/power/sysfs.c
> ===================================================================
> --- g26.orig/drivers/base/power/sysfs.c	2006-09-27 16:19:00.000000000 -0700
> +++ g26/drivers/base/power/sysfs.c	2006-12-19 19:27:25.000000000 -0800
> @@ -42,9 +42,17 @@ static ssize_t state_show(struct device 
>  
>  static ssize_t state_store(struct device * dev, struct device_attribute *attr, const char * buf, size_t n)
>  {
> +	static int warned;
>  	pm_message_t state;
>  	int error = -EINVAL;
>  
> +	if (!warned) {
> +		printk(KERN_WARNING
> +			"*** WARNING *** sysfs devices/.../power/state files "
> +			"are only for testing, and will be removed\n");
> +		warned = error;
> +	}
> +
>  	/* disallow incomplete suspend sequences */
>  	if (dev->bus && (dev->bus->suspend_late || dev->bus->resume_early))
>  		return error;

Well that's not much use.  It tells people "hey, we broke it".  They
already knew that.

What we should do is to revert 047bda36150d11422b2c7bacca1df324c909c0b3 and
add a printk("hey, we'll be breaking this soon").

