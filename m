Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264454AbTE0Xur (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 19:50:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264453AbTE0Xuq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 19:50:46 -0400
Received: from toulouse-2-a7-62-147-37-133.dial.proxad.net ([62.147.37.133]:1152
	"EHLO albireo.free.fr") by vger.kernel.org with ESMTP
	id S264454AbTE0Xup (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 19:50:45 -0400
Message-Id: <200305280003.h4S03q4L000448@albireo.free.fr>
Date: Wed, 28 May 2003 02:03:52 +0200 (CEST)
From: frahm@irsamc.ups-tlse.fr
Reply-To: frahm@irsamc.ups-tlse.fr
Subject: Re: 2.4.21-rc5: DMA disabled for IDE Cdrom, works with 2.4.20
To: c-d.hailfinger.kernel.2003@gmx.net, linux-kernel@vger.kernel.org
In-Reply-To: <3ED3EA03.8070406@gmx.net>
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
>> CONFIG_IDEDMA_PCI_AUTO=y
> 
> Please disable 'Use PCI DMA by default when available'
> (CONFIG_IDEDMA_PCI_AUTO) in your kernel config, enable DMA with hdparm
> after bootup and report back.
> 
>> CONFIG_BLK_DEV_IDEDMA=y
>> CONFIG_BLK_DEV_ADMA100=y
>> CONFIG_BLK_DEV_PIIX=y
> 
> The above should fix your hangs.
> 
> 
> HTH,
> Carl-Daniel

I have now disabled "CONFIG_IDEDMA_PCI_AUTO" such that initially DMA is 
disabled for /dev/hda and /dev/hdb. I have then enabled DMA only for
/dev/hdb with hdparm (keeping DMA disabled for /dev/hda) but the problem
persists and DMA for /dev/hdb will be disabled when I try to mount a
cdrom. It seems that the DMA-setting for /dev/hda has no influence on 
this.

Actually, I forgot to mention that the dmesg-output I have put in my
former message corresponds actually to the case with both 
CONFIG_IDEDMA_PCI_AUTO and CONFIG_IDEDMA_ONLYDISK enabled such that at boot 
DMA is enabled for the harddisk but not for the CDrom and I used hdparm to 
enable it for the latter. 

Here the diff of dmesg before and after the modification:
---------------------------------------------------------
1c1
< Linux version 2.4.21-rc5 (frahm@albireo) (gcc version 3.2.2) #1 Tue May 27 22:
40:09 CEST 2003
---
> Linux version 2.4.21-rc5 (frahm@albireo) (gcc version 3.2.2) #2 Wed May 28 01:
27:23 CEST 2003
17c17
< Detected 501.146 MHz processor.
---
> Detected 501.144 MHz processor.
88d87
< blk: queue c038ec20, I/O limit 4095Mb (mask 0xffffffff)
92c91
< hda: 26564832 sectors (13601 MB) w/2048KiB Cache, CHS=1653/255/63, UDMA(33)
---
> hda: 26564832 sectors (13601 MB) w/2048KiB Cache, CHS=1653/255/63
-----------------------------------------------------

and here "dmesg | grep hd" (after modification)
-----------------------------------------------------

    ide0: BM-DMA at 0xb800-0xb807, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xb808-0xb80f, BIOS settings: hdc:pio, hdd:pio
hda: WDC WD136AA, ATA DISK drive
hdb: SONY CDU4811, ATAPI CD/DVD-ROM drive
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 26564832 sectors (13601 MB) w/2048KiB Cache, CHS=1653/255/63
hdb: attached ide-cdrom driver.
hdb: ATAPI 48X CD-ROM drive, 120kB Cache
 hda: hda1 hda2 hda3 < hda5 hda6 hda7 hda8 hda9 hda10 >
hdb: DMA interrupt recovery
hdb: lost interrupt
hdb: status timeout: status=0xd0 { Busy }
hdb: status timeout: error=0x00
hdb: DMA disabled
hdb: drive not ready for command
hdb: ATAPI reset complete


Klaus                             

e-mail : frahm@irsamc.ups-tlse.fr


