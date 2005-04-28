Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261853AbVD1HDo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261853AbVD1HDo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 03:03:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261809AbVD1HCm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 03:02:42 -0400
Received: from mail.kroah.org ([69.55.234.183]:24972 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261853AbVD1HBA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 03:01:00 -0400
Date: Thu, 28 Apr 2005 00:00:22 -0700
From: Greg KH <gregkh@suse.de>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, Greg KH <gregkh@suse.de>
Subject: Re: [PATCH 0/5] Misc driver core changes (constness)
Message-ID: <20050428070022.GC12086@kroah.com>
References: <200504260229.03866.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200504260229.03866.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2005 at 02:29:03AM -0500, Dmitry Torokhov wrote:
> Hi,
> 
> It all started when code like this:
> 
> static const char driver_name = "blah";
> static struct device_driver {
> 	.name = driver_name,
> };
> 
> would give me compiler warning about removing constness because driver
> core has "name" fields drclared simply as "char *". I think it is a good
> idea to have them as "const char *" since whoever accesses them should
> not try to change them.
> 
> 01-hotplug-use-kobject-name.patch
>   - kobject_hotplug should use kobject_name() instead of
>     accessing kobj->name directly since for objects with
>     long names it can contain garbage.
> 
> 02-sysfs-link-constness.patch
>   - make sysfs_{create|remove}_link to take const char * name.
> 
> 03-kobject-const-name.patch
>   - make kobject's name const char * since users should not
>     attempt to change it (except by calling kobject_rename).
> 
> 04-kset-name-const.patch
>   - change name() method in kset_hiotplug_ops return const char *
>     since users shoudl not try to modify returned data.
> 
> 05-driver-const-name.patch
>   - change driver's, bus's, class's and platform device's names
>     to be const char * so one can use const char *drv_name = "asdfg";
>     when initializing structures.
>     Also kill couple of whitespaces.
> 
> Please consider for inclusion.

Very nice, I've added all 5 patches to my tree, and are queued up for
after 2.6.12 is out.

thanks,

greg k-h
