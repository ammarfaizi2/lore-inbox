Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269778AbRH0Xsx>; Mon, 27 Aug 2001 19:48:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269779AbRH0Xso>; Mon, 27 Aug 2001 19:48:44 -0400
Received: from 203-79-82-83.adsl-wns.paradise.net.nz ([203.79.82.83]:21991
	"HELO volcano.plumtree.co.nz") by vger.kernel.org with SMTP
	id <S269778AbRH0Xsf>; Mon, 27 Aug 2001 19:48:35 -0400
Date: Tue, 28 Aug 2001 11:48:44 +1200
From: Nicholas Lee <nj.lee@plumtree.co.nz>
To: Tim Moore <timothymoore@bigfoot.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Crashing with Abit KT7, 2.2.19+ide patches
Message-ID: <20010828114843.B28423@cone.kiwa.co.nz>
Mail-Followup-To: Nicholas Lee <nj.lee@plumtree.co.nz>,
	Tim Moore <timothymoore@bigfoot.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20010827200106.A26175@cone.kiwa.co.nz> <3B8AD463.C196B9B6@bigfoot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B8AD463.C196B9B6@bigfoot.com>; from timothymoore@bigfoot.com on Mon, Aug 27, 2001 at 04:14:43PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2001 at 04:14:43PM -0700, Tim Moore wrote:
> > [nic@hoppa:~] dmesg | grep -i DMA
> > VP_IDE: VIA vt82c686a (rev 22) IDE UDMA66 controller on pci00:07.1
> >     ide0: BM-DMA at 0xec00-0xec07, BIOS settings: hda:DMA, hdb:pio
> >     ide1: BM-DMA at 0xec08-0xec0f, BIOS settings: hdc:DMA, hdd:pio
> > hda: ST320420A, 19458MB w/2048kB Cache, CHS=2480/255/63, UDMA(66)
> > hdc: ATAPI 48X CD-ROM drive, 120kB Cache, UDMA(33)
> > 
> > Aug 26 13:59:05 hoppa kernel: hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> > Aug 26 13:59:05 hoppa kernel: hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> 
> I've a similar machine
> 
> [15:45] abit:~ > dmesg | grep -i DMA
> VP_IDE: VIA vt82c686a (rev 22) IDE UDMA66 controller on pci00:07.1
>     ide0: BM-DMA at 0xe000-0xe007, BIOS settings: hda:DMA, hdb:DMA
>     ide1: BM-DMA at 0xe008-0xe00f, BIOS settings: hdc:DMA, hdd:DMA
> hda: IBM-DTLA-307020, 19623MB w/1916kB Cache, CHS=2501/255/63, UDMA(66)
> hdc: Maxtor 32049H2, 19541MB w/2048kB Cache, CHS=39704/16/63, UDMA(66)
> 
> and have had this problem in the past.  Make sure you are using the
> latest 2.2.19 ide patch (ide.2.2.19.05042001).  My problem was marginal


[nic@hoppa:~] ls -l ide.2.2.19.05042001.patch 
-rw-r--r--    1 nic      nic        240676 Aug 15 18:22 ide.2.2.19.05042001.patch


Hmm, I should have looked "in" this patch before:


+Use multi-mode by default
+CONFIG_IDEDISK_MULTI_MODE
+  If you get this error, try to enable this option.
+
+  hda: set_multmode: status=0x51 { DriveReady SeekComplete Error }
+  hda: set_multmode: error=0x04 { DriveStatusError }
+
+  If in doubt, say N.
+

Not sure if that will help though as the error messages I;'ve been
seeing are different:

Aug 28 08:55:00 hoppa kernel: hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Aug 28 08:55:00 hoppa kernel: hda: dma_intr: error=0x84 { DriveStatusError BadCRC }

No mention of set_multmode.  Looks more like a DMA interrupt (dma_intr) error.



> ATA/66 IDE cables that came with my motherboard (Abit KA7).  Other than

It has an ATA100 cable on the HDD in question, of course that is a cable
that came with the motherboard.  

> upgrading cables I also use kernel param 'ide0=ata66' at boot and these
> .config entries:
> 
> CONFIG_M686=y
> CONFIG_MTRR=y
> CONFIG_IDEDMA_AUTO=y
> CONFIG_BLK_DEV_VIA82CXXX=y

Yep they are all set.   



> Also it could be EIDE cables too long or not fully inserted or damaged
> (pinched), or an actual disk failing, or excessive heat in the box if

I'll look at getting some new cables I guess.  I hate these sorts of
bugs, as the only way to test fixes is to risk further corruption.


> the disk is very hot to the touch.

I doubt heat would be the problem as the system is in a new case (6
months) with an extra case fan and a 300W PSU.  Last time I looked in
the bios it said the Duron 700 was running at 30C, I'm not sure I
believe that though.   Its certainly not like some of the old P5
troopers I've seen around.  One friend had the PSU and CPU fan fail on
him, almost burnt the house down before he found out,  the system keep
happly going almost to the end. 8)



Do you think that putting something like a 3wave IDE controller in the
machine will fix this?  ie. Ignoring a possible cable fault is VIA 686
southbridge really that crap.


Thanks for the help.


-- 
Nicholas Lee - nj.lee at plumtree.co dot nz, somewhere on the fish Maui caught.

                         Quixotic Eccentricity

