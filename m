Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261894AbSI3By1>; Sun, 29 Sep 2002 21:54:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261897AbSI3By1>; Sun, 29 Sep 2002 21:54:27 -0400
Received: from kweetal.tue.nl ([131.155.2.7]:14714 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S261894AbSI3By0>;
	Sun, 29 Sep 2002 21:54:26 -0400
Date: Mon, 30 Sep 2002 03:59:48 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Jens Axboe <axboe@suse.de>
Cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
Subject: Re: 2.5.37 oopses at boot in ide_toggle_bounce
Message-ID: <20020930015948.GA18680@win.tue.nl>
References: <UTC200209211211.g8LCBcW16848.aeb@smtp.cwi.nl> <20020923074142.GB15479@suse.de> <20020923100134.GA16260@win.tue.nl> <20020923100219.GG25682@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020923100219.GG25682@suse.de>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2002 at 12:04:24PM +0200, Jens Axboe wrote:
> > On Mon, Sep 23 2002, Andries Brouwer wrote:

> > > It no longer sees my disks on an HPT366,

> > Can you send me the kernel boot log
>
> Ah hang on, please boot with this patch from Ivan.

Patch makes no difference.

Situation:
 no special kernel boot parameters concerning these disks,
 no hdparm used
 no CONFIG_BLK_DEV_HPT366

For 2.5.33:

HPT366: IDE controller on PCI bus 00 dev 48
HPT366: detected chipset, but driver not compiled in!
HPT366: chipset revision 1
HPT366: not 100%% native mode: will probe irqs later
    ide2: BM-DMA at 0x9c00-0x9c07, BIOS settings: hde:pio, hdf:pio
HPT366: IDE controller on PCI bus 00 dev 49
HPT366: chipset revision 1
HPT366: not 100%% native mode: will probe irqs later
    ide3: BM-DMA at 0xa800-0xa807, BIOS settings: hdg:pio, hdh:pio

For 2.5.38:
The string HPT does not occur in the boot log.

For 2.5.38 with CONFIG_BLK_DEV_HPT366:
 all OK at first sight, the disks mount, have not tried to stress them
 warnings in boot.log:

HPT366: chipset revision 1
HPT366: not 100%% native mode: will probe irqs later
    ide2: BM-DMA at 0x9c00-0x9c07, BIOS settings: hde:DMA, hdf:DMA
hde: Maxtor 93652U8, ATA DISK drive
hdf: Maxtor 96147H6, ATA DISK drive
hde: set_drive_speed_status: status=0x51 { DriveReady SeekComplete Error }
hde: set_drive_speed_status: error=0x04 { DriveStatusError }
hdf: set_drive_speed_status: status=0x51 { DriveReady SeekComplete Error }
hdf: set_drive_speed_status: error=0x04 { DriveStatusError }

Funny that 2.5.33 reports "BIOS settings: hde:pio, hdf:pio"
while 2.5.38 says "BIOS settings: hde:DMA, hdf:DMA".

Long ago I would get (sporadic) disk errors and fs corruption with
CONFIG_BLK_DEV_HPT366, while all worked without. Today
CONFIG_BLK_DEV_HPT366 is required, but apart from the messages quoted
I have not seen any error messages or problems. Everything works.

Precisely the same holds for 2.5.39.

Andries
