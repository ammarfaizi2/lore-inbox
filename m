Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274069AbRISOXT>; Wed, 19 Sep 2001 10:23:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274072AbRISOXJ>; Wed, 19 Sep 2001 10:23:09 -0400
Received: from lilly.ping.de ([62.72.90.2]:22287 "HELO lilly.ping.de")
	by vger.kernel.org with SMTP id <S274069AbRISOXB>;
	Wed, 19 Sep 2001 10:23:01 -0400
Date: 19 Sep 2001 15:21:02 +0200
Message-ID: <20010919152102.A3682@planetzork.spacenet>
From: jogi@planetzork.ping.de
To: "Andrea Arcangeli" <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.10-pre11: alsaplayer skiping during kernel build (-pre10 did not)
In-Reply-To: <20010918171416.A6540@planetzork.spacenet> <20010918172500.F19092@athlon.random> <20010918173515.B6698@planetzork.spacenet> <20010918174434.I19092@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20010918174434.I19092@athlon.random>; from andrea@suse.de on Tue, Sep 18, 2001 at 05:44:34PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2001 at 05:44:34PM +0200, Andrea Arcangeli wrote:
> On Tue, Sep 18, 2001 at 05:35:15PM +0200, jogi@planetzork.ping.de wrote:
> > Since I am not using md there are not that much changes left between
> > -pre10 and -pre11. Or do you think that it is caused by the console
> > locking changes?
> 
> certainly not from the console locking changes. Can you just go back to
> pre10 and verify you don't get those skips to just to be 100% sure the
> userspace config is the same?
> 
> The only scheduler change in pre11 is this one:
> 
> 	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.10pre10aa1/00_sched-rt-fix-1
> 
> which should be infact a bugfix for rt threads, also discussed on l-k
> recently, so it's not clear how this odd regression happened.
> 
> You can try to back it out and see if helps just in case.

Hello Andrea,

I backed out this patch and it did not help. But I checked with top
and alsaplayer is in status D and hanging in waitchannel wait_on_p
(probably wait_on_paige). Furthermore there are lots of other processes
waiting in wait_on_p and wait_on_b. Since the problem might be I/O
related here is the output of hdparm /dev/hda:

/dev/hda:
 multcount    = 16 (on)
 I/O support  =  1 (32-bit)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 3165/255/63, sectors = 50859648, start = 0

dmesg:

Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
    ide0: BM-DMA at 0xa400-0xa407, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xa408-0xa40f, BIOS settings: hdc:DMA, hdd:pio
hda: QUANTUM FIREBALLlct08 26, ATA DISK drive
hdc: QUANTUM FIREBALL CR13.0A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 50859648 sectors (26040 MB) w/418KiB Cache, CHS=3165/255/63, (U)DMA
hdc: 25429824 sectors (13020 MB) w/418KiB Cache, CHS=25228/16/63, (U)DMA
Partition check:
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 >
 hdc: [PTBL] [1582/255/63] hdc1 hdc2 hdc3 hdc4 < hdc5 hdc6 >

mount:

/dev/hda3 on / type ext2 (rw,errors=remount-ro,errors=remount-ro)
proc on /proc type proc (rw)
devpts on /dev/pts type devpts (rw,gid=5,mode=620)
/dev/hda2 on /boot type ext2 (ro)
/dev/hda5 on /var type reiserfs (rw)
/dev/hda6 on /usr type reiserfs (rw)
/dev/hda7 on /home type reiserfs (rw)

Hope this helps. If you need further testing just let me know.


Regards,

  Jogi

-- 

Well, yeah ... I suppose there's no point in getting greedy, is there?

    << Calvin & Hobbes >>
