Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263394AbTFPFpE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 01:45:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263398AbTFPFpE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 01:45:04 -0400
Received: from auth22.inet.co.th ([203.150.14.104]:57612 "EHLO
	auth22.inet.co.th") by vger.kernel.org with ESMTP id S263394AbTFPFo7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 01:44:59 -0400
From: Michael Frank <mflt1@micrologica.com.hk>
To: linux-kernel@vger.kernel.org
Subject: 2.5.71-mm1 PCMCIA Yenta socket nonfunctional
Date: Mon, 16 Jun 2003 13:58:30 +0800
User-Agent: KMail/1.5.2
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200306161343.03663.mflt1@micrologica.com.hk>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

8250_cs loaded manually. Tested with generic modem

2.5.70-mm3 is OK:

Jun 16 13:50:02 mhfl2 kernel: Linux Kernel Card Services 3.1.22
Jun 16 13:50:02 mhfl2 kernel:   options:  [pci] [cardbus] [pm]
Jun 16 13:50:02 mhfl2 kernel: Intel PCIC probe: not found.
Jun 16 13:50:02 mhfl2 kernel: PCI: Enabling device 00:12.0 (0000 -> 0002)
Jun 16 13:50:02 mhfl2 kernel: Yenta IRQ list 0000, PCI irq5
Jun 16 13:50:02 mhfl2 kernel: Socket status: 30000007
Jun 16 13:50:03 mhfl2 cardmgr[3094]: watching 1 sockets
Jun 16 13:50:03 mhfl2 kernel: cs: IO port probe 0x0c00-0x0cff: clean.
Jun 16 13:50:03 mhfl2 kernel: cs: IO port probe 0x0800-0x08ff: clean.
Jun 16 13:50:03 mhfl2 kernel: cs: IO port probe 0x0100-0x04ff: 
  excluding 0x1e0-0x1e7 0x3c0-0x3df 0x408-0x40f 0x480-0x48f 0x4d0-0x4d7
Jun 16 13:50:03 mhfl2 kernel: cs: IO port probe 0x0a00-0x0aff: clean.
Jun 16 13:50:03 mhfl2 cardmgr[3095]: starting, version is 3.2.4
Jun 16 13:50:38 mhfl2 kernel: cs: memory probe 0xa0000000-0xa0ffffff: clean.
Jun 16 13:50:38 mhfl2 cardmgr[3095]: socket 0: Serial or Modem
Jun 16 13:50:38 mhfl2 cardmgr[3095]: executing: './serial start ttyS0'
Jun 16 13:50:38 mhfl2 kernel: ttyS0 at I/O 0x3f8 (irq = 5) is a 16550A

-----
2.5.71-mm1 Problem: does not init 

2.5.71-mm1 log

Jun 16 13:00:56 mhfl2 kernel: Linux Kernel Card Services 3.1.22
Jun 16 13:00:56 mhfl2 kernel:   options:  [pci] [cardbus] [pm]
Jun 16 13:00:57 mhfl2 kernel: Intel PCIC probe: not found.
Jun 16 13:00:57 mhfl2 kernel: Intel PCIC probe: not found.
Jun 16 13:02:58 mhfl2 kernel: PCI: Enabling device 00:12.0 (0000 -> 0002)
Jun 16 13:02:59 mhfl2 kernel: Yenta IRQ list 0000, PCI irq5
Jun 16 13:02:59 mhfl2 kernel: Socket status: 30000011

Socket status after removal and insertion of pcmcia modules:

Jun 16 13:06:59 mhfl2 kernel: Yenta IRQ list 0000, PCI irq5
Jun 16 13:06:59 mhfl2 kernel: Socket status: 30000007

Removing / inserting modem or other cards increases IRQ5 
interrupts, but no further messages in log.

$ cat /proc/interrupts
           CPU0
  0:     174005          XT-PIC  timer
  1:       3082          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  4:          0          XT-PIC  KGDB-stub
  5:         14          XT-PIC  Toshiba America Info ToPIC95 PCI to Cardb
  8:          0          XT-PIC  rtc
  9:        154          XT-PIC  acpi
 10:      16123          XT-PIC  eth0
 12:      29334          XT-PIC  i8042
 14:       6984          XT-PIC  ide0
NMI:          0
LOC:          0
ERR:          0
MIS:          0

$ lsmod

Module                  Size  Used by
8250_cs                 8152  0
ds                     13008  1 8250_cs
yenta                  13068  1
pcmcia_core            69632  3 8250_cs,ds,yenta
toshiba_acpi            6564  0
e100                   67576  0

$ lspci

00:00.0 Host bridge: Transmeta Corporation LongRun Northbridge (rev 01)
00:00.1 RAM memory: Transmeta Corporation SDRAM controller
00:00.2 RAM memory: Transmeta Corporation BIOS scratchpad
00:04.0 VGA compatible controller: S3 Inc. 86C270-294 Savage/IX-MV (rev 13)
00:06.0 Multimedia audio controller: ALi Corporation M5451 PCI AC-Link Controller Audio Device (rev 01)
00:07.0 ISA bridge: ALi Corporation M1533 PCI to ISA Bridge [Aladdin IV]
00:0e.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 08)
00:10.0 IDE interface: ALi Corporation M5229 IDE (rev c3)
00:11.0 Bridge: ALi Corporation M7101 PMU
00:12.0 CardBus bridge: Toshiba America Info Systems ToPIC95 PCI to Cardbus Bridge with ZV Support (rev 32)
00:14.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03)


Regards
Michael

-- 
Powered by linux-2.5.71-mm1, compiled with gcc-2.95-3 because it's rock solid
     
My current linux related activities in rough order of priority:
- Testing of Swsusp for 2.4
- Learning 2.5 kernel debugging with kgdb - it's in the -mm tree
- Studying 2.5 serial and ide drivers, ACPI, S3

The 2.5 kernel could use your usage. More info on setting up 2.5 kernel at 
http://www.codemonkey.org.uk/post-halloween-2.5.txt

