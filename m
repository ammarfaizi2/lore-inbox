Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264562AbTLCMsk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 07:48:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264563AbTLCMsk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 07:48:40 -0500
Received: from serena.fsr.ku.dk ([130.225.215.194]:16856 "EHLO
	serena.fsr.ku.dk") by vger.kernel.org with ESMTP id S264562AbTLCMsb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 07:48:31 -0500
To: linux-kernel@vger.kernel.org
Subject: 2.4.23 oops on boot
From: Henrik Christian Grove <grove@sslug.dk>
Organization: =?iso-8859-1?q?Sk=E5ne_Sj=E6lland?= Linux User Group
Date: 03 Dec 2003 13:48:29 +0100
Message-ID: <7gfzg2kqxu.fsf@serena.fsr.ku.dk>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[1.] One line summary of the problem:    

A newly compiled 2.4.23 kernel oops'es early in the boot process.

[2.] Full description of the problem/report:

Shortly after booting a 2.4.23 kernel it oops'es and panics leaving the
computer 100% unusable. The 'Caps Lock' and 'Scroll Lock' LEDs on the
keyboard blinks.

[3.] Keywords (i.e., modules, networking, kernel):

Booting the kernel.

[4.] Kernel version (from /proc/version):

2.4.23 (not from /proc/version as the computer never reaches a useable
    state). 

[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)

Copied by hand:
-----
CPU: Intel Pentium MMX stepping 04
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
Unable to handle kernel NULL pointer dereference at virtual address
00000003
 printing eip:
c0114203
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0qq4203>]    Not tainted
EFLAGS: 00010286
eax: ffffffff   ebx: c1170000   ecx: 00000000   edx: c029e000
esi: c029e5a0   edi: c11705a0   ebp: 00010f00   esp: c029ff34
ds: 0018   es: 0018   ss: 0018
Process per (pid: 0, stackpage=c029f000)
Stack: c029e000 c029ffac 00000000 c029ff70 000001f0 fffffff5 c110d420 000001f0
       c0286e9c 00000625 c0105925 00010f00 00000078 c029ff78 00000000
0008e000
       c0106c43 00010f00 00000078 c0105054 c029ffac 00000000 0008e000
00000078
Call Trace:    [<c0105925>] [<c0106c43>] [<c0105054>] [<c0105567>]
[<c0105000>]
  [<c0114151>] [<c0105054>] [<c0105011>] [<c0105054>]

Code: 8b 40 04 3b 83 18 02 00 00 72 1c 8b 82 d4 01 00 00 a9 00 00
 <0>Kernel panic: Attempted to kill the idle task!
In idle task - not syncing
-----

Output from `ksymoops -v /home/src/linux-2.4.23/vmlinux -K -L -O -m
/boot/System.map-2.4.23 celine-oops-2.4.23.txt`:
-----
ksymoops 2.4.5 on i586 2.4.21.  Options used
     -v /home/src/linux-2.4.23/vmlinux (specified)
     -K (specified)
     -L (specified)
     -O (specified)
     -m /boot/System.map-2.4.23 (specified)

Unable to handle kernel NULL pointer dereference at virtual address
00000003
c0114203
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0qq4203>]    Not tainted
EFLAGS: 00010286
eax: ffffffff   ebx: c1170000   ecx: 00000000   edx: c029e000
esi: c029e5a0   edi: c11705a0   ebp: 00010f00   esp: c029ff34
ds: 0018   es: 0018   ss: 0018
Process per (pid: 0, stackpage=c029f000)
Stack: c029e000 c029ffac 00000000 c029ff70 000001f0 fffffff5 c110d420 000001f0
       c0286e9c 00000625 c0105925 00010f00 00000078 c029ff78 00000000
0008e000
       c0106c43 00010f00 00000078 c0105054 c029ffac 00000000 0008e000
00000078
Call Trace:    [<c0105925>] [<c0106c43>] [<c0105054>] [<c0105567>]
[<c0105000>]
  [<c0114151>] [<c0105054>] [<c0105011>] [<c0105054>]
Code: 8b 40 04 3b 83 18 02 00 00 72 1c 8b 82 d4 01 00 00 a9 00 00
Using defaults from ksymoops -t elf32-i386 -a i386


>>eax; ffffffff <END_OF_CODE+3fce53a3/????>
>>ebx; c1170000 <END_OF_CODE+e553a4/????>
>>edx; c029e000 <init_task_union+0/2000>
>>esi; c029e5a0 <init_task_union+5a0/2000>
>>edi; c11705a0 <END_OF_CODE+e55944/????>
>>ebp; 00010f00 Before first symbol
>>esp; c029ff34 <init_task_union+1f34/2000>

Trace; c0105925 <sys_clone+1d/24>
Trace; c0106c43 <system_call+33/40>
Trace; c0105054 <init+0/ec>
Trace; c0105567 <arch_kernel_thread+1f/38>
Trace; c0105000 <_stext+0/0>
Trace; c0114151 <kernel_thread+35/5c>
Trace; c0105054 <init+0/ec>
Trace; c0105011 <rest_init+11/28>
Trace; c0105054 <init+0/ec>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 40 04                  mov    0x4(%eax),%eax
Code;  00000003 Before first symbol
   3:   3b 83 18 02 00 00         cmp    0x218(%ebx),%eax
Code;  00000009 Before first symbol
   9:   72 1c                     jb     27 <_EIP+0x27> 00000027 Before
first sy
mbol
Code;  0000000b Before first symbol
   b:   8b 82 d4 01 00 00         mov    0x1d4(%edx),%eax
Code;  00000011 Before first symbol
  11:   a9 00 00 00 00            test   $0x0,%eax

 <0>Kernel panic: Attempted to kill the idle task!
-----

[6.] A small shell script or example program which triggers the
     problem (if possible)

All I have to do to trigger the problem is to boot a specific kernel.

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)

I use lilo 22.2 (from Debian Woody) to boot, since nothing else runs I
don't find that relevant.

[7.2.] Processor information (from /proc/cpuinfo):

Taken while running a 2.4.21 kernel:
-----
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 5
model           : 4
model name      : Pentium MMX
stepping        : 4
cpu MHz         : 200.456
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : yes
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 mmx
bogomips        : 399.76
-----

[7.3.] Module information (from /proc/modules):
[7.4.] Loaded driver and hardware information (/proc/ioports,
/proc/iomem)
[7.5.] PCI information ('lspci -vvv' as root)

Again taken while running 2.4.21:
-----
00:00.0 Host bridge: Intel Corp. 430TX - 82439TX MTXC (rev 01)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
        ParErr- Step
ping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
        <TAbort
- <MAbort+ >SERR- <PERR-
        Latency: 32

00:07.0 ISA bridge: Intel Corp. 82371AB PIIX4 ISA (rev 01)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
        ParErr- Step
ping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
        <TAbort
- <MAbort- >SERR- <PERR-
        Latency: 0

00:07.1 IDE interface: Intel Corp. 82371AB PIIX4 IDE (rev 01) (prog-if
80 [Maste
r])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Step
ping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort
- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 4: I/O ports at f000 [size=16]
00:07.2 USB Controller: Intel Corp. 82371AB PIIX4 USB (rev 01) (prog-if
00 [UHCI
])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Step
ping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort
- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin D routed to IRQ 11
        Region 4: I/O ports at 6300 [size=32]

00:07.3 Bridge: Intel Corp. 82371AB PIIX4 ACPI (rev 01)
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
        ParErr- Step
ping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
        <TAbort
- <MAbort- >SERR- <PERR-
        Interrupt: pin ? routed to IRQ 9

00:09.0 VGA compatible controller: S3 Inc. 86c988 [ViRGE/VX] (rev 02)
(prog-if 0
0 [VGA])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Step
ping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort
- <MAbort- >SERR- <PERR-
        Latency: 32 (1000ns min, 63750ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at e0000000 (32-bit, non-prefetchable)
[size=64M]
        Expansion ROM at <unassigned> [disabled] [size=64K]

00:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139
(rev 10)
        Subsystem: D-Link System Inc DFE-538TX
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Step
ping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort
- <MAbort- >SERR- <PERR-
        Latency: 32 (8000ns min, 16000ns max)
        Interrupt: pin A routed to IRQ 9
        Region 0: I/O ports at 6400 [size=256]
        Region 1: Memory at e4000000 (32-bit, non-prefetchable)
[size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1+,D2+,D3hot
+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139
(rev 10)
        Subsystem: Accton Technology Corporation: Unknown device ec01
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Step
ping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort
- <MAbort- >SERR- <PERR-
        Latency: 32 (8000ns min, 16000ns max)
        Interrupt: pin A routed to IRQ 9
        Region 0: I/O ports at 6500 [size=256]
        Region 1: Memory at e4001000 (32-bit, non-prefetchable)
[size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot
-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0c.0 SCSI storage controller: LSI Logic / Symbios Logic (formerly
NCR) 53c875
 (rev 04)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr+ Step
ping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort
- <MAbort- >SERR- <PERR-
        Latency: 72 (4250ns min, 16000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at 6600 [size=256]
        Region 1: Memory at e4002000 (32-bit, non-prefetchable)
[size=256]
        Region 2: Memory at e4003000 (32-bit, non-prefetchable)
[size=4K]
        Expansion ROM at <unassigned> [disabled] [size=64K]
-----

[7.6.] SCSI information (from /proc/scsi/scsi)

Again taken while running 2.4.21:
-----
Attached devices: 
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: PLEXTOR  Model: CD-ROM PX-40TS   Rev: 1.10
  Type:   CD-ROM                           ANSI SCSI revision: 02
-----

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
[X.] Other notes, patches, fixes, workarounds:

.Henrik

-- 
Når man kører Linux er dette også en mulighed:
   Modeline  "912x684"    64.00 912 966 1104 1232 684 699 706 734
