Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314085AbSDVIjL>; Mon, 22 Apr 2002 04:39:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314088AbSDVIjK>; Mon, 22 Apr 2002 04:39:10 -0400
Received: from 12-226-21-207.client.attbi.com ([12.226.21.207]:46581 "EHLO
	spartan.jdc.home") by vger.kernel.org with ESMTP id <S314085AbSDVIjJ>;
	Mon, 22 Apr 2002 04:39:09 -0400
Subject: ide-scsi 760MP Oops
From: Jim Crilly <noth@noth.is.eleet.ca>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 22 Apr 2002 04:39:07 -0400
Message-Id: <1019464748.2062.9.camel@warblade>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I found a similar post, but no responses so I'm not sure what came of
this. Trying to burn a CD using cdrecord with 2.4.18 gave me this:

scsi : aborting command due to timeout : pid 4162, scsi1, channel 0, id
0, lun 0 Write (10) 00 00 00 00 00 00 00 1f 00 
hda: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hda: status error: status=0x20 { DeviceFault }
ide-scsi: Strange, packet command initiated yet DRQ isn't asserted
hda: ATAPI reset complete
hda: irq timeout: status=0x80 { Busy }
hda: ATAPI reset complete
hda: irq timeout: status=0x80 { Busy }
Unable to handle kernel NULL pointer dereference at virtual address
00000184
 printing eip:
f88c42b1
*pde = 00000000
Oops: 0002
CPU:    1
EIP:    0010:[<f88c42b1>]    Not tainted
EFLAGS: 00010002
eax: 00000000   ebx: f7118e40   ecx: f7348000   edx: f7118e40
esi: f88bc560   edi: 00000080   ebp: c2417e90   esp: c2417e6c
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c2417000)
Stack: f7118e40 f88bc560 00000080 f88bc560 00000000 f7348000 f7118e40
f77c0d40 
       f88bc560 c2417eb0 f88ad461 00000000 f7bb35c0 f88bc560 f7bb35c0
f88c44e0 
       00000080 c2417edc f88ae09a f88bc560 f88b61a2 00000080 f7bb35c0
f88adee0 
Call Trace: [<f88bc560>] [<f88bc560>] [<f88bc560>] [<f88ad461>]
[<f88bc560>] 
   [<f88c44e0>] [<f88ae09a>] [<f88bc560>] [<f88b61a2>] [<f88adee0>]
[<f88bc520>] 
   [<c011fe66>] [<c011c1ee>] [<c011c09f>] [<c011bded>] [<c0108d6b>]
[<c0105410>] 
   [<c0105410>] [<c0105410>] [<c0105410>] [<c010543f>] [<c01054c2>]
[<c0117878>] 

Code: c7 80 84 01 00 00 00 00 07 00 83 7d ec 00 0f 84 a8 01 00 00 

>>EIP; f88c42b1 <[ide-scsi]idescsi_end_request+71/2a0>   <=====

>>ebx; f7118e40 <_end+36d18700/384578c0>
>>ecx; f7348000 <_end+36f478c0/384578c0>
>>edx; f7118e40 <_end+36d18700/384578c0>
>>esi; f88bc560 <[ide-mod]ide_hwifs+40/1ec8>
>>ebp; c2417e90 <_end+2017750/384578c0>
>>esp; c2417e6c <_end+201772c/384578c0>

Trace; f88bc560 <[ide-mod]ide_hwifs+40/1ec8>
Trace; f88bc560 <[ide-mod]ide_hwifs+40/1ec8>
Trace; f88bc560 <[ide-mod]ide_hwifs+40/1ec8>
Trace; f88ad461 <[ide-mod]ide_error+121/170>
Trace; f88bc560 <[ide-mod]ide_hwifs+40/1ec8>
Trace; f88c44e0 <[ide-scsi]idescsi_pc_intr+0/240>
Trace; f88ae09a <[ide-mod]ide_timer_expiry+1ba/220>
Trace; f88bc560 <[ide-mod]ide_hwifs+40/1ec8>
Trace; f88b61a2 <[ide-mod]ide_hwif_to_major+59f/2b9c>
Trace; f88adee0 <[ide-mod]ide_timer_expiry+0/220>
Trace; f88bc520 <[ide-mod]ide_hwifs+0/1ec8>
Trace; c011fe66 <timer_bh+256/2b0>
Trace; c011c1ee <bh_action+4e/90>
Trace; c011c09f <tasklet_hi_action+6f/b0>
Trace; c011bded <do_softirq+7d/e0>
Trace; c0108d6b <do_IRQ+db/f0>
Trace; c0105410 <default_idle+0/40>
Trace; c0105410 <default_idle+0/40>
Trace; c0105410 <default_idle+0/40>
Trace; c0105410 <default_idle+0/40>
Trace; c010543f <default_idle+2f/40>
Trace; c01054c2 <cpu_idle+42/60>
Trace; c0117878 <release_console_sem+98/b0>

Code;  f88c42b1 <[ide-scsi]idescsi_end_request+71/2a0>
00000000 <_EIP>:
Code;  f88c42b1 <[ide-scsi]idescsi_end_request+71/2a0>   <=====
   0:   c7 80 84 01 00 00 00      movl   $0x70000,0x184(%eax)   <=====
Code;  f88c42b8 <[ide-scsi]idescsi_end_request+78/2a0>
   7:   00 07 00 
Code;  f88c42bb <[ide-scsi]idescsi_end_request+7b/2a0>
   a:   83 7d ec 00               cmpl   $0x0,0xffffffec(%ebp)
Code;  f88c42bf <[ide-scsi]idescsi_end_request+7f/2a0>
   e:   0f 84 a8 01 00 00         je     1bc <_EIP+0x1bc> f88c446d
<[ide-scsi]idescsi_end_request+22d/2a0>

My hardware is:
00:00.0 Host bridge: Advanced Micro Devices [AMD]: Unknown device 700c
(rev 11)
        Flags: bus master, medium devsel, latency 64
        Memory at f4000000 (32-bit, prefetchable) [size=64M]
        Memory at f0003000 (32-bit, prefetchable) [size=4K]
        I/O ports at 14b0 [disabled] [size=4]
        Capabilities: [a0] AGP version 2.0

00:01.0 PCI bridge: Advanced Micro Devices [AMD]: Unknown device 700d
(prog-if 00 [Normal decode])
        Flags: bus master, 66Mhz, medium devsel, latency 99
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=68
        Memory behind bridge: f1000000-f1ffffff
        Prefetchable memory behind bridge: f8000000-fc0fffff

00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-765 [Viper] ISA
(rev 02)
        Flags: bus master, medium devsel, latency 0

00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-765 [Viper] IDE
(rev 01) (prog-if 8a [Master SecP PriP])
        Flags: bus master, medium devsel, latency 64
        I/O ports at f000 [size=16]

00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-765 [Viper] ACPI (rev
01)
        Flags: medium devsel

00:07.4 USB Controller: Advanced Micro Devices [AMD] AMD-765 [Viper] USB
(rev 07) (prog-if 10 [OHCI])
        Flags: bus master, medium devsel, latency 16, IRQ 11
        Memory at 000dc000 (32-bit, non-prefetchable) [size=4K]

00:09.0 SCSI storage controller: Adaptec 7892A (rev 02)
        Subsystem: Adaptec: Unknown device 62a0
        Flags: bus master, 66Mhz, medium devsel, latency 72, IRQ 5
        BIST result: 00
        I/O ports at 1000 [disabled] [size=256]
        Memory at f0001000 (64-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2

00:0c.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev
04)
        Subsystem: Creative Labs CT4850 SBLive! Value
        Flags: bus master, medium devsel, latency 64, IRQ 11
        I/O ports at 1480 [size=32]
        Capabilities: [dc] Power Management version 1

00:0c.1 Input device controller: Creative Labs SB Live! (rev 01)
        Subsystem: Creative Labs Gameport Joystick
        Flags: bus master, medium devsel, latency 64
        I/O ports at 14b8 [size=8]
        Capabilities: [dc] Power Management version 1

00:0d.0 Ethernet controller: Digital Equipment Corporation DECchip
21142/43 (rev 30)
        Subsystem: Digital Equipment Corporation DE500 Fast Ethernet
        Flags: bus master, medium devsel, latency 165, IRQ 5
        I/O ports at 1400 [size=128]
        Memory at f0002000 (32-bit, non-prefetchable) [size=128]
        Expansion ROM at <unassigned> [disabled] [size=256K]

01:05.0 VGA compatible controller: nVidia Corporation NV20 (GeForce3)
(rev a3) (prog-if 00 [VGA])
        Subsystem: VISIONTEK: Unknown device 001b
        Flags: bus master, 66Mhz, medium devsel, latency 248, IRQ 10
        Memory at f1000000 (32-bit, non-prefetchable) [size=16M]
        Memory at f8000000 (32-bit, prefetchable) [size=64M]
        Memory at fc000000 (32-bit, prefetchable) [size=512K]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [60] Power Management version 2
        Capabilities: [44] AGP version 2.0

I'm using XFS on my root filesystem or I would try a 2.4.19-pre kernel.
I also have SMP and HIGHMEM (I have 1.2G memory) enabled.

-- 
Help protect your rights on-line.
Join the Electronic Frontiers Foundation today: http://www.eff.org/join
-------------------------------------------------------------------------------
It's funny how the cross - an execution tool - has become a religion
symbol.
I have to wonder if we'd be seeing Jesus with a stake up his sphincter
if that 
indeed was the was he was executed. I guess if he'd lived in more modern
times 
we'd see Jesus in an electric chair above the alter.
-------------------------------------------------------------------------------
In-Warren R says: Our technicians are working on it and it will be
blazing 	
fast. (AT&T Tech support)

