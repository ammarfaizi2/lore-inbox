Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264686AbTA0XJ3>; Mon, 27 Jan 2003 18:09:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264688AbTA0XJ3>; Mon, 27 Jan 2003 18:09:29 -0500
Received: from smtp08.iddeo.es ([62.81.186.18]:28806 "EHLO smtp08.retemail.es")
	by vger.kernel.org with ESMTP id <S264686AbTA0XJ2>;
	Mon, 27 Jan 2003 18:09:28 -0500
Date: Tue, 28 Jan 2003 00:18:19 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21-pre3 kernel crash
Message-ID: <20030127231819.GA1651@werewolf.able.es>
References: <Pine.OSF.4.51.0301271632230.49659@tao.natur.cuni.cz> <3E356403.9010805@google.com> <Pine.OSF.4.51.0301271813230.57372@tao.natur.cuni.cz> <20030127192327.GD889@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20030127192327.GD889@suse.de>; from axboe@suse.de on Mon, Jan 27, 2003 at 20:23:27 +0100
X-Mailer: Balsa 2.0.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2003.01.27 Jens Axboe wrote:
> On Mon, Jan 27 2003, Martin MOKREJ? wrote:
> > On Mon, 27 Jan 2003, Ross Biro wrote:
> > 
> > > This looks like the same problem I ran into with IDE and highmem not
> > > getting along.  Try compiling your kernel with out highmem enabled and
> > > see what happenes.
> > 
> > Yes, that "fixes" it. Any "better solution"? ;-)
> > 
> > > >Trace; c024dfc1 <ide_build_sglist+181/1a0>
> > > >Trace; c024e1b4 <ide_build_dmatable+54/1a0>
> > > >Trace; c024e6df <__ide_dma_read+3f/150>
> 
> Someone completely lost the highmem capable scatterlist setup, *boggle*.
> This should fix it.
> 

Applied on top of 2.4.21-pre3-aa (no highmem), it makes my box hang on drive
detection:

PIIX4: IDE controller at PCI slot 00:07.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
hda: 

<hangs here>

normal startup says:

hda: Conner Peripherals 1080MB - CFS1081A, ATA DISK drive
hdb: TOSHIBA DVD-ROM SD-M1712, ATAPI CD/DVD-ROM drive
blk: queue 403386e0, I/O limit 4095Mb (mask 0xffffffff)
hdc: YAMAHA CRW8424E, ATAPI CD/DVD-ROM drive
hdd: IOMEGA ZIP 250 ATAPI, ATAPI FLOPPY drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
hda: task_no_data_intr: error=0x04 { DriveStatusError }
hda: 2114180 sectors (1082 MB), CHS=524/64/63, DMA

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.1 (Cooker) for i586
Linux 2.4.21-pre3-jam4 (gcc 3.2.1 (Mandrake Linux 9.1 3.2.1-4mdk))
