Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318734AbSIIS33>; Mon, 9 Sep 2002 14:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318769AbSIIS32>; Mon, 9 Sep 2002 14:29:28 -0400
Received: from ute.rlxtechnologies.com ([65.66.195.252]:22290 "EHLO
	mail.rocketlogix.com") by vger.kernel.org with ESMTP
	id <S318734AbSIIS30>; Mon, 9 Sep 2002 14:29:26 -0400
Subject: oops on 2.4.20-pre5-ac2
From: Dan Eaton <dan.eaton@rlx.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 09 Sep 2002 13:28:59 -0500
Message-Id: <1031596139.25426.184.camel@dan>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Encountered the following oops on pre5-ac2:

--------------------------------------------------------------------
ALI15X3: IDE controller at PCI slot 00:0f.0
ALI15X3: chipset revision 195
ALI15X3: not 100% native mode: will probe irqs later
Unable to handle kernel NULL pointer dereference at virtual address
00000024
 printing eip:
c031f886
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c031f886>]    Not tainted
EFLAGS: 00010086
eax: 00000000   ebx: 00000246   ecx: 80007848   edx: 00000cff
esi: dffebf1b   edi: dffe0c00   ebp: 00000000   esp: dffebf18
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 1, stackpage=dffeb000)
Stack: c1329ee8 dffe0c00 c0299a4f c038f0f0 c0329ee8 c01d9837 dffe0c00
c0299a4f
       00000000 0000000e 00000001 00000000 c037fa20 00000001 00000000
dffe0c00
       c038e7a0 c038ec30 0008e000 c01d9a47 dffebf78 dffe0c00 c0329ee8
00000001
Call Trace:    [<c01d9837>] [<c01d9a47>] [<c0105000>] [<c0105078>]
[<c0105000>]
  [<c0105676>] [<c0105050>]

Code: 66 81 7d 24 b9 10 74 04 53 9d eb 54 56 a1 cc 15 39 c0 6a 79
 <0>Kernel panic: Attempted to kill init!

(c031f886 is at offset 0xb6 in the init_chipset_ali15x3() in
drivers/ide/pci/alim15x3.c.  I may be wrong but it appears that the
struct pci_dev *north pointer is the issue.)
--------------------------------------------------------------------


Did not see this problem on the straight 2.4.20-pre5 patch.
Unfortunately, the "ac" patch has some ide fixes that I need to correct
some 24 vs 48 bit addressing issues.  Anyone else seeing this issue?  I
would be glad to provide more information if needed.  Please CC me
personally on replies.


Below is the output of 'lspci -v -x' on my system:


00:07.0 ISA bridge: Acer Laboratories Inc. [ALi] M1533 PCI to ISA Bridge
[Aladdin IV]
        Subsystem: Unknown device 1749:1010
        Flags: bus master, medium devsel, latency 0
        Capabilities: [a0] Power Management version 1
00: b9 10 33 15 0f 00 10 02 00 00 01 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 49 17 10 10
30: 00 00 00 00 a0 00 00 00 00 00 00 00 00 00 00 00

00:09.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100]
(rev 08)
        Subsystem: Unknown device 1749:2010
        Flags: bus master, medium devsel, latency 66, IRQ 11
        Memory at fe800000 (32-bit, non-prefetchable) [size=4K]
        I/O ports at 1000 [size=64]
        Memory at fe900000 (32-bit, non-prefetchable) [size=1M]
        Expansion ROM at <unassigned> [disabled] [size=1M]
        Capabilities: [dc] Power Management version 2
00: 86 80 29 12 17 00 90 02 08 00 00 02 08 42 00 00
10: 00 00 80 fe 01 10 00 00 00 00 90 fe 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 49 17 10 20
30: 00 00 00 00 dc 00 00 00 00 00 00 00 0b 01 08 38

00:0a.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100]
(rev 08)
        Subsystem: Unknown device 1749:2010
        Flags: bus master, medium devsel, latency 66, IRQ 10
        Memory at fe801000 (32-bit, non-prefetchable) [size=4K]
        I/O ports at 1040 [size=64]
        Memory at fea00000 (32-bit, non-prefetchable) [size=1M]
        Expansion ROM at <unassigned> [disabled] [size=1M]
        Capabilities: [dc] Power Management version 2
00: 86 80 29 12 17 00 90 02 08 00 00 02 08 42 00 00
10: 00 10 80 fe 41 10 00 00 00 00 a0 fe 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 49 17 10 20
30: 00 00 00 00 dc 00 00 00 00 00 00 00 0a 01 08 38

00:0b.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100]
(rev 08)
        Subsystem: Unknown device 1749:2010
        Flags: bus master, medium devsel, latency 66, IRQ 7
        Memory at fe802000 (32-bit, non-prefetchable) [size=4K]
        I/O ports at 1080 [size=64]
        Memory at feb00000 (32-bit, non-prefetchable) [size=1M]
        Expansion ROM at <unassigned> [disabled] [size=1M]
        Capabilities: [dc] Power Management version 2
00: 86 80 29 12 17 00 90 02 08 00 00 02 08 42 00 00
10: 00 20 80 fe 81 10 00 00 00 00 b0 fe 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 49 17 10 20
30: 00 00 00 00 dc 00 00 00 00 00 00 00 07 01 08 38

00:0f.0 IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev c3)
(prog-if fa)
        Subsystem: Unknown device 1749:1020
        Flags: bus master, medium devsel, latency 64, IRQ 14
        I/O ports at 10c0 [size=16]
        Capabilities: [60] Power Management version 2
00: b9 10 29 52 05 00 90 02 c3 fa 01 01 00 40 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: c1 10 00 00 00 00 00 00 00 00 00 00 49 17 20 10
30: 00 00 00 00 60 00 00 00 00 00 00 00 0e 01 02 04

00:11.0 Bridge: Acer Laboratories Inc. [ALi] M7101 PMU
        Subsystem: Unknown device 1749:1040
        Flags: medium devsel
00: b9 10 01 71 00 00 00 02 00 00 80 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 49 17 40 10
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:14.0 PCI bridge: Crucial Technology: Unknown device 3330 (rev 03)
(prog-if 00 [Normal decode])
        Flags: bus master, 66Mhz, medium devsel, latency 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=68
        Capabilities: [40] Power Management version 2
        Capabilities: [50] PCI-X non-bridge device.
00: 44 13 30 33 17 00 b0 02 03 00 04 06 08 40 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 44 f0 00 a0 22
20: f0 ff 00 00 f0 ff 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 00 00 04 00

00:18.0 Host bridge: Crucial Technology: Unknown device 3320 (rev 03)
        Subsystem: Micron: Unknown device 1042
        Flags: bus master, 66Mhz, medium devsel, latency 32
00: 44 13 20 33 07 01 a0 02 03 00 00 06 08 20 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 42 10 42 10
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:18.1 RAM memory: Crucial Technology: Unknown device 3321 (rev 03)
        Subsystem: Micron: Unknown device 1042
        Flags: 66Mhz, medium devsel
00: 44 13 21 33 02 00 a0 02 03 00 00 05 08 40 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 42 10 42 10
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00



Thanks,

Dan

-- 
Dan Eaton


