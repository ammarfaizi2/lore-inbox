Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314596AbSDTJRQ>; Sat, 20 Apr 2002 05:17:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314598AbSDTJRP>; Sat, 20 Apr 2002 05:17:15 -0400
Received: from m206-234.dsl.tsoft.com ([198.144.206.234]:42139 "EHLO
	jojda.2y.net") by vger.kernel.org with ESMTP id <S314596AbSDTJRO>;
	Sat, 20 Apr 2002 05:17:14 -0400
Message-ID: <3CC13217.192D8D5F@bigfoot.com>
Date: Sat, 20 Apr 2002 02:17:11 -0700
From: Erik Steffl <steffl@bigfoot.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en, sk, ru
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: hdc: lost interrupt (only when ripping audio cd)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  I have a problem with cdrom burner, everything works except of ripping
audio cds - whenever I run some ripping program (I tried cdparanoia and
cdda2wav) I get the lost interrupt messages and it rips VERY slowly
(hours per song).

  here's the detailed info:

  system:

    hdc: TDK CDRW321040B, ATAPI CD/DVD-ROM drive
    Linux jojda 2.4.17 #1 Wed Mar 13 01:33:28 PST 2002 i686 unknown
    debian unstable
    VIA Technologies, Inc. VT82C693A/694x (abit)
    kernel config: CONFIG_BLK_DEV_VIA82CXXX=y
    dma access both on and off (same problem)
    32 bit access both on and off (same problem)

  the cdrom is a cd r/rw writer

  further testing (counter in ide-cd.c) showed that approximately 30-100
reads are OK, then one failure, 30-100 good reads, one failure (the
number of successfull reads fluctuates).

  as far as I can tell everything else works: burning cds, reading data
cds, playing audio cds. none of these activities have any influence on
ripping (and vice versa).

  another cdrom (reader only) on same ide (hdc) exhibits same symptoms,
HD on the same ide (hdc) works with no problems.

  I don't see any irq conflict... as long as it's data cd the count of
interrupts in /proc/interrupts goes up (so the interrupt is working fine
for data cd).

  BTW cd ripping works fine under windows, even though I've read that it
doesn't mean much because windows often pools hw instead of using IRQ.

  searching the web and kernel mailing list archives reveals that:

  - early 2.4.x kernels had some problems with ide and via motherboards
(different from the problem I have) - could this be some remnant of the
same problem?

  - there was one email that seemed to be relevant, there's no further
info on it though:

> From: Jens Axboe (axboe@image.dk)
...
> Does you drive otherwise work, except for the CDDA ripping?
> I might have a possible fix for this.

  in response to a problem somewhat similar to mine. the given thread
does not reveal any solution to a problem apart from the hint of hope
quoted above (Jens, are you listening?)

  any pointers as to what might be wrong and how to fix it?

  TIA

  here's info from /proc/interrupts and lspci, not sure what else might
be relevant:

jojda:/home/erik# cat /proc/interrupts 
           CPU0       
  0:   15518706          XT-PIC  timer
  1:       8968          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  5:          0          XT-PIC  SoundBlaster
  8:          1          XT-PIC  rtc
  9:          0          XT-PIC  usb-uhci, usb-uhci
 10:      33210          XT-PIC  eth1
 11:     530613          XT-PIC  eth0
 12:      39386          XT-PIC  PS/2 Mouse
 14:     593071          XT-PIC  ide0
 15:         21          XT-PIC  ide1
NMI:          0 
LOC:   15518583 
ERR:          0

  here's what lspci says:

jojda:/home/erik# lspci
00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo
PRO133x] (rev c4)
00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo
MVP3/Pro133x AGP]
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South]
(rev 40)
00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)
00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16)00:07.3
USB Controller: VIA Technologies, Inc. UHCI USB (rev 16)
00:07.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
(rev 40)
00:0b.0 Ethernet controller: D-Link System Inc RTL8139 Ethernet (rev 10)
00:0d.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139
(rev 10)
00:0f.0 VGA compatible controller: 3Dfx Interactive, Inc. Voodoo 3 (rev
01)
jojda:/home/erik# 

	erik
