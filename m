Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262151AbTHaQQi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 12:16:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262341AbTHaQQi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 12:16:38 -0400
Received: from pasky.ji.cz ([213.226.226.138]:52731 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262151AbTHaQQg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 12:16:36 -0400
Date: Sun, 31 Aug 2003 18:16:34 +0200
From: Petr Baudis <pasky@ucw.cz>
To: andre@linux-ide.org
Cc: linux-kernel@vger.kernel.org
Subject: IDE DMA breakage w/ 2.4.21+ and 2.6.0-test4(-mm4)
Message-ID: <20030831161634.GA695@pasky.ji.cz>
Mail-Followup-To: andre@linux-ide.org, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

  when upgrading from 2.4.20 to 2.4.22, I hit a strange problem - the machine
mysteriously freezed (totally, interrupts blocked) in few seconds when I tried
to do anything with the soundcard. It turned out to be a DMA conflict between
soundcard and disk, since it disappears when I disable the (now defaultly on)
DMA-by-default IDE option.

  The IDE driver smells the hardware as:

Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 00:07.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686a (rev 1b) IDE UDMA66 controller on pci00:07.1
    ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:pio, hdd:DMA
hda: C/H/S=1024/16/255 from BIOS ignored
hda: IC35L040AVER07-0, ATA DISK drive
hdd: SAMSUNG CD-R/RW DRIVE SW-224B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 80418240 sectors (41174 MB) w/1916KiB Cache, CHS=79780/16/63
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 < p5 p6 p7 p8 p9 p10 p11 >

  The option help mentions that this is gonna happen if I have VIA VP2 chipset,
however I think I have VP3 :

    Host bridge: VIA Technologies, Inc. VT82C597 [Apollo VP3] (rev 4).
      Master Capable.  Latency=16.
      Prefetchable 32 bit memory at 0xd8000000 [0xdfffffff].
  Bus  0, device   1, function  0:
    PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x AGP] (rev 0).
      Master Capable.  No bursts.  Min Gnt=12.
  Bus  0, device   7, function  0:
    ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 27).
  Bus  0, device   7, function  1:
    IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 6).
      Master Capable.  Latency=32.
      I/O at 0xd000 [0xd00f].

  So apparently this is still not fixed in VP3, I think it should be mentioned
in the option help (together with reflecting that this is on by default now),
especially as VP3 IMHO isn't that uncommon. If you don't want to bother with
doing this, I can make the patch. Just FYI.

  Kind regards,

-- 
 
				Petr "Pasky" Baudis
.
Perfection is reached, not when there is no longer anything to add, but when
there is no longer anything to take away.
	-- Antoine de Saint-Exupery
.
Stuff: http://pasky.ji.cz/
