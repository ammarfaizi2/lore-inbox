Return-Path: <linux-kernel-owner+w=401wt.eu-S1751034AbXAIEYH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751034AbXAIEYH (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 23:24:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751040AbXAIEYH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 23:24:07 -0500
Received: from smtp.osdl.org ([65.172.181.24]:39749 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751034AbXAIEYG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 23:24:06 -0500
Date: Mon, 8 Jan 2007 20:23:59 -0800
From: Andrew Morton <akpm@osdl.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg KH <greg@kroah.com>, Kay Sievers <kay.sievers@novell.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Driver core: fix refcounting bug
Message-Id: <20070108202359.1e7a6670.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0701081103530.4249-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.0701081103530.4249-100000@iolanthe.rowland.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Jan 2007 11:06:44 -0500 (EST)
Alan Stern <stern@rowland.harvard.edu> wrote:

> This patch (as832) fixes a newly-introduced bug in the driver core.
> When a kobject is assigned to a kset, it must acquire a reference to
> the kset.
> 
> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> 
> ---
> 
> The bug was introduced in Kay's "unify /sys/class and /sys/bus at 
> /sys/subsystem" patch.
> 
> I left the assignment of class_dev->kobj.parent as it was, although it is 
> not needed.  The following call to kobject_add() will end up doing the 
> same thing.
> 
> Alan Stern
> 
> P.S.: Tracking down refcounting bugs is a real pain!  I spent an entire 
> afternoon on this one...  :-(
> 
> 
> Index: usb-2.6/drivers/base/class.c
> ===================================================================
> --- usb-2.6.orig/drivers/base/class.c
> +++ usb-2.6/drivers/base/class.c
> @@ -648,7 +648,7 @@ int class_device_add(struct class_device
>  		class_dev->kobj.parent = &parent_class_dev->kobj;
>  	else {
>  		/* assign parent kset for uevent hook */
> -		class_dev->kobj.kset = &parent_class->devices_dir;
> +		class_dev->kobj.kset = kset_get(&parent_class->devices_dir);
>  		/* the device directory in /sys/subsystem/<name>/devices */
>  		class_dev->kobj.parent = &parent_class->devices_dir.kobj;
>  	}

OK, I give up.  What kernel is this against?

More importantly: does 2.6.20-rc4 need fixing?
