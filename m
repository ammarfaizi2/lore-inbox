Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264799AbTE1Qsv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 12:48:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264800AbTE1Qsv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 12:48:51 -0400
Received: from smtp.ualg.pt ([193.136.224.8]:1190 "EHLO smtp.ualg.pt")
	by vger.kernel.org with ESMTP id S264799AbTE1Qsq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 12:48:46 -0400
From: "Joao Rochate" <jrochate@ualg.pt>
To: <linux-kernel@vger.kernel.org>
Subject: Problem with 2.4.20 + TI1410 PCI-PCMCIA card + Dual XEON HT PCI-X
Date: Wed, 28 May 2003 18:01:57 +0100
Message-ID: <MGEFKIPHLPENLJDKJLDEAENPECAA.jrochate@ualg.pt>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4920.2300
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi...

Scenario:
- Proliant 380G3: Dual XEON HT with 2 HotPlug PCI-X 100Mhz and 1 PCI-X
133Mhz
- Card: Avaya ORiNOCO PCI Adaptor to enable PCMCIA cards on a PCI Slot
- OS: RedHat 9 with 2.4.20-8smp + kernel-pcmcia-cs-3.1.31-13
- Config: Full Table APIC and PCI adapter fitted on PCI-X 133 (non-hotplug)

Problem:
- The OS boots, the PCI card gets detected, driver is yenta_socket and all
modules load fine.
- The problem is that any card PCMCIA or CF+adapter that I connect, doesn't
get recognized by the OS, booting it with card inserted or not.

Tests I've made:
- Standard PC intel P-III 1Ghz non-smp, standard PCI, runing RedHat 8 stock
works fine with the same PCI-PCMCIA card adapter! Every card gets loaded
fine.
- I've tried 5V cards and 3.3V cards. I'm sure because I've inserted them on
the P-III and after a 'cardctl status' I can read 3.3 Vcc.
- Tried inserting card on HotPlug slots, but machine wouldn't boot
- cardmgr is runing, and cardctl always sais 'no card'.

Assumptions:
- I think if there were any problem with the Server, then I could not get
the modules loaded, or the card wouldn't be recognized by the kernel.
- Maybe it's a problem with IRQ's, since I can't get an IRQ when the APIC
mode is not full table
- I haven't tried to boot the Server with non-smp kernel
- Ahhhh: I have already sent an email to pcmcia-cs developers who advised me
to contact linux-kernel people :)
- Strange the Socket Status on dmesg: Socket status: ffffffff


Here is some logs. Sorry to everyone about the garbish, if this is not the
right place to put this kind or problems.

Any help will be greatly appreciate. :)

- - - - - - - - - - - - - - - - - - - - - - - - - - - - -

/sbin/probe:
PCI bridge probe: TI 1410 found, 2 sockets.

dmesg:
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
PCI: Enabling device 03:01.0 (0000 -> 0002)
Yenta IRQ list 0000, PCI irq20
Socket status: ffffffff
cs: IO port probe 0x0c00-0x0cff: excluding 0xc00-0xc07 0xc10-0xc17
0xc48-0xc4f 0xc68-0xc6f 0xc80-0xc87 0xcd0-0xcd7
cs: IO port probe 0x0100-0x04ff: excluding 0x220-0x227 0x230-0x237
0x240-0x267 0x408-0x40f 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.

lspci -vvv:
03:01.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus Controller
(rev 01)
        Subsystem: SCM Microsystems: Unknown device 3000
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 168, cache line size 20
        Interrupt: pin A routed to IRQ 20
        Region 0: Memory at 20000000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=03, secondary=04, subordinate=07, sec-latency=176
        Memory window 0: 20400000-207ff000 (prefetchable)
        Memory window 1: 20800000-20bff000
        I/O window 0: 00004000-000040ff
        I/O window 1: 00004400-000044ff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt-
PostWrite+
        16-bit legacy interface ports at 0001

/proc/ioports:
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
1800-18ff : PCI device 0e11:b203 (Compaq Computer Corporation)
2000-200f : ServerWorks CSB5 IDE Controller
  2000-2007 : ide0
  2008-200f : ide1
2400-24ff : ATI Technologies Inc Rage XL
2800-28ff : PCI device 0e11:b204 (Compaq Computer Corporation)
3000-30ff : Compaq Computer Corporation Smart Array 5i/532
  3000-30ff : cciss
4000-40ff : PCI CardBus #04
4400-44ff : PCI CardBus #04

/proc/iomem:
00000000-0009f3ff : System RAM
0009f400-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000cbfff : Extension ROM
000cc000-000cd7ff : Extension ROM
000f0000-000fffff : System ROM
00100000-1fff9fff : System RAM
  00100000-002720eb : Kernel code
  002720ec-00383ba3 : Kernel data
1fffa000-1fffffff : ACPI Tables
20000000-20000fff : Texas Instruments PCI1410 PC card Cardbus Controller
20400000-207fffff : PCI CardBus #04
20800000-20bfffff : PCI CardBus #04
f5ef0000-f5ef0fff : ServerWorks OSB4/CSB5 OHCI USB Controller
  f5ef0000-f5ef0fff : usb-ohci
f5f00000-f5f7ffff : PCI device 0e11:b204 (Compaq Computer Corporation)
f5fc0000-f5fc1fff : PCI device 0e11:b204 (Compaq Computer Corporation)
f5fd0000-f5fd07ff : PCI device 0e11:b204 (Compaq Computer Corporation)
f5fe0000-f5fe01ff : PCI device 0e11:b203 (Compaq Computer Corporation)
f5ff0000-f5ff0fff : ATI Technologies Inc Rage XL
f6000000-f6ffffff : ATI Technologies Inc Rage XL
f7cf0000-f7cf3fff : Compaq Computer Corporation Smart Array 5i/532
f7dc0000-f7dfffff : Compaq Computer Corporation Smart Array 5i/532
f7ee0000-f7eeffff : Broadcom Corporation NetXtreme BCM5703X Gigabit Ethernet
(#2)
  f7ee0000-f7eeffff : tg3
f7ef0000-f7efffff : Broadcom Corporation NetXtreme BCM5703X Gigabit Ethernet
  f7ef0000-f7efffff : tg3
f7ff0000-f7ff0fff : Compaq Computer Corporation PCI Hotplug Controller
fec00000-fec0ffff : reserved
fee00000-fee0ffff : reserved
ffc00000-ffffffff : reserved

lsmod:
Module                  Size  Used by    Not tainted
ide-cd                 35772   0  (autoclean)
cdrom                  34176   0  (autoclean) [ide-cd]
lp                      9188   0  (autoclean)
parport                39072   0  (autoclean) [lp]
autofs                 13684   0  (autoclean) (unused)
ds                      8840   1
yenta_socket           13568   1
pcmcia_core            62304   0  [ds yenta_socket]
iptable_filter          2412   0  (autoclean) (unused)
ip_tables              15864   1  [iptable_filter]
tg3                    52904   1
keybdev                 2976   0  (unused)
mousedev                5656   0  (unused)
hid                    22308   0  (unused)
input                   6208   0  [keybdev mousedev hid]
usb-ohci               22216   0  (unused)
usbcore                82592   1  [hid usb-ohci]
ext3                   73376   4
jbd                    56336   4  [ext3]
cciss                  44420   5
sd_mod                 13452   0  (unused)
scsi_mod              110488   1  [cciss sd_mod]

/proc/interrupts:
           CPU0       CPU1       CPU2       CPU3
  0:   19460047          0          0          0    IO-APIC-edge  timer
  1:          4          0          0          0    IO-APIC-edge  keyboard
  2:          0          0          0          0          XT-PIC  cascade
  7:          0          0          0          0   IO-APIC-level  usb-ohci
  8:          2          0          0          0    IO-APIC-edge  rtc
 12:         23          0          0          0    IO-APIC-edge  PS/2 Mouse
 14:         61          1          0          0    IO-APIC-edge  ide0
 20:          0          0          0          0   IO-APIC-level  Texas
Instruments PCI141
0 PC card Cardbus Controller
 29:   11405579          0          0          0   IO-APIC-level  eth0
 30:    1208979          0          0          0   IO-APIC-level  cciss0
NMI:          0          0          0          0
LOC:   19459243   19459249   19459249   19459248
ERR:          0
MIS:          0


