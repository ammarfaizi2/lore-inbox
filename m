Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129109AbRAaVfQ>; Wed, 31 Jan 2001 16:35:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129095AbRAaVfG>; Wed, 31 Jan 2001 16:35:06 -0500
Received: from f148.law9.hotmail.com ([64.4.9.148]:40202 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S129091AbRAaVe7>;
	Wed, 31 Jan 2001 16:34:59 -0500
X-Originating-IP: [128.2.152.56]
From: "William Knop" <w_knop@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Modules and DevFS
Date: Wed, 31 Jan 2001 16:34:53 -0500
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F148MamEWkeMEwuwi7N000015ef@hotmail.com>
X-OriginalArrivalTime: 31 Jan 2001 21:34:53.0503 (UTC) FILETIME=[A5F1FCF0:01C08BCD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I decided recently to go bleeding-edge on one of my Linux boxes and 
discovered I had a problem with module loading while using DevFS.

Correct me if I'm wrong, but DevFS only makes /dev entries when a device is 
present, and the device is not present until the module is loaded. So if I 
want to access /dev/hda and the IDE module has not been loaded yet, I will 
get a message telling me the device doesn't exist or some such instead of 
autoloading the module and being happy. Same goes for hotswap devices, 
right? I boot directly into X and have to crash out (otherwise it 
continually tries to unsuccessfully load X) so I could enable my USB mouse 
and various other devices.

I realize modularizing the entire IDE subsystem is not really good anyway, 
because every time it reloads it will rescan the bus... But what about USB? 
Suppose I don't have any IDE or USB devices, but want support so I can use 
them later. Especially in the case of USB, plugability is a must for desktop 
"home" systems.

I also have enabled the "module autoload" feature of DevFS, which 
conveniently autoloads my 3c59x driver. :)

Does the kernel only autoload modules through userspace request, or can a 
hardware request cause loading? For instance, inserting a USB peripheral 
would cause the USB chipset to signal the OS. So therefore the OS can update 
its device tables and unload the module again when it becomes inactive. This 
goes for all hot-swap devices, IMHO.

I read all the FAQs and stuff and found nothing that really addresses this, 
so here I ask if anyone has any idea as to a solution. No doubt I screwed 
something up somewhere along the line... If my kernel or XF86 config files 
are needed, I can pull 'em up and post 'em. Also, please CC responses to me 
because I'm not currently subscribed.

Thanks a bunch,
Will


Box info:
  Linux 2.4.1
  Abit M/B
  P3 550
  256MB RAM
  AGP Devices:
    Nvidia TNT2 AGP display card
  PCI Devices:
    S3Virge/VX display card
    Adaptec 3940UW SCSI card
    3Com "Boomerang" ethernet card
  ISA Devices:
    SB AWE 64 Gold ISA sound card
  IDE Drives:
    2 CDROM drives
  SCSI Drives:
    4.5 GB UW drive
_________________________________________________________________
Get your FREE download of MSN Explorer at http://explorer.msn.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
