Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263771AbUDZChn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263771AbUDZChn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Apr 2004 22:37:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263790AbUDZChn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Apr 2004 22:37:43 -0400
Received: from [203.97.82.178] ([203.97.82.178]:52864 "EHLO tyreal.dmz")
	by vger.kernel.org with ESMTP id S263771AbUDZCh3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Apr 2004 22:37:29 -0400
Message-ID: <408C75E4.50908@treshna.com>
Date: Mon, 26 Apr 2004 14:37:24 +1200
From: Dru <andru@treshna.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: Kernel lockup on alpha with heavy IO
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've recently installed debian on a alpha box and have a problem with  
the kernel locking up
after a couple of hours of heavy use.  An individual partition will stop 
responding, all processes
that try and access it will just sit there waiting and you have to 
reboot the server.
I've been using a mixture of IDE drives and they all do this. I thought 
it might be the motherboard
so i've installed a pci ide controller card, had same effect. I've tried 
accessing files over usb devices
as a finial ditch effort but it also does it there also so i am sure it 
is in the kernel and not
the hardware that is at fault.

Kernels I've tried.
Linux 2.6.5, Linux 2.4.18

To re-create the problem on an alpha, copy directories around from one 
partition to another. Have
several copies going at once, do a few hdparm -t -T as well and 
generally provides a lock up within
an hour.  I am running a mixture of ext3 and xfs for partitions.


cpu                     : Alpha
cpu model               : SimulateLCA4
cpu variation           : 7
cpu revision            : 0
cpu serial number       :
system type             : Nautilus
system variation        : 0
system revision         : 0
system serial number    :
cycle frequency [Hz]    : 796423125 est.
timer frequency [Hz]    : 1024.00
page size [bytes]       : 8192
phys. address bits      : 44
max. addr. space #      : 255
BogoMIPS                : 1586.36
kernel unaligned acc    : 1939 (pc=fffffc000101e7e0,va=fffffffc004af731)
user unaligned acc      : 0 (pc=0,va=0)
platform string         : ATEK1000 800 MHz
cpus detected           : 1
L1 Icache               : unknown
L1 Dcache               : unknown
L2 cache                : unknown
L3 cache                : unknown

nfsd 137824 8 - Live 0xfffffffc00496000
exportfs 6552 1 nfsd, Live 0xfffffffc003e6000
lockd 88892 2 nfsd, Live 0xfffffffc004c2000
sunrpc 177120 2 nfsd,lockd, Live 0xfffffffc004e4000
usb_storage 76872 4 - Live 0xfffffffc003ca000
tulip 68952 0 - Live 0xfffffffc003ea000
ehci_hcd 37204 0 - Live 0xfffffffc003b6000
ohci_hcd 23188 0 - Live 0xfffffffc003c2000
usbcore 127940 5 usb_storage,ehci_hcd,ohci_hcd, Live 0xfffffffc00358000
snd_ali5451 29580 0 - Live 0xfffffffc00336000
snd_pcm 111993 1 snd_ali5451, Live 0xfffffffc00318000
snd_page_alloc 12816 1 snd_pcm, Live 0xfffffffc002f4000
snd_timer 28944 1 snd_pcm, Live 0xfffffffc002c6000
snd_ac97_codec 81884 1 snd_ali5451, Live 0xfffffffc00342000
snd 67712 4 snd_ali5451,snd_pcm,snd_timer,snd_ac97_codec, Live 
0xfffffffc002e0000
soundcore 9600 1 snd, Live 0xfffffffc002da000
sk98lin 233256 1 - Live 0xfffffffc0037a000
sd_mod 23609 5 - Live 0xfffffffc002d2000
scsi_mod 106344 2 usb_storage,sd_mod, Live 0xfffffffc002fc000

0000:00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-760 [IGD4-1P] 
System Controller (rev 13)
        Flags: bus master, medium devsel, latency 255
        Memory at <unassigned> (32-bit, prefetchable)
        Memory at 00000000ff064000 (32-bit, prefetchable) [size=4K]
        I/O ports at 8c90 [disabled] [size=4]
        Capabilities: [a0] AGP version 2.0
 
0000:00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-760 [IGD4-1P] 
AGP Bridge (prog-if 00 [Normal decode])
        Flags: bus master, 66MHz, medium devsel, latency 255
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=255
        Memory behind bridge: fb000000-fbffffff
        Prefetchable memory behind bridge: fc000000-feffffff
 
0000:00:03.0 Modem: ALi Corporation Intel 537 [M5457 AC-Link Modem] 
(prog-if 00 [Generic])
        Subsystem: ALi Corporation Intel 537 [M5457 AC-Link Modem]
        Flags: bus master, medium devsel, latency 255, IRQ 255
        Memory at 00000000ff065000 (32-bit, non-prefetchable)
        I/O ports at 8000 [size=256]
        Capabilities: [40] Power Management version 2
 
0000:00:06.0 Multimedia audio controller: ALi Corporation M5451 PCI 
AC-Link Controller Audio Device (rev 02)
        Subsystem: ALi Corporation M5451 PCI AC-Link Controller Audio Device
        Flags: bus master, medium devsel, latency 240, IRQ 10
        I/O ports at 8400
        Memory at 00000000ff066000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [dc] Power Management version 2
 
0000:00:07.0 ISA bridge: ALi Corporation M1533 PCI to ISA Bridge 
[Aladdin IV]
        Subsystem: ALi Corporation ALI M1533 Aladdin IV ISA Bridge
        Flags: bus master, medium devsel, latency 0
        Capabilities: [a0] Power Management version 1
 
0000:00:09.0 Ethernet controller: D-Link System Inc: Unknown device 4c00 
(rev 11)
        Subsystem: D-Link System Inc: Unknown device 4c00
        Flags: bus master, 66MHz, medium devsel, latency 255, IRQ 9
        Memory at 00000000ff060000 (32-bit, non-prefetchable) 
[size=00000000ff040000]
        I/O ports at 8800 [size=256]
        Expansion ROM at 0000000000020000 [disabled]
        Capabilities: [48] Power Management version 2
        Capabilities: [50] Vital Product Data
 
0000:00:0a.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03) 
(prog-if 10 [OHCI])
        Subsystem: ALi Corporation USB 1.1 Controller
        Flags: bus master, 66MHz, medium devsel, latency 248, IRQ 11
        Memory at 00000000ff067000 (32-bit, non-prefetchable)
        Capabilities: [60] Power Management version 2
 
0000:00:0a.3 USB Controller: ALi Corporation USB 2.0 Controller (rev 01) 
(prog-if 20 [EHCI])
        Subsystem: Unknown device 2020:8888
        Flags: bus master, 66MHz, medium devsel, latency 248, IRQ 10
        Memory at 00000000ff06a000 (32-bit, non-prefetchable)
        Capabilities: [50] Power Management version 2
        Capabilities: [58] #0a [2090]
 
0000:00:0b.0 Ethernet controller: Digital Equipment Corporation DECchip 
21142/43 (rev 41)
        Subsystem: Digital Equipment Corporation DE500B Fast Ethernet
        Flags: bus master, medium devsel, latency 255, IRQ 11
        I/O ports at 8c00 [size=00000000ff000000]
        Memory at 00000000ff069000 (32-bit, non-prefetchable) [size=1K]
        Expansion ROM at 0000000000040000 [disabled]
 
0000:00:10.0 IDE interface: ALi Corporation M5229 IDE (rev c4) (prog-if fa)
        Flags: bus master, medium devsel, latency 255, IRQ 15
        I/O ports at <ignored>
        I/O ports at <ignored>
        I/O ports at <ignored>
        I/O ports at <ignored>
        I/O ports at 8c80 [size=16]
        Capabilities: [60] Power Management version 2
 
0000:00:11.0 Non-VGA unclassified device: ALi Corporation M7101 PMU
        Flags: medium devsel
 
0000:00:14.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03) 
(prog-if 10 [OHCI])
        Flags: bus master, medium devsel, latency 248, IRQ 9
        Memory at 00000000ff068000 (32-bit, non-prefetchable)
        Capabilities: [60] Power Management version 2
 
0000:01:05.0 VGA compatible controller: nVidia Corporation NV5M64 [RIVA 
TNT2 Model 64/Model 64 Pro] (rev 15) (prog-if 00 [VGA])
        Flags: bus master, 66MHz, medium devsel, latency 248, IRQ 10
        Memory at 00000000fb000000 (32-bit, non-prefetchable) 
[size=00000000fe000000]
        Memory at 00000000fc000000 (32-bit, prefetchable) [size=32M]
        Expansion ROM at 0000000000010000 [disabled]
        Capabilities: [60] Power Management version 1
        Capabilities: [44] AGP version 2.0
 


