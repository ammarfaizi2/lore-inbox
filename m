Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265550AbSKAAzV>; Thu, 31 Oct 2002 19:55:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265551AbSKAAzV>; Thu, 31 Oct 2002 19:55:21 -0500
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:5109 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP
	id <S265550AbSKAAzT>; Thu, 31 Oct 2002 19:55:19 -0500
Message-ID: <3DC1D271.5070602@attbi.com>
Date: Thu, 31 Oct 2002 17:01:37 -0800
From: Miles Lane <miles.lane@attbi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021022
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Douglas Gilbert <dougg@torque.net>, linux-kernel@vger.kernel.org
Subject: [PATCH] Re: ieee1394/sbp2.c doesn't compile in 2.5.45
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Douglas wrote:

> Adrian,
> Could you try this patch that I sent to the scsi
> list against 2.5.44-bk3.

Yes, this patch fixed the 2.5.45 compile for me.

	Miles

> --- linux/drivers/ieee1394/sbp2.h	2002-10-26 03:11:32.000000000 +1000
> +++ linux/drivers/ieee1394/sbp2.h2544bk3fix	2002-10-31 11:27:25.000000000 +1100
> @@ -552,7 +552,8 @@
>  #if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,28)
>  static int sbp2scsi_biosparam (Scsi_Disk *disk, kdev_t dev, int geom[]);
>  #else
> -static int sbp2scsi_biosparam (Scsi_Disk *disk, struct block_device *dev, int geom[]);
> +static int sbp2scsi_biosparam (struct scsi_device *sdev, 
> +			struct block_device *dev, sector_t capacy, int geom[]);
>  #endif
>  static int sbp2scsi_abort (Scsi_Cmnd *SCpnt); 
>  static int sbp2scsi_reset (Scsi_Cmnd *SCpnt); 
> --- linux/drivers/ieee1394/sbp2.c	2002-10-31 09:22:50.000000000 +1100
> +++ linux/drivers/ieee1394/sbp2.c2544bk3fix	2002-10-31 11:30:20.000000000 +1100
> @@ -3137,14 +3137,14 @@
>  /*
>   * Called by scsi stack to get bios parameters (used by fdisk, and at boot).
>   */
> -#if LINUX_VERSION_CODE > KERNEL_VERSION(2,5,44)
> +#if LINUX_VERSION_CODE > KERNEL_VERSION(2,5,43)
>  static int sbp2scsi_biosparam (struct scsi_device *sdev,
> -		struct block_device *dev, sector_t capacy, int geom[]) 
> +		struct block_device *dev, sector_t capacity, int geom[]) 
>  {
>  #else
>  static int sbp2scsi_biosparam (Scsi_Disk *disk, kdev_t dev, int geom[]) 
>  {
> -	sector_t capacy = disk->capacity;
> +	sector_t capacity = disk->capacity;
>  #endif
>  	int heads, sectors, cylinders;



