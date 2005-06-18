Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262112AbVFRNNK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262112AbVFRNNK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Jun 2005 09:13:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262113AbVFRNNK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Jun 2005 09:13:10 -0400
Received: from bay106-f18.bay106.hotmail.com ([65.54.161.27]:54664 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S262112AbVFRNMt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Jun 2005 09:12:49 -0400
Message-ID: <BAY106-F174F4C47907363D2C32C3EC8F70@phx.gbl>
X-Originating-IP: [65.54.161.200]
X-Originating-Email: [nchiellini@hotmail.com]
From: "Nicolo Chiellini" <nchiellini@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: libata + sata_sil on sil3112 dosen't work proper
Date: Sat, 18 Jun 2005 15:12:48 +0200
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
X-OriginalArrivalTime: 18 Jun 2005 13:12:48.0735 (UTC) FILETIME=[6CB56EF0:01C57407]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All

I have a problem whit a raid controller using SATA SIL 3112 chipset, when i 
try to load libata and sata_sil modules i got this proble:

root@SERVER1:~# modprobe sata_sil

Message from syslogd@SERVER1 at Sat Jun 18 14:57:08 2005 ...
SERVER1 kernel: Disabling IRQ #11

and on dmesg:

libata version 1.11 loaded.
sata_sil version 0.9
PCI: Found IRQ 11 for device 0000:02:0b.0
PCI: Sharing IRQ 11 with 0000:00:1f.4
ata1: SATA max UDMA/100 cmd 0xE1A2E080 ctl 0xE1A2E08A bmdma 0xE1A2E000 irq 
11
ata2: SATA max UDMA/100 cmd 0xE1A2E0C0 ctl 0xE1A2E0CA bmdma 0xE1A2E008 irq 
11
irq 11: nobody cared!
[<c013d15a>] __report_bad_irq+0x2a/0xa0
[<c013cb00>] handle_IRQ_event+0x30/0x70
[<c013d260>] note_interrupt+0x70/0xb0
[<c013cc50>] __do_IRQ+0x110/0x120
[<c01057c9>] do_IRQ+0x19/0x30
[<c0103b32>] common_interrupt+0x1a/0x20
[<c011e84e>] __do_softirq+0x2e/0x90
[<c011e8d6>] do_softirq+0x26/0x30
[<c011e9a5>] irq_exit+0x35/0x40
[<c01057ce>] do_IRQ+0x1e/0x30
[<c0103b32>] common_interrupt+0x1a/0x20
[<c0101030>] default_idle+0x0/0x30
[<c0101053>] default_idle+0x23/0x30
[<c01010f0>] cpu_idle+0x50/0x60
[<c059e86d>] start_kernel+0x18d/0x1d0
[<c059e3d0>] unknown_bootoption+0x0/0x1e0
handlers:
[<c03516f0>] (usb_hcd_irq+0x0/0x70)
[<c03516f0>] (usb_hcd_irq+0x0/0x70)
[<c03bed10>] (snd_intel8x0_interrupt+0x0/0x240)
[<e1a47720>] (ata_interrupt+0x0/0x130 [libata])
Disabling IRQ #11
ata1: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4063 85:7c69 86:3e01 87:4063 
88:207f
ata1: dev 0 ATA, max UDMA/133, 398297088 sectors: lba48

I've encountered this error on all 2.6.x


Some system's infos:

from sh scripts/ver_linux :

Linux SERVER1 2.6.12 #1 Sat Jun 18 14:42:16 CEST 2005 i686 unknown unknown 
GNU/Linux

Gnu C                  3.3.4
Gnu make               3.80
binutils               2.15.90.0.3
util-linux             2.12a
mount                  2.12a
module-init-tools      3.0
e2fsprogs              1.35
jfsutils               1.1.6
reiserfsprogs          3.6.17
reiser4progs           line
xfsprogs               2.6.13
pcmcia-cs              3.2.7
quota-tools            3.12.
PPP                    2.4.2
nfs-utils              1.0.6
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Linux C++ Library      5.0.6
Procps                 3.2.1
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
udev                   026
Modules Loaded         sata_sil libata ipv6 evdev

from lspci:

00:00.0 Host bridge: Intel Corp. 82845 845 (Brookdale) Chipset Host Bridge 
(rev 03)
00:01.0 PCI bridge: Intel Corp. 82845 845 (Brookdale) Chipset AGP Bridge 
(rev 03)
00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB/EB/ER Hub interface to PCI 
Bridge (rev 12)
00:1f.0 ISA bridge: Intel Corp. 82801BA ISA Bridge (LPC) (rev 12)
00:1f.1 IDE interface: Intel Corp. 82801BA IDE U100 (rev 12)
00:1f.2 USB Controller: Intel Corp. 82801BA/BAM USB (Hub #1) (rev 12)
00:1f.4 USB Controller: Intel Corp. 82801BA/BAM USB (Hub #2) (rev 12)
00:1f.5 Multimedia audio controller: Intel Corp. 82801BA/BAM AC'97 Audio 
(rev 12)
01:00.0 VGA compatible controller: ATI Technologies Inc Radeon RV100 QY 
[Radeon 7000/VE]
02:06.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8169 (rev 
10)
02:0b.0 Unknown mass storage controller: CMD Technology Inc Silicon Image 
SiI 3112 SATARaid Controller (rev 01)
02:0d.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
RTL-8139/8139C/8139C+ (rev 10)

from /proc/ioports:

0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
0cf8-0cff : PCI conf1
4000-407f : 0000:00:1f.0
4080-40bf : 0000:00:1f.0
a000-a0ff : 0000:02:06.0
  a000-a0ff : r8169
a400-a407 : 0000:02:0b.0
  a400-a407 : sata_sil
a800-a803 : 0000:02:0b.0
  a800-a803 : sata_sil
ac00-ac07 : 0000:02:0b.0
  ac00-ac07 : sata_sil
b000-b003 : 0000:02:0b.0
  b000-b003 : sata_sil
b400-b40f : 0000:02:0b.0
  b400-b40f : sata_sil
b800-b8ff : 0000:02:0d.0
  b800-b8ff : 8139too
c000-cfff : PCI Bus #01
  c000-c0ff : 0000:01:00.0
    c000-c0ff : radeonfb
d000-d01f : 0000:00:1f.2
  d000-d01f : uhci_hcd
d400-d41f : 0000:00:1f.4
  d400-d41f : uhci_hcd
d800-d8ff : 0000:00:1f.5
  d800-d8ff : Intel 82801BA-ICH2
dc00-dc3f : 0000:00:1f.5
  dc00-dc3f : Intel 82801BA-ICH2
f000-f00f : 0000:00:1f.1
  f000-f007 : ide0
  f008-f00f : ide1



Thanks for support


