Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267232AbSK3LdS>; Sat, 30 Nov 2002 06:33:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267234AbSK3LdS>; Sat, 30 Nov 2002 06:33:18 -0500
Received: from twister.ispgateway.de ([62.67.200.3]:54023 "HELO
	twister.ispgateway.de") by vger.kernel.org with SMTP
	id <S267232AbSK3LdQ>; Sat, 30 Nov 2002 06:33:16 -0500
Date: Sat, 30 Nov 2002 12:40:49 +0100
From: Steffen Moser <lists@steffen-moser.de>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20-ac1
Message-ID: <20021130114049.GA1735@steffen-moser.de>
Mail-Followup-To: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
References: <200211292324.gATNOQO26672@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200211292324.gATNOQO26672@devserv.devel.redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* On Fri, Nov 29, 2002 at 06:24 PM (-0500), Alan Cox wrote:

> [+ indicates stuff that went to Marcelo, o stuff that has not,
>  * indicates stuff that is merged in mainstream now, X stuff that proved
>    bad and was dropped out, - indicates stuff not relevant to the main tree]
> 
> This is the initial 2.4.20-ac merge up. This one may still have a few
> small funnies to shake out especially in the DRM updates.
> 
> Linux 2.4.20-ac1

I've just compiled "linux-2.4.20-ac1". 

It reports "DMA disabled" messages on boot for all of my IDE drives:

 |   VP_IDE: VIA vt82c686a (rev 22) IDE UDMA66 controller on pci00:07.1
 |     ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:pio
 |     ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:DMA
 | hda: WDC WD400BB-53AUA1, ATA DISK drive
 | hda: DMA disabled
 | blk: queue c02918a0, I/O limit 4095Mb (mask 0xffffffff)
 | hdc: WDC WD1000BB-00CAA0, ATA DISK drive
 | hdd: CD-540E, ATAPI CD/DVD-ROM drive
 | hdc: DMA disabled
 | blk: queue c0291d0c, I/O limit 4095Mb (mask 0xffffffff)
 | hdd: DMA disabled

However, "hdparm" reports DMA mode to be enabled for all drives:

 | pc01:~ # hdparm -d /dev/hda
 | 
 | /dev/hda:
 |  using_dma    =  1 (on)
  
 | pc01:~ # hdparm -d /dev/hdc
 | 
 | /dev/hdc:
 |  using_dma    =  1 (on)
 
 | pc01:~ # hdparm -d /dev/hdd
 | 
 | /dev/hdd:
 |  using_dma    =  1 (on)

What might be the reason for this behaviour?

SuSE's start scripts seem to activate DMA mode explicitly only for the 
CD-ROM drive ("hdd"), so I suppose that the "DMA disabled" messages the 
kernel reports for "hda" and "hdc" are not true. 

The same messages I had using "linux-2.4.20-rc4-ac1" and
"linux-2.4.20-rc2-ac3".

More information (kernel config, full dmesg output, lspci output) is 
available at:

  http://www.uni-ulm.de/~s_smoser/lkml/linux-2.4.20-ac1/

Thanks,
Steffen
