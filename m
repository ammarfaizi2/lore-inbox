Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135575AbRAUMHR>; Sun, 21 Jan 2001 07:07:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131986AbRAUMHA>; Sun, 21 Jan 2001 07:07:00 -0500
Received: from zeus.kernel.org ([209.10.41.242]:33734 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S135533AbRAULyp>;
	Sun, 21 Jan 2001 06:54:45 -0500
Date: Sun, 21 Jan 2001 12:54:36 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: "David D.W. Downey" <pgpkeys@hislinuxbox.com>
Cc: P.Flinders@ftel.co.uk, powers@b2pi.com, linux-kernel@vger.kernel.org
Subject: Re: VIA chipset discussion
Message-ID: <20010121125436.A870@suse.cz>
In-Reply-To: <20010118081259.A694@suse.cz> <Pine.LNX.4.21.0101181548230.9718-100000@ns-01.hislinuxbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0101181548230.9718-100000@ns-01.hislinuxbox.com>; from pgpkeys@hislinuxbox.com on Sun, Jan 21, 2001 at 03:04:37AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 21, 2001 at 03:04:37AM -0800, David D.W. Downey wrote:
> 
> OK, currently at work so I don't have the affected system in front of
> me. I'm doing this from memory..
> 
> My apologies to those that responded to me. I've been unable to work on
> this issue for the last few days due to work.
> 
> My particular board is the MSI 694D Pro Dual processor board. It uses the
> VT82C686A chipset and the PDC20265 Promise ATA100.
> 
> I'm running dual PIII-733s with 1GB of Corsair RAM. The board, CPUs, and
> memory all run at 133MHz. The drives are 
> 
>     ide0: BM-DMA at 0xb000-0xb007, BIOS settings: hda:DMA, hdb:DMA
> hda: WDC WD153AA, ATA DISK drive
> hda: 30064608 sectors (15393 MB) w/2048KiB Cache, CHS=1871/255/63, UDMA(66)
>     ide0: BM-DMA at 0xb000-0xb007, BIOS settings: hda:DMA, hdb:DMA
> hdb: WDC WD300BB-00AUA1, ATA DISK drive
> hdb: 58633344 sectors (30020 MB) w/2048KiB Cache, CHS=3649/255/63, UDMA(66)
> Now to recap...
> Kernel command line: BOOT_IMAGE=new ro root=304 idebus=66 hdc=ignore
> ide_setup: hdc=ignore -- BAD OPTION

Don't use "idebus=66". It's wrong. If you want to force UDMA66/UDMA100,
the correct option is ide0=ata66. If you want to use idebus=, you should
use idebus=33, because that's what your PCI bus most likely operates at.

Also "hdc=ignore" doesn't work either.

>     ide1: BM-DMA at 0xb008-0xb00f, BIOS settings: hdc:DMA, hdd:pio
> hdc: SAMSUNG CD-ROM SC-148F, ATAPI CDROM drive
> hdc: ATAPI 48X CD-ROM drive, 128kB Cache, DMA
> 
> I'm experiencing consistant kernel deaths when doing any type of heavy IO
> as I stated earlier. I'm using the following as my test.
> 
> dd if=/dev/hda4 of=/tmp/testdd.img bs=1024M count=2k
> 
> It gets about 300MB into the file and pukes the kernel.

What does the 'puking' exactly do?

> I get lots of errors about disabling DMA within my logs.

Just this?

> No perosnally, I believe it's a problem with the VIA chipset
> specifically. I've seen a couple of emails regarding the same type of
> problem with various setups and the commonality is the VIA chipset. How is
> this affecting it? I'm not quite sure. (This may already have been covered
> but for the purpose of making sure that I'm not chasing numerous
> possibilities I've ignored some of them.) I **THINK** it's a problem
> specifically with the DMA support. 

The VIA chipsets are not easy to set up and the margins for error are
too thin.

> However, I do still get the kernel deaths even when using ATA33. I've
> specifically noticed that if you install mixed drives (ATA33 + ATA66 +
> ATA100) then the system will consistantly puke as well. Take out the ATA66
> drives and things stabilize for a bit then puke. I'm not sure if dropping
> an ATA33 drive on there by itself is the solution even if it does
> completely stabilize the machine. There is no reason for the ATA66 support
> not to work since it's a combined controller that I'm sure the VIA driver
> maintainer has looked at. (He emailed me but I forgot his name. Please
> accept my apologies for not remembering, no disrespect is intended.)

Me, most likely.

> Is anyone out there with as close a match to my setup as possible wish to
> help me with this? (I'm not discounting the mismatched setups, I just want
> a baseline to go from. If someone with my setup is NOT ahving trouble then
> I may need to look at something different).

-- 
Vojtech Pavlik
SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
