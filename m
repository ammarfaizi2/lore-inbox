Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261329AbVBVTFt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261329AbVBVTFt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 14:05:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261317AbVBVTFT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 14:05:19 -0500
Received: from lyle.provo.novell.com ([137.65.81.174]:56887 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S261329AbVBVTEY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 14:04:24 -0500
Date: Tue, 22 Feb 2005 11:04:12 -0800
From: Greg KH <gregkh@suse.de>
To: Malcolm Rowe <malcolm-linux@farside.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Symlink /sys/class/block to /sys/block
Message-ID: <20050222190412.GA23687@suse.de>
References: <courier.4217CBC9.000027C1@mail.farside.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <courier.4217CBC9.000027C1@mail.farside.org.uk>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 19, 2005 at 11:29:13PM +0000, Malcolm Rowe wrote:
> Greg, 
> 
> Following the discussion in [1], the attached patch creates /sys/class/block
> as a symlink to /sys/block. The patch applies to 2.6.11-rc4-bk7. 
> 
> Please cc: me on any replies - I'm not subscribed to the mailing list. 

Hm, your patch is linewrapped, and can't be applied :(

But more importantly:

> @@ -406,6 +420,7 @@
> static void disk_release(struct kobject * kobj)
> {
> 	struct gendisk *disk = to_disk(kobj);
> +	sysfs_remove_link(&class_subsys.kset.kobj, "block");
> 	kfree(disk->random);
> 	kfree(disk->part);
> 	free_disk_stats(disk); 

Did you try to remove a disk (like a usb device) and see what happens
here?  Hint, this isn't the proper place to remove the symlink...

thanks,

greg k-h
