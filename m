Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269752AbRH0XOp>; Mon, 27 Aug 2001 19:14:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269739AbRH0XOg>; Mon, 27 Aug 2001 19:14:36 -0400
Received: from dfw-smtpout3.email.verio.net ([129.250.36.43]:57230 "EHLO
	dfw-smtpout3.email.verio.net") by vger.kernel.org with ESMTP
	id <S269726AbRH0XO3>; Mon, 27 Aug 2001 19:14:29 -0400
Message-ID: <3B8AD463.C196B9B6@bigfoot.com>
Date: Mon, 27 Aug 2001 16:14:43 -0700
From: Tim Moore <timothymoore@bigfoot.com>
Organization: Yoyodyne Propulsion Systems, Inc.
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.2.20p9ai i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Nicholas Lee <nj.lee@plumtree.co.nz>
CC: linux-kernel@vger.kernel.org
Subject: Re: Crashing with Abit KT7, 2.2.19+ide patches
In-Reply-To: <20010827200106.A26175@cone.kiwa.co.nz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [nic@hoppa:~] dmesg | grep -i DMA
> VP_IDE: VIA vt82c686a (rev 22) IDE UDMA66 controller on pci00:07.1
>     ide0: BM-DMA at 0xec00-0xec07, BIOS settings: hda:DMA, hdb:pio
>     ide1: BM-DMA at 0xec08-0xec0f, BIOS settings: hdc:DMA, hdd:pio
> hda: ST320420A, 19458MB w/2048kB Cache, CHS=2480/255/63, UDMA(66)
> hdc: ATAPI 48X CD-ROM drive, 120kB Cache, UDMA(33)
> 
> Aug 26 13:59:05 hoppa kernel: hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> Aug 26 13:59:05 hoppa kernel: hda: dma_intr: error=0x84 { DriveStatusError BadCRC }

I've a similar machine

[15:45] abit:~ > dmesg | grep -i DMA
VP_IDE: VIA vt82c686a (rev 22) IDE UDMA66 controller on pci00:07.1
    ide0: BM-DMA at 0xe000-0xe007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xe008-0xe00f, BIOS settings: hdc:DMA, hdd:DMA
hda: IBM-DTLA-307020, 19623MB w/1916kB Cache, CHS=2501/255/63, UDMA(66)
hdc: Maxtor 32049H2, 19541MB w/2048kB Cache, CHS=39704/16/63, UDMA(66)

and have had this problem in the past.  Make sure you are using the
latest 2.2.19 ide patch (ide.2.2.19.05042001).  My problem was marginal
ATA/66 IDE cables that came with my motherboard (Abit KA7).  Other than
upgrading cables I also use kernel param 'ide0=ata66' at boot and these
.config entries:

CONFIG_M686=y
CONFIG_MTRR=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_VIA82CXXX=y

Also it could be EIDE cables too long or not fully inserted or damaged
(pinched), or an actual disk failing, or excessive heat in the box if
the disk is very hot to the touch.

rgds,
tim.

--
