Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273738AbRIQWjn>; Mon, 17 Sep 2001 18:39:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273731AbRIQWj1>; Mon, 17 Sep 2001 18:39:27 -0400
Received: from smtp8.us.dell.com ([143.166.224.234]:13329 "EHLO
	smtp8.us.dell.com") by vger.kernel.org with ESMTP
	id <S273736AbRIQWjN>; Mon, 17 Sep 2001 18:39:13 -0400
Date: Mon, 17 Sep 2001 17:39:37 -0500 (CDT)
From: Robert Macaulay <robert_macaulay@dell.com>
X-X-Sender: <robert@ping.us.dell.com>
Reply-To: Robert Macaulay <robert_macaulay@dell.com>
To: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.9-ac10 scsi_scan broke with SPARSELUN devices( /proc/partitions
 loops)
In-Reply-To: <Pine.LNX.4.33.0109171504590.23583-100000@ping.us.dell.com>
Message-ID: <Pine.LNX.4.33.0109171737001.24019-100000@ping.us.dell.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reverting the the 2.4.9 sd.c also fixed my problem. Apparently it has 
nothing to do with the SPARSELUN in scsi_scan. 

Perhaps since my boot/root device aren't modules, my system wasn't 
affected till I loaded a disk module.

Robert

On Mon, 17 Sep 2001, Macaulay, Robert wrote:

> 
> On a clean 2.4.9ac10 kernel, with no SPARSELUN devices loaded,
> /proc/partitions lists the devices as it should. The machine is a HIMEM64
> box with 8GB of RAM, and a qlogic 2200 connected to the fibre channel
> disks.
> 
> Once the qlogicfc driver is loaded with Dell PV650f(a SPARSELUN device),
> the /proc/partitions lists the correct devices, but does so over and
> over. 
> For example, a /proc/partitions after the load, somewhat abbreviated
> 
>    8     0   17547264 sda
>    8     1      56196 sda1
>    8    16   17342660 sdb
>    8    17     103408 sdb1
>    8     0   17547264 sda
>    8     1      56196 sda1
>    8    16   17342660 sdb
>    8    17     103408 sdb1
>    .
>    .
>    .
> 
> The same results happen if we use qlogic's qla2x00 driver on this
> kernel. The driver's messages in dmesg are correct, however the block
> devices are still usable, but anything that grabs all devices(mount -a)
> will cause it to spin forever.
> 
> Thanks
> Robert Macaulay
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
> 


