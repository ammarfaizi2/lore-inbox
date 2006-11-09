Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424277AbWKIXmN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424277AbWKIXmN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 18:42:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424261AbWKIXlp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 18:41:45 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:52040 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1424259AbWKIXjs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 18:39:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PyP1MXo/gxvpYTx8G1IeVkyfo11gPVto+Xnk7zGp2AlWUq80fSETibAqqusqYds/oGyQ6hInOkxUDJJyB79mVAKr8t4XHCGORJIQ06jw6n8ZAxsv+pUXuTmhDCd2pFqlEipK6NIQ/o89ny/9vjm31Cm0pQ9aOlbZ4pJ1ovGKUhQ=
Message-ID: <f56c1ba00611091539n1d1cbe99obdb1c5f608646c96@mail.gmail.com>
Date: Fri, 10 Nov 2006 00:39:46 +0100
From: "=?ISO-8859-1?Q?C=E9dric_Augonnet?=" <cedric.augonnet@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: [linux-usb-devel] 2.6.19-rc5-mm1
Cc: "Alan Stern" <stern@rowland.harvard.edu>,
       "Benoit Boissinot" <bboissin@gmail.com>,
       "Mattia Dongili" <malattia@linux.it>,
       "USB development list" <linux-usb-devel@lists.sourceforge.net>,
       "Kernel development list" <linux-kernel@vger.kernel.org>,
       "SCSI development list" <linux-scsi@vger.kernel.org>
In-Reply-To: <20061109145100.01d6ec46.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <20061109192658.GA2560@inferi.kami.home>
	 <Pine.LNX.4.44L0.0611091655080.2262-100000@iolanthe.rowland.org>
	 <20061109145100.01d6ec46.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2006/11/9, Andrew Morton <akpm@osdl.org>:

>
> hm.  Maybe it's the disk_sysfs_symlinks() changes.
>
> Could someone who can reproduce this please try this revert, on
> 2.6.19-rc2-mm2 through 2.6.19-rc5-mm1?
>
>
>
>  fs/partitions/check.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
>
> diff -puN fs/partitions/check.c~revert-fix-ide-cs-hang-after-device-removal fs/partitions/check.c
> --- a/fs/partitions/check.c~revert-fix-ide-cs-hang-after-device-removal
> +++ a/fs/partitions/check.c
> @@ -416,7 +416,7 @@ static char *make_block_name(struct gend
>
>  static int disk_sysfs_symlinks(struct gendisk *disk)
>  {
> -       struct device *target = disk->driverfs_dev;
> +       struct device *target = get_device(disk->driverfs_dev);
>         int err;
>         char *disk_name = NULL;
>
> @@ -452,8 +452,9 @@ err_out_dev_link:
>                 sysfs_remove_link(&disk->kobj, "device");
>  err_out_disk_name:
>                 kfree(disk_name);
> -       }
>  err_out:
> +               put_device(target);
> +       }
>         return err;
>  }
>
> _
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

Hi,

This patch seems to be working : whereas i had the same oops as Mattia
each time I unplugged my USB external DD drive, now it does not happen
anymore.
Thank you very much for this one !

Best regards,
Cédric
