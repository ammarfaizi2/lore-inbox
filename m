Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261746AbSJIBBV>; Tue, 8 Oct 2002 21:01:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261740AbSJIBAO>; Tue, 8 Oct 2002 21:00:14 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:681 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261676AbSJIA7M>;
	Tue, 8 Oct 2002 20:59:12 -0400
Date: Tue, 8 Oct 2002 21:04:52 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Patrick Mochel <mochel@osdl.org>
cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [bk/patch] driver model update: device_unregister()
In-Reply-To: <Pine.LNX.4.44.0210081757340.16276-100000@cherise.pdx.osdl.net>
Message-ID: <Pine.GSO.4.21.0210082102440.5897-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 8 Oct 2002, Patrick Mochel wrote:

> 
> ChangeSet@1.600, 2002-10-08 17:32:17-07:00, mochel@osdl.org
>   IDE: call device_unregister() instead of put_device() in ide-disk->cleanup().
> 
> diff -Nru a/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
> --- a/drivers/ide/ide-disk.c	Tue Oct  8 17:55:17 2002
> +++ b/drivers/ide/ide-disk.c	Tue Oct  8 17:55:17 2002
> @@ -1692,7 +1692,7 @@
>  {
>  	struct gendisk *g = drive->disk;
>  
> -	put_device(&drive->disk->disk_dev);
> +	device_unregister(&drive->disk->disk_dev);


While you are at it, _please_, take it into ide_drive.  ->disk_dev is
handled by parititions/check.c; please don't overload it.

