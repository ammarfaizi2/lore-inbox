Return-Path: <linux-kernel-owner+w=401wt.eu-S964839AbWLTD3R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964839AbWLTD3R (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 22:29:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964836AbWLTD3R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 22:29:17 -0500
Received: from smtp102.sbc.mail.mud.yahoo.com ([68.142.198.201]:40921 "HELO
	smtp102.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S964835AbWLTD3R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 22:29:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=ARshs3uwXTjLqAiLOQ+Sn3ek6SrdW1oF5rzluVm8grRqjeCNIb7GUggyaAyzAsSc/bvPf5dgroyUig5lVTzm/JAF74Qrq0LcyaJcrX942jw/IFeCULRWthqjPO9WgaN5lDFF7vWja0bWPqE6OxtHkfsxLIPFhTsl1bnhieI5BDE=  ;
X-YMail-OSG: pCKgQcIVM1koCj4kYrzZKb1wf1PFT8Eg6VNG3v4yg0yUFOohc5DZ7omq1SWKMnRR6clfgalHLn5USievMr6Xu0JkA7bcF2EXEK6BdNMRen1DvHtaTod6dT.0LIgdJgZ3q0TwTxd.qk6rCgO0b0DWTH8ml1DUB5kGYIN2v4RWayfreqSS1o8p2NNd0q48
From: David Brownell <david-b@pacbell.net>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: Changes to sysfs PM layer break userspace
Date: Tue, 19 Dec 2006 19:29:13 -0800
User-Agent: KMail/1.7.1
Cc: Matthew Garrett <mjg59@srcf.ucam.org>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       gregkh@suse.de
References: <20061219185223.GA13256@srcf.ucam.org> <200612191334.49760.david-b@pacbell.net> <20061219181524.c15c02af.akpm@osdl.org>
In-Reply-To: <20061219181524.c15c02af.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612191929.14524.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 19 December 2006 6:15 pm, Andrew Morton wrote:
> On Tue, 19 Dec 2006 13:34:49 -0800
> David Brownell <david-b@pacbell.net> wrote:
> 
> > Documentation/feature-removal-schedule.txt has warned about this since
> > August
> 
> Nobody reads that.
> 
> Please, wherever possible, put a nice printk("this is going away") in the code
> when planning these things.


Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

Index: g26/drivers/base/power/sysfs.c
===================================================================
--- g26.orig/drivers/base/power/sysfs.c	2006-09-27 16:19:00.000000000 -0700
+++ g26/drivers/base/power/sysfs.c	2006-12-19 19:27:25.000000000 -0800
@@ -42,9 +42,17 @@ static ssize_t state_show(struct device 
 
 static ssize_t state_store(struct device * dev, struct device_attribute *attr, const char * buf, size_t n)
 {
+	static int warned;
 	pm_message_t state;
 	int error = -EINVAL;
 
+	if (!warned) {
+		printk(KERN_WARNING
+			"*** WARNING *** sysfs devices/.../power/state files "
+			"are only for testing, and will be removed\n");
+		warned = error;
+	}
+
 	/* disallow incomplete suspend sequences */
 	if (dev->bus && (dev->bus->suspend_late || dev->bus->resume_early))
 		return error;
