Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263444AbTJVHNX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 03:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263447AbTJVHNX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 03:13:23 -0400
Received: from obsidian.spiritone.com ([216.99.193.137]:1193 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S263444AbTJVHNN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 03:13:13 -0400
Date: Tue, 21 Oct 2003 23:37:02 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: healer@rpi.edu
Subject: [Bug 1399] New: oops on filesystem mount (befs)
Message-ID: <4740000.1066804622@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=1399

           Summary: opps on filesystem mount
    Kernel Version: 2.6.0-test8
            Status: NEW
          Severity: high
             Owner: bugme-janitors@lists.osdl.org
         Submitter: healer@rpi.edu


Distribution: Gentoo 1.4
Hardware Environment: IBM Thinkpad T30 Output of lspci -vvv:
00:00.0 Host bridge: Intel Corp. 82845 845 (Brookdale) Chipset Host Bridge (rev 04)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort+ >SERR- <PERR-
        Latency: 0
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [e4] #09 [d104]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans-
64bit- FW+ AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW+ Rate=x1

00:01.0 PCI bridge: Intel Corp. 82845 845 (Brookdale) Chipset AGP Bridge (rev
04) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
        Latency: 96
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 00003000-00003fff
        Memory behind bridge: d0100000-d01fffff
        Prefetchable memory behind bridge: e8000000-efffffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:1d.0 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #1) (rev 02) (prog-if
00 [UHCI])
        Subsystem: IBM ThinkPad A/T/X Series
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 11
        Region 4: I/O ports at 1800 [size=32]

00:1d.1 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #2) (rev 02) (prog-if
00 [UHCI])
        Subsystem: IBM ThinkPad A/T/X Series
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 11
        Region 4: I/O ports at 1820 [size=32]

00:1d.2 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #3) (rev 02) (prog-if
00 [UHCI])
        Subsystem: IBM ThinkPad A/T/X Series
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin C routed to IRQ 11
        Region 4: I/O ports at 1840 [size=32]

00:1e.0 PCI bridge: Intel Corp. 82801BAM/CAM PCI Bridge (rev 42) (prog-if 00
[Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=02, subordinate=08, sec-latency=64
        I/O behind bridge: 00004000-00008fff
        Memory behind bridge: d0200000-dfffffff
        Prefetchable memory behind bridge: f0000000-f80fffff
        BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corp. 82801CAM ISA Bridge (LPC) (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:1f.1 IDE interface: Intel Corp. 82801CAM IDE U100 (rev 02) (prog-if 8a
[Master SecP PriP])
        Subsystem: IBM ThinkPad A/T/X Series
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at <ignored>
        Region 1: I/O ports at <ignored>
        Region 2: I/O ports at <ignored>
        Region 3: I/O ports at <ignored>
        Region 4: I/O ports at 1860 [size=16]
        Region 5: Memory at 10000000 (32-bit, non-prefetchable) [size=1K]

00:1f.3 SMBus: Intel Corp. 82801CA/CAM SMBus Controller (rev 02)
        Subsystem: IBM ThinkPad A/T/X Series
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 11
        Region 4: I/O ports at 1880 [size=32]

00:1f.5 Multimedia audio controller: Intel Corp. 82801CA/CAM AC'97 Audio
Controller (rev 02)
        Subsystem: IBM ThinkPad T30
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 11
        Region 0: I/O ports at 1c00 [size=256]
        Region 1: I/O ports at 18c0 [size=64]

00:1f.6 Modem: Intel Corp. 82801CA/CAM AC'97 Modem Controller (rev 02) (prog-if
00 [Generic])
        Subsystem: IBM ThinkPad A/T/X Series
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 11
        Region 0: I/O ports at 2400 [size=256]
        Region 1: I/O ports at 2000 [size=128]

01:00.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility M7 LW
[Radeon Mobility 7500] (prog-if 00 [VGA])
        Subsystem: IBM ThinkPad T30
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping+ SERR+ FastB2B+
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 66 (2000ns min), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at e8000000 (32-bit, prefetchable) [size=128M]
        Region 1: I/O ports at 3000 [size=256]
        Region 2: Memory at d0100000 (32-bit, non-prefetchable) [size=64K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [58] AGP version 2.0
                Status: RQ=48 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans-
64bit- FW- AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP- GART64- 64bit- FW- Rate=<none>
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:00.0 CardBus bridge: Texas Instruments PCI1250 PC card Cardbus Controller
(rev 01)
        Subsystem: IBM ThinkPad T30
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at 50000000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=02, secondary=03, subordinate=06, sec-latency=176
        Memory window 0: 00000000-00000000 (prefetchable)
        Memory window 1: 00000000-00000000 (prefetchable)
        I/O window 0: 00000000-00000003
        I/O window 1: 00000000-00000003
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite-
        16-bit legacy interface ports at 0001

02:00.1 CardBus bridge: Texas Instruments PCI1250 PC card Cardbus Controller
(rev 01)
        Subsystem: IBM ThinkPad T30
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, cache line size 08
        Interrupt: pin B routed to IRQ 11
        Region 0: Memory at 51000000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=02, secondary=07, subordinate=0a, sec-latency=176
        Memory window 0: 00000000-00000000 (prefetchable)
        Memory window 1: 00000000-00000000 (prefetchable)
        I/O window 0: 00000000-00000003
        I/O window 1: 00000000-00000003
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite-
        16-bit legacy interface ports at 0001

02:02.0 Network controller: Harris Semiconductor Prism 2.5 Wavelan chipset (rev 01)
        Subsystem: Intel Corp. Wireless 802.11b MiniPCI Adapter
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at f8000000 (32-bit, prefetchable) [size=4K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:08.0 Ethernet controller: Intel Corp. 82801CAM (ICH3) PRO/100 VE (LOM)
Ethernet Controller (rev 42)
        Subsystem: IBM ThinkPad A/T/X Series
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 66 (2000ns min, 14000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at d0200000 (32-bit, non-prefetchable) [size=4K]
        Region 1: I/O ports at 8000 [size=64]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

Software Environment: output of scripts/ver_linux:
Linux seaking-14.dynamic.rpi.edu 2.6.0-test8 #1 Mon Oct 20 12:50:33 EDT 2003
i686 Intel(R) Pentium(R) 4 Mobile CPU 1.80GHz GenuineIntel GNU/Linux

Gnu C                  3.2.3
Gnu make               3.80
util-linux             2.11z
mount                  2.11z
module-init-tools      0.9.12
e2fsprogs              1.33
pcmcia-cs              3.2.4
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.1.9
Net-tools              1.60
Kbd                    1.06
Sh-utils               5.0
Modules Loaded         snd_mixer_oss agpgart orinoco_pci orinoco hermes e100
parport_pc lp parport ds pcmcia_core snd_intel8x0 snd_ac97_codec snd_pcm
snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device snd usbcore
befs nls_iso8859_1 nls_cp437

Problem Description: I have a BeOS partition that I like to keep mounted
readonly.  I have no problems under the 2.4 kernel.  The 1st attempt to mount
the partition produces the included oops.  Further calls just cause mount to
hang indefinately.
BeFS version: 0.9.3
Unable to handle kernel NULL pointer dereference at virtual address 00000001
 printing eip:
c01ca3b1
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c01ca3b1>]    Not tainted
EFLAGS: 00010202
EIP is at match_one+0x35/0x207
eax: 00002525   ebx: 00000001   ecx: 00000009   edx: 00000001
esi: 00000001   edi: cf32c000   ebp: cf32c000   esp: cfa4fde4
ds: 007b   es: 007b   ss: 0068
Process mount (pid: 2445, threadinfo=cfa4e000 task=cfc0a080)
Stack: 00000000 00000000 00000000 0000000a 00000000 ffffffff 00000000 d18d7f80
       cfa4fe40 cf32c000 cfdc3e00 c01ca5a8 cf32c000 00000001 cfa4fe40 cf32c000
       cf66e7e0 cfa4fe40 d18d4b7a cf32c000 d18d7f60 cfa4fe40 c130cb90 cfa4fea4
Call Trace:
 [<c01ca5a8>] match_token+0x25/0x37
 [<d18d4b7a>] parse_options+0x7f/0x15e [befs]
 [<c01cc16e>] snprintf+0x27/0x2b
 [<c0180472>] disk_name+0x66/0xaf
 [<d18d4d20>] befs_fill_super+0x50/0x288 [befs]
 [<c0156ac0>] sb_set_blocksize+0x25/0x53
 [<c0156537>] get_sb_bdev+0x127/0x159
 [<c016a26b>] alloc_vfsmnt+0x87/0xb6
 [<d18d501c>] befs_get_sb+0x2f/0x33 [befs]
 [<d18d4cd0>] befs_fill_super+0x0/0x288 [befs]
 [<c0156769>] do_kern_mount+0x5f/0xd1
 [<c016b4b3>] do_add_mount+0x95/0x176
 [<c016b7eb>] do_mount+0x155/0x1a1
 [<c016b620>] copy_mount_options+0x8c/0x102
 [<c016bbe1>] sys_mount+0xd7/0x135
 [<c0109327>] syscall_call+0x7/0xb

Code: ac 38 e0 74 09 84 c0 75 f7 be 01 00 00 00 89 f0 48 85 c0 89



Steps to reproduce:
mount -t befs /dev/somewhere /beos

I think I have provided all the needed information, if not, I will provide what
is missing as soon as I can figure out what is missing.




