Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261474AbTHSVaM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 17:30:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261508AbTHSV2D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 17:28:03 -0400
Received: from hendrix.ece.utexas.edu ([128.83.59.42]:29338 "EHLO
	hendrix.ece.utexas.edu") by vger.kernel.org with ESMTP
	id S261471AbTHSV0e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 17:26:34 -0400
Date: Tue, 19 Aug 2003 16:26:29 -0500 (CDT)
From: "Hmamouche, Youssef" <youssef@ece.utexas.edu>
To: linux-kernel@vger.kernel.org
Subject: [Oops] linux-2.6.0-test3 sound 
Message-ID: <Pine.LNX.4.21.0308191558520.844-100000@linux08.ece.utexas.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam,
	SpamAssassin (Disabled due to 10consecutive timeouts)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This happened when enlightenment tried to load the sound
daemon(esd). This is my first time running a 2.6.0 series kernel. it's
running on an dell inspiron 3800.  Below the oops is the lspci, hardware
info, etc. I'll post this and verify if the oops can be reproduced.

Thanks


Right before the oops:

-------------------------------------------------------------
eth0: New link status: Connected (0001)
warning: process `update' used the obsolete bdflush system call
Fix your initscripts?
------------------------------------------------------------

After the oops:

----------------------------------------------------------------

Unable to handle kernel NULL pointer dereference at virtual address
00000188
 printing eip:
c03dabe1
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c03dabe1>]    Not tainted
EFLAGS: 00010046
EIP is at m3_open+0x131/0x390
eax: 00000000   ebx: 00000000   ecx: c5a74004   edx: 00000002
esi: c776102c   edi: 00000003   ebp: c5b91ec4   esp: c5b91e8c
ds: 007b   es: 007b   ss: 0068
Process esd (pid: 149, threadinfo=c5b90000 task=c59f3000)
Stack: c0571c90 00000077 00000000 c5c98288 c5b91ec0 c0159b94 00010c00
00000000
       c776103c 00000246 ff00f448 c062fce0 00000000 00000000 c5b91ef8
c03d4d25
       c5a36094 c5a74004 00000e03 c5b91f20 c77df448 c77df448 c0186c90
c06309c0
Call Trace:
 [<c0159b94>] check_poison_obj+0x54/0x1d0
 [<c03d4d25>] soundcore_open+0x1e5/0x4e0
 [<c0186c90>] exact_match+0x0/0x10
 [<c0186696>] chrdev_open+0x156/0x3e0
 [<c017a388>] get_empty_filp+0x98/0x100
 [<c017823c>] dentry_open+0x12c/0x1c0
 [<c0178106>] filp_open+0x66/0x70
 [<c0178855>] sys_open+0x55/0x90
 [<c010b00f>] syscall_call+0x7/0xb

Code: 81 bb 88 01 00 00 3c 4b 24 1d 74 26 c7 44 24 08 ed 07 00 00


---------------------------------------------------------------------

labo@darkstar:~$ cat /proc/version
Linux version 2.6.0-test3 (root@darkstar) (gcc version 3.2.2) #1 Tue Aug
19 15:18:44 /etc/localtime 2003
--------------------------------------------------------------------

 part of lspci -vvv


------------------------------------------------------------------

00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev
01) (prog-if 00 [UHCI])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin D routed to IRQ 11
        Region 4: I/O ports at dce0 [size=32]

00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 03)
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin ? routed to IRQ 9

00:08.0 Multimedia audio controller: ESS Technology ES1983S Maestro-3i PCI
Audio Accelerator (rev 10)
        Subsystem: Dell Computer Corporation: Unknown device 00bb
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (500ns min, 6000ns max)
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at d800 [size=256]
        Region 1: Memory at faffe000 (32-bit, non-prefetchable) [size=8K]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0-,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:08.1 Communication controller: ESS Technology ES1983S Maestro-3i PCI
Modem Accelerator (rev 10)
        Subsystem: Dell Computer Corporation: Unknown device 00bb
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at d400 [size=256]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=100mA
PME(D0-,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME+

01:00.0 VGA compatible controller: ATI Technologies Inc 3D Rage P/M
Mobility AGP 2x (rev 64) (prog-if 00 [VGA])
        Subsystem: Dell Computer Corporation: Unknown device 00bc
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: I/O ports at ec00 [size=256]
        Region 2: Memory at fcfff000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [50] AGP version 1.0
                Status: RQ=255 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
        Capabilities: [5c] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

----------------------------------------------------------------------

labo@darkstar:~$ cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 3
cpu MHz         : 697.916
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de tsc msr pae mce cx8 sep mtrr pge mca cmov pat
pse36 mmx fxsr sse
bogomips        : 1380.35

----------------------------------------------------------------------



