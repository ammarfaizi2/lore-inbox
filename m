Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263636AbTLSUh5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 15:37:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263620AbTLSUh5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 15:37:57 -0500
Received: from linux.us.dell.com ([143.166.224.162]:2993 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S263609AbTLSUhx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 15:37:53 -0500
Date: Fri, 19 Dec 2003 14:37:49 -0600
From: Matt Domsch <Matt_Domsch@dell.com>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [RFC] 2.6.0 EDD enhancements
Message-ID: <20031219143749.A8351@lists.us.dell.com>
References: <Pine.LNX.4.44.0312191254550.2465-100000@humbolt.us.dell.com> <20031219130129.B6530@lists.us.dell.com> <1071865401.1943.31.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1071865401.1943.31.camel@mulgrave>; from James.Bottomley@steeleye.com on Fri, Dec 19, 2003 at 03:23:21PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This is a bit nasty...you're assuming a lot of hidden knowledge about
> the layout of sysfs objects in scsi_device in this code.
> 
> The current(*) way you should be doing this is to use scsi_device_get()
> in your edd_match_scsi_dev() and do a scsi_device_put() after creating
> the link...that should be hotplug robust.

Ok, I'll gladly make that change, but I still need a handle on the
sdev_gendev.kobj in order to make the symlink:

>  			rc = sysfs_create_link(&edev->kobj,
> 					       &sdev->sdev_gendev.kobj,
>  					       "disc");

While there's an accessor function to_scsi_device() to go from the
struct device to the struct scsi_device, there's not accessor to go from the
scsi_device to the struct device, which would further abstract
struct internals.  Can I get such added to a SCSI header file?
Something like:

static inline struct device *
sdev_to_gendev(struct scsi_device *sdev)
{
    return &sdev->sdev_gendev;
}


Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
