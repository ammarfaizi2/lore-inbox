Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752343AbWFMHrm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752343AbWFMHrm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 03:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752346AbWFMHrm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 03:47:42 -0400
Received: from 62-99-178-133.static.adsl-line.inode.at ([62.99.178.133]:4752
	"HELO office-m.at") by vger.kernel.org with SMTP id S1752343AbWFMHrm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 03:47:42 -0400
In-Reply-To: <Pine.LNX.4.61.0606122105490.27755@yvahk01.tjqt.qr>
References: <0CB396BB-A11B-4191-982F-8C0B89F848D6@office-m.at> <Pine.LNX.4.61.0606122003190.7959@yvahk01.tjqt.qr> <6988083B-3A0E-41F2-A1E4-B4A953B88705@office-m.at> <Pine.LNX.4.61.0606122105490.27755@yvahk01.tjqt.qr>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <2F9A5649-92B3-439A-83E4-39FC6C5B7BB7@office-m.at>
Cc: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Markus Biermaier <mbier@office-m.at>
Subject: Re: Can't Mount CF-Card on boot of 2.6.15 Kernel on EPIA - VFS: Cannot open root device
Date: Tue, 13 Jun 2006 09:47:39 +0200
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
X-Mailer: Apple Mail (2.750)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Am 12.06.2006 um 21:09 schrieb Jan Engelhardt:

> Hm. Maybe http://lkml.org/lkml/2005/2/26/92 (updated version for
> 2.6.16/.17 below) can help you.
>
> diff --fast -Ndpru linux-2.6.17-rc6~/block/genhd.c linux-2.6.17-rc6 
> +/block/genhd.c
> --- linux-2.6.17-rc6~/block/genhd.c	2006-06-06 02:57:02.000000000  
> +0200
> +++ linux-2.6.17-rc6+/block/genhd.c	2006-06-08 22:29:16.607058000  
> +0200
> @@ -214,6 +214,52 @@ struct gendisk *get_gendisk(dev_t dev, i
>  	return  kobj ? to_disk(kobj) : NULL;
>  }
>
> +/*
> + * printk a full list of all partitions - intended for
> + * places where the root filesystem can't be mounted and thus
> + * to give the victim some idea of what went wrong
> + */
> +void printk_all_partitions(void)
> +{
[snip]

Am 13.06.2006 um 08:44 schrieb Markus Biermaier:
> make targz-pkg
> block/genhd.c: In function `printk_all_partitions':
> block/genhd.c:240: Warnung: implicit declaration of function  
> `mutex_lock'
> block/genhd.c:240: error: `block_subsys_lock' undeclared (first use  
> in this function)
> block/genhd.c:240: error: (Each undeclared identifier is reported  
> only once
> block/genhd.c:240: error: for each function it appears in.)
> block/genhd.c:273: Warnung: implicit declaration of function  
> `mutex_unlock'
> make[3]: *** [block/genhd.o] Error 1
> make[2]: *** [block] Error 2
> make[1]: *** [targz-pkg] Error 2
> make: *** [targz-pkg] Error 2

Hello Jan,

to get the function "printk_all_partitions" compiled I simply  
commented out "mutex_lock" and "mutex_unlock"...

So the result before the boot-panic is:

...
here are the partitions available:
2100     500472 hde driver: ide-disk
   2101     500440 hde1
...
What does this mean?

Markus

