Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132788AbRDIQDr>; Mon, 9 Apr 2001 12:03:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132785AbRDIQDi>; Mon, 9 Apr 2001 12:03:38 -0400
Received: from staffnet.com ([207.226.80.14]:9999 "EHLO staffnet.com")
	by vger.kernel.org with ESMTP id <S132784AbRDIQDc>;
	Mon, 9 Apr 2001 12:03:32 -0400
Message-ID: <3AD1DD4C.84A2D03C@staffnet.com>
Date: Mon, 09 Apr 2001 12:03:24 -0400
From: Wade Hampton <whampton@staffnet.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>,
        lids-user@lists.sourceforge.net
Subject: OPPS with 2.4.3 and LIDS
Content-Type: multipart/mixed;
 boundary="------------FE10BD1DBD3CF8FFF06CDBF8"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------FE10BD1DBD3CF8FFF06CDBF8
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

See attached oops description.
-- 
W. Wade, Hampton  <whampton@staffnet.com>
--------------FE10BD1DBD3CF8FFF06CDBF8
Content-Type: text/plain; charset=us-ascii;
 name="oops1.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="oops1.txt"

BUG report for vmguest5 on Mon Apr  9 07:00:32 EDT 2001

[1.] One line summary of the problem:    
Kernel oops with 2.4.3+LIDS running under VMWare

[2.] Full description of the problem/report:

The machine that crashed is a RedHat 7.0 virtual 
host running under VMWare 2.0.3 on a RedHat 6.2 
base host.  The virtual host has 2.4.3 with LIDS 1.0.7.
This report is on the virtual host that includes LIDS.

Over the weekend, I had two VMs running on my Linux
box (RH 6.2 with 2.4.3), but apparently there is 
an issue with vmware and 2.4.3 SMP.  The box locked
up (base O/S).  Note, 2.4.3 seems much better than
2.4.1 for vmware lockups with 2 VMs, but still I 
don't recommend it, yet.  This is a separate
issue and I have yet to get an oops I can report.
This will be a separate report....

This morning, I rebooted the base O/S, then once
it was up and functioning properly, I started the
test VM with LIDS.  The test VM started booting,
then came to the login prompt.  It then started
running slocate, etc.  A few minutes after booting,
I got the OOPS.  

[3.] Keywords (i.e., modules, networking, kernel):
kernel 2.4.3, VMWare, LIDS

[4.] Kernel version (from /proc/version):
Linux version 2.4.3 (root@vmguest5) (gcc version 2.96 20000731 (Red Hat Linux 7.0)) #3 Fri Apr 6 10:40:10 EDT 2001

[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)

Trace; c012dc3b <kmalloc+6b/90>
Trace; c01fccf5 <lids_proceed_scan+145/2b0>
Trace; c01fcbb0 <lids_proceed_scan+0/2b0>
Trace; c011a0c3 <timer_bh+213/250>
Trace; c01163fc <bh_action+1c/60>
Trace; c0116306 <tasklet_hi_action+36/60>
Trace; c011620b <do_softirq+5b/80>
Trace; c01083af <do_IRQ+9f/b0>
Trace; c0106fd0 <ret_from_intr+0/20>

Original OOPS:

LIDS:  slocate (3 5 inode 96962) pid 1220 ppid 1218 user (0/0) on NULL tty:
      voliated CAP_DAC_READ_SEARCH

kernelb BUG at slab.c:1073!
invalid operand: 0000
CPU:    0
EIP:    0010:[c012d99b>]
EFLAGS: 00000286
...
Process sendmail (pid: 1552, stackpage c397b000)
Stack:  c0219f9e c021a03e 00000431 00030002 
        c159bbfc c1134050 c25b5005 0026c8ca
        00000003 00000015 c1117570 00000007
        00000000 c1263d20 c012dc3b c1117570
        00000007 00000282 00000001 c111b260
        00001000 c22089e0 0000000c c01fccf5
Call Trace: [<c012dc3b>] [<c01fccf5>] [<c01fcbb0>] [<c011a0c3>] [<c01163fc>]
	[<c0116306>] [<c011620b>] [<c01083af>] [<c0106fd0>]

Kernel panic:  Aiee, killing interrupt handler!
In interrupt handler - not syncing

[6.] A small shell script or example program which triggers the
     problem (if possible)
none

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Base O/S:
- RedHat 6.2 (VA) with updates
- Kernel 2.4.3
- VMWare 2.0.3

VMHost O/S (the one that crashed):
- RedHat 7.0 with updates
- Kernel 2.4.3 
- part of pcnet32 patch removed to get it to work (previous kernel msgs)
- LIDS 1.0.7 patch

Linux vmguest5 2.4.3 #3 Fri Apr 6 10:40:10 EDT 2001 i686 unknown
 
Gnu C                  2.96
Gnu make               3.79.1
binutils               2.10.0.18
util-linux             2.10m
modutils               2.3.21
e2fsprogs              1.18
pcmcia-cs              3.1.19
Linux C Library        > libc.2.2
Dynamic linker (ldd)   2.2
Procps                 2.0.7
Net-tools              1.56
Console-tools          0.3.3
Sh-utils               2.0
Modules Loaded         pcnet32 sb sb_lib uart401 sound soundcore

[7.2.] Processor information (from /proc/cpuinfo):
Base O/S:
- Dual PIII/800 

VMHost O/S (the one that crashed):

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 8
model name	: Pentium III (Coppermine)
stepping	: 3
cpu MHz		: 931.349
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips	: 1228.80


[7.3.] Module information (from /proc/modules):
pcnet32                11600   1 (autoclean)
sb                      7520   0 (unused)
sb_lib                 34528   0 [sb]
uart401                 6416   0 [sb_lib]
sound                  58864   0 [sb_lib uart401]
soundcore               4080   5 [sb_lib sound]

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0220-022f : soundblaster
02e8-02ef : serial(auto)
02f8-02ff : serial(auto)
0330-0333 : MPU-401 UART
0376-0376 : ide1
03c0-03df : vga+
03e8-03ef : serial(auto)
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
1000-101f : Advanced Micro Devices [AMD] 79c970 [PCnet LANCE]
  1000-101f : PCnet/PCI II 79C970A
1020-103f : Advanced Micro Devices [AMD] 79c970 [PCnet LANCE] (#2)
  1020-103f : PCnet/PCI II 79C970A
1040-104f : Intel Corporation 82371AB PIIX4 IDE
1050-105f : VMWare Inc Virtual SVGA

00000000-0009f3ff : System RAM
0009f400-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-03ffffff : System RAM
  00100000-0020ddef : Kernel code
  0020ddf0-002d91b7 : Kernel data
fb000000-fbffffff : VMWare Inc Virtual SVGA
fc000000-fcffffff : VMWare Inc Virtual SVGA
fd000000-fd00001f : Advanced Micro Devices [AMD] 79c970 [PCnet LANCE]
fd000400-fd00041f : Advanced Micro Devices [AMD] 79c970 [PCnet LANCE] (#2)
fec00000-fec0ffff : reserved
fee00000-fee00fff : reserved
fff80000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)
00:00.0 Host bridge: Intel Corporation 430TX - 82439TX MTXC (rev 01)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:07.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 08)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01) (prog-if 8a [Master SecP PriP])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 4: I/O ports at 1040 [size=16]

00:0f.0 Display controller: VMWare Inc Virtual SVGA
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Region 0: I/O ports at 1050 [size=16]
	Region 1: Memory at fc000000 (32-bit, non-prefetchable) [disabled] [size=16M]
	Region 2: Memory at fb000000 (32-bit, non-prefetchable) [disabled] [size=16M]

00:10.0 Ethernet controller: Advanced Micro Devices [AMD] 79c970 [PCnet LANCE] (rev 10)
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (1500ns min, 63750ns max)
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at 1000 [size=32]
	Region 1: Memory at fd000000 (32-bit, non-prefetchable) [disabled] [size=32]

00:11.0 Ethernet controller: Advanced Micro Devices [AMD] 79c970 [PCnet LANCE] (rev 10)
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (1500ns min, 63750ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at 1020 [size=32]
	Region 1: Memory at fd000400 (32-bit, non-prefetchable) [disabled] [size=32]


[7.6.] SCSI information (from /proc/scsi/scsi)
None

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

Base O/S:
- Dual PIII/800 
- 256M RAM
- AIC7xxx scsi

VMHost O/S (the one that crashed):
- Single PIII with wrong speed and bogomips reported
- 64M RAM
- RTC and sound connected
- CDROM and FLOPPY disconnected

[X.] Other notes, patches, fixes, workarounds:
None

--------------FE10BD1DBD3CF8FFF06CDBF8--

