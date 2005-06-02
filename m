Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261449AbVFBW6z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261449AbVFBW6z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 18:58:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261160AbVFBW6z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 18:58:55 -0400
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:26048 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S261650AbVFBWuD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 18:50:03 -0400
From: Grant Coady <grant_lkml@dodo.com.au>
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
       David Brownell <david-b@pacbell.net>, Pavel Machek <pavel@ucw.cz>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel <linux-kernel@vger.kernel.org>, Mark Lord <lkml@rtr.ca>,
       David Brownell <dbrownell@users.sourceforge.net>
Subject: Re: External USB2 HDD affects speed hda
Date: Fri, 03 Jun 2005 08:49:42 +1000
Organization: <http://scatter.mine.nu/>
Message-ID: <ki1v9196ga4hbeif05unuq5f29ohg5fcnc@4ax.com>
References: <429BA001.2030405@keyaccess.nl> <20050601081810.GA23114@elf.ucw.cz> <429DFD90.10802@keyaccess.nl> <200506011240.09540.david-b@pacbell.net> <429E3338.9000401@keyaccess.nl> <20050602135737.GO23621@csclub.uwaterloo.ca> <429F0570.1090004@keyaccess.nl>
In-Reply-To: <429F0570.1090004@keyaccess.nl>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 02 Jun 2005 15:11:12 +0200, Rene Herman <rene.herman@keyaccess.nl> wrote:
>
>In fact, anyone who could do the same would be much welcome. Certainly 
>with the EHCI controller on a PCI card, and even more certainly with a 
>VIA VT6212 EHCI controller on a PCI card.

Not quite what you asked, following is with 6GB laptop HDD in USB 
enclosure on /dev/sdb, main drive is Seagate SATA /dev/sda. 
More hardware info on http://scatter.mine.nu/test/boxen/sempro/ 
 includes an lspci -v, mobo, CPU, HDD info

nVidia driver not loaded, box running headless to ssh terminal.
USB optical mouse only other device plugged in
USB drive plugged in prior to reboot both times

Summary: interrupts being lost on latest?  No HDD slowdown. 
 All USB ports use IRQ18, SATA on IRQ17

More info on request.

--Grant.

stable then latest:

2.6.11.11: after many runs, plus hardware info:

root@sempro:~# cat /sys/class/usb_host/usb1/registers
bus pci, device 0000:00:10.4 (driver 10 Dec 2004)
EHCI 1.00, hcd state 1
structural params 0x00004208
capability params 0x00006872
status a008 Async Recl FLR
command 010009 (park)=0 ithresh=1 period=256 RUN
intrenable 37 IAA FATAL PCD ERR INT
uframe 02c2
port 1 status 003402 POWER OWNER sig=k  CSC
port 2 status 001000 POWER sig=se0
port 3 status 001000 POWER sig=se0
port 4 status 001000 POWER sig=se0
port 5 status 001005 POWER sig=se0  PE CONNECT
port 6 status 001000 POWER sig=se0
port 7 status 001000 POWER sig=se0
port 8 status 001000 POWER sig=se0
irq normal 5470 err 0 reclaim 3645 (lost 0)
complete 5904 unlink 0
root@sempro:~# hdparm -Tt /dev/sda

/dev/sda:
 Timing cached reads:   1160 MB in  2.01 seconds = 578.35 MB/sec
HDIO_DRIVE_CMD(null) (wait for flush complete) failed: Inappropriate ioctl for device
 Timing buffered disk reads:  170 MB in  3.01 seconds =  56.51 MB/sec
HDIO_DRIVE_CMD(null) (wait for flush complete) failed: Inappropriate ioctl for device
root@sempro:~# hdparm -Tt /dev/sdb

/dev/sdb:
 Timing cached reads:   1172 MB in  2.00 seconds = 584.63 MB/sec
 Timing buffered disk reads:   26 MB in  3.17 seconds =   8.21 MB/sec

root@sempro:~# lspci
00:00.0 Host bridge: VIA Technologies, Inc. VT8378 [KM400/A] Chipset Host Bridge
00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI Bridge
00:0f.0 RAID bus controller: VIA Technologies, Inc. VIA VT6420 SATA RAID Controller (rev 80)
00:0f.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81)
00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81)
00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81)
00:10.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81)
00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86)
00:11.0 ISA bridge: VIA Technologies, Inc. VT8237 ISA bridge [KT600/K8T800/K8T890 South]
00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235/8237 AC97 Audio Controller (rev 60)
00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 78)
01:00.0 VGA compatible controller: nVidia Corporation NV18 [GeForce4 MX 440 AGP 8x] (rev a2)

root@sempro:~# lsmod
Module                  Size  Used by
w83627hf               28456  0
i2c_sensor              2944  1 w83627hf
usb_storage            41024  0
via_agp                 7552  1
agpgart                28456  1 via_agp
ide_floppy             16704  0
root@sempro:~#

2.6.12-rc5-mm2a third run

/dev/sda:
 Timing cached reads:   1096 MB in  2.00 seconds = 546.87 MB/sec
HDIO_DRIVE_CMD(null) (wait for flush complete) failed: Inappropriate ioctl for device
 Timing buffered disk reads:  172 MB in  3.03 seconds =  56.72 MB/sec
HDIO_DRIVE_CMD(null) (wait for flush complete) failed: Inappropriate ioctl for device
root@sempro:~# hdparm -tT /dev/sdb

/dev/sdb:
 Timing cached reads:   1224 MB in  2.00 seconds = 610.74 MB/sec
 Timing buffered disk reads:   26 MB in  3.16 seconds =   8.23 MB/sec
root@sempro:~# cat /sys/class/usb_host/usb1/registers
bus pci, device 0000:00:10.4 (driver 10 Dec 2004)
VIA Technologies, Inc. USB 2.0
EHCI 1.00, hcd state 1
ownership 01000001 linux
SMI sts/enable 0xe0080000
structural params 0x00004208
capability params 0x00006872
status 0008 FLR
command 010009 (park)=0 ithresh=1 period=256 RUN
intrenable 37 IAA FATAL PCD ERR INT
uframe 2365
port 1 status 003402 POWER OWNER sig=k CSC
port 2 status 001000 POWER sig=se0
port 3 status 001000 POWER sig=se0
port 4 status 001000 POWER sig=se0
port 5 status 001005 POWER sig=se0 PE CONNECT
port 6 status 001000 POWER sig=se0
port 7 status 001000 POWER sig=se0
port 8 status 001000 POWER sig=se0
irq normal 8184 err 0 reclaim 5387 (lost 82)
complete 8785 unlink 0
root@sempro:~# uname -a
Linux sempro 2.6.12-rc5-mm2a #5 Fri Jun 3 08:14:01 EST 2005 i686 unknown unknown GNU/Linux
root@sempro:~# cat /proc/interrupts
           CPU0
  0:     242764    IO-APIC-edge  timer
  1:         20    IO-APIC-edge  i8042
  8:          1    IO-APIC-edge  rtc
  9:          0   IO-APIC-level  acpi
 14:         13    IO-APIC-edge  ide0
 15:         68    IO-APIC-edge  ide1
 16:        744   IO-APIC-level  eth0
 17:       7441   IO-APIC-level  libata
 18:      13314   IO-APIC-level  ehci_hcd:usb1, uhci_hcd:usb2, uhci_hcd:usb3, uhci_hcd:usb4, uhci_hcd:usb5
 19:          0   IO-APIC-level  VIA8237
NMI:          0
LOC:     242657
ERR:          0
MIS:          0

#end :o)

