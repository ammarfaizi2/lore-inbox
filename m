Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264369AbTCXR7A>; Mon, 24 Mar 2003 12:59:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264374AbTCXR7A>; Mon, 24 Mar 2003 12:59:00 -0500
Received: from fubar.phlinux.com ([216.254.54.154]:3760 "EHLO
	fubar.phlinux.com") by vger.kernel.org with ESMTP
	id <S264369AbTCXR6Y>; Mon, 24 Mar 2003 12:58:24 -0500
Date: Mon, 24 Mar 2003 10:09:27 -0800 (PST)
From: Matt C <wago@phlinux.com>
To: andrea@suse.de
Cc: The Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.4.21-pre5aa2: BUG in vmscan.c:694
Message-ID: <Pine.LNX.4.44.0303241004300.10958-100000@fubar.phlinux.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All:

I posted an OOPS under 2.4.21-pre5 about a week ago listing the details of
a BUG in vmscan.c:359. I ran the same tests under -pre5aa2 to see if there
are still problems in the upstream VM, and got an oops at a new line
number.

For my earlier report, see:
http://www.uwsg.iu.edu/hypermail/linux/kernel/0303.2/0347.html

Thanks in advance for your help!

-Matt

Here's the full bug report as per REPORTING-BUGS in the kernel source 
tree:

[1.] One line summary of the problem:  
Kernel bug in 2.4.21-pre5aa2 VM

[2.] Full description of the problem/report:
Had the following oops on 2.4.21-pre5aa2. The machine was under a high
artificial load of stress-kernel and large file copies involving local
and NFS disk. I tried to load netconsole.o at boot, but it failed since
my network card was not supported. However, that generated the "Tainted: P"
in the OOPS below. The storage on this machine is an HP NetRaid, which is
the HP-branded megaraid controller. The megaraid driver is compiled
in the monolithic kernel.

[3.] Keywords (i.e., modules, networking, kernel):
kernel, VM, andrea, 2.4.21-pre5aa2

[4.] Kernel version (from /proc/version):
Linux version 2.4.21-pre5aa2 (wago@kernel-build-1.phlinux.com) (gcc
version 2.96 20000731 (Red Hat Linux 7.1 2.96-98)) #1 SMP Tue Mar 18 11:04:51
PST 2003

[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)
kernel BUG at vmscan.c:694!                               
invalid operand: 0000 2.4.21-pre5aa2 #1 SMP Tue Mar 18 11:04:51 PST 2003        
CPU:    0                                                                       
EIP:    0010:[<c013af6a>]    Tainted: P                                         
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202                                                                
eax: 010000c1   ebx: c18a5300   ecx: 0000000f   edx: ffffffff                   
esi: c18a531c   edi: c15b66ec   ebp: e1f2bd6c   esp: e1f2bd58                   
ds: 0018   es: 0018   ss: 0018                                                  
Process memtst (pid: 4609, stackpage=e1f2b000)                                  
Stack: 00000009 c02cddd8 00000000 00000006 0000001f e1f2bda4 c013ad47 e1f2a000  
       00000c1c 00001ce0 000001d2 c02cddd8 c013af92 c18714f0 00000001 00000000  
       0000001f 000001d2 c02cddd8 e1f2bdbc c013b03e e1f2bdd4 0000003b 000001d2  
Call Trace:    [<c013ad47>] [<c013af92>] [<c013b03e>] [<c013b0c0>] [<c013be5e>] 
  [<c013c1c2>] [<c013ccec>] [<c012cf2d>] [<c012cfc0>] [<c01f251d>] [<c012da85>] 
  [<c01f7efc>] [<c0115c92>] [<c0120fb0>] [<c0124a4c>] [<c012503e>] [<c010ad13>] 
  [<c0115a80>] [<c0109194>]                                                     
Code: 0f 0b b6 02 b8 91 28 c0 a1 f4 d2 2c c0 89 70 04 89 43 1c c7     

>>EIP; c013af6a <refill_inactive+16a/200>   <=====
Trace; c013ad47 <shrink_cache+3d7/490>
Trace; c013af92 <refill_inactive+192/200>
Trace; c013b03e <shrink_caches+3e/50>
Trace; c013b0c0 <try_to_free_pages_zone+70/100>
Trace; c013be5e <balance_classzone+6e/180>
Trace; c013c1c2 <__alloc_pages+252/380>
Trace; c013ccec <read_swap_cache_async+6c/ac>
Trace; c012cf2d <swapin_readahead+4d/60>
Trace; c012cfc0 <do_swap_page+80/340>
Trace; c01f251d <scsi_old_done+6ed/710>
Trace; c012da85 <handle_mm_fault+a5/180>
Trace; c01f7efc <megaraid_isr+34c/370>
Trace; c0115c92 <do_page_fault+212/656>
Trace; c0120fb0 <__run_task_queue+60/70>
Trace; c0124a4c <tqueue_bh+1c/30>
Trace; c012503e <run_local_timers+9e/130>
Trace; c010ad13 <do_IRQ+e3/f0>
Trace; c0115a80 <do_page_fault+0/656>
Trace; c0109194 <error_code+34/3c>
Code;  c013af6a <refill_inactive+16a/200>
00000000 <_EIP>:
Code;  c013af6a <refill_inactive+16a/200>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c013af6c <refill_inactive+16c/200>
   2:   b6 02                     mov    $0x2,%dh
Code;  c013af6e <refill_inactive+16e/200>
   4:   b8 91 28 c0 a1            mov    $0xa1c02891,%eax
Code;  c013af73 <refill_inactive+173/200>
   9:   f4                        hlt    
Code;  c013af74 <refill_inactive+174/200>
   a:   d2 2c c0                  shrb   %cl,(%eax,%eax,8)
Code;  c013af77 <refill_inactive+177/200>
   d:   89 70 04                  mov    %esi,0x4(%eax)
Code;  c013af7a <refill_inactive+17a/200>
  10:   89 43 1c                  mov    %eax,0x1c(%ebx)
Code;  c013af7d <refill_inactive+17d/200>
  13:   c7 00 00 00 00 00         movl   $0x0,(%eax)

[6.] A small shell script or example program which triggers the
     problem (if possible)
3 tests running concurrently:
	i. stress-kernel-1.2.15-16.2
	ii. 'largefile-integrity' shell script:
---------------------------------------------------------------------
#!/bin/bash
#
# test largefile integrity

# directory to store our files
WORKDIR=/workplace/test/

# datafile size. you need 3x this available on the workdir
SIZE=1000
# SIZE=10

# step 1: create the master file
MASTER=${WORKDIR}/lftest.master
echo -n "Creating master file ... "
dd if=/dev/urandom of=${MASTER} bs=1M count=${SIZE} 2>/dev/null > /dev/null
echo "done"
echo

# step 2: run the copy loop
COPY1=${WORKDIR}/lftest.copy1
COPY2=${WORKDIR}/lftest.copy2
i=0
echo "Running INFINITE loops of a ping-pong file copy:"
cp ${MASTER} ${COPY1}
while :; do
        i=`expr $i + 1`
        dd if=${COPY1} of=${COPY2} bs=1M 2>/dev/null >/dev/null
        rm ${COPY1}
        cp ${COPY2} ${COPY1}
        rm ${COPY2}
        echo -n "Results of loop ${i}: "
        diff -q -s ${MASTER} ${COPY1}
done
---------------------------------------------------------------------

	iii. 'combo-cat-loop' scripts:
---------------------------------------------------------------------
#!/bin/bash
# master combo-cat-loop script
i=0

while :; do
        i=`expr $i + 1`
        echo -n "Starting loop $i... "
        find /net/linux-test-2/workplace1 -type f -exec ./combo-child {} \;
> /dev/null 1> /dev/null 2> /dev/null
        echo "done."
done
---------------------------------------------------------------------
#!/bin/bash
# slave combo-child script

base=`basename $1`

if [ -f $1 ] ; then
        cp ${1} /workplace/test/${base}
        cat /workplace/test/${base} > /dev/null
        rm -f /workplace/test/${base}
fi
---------------------------------------------------------------------


[7.] Environment
distro: redhat-7.2
system: HP NetServer LT6000R 4x550MHz P3-Xeon
mem: 2GB ECC (tested via memtest86)
disk: 4x 18G internal in megaraid RAID-1+0
net: intel etherexpress pro/100 onboard

[7.1.] Software (add the output of the ver_linux script here)
Linux linux-test-1.phlinux.com 2.4.21-pre5aa2 #1 SMP Tue Mar 18 11:04:51 PST 2003 i686 unknown
 
Gnu C                  2.95.3
Gnu make               3.79.1
binutils               2.11.90.0.8
util-linux             2.11f
mount                  2.11g
modutils               2.4.22
e2fsprogs              1.26
reiserfsprogs          3.x.0j
Linux C Library        2.2.4
Dynamic linker (ldd)   2.2.4
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.3.3
Sh-utils               2.0.11
Modules Loaded         e100 loop

[7.2.] Processor information (from /proc/cpuinfo):
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 7
model name      : Pentium III (Katmai)
stepping        : 3
cpu MHz         : 550.065
cache size      : 2048 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 mmx fxsr sse
bogomips        : 1097.72

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 7
model name      : Pentium III (Katmai)
stepping        : 3
cpu MHz         : 550.065
cache size      : 2048 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 mmx fxsr sse
bogomips        : 1038.74

processor       : 2
vendor_id       : GenuineIntel
cpu family      : 6
model           : 7
model name      : Pentium III (Katmai)
stepping        : 3
cpu MHz         : 550.065
cache size      : 2048 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 mmx fxsr sse
bogomips        : 1097.72

processor       : 3
vendor_id       : GenuineIntel
cpu family      : 6
model           : 7
model name      : Pentium III (Katmai)
stepping        : 3
cpu MHz         : 550.065
cache size      : 2048 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 mmx fxsr sse
bogomips        : 1097.72

[7.3.] Module information (from /proc/modules):
e100                   60100   1
loop                   10960   0 (autoclean)

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
$ cat /proc/ioports 
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
02f8-02ff : serial(auto)
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
1400-14ff : ATI Technologies Inc 3D Rage IIC
1800-183f : Intel Corp. 82557/8/9 [Ethernet Pro 100]
  1800-183f : e100
1840-184f : ServerWorks OSB4 IDE Controller
2000-20ff : Hewlett-Packard Company NetServer PCI Hot-Plug Controller
2400-24ff : Hewlett-Packard Company NetServer SMIC Controller
2800-283f : Intel Corp. 82557/8/9 [Ethernet Pro 100] (#2)
  2800-283f : e100
3000-3fff : PCI Bus #03
  3000-3007 : Hewlett-Packard Company TopTools Remote Control
  3008-300b : Hewlett-Packard Company TopTools Remote Control
  3010-3017 : Hewlett-Packard Company TopTools Remote Control

$ cat /proc/iomem   
00000000-0009e7ff : System RAM
0009e800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000c8fff : Extension ROM
000f0000-000fffff : System ROM
00100000-7ffeffff : System RAM
  00100000-00279817 : Kernel code
  00279818-002e35ff : Kernel data
7fff0000-7ffffbff : ACPI Tables
7ffffc00-7fffffff : ACPI Non-volatile Storage
f4001000-f4001fff : Intel Corp. 82557/8/9 [Ethernet Pro 100]
  f4001000-f4001fff : e100
f4002000-f4002fff : ATI Technologies Inc 3D Rage IIC
f4100000-f41fffff : Intel Corp. 82557/8/9 [Ethernet Pro 100]
  f4100000-f41fffff : e100
f5000000-f5ffffff : ATI Technologies Inc 3D Rage IIC
f6000000-f60fffff : Intel Corp. 82557/8/9 [Ethernet Pro 100] (#2)
  f6000000-f60fffff : e100
f6100000-f6100fff : Intel Corp. 82557/8/9 [Ethernet Pro 100] (#2)
  f6100000-f6100fff : e100
f6200000-f62fffff : PCI Bus #03
  f6200000-f6207fff : Hewlett-Packard Company NetServer Smart IRQ Router
  f6208000-f6208fff : Hewlett-Packard Company TopTools Remote Control
  f6240000-f627ffff : Hewlett-Packard Company TopTools Remote Control
f8000000-fbffffff : Intel Corp. 80960RP [i960RP Microprocessor]
fec00000-fecfffff : reserved
fee00000-feefffff : reserved
fff80000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)
00:00.0 Host bridge: ServerWorks CNB20HE Host Bridge (rev 21)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:00.1 Host bridge: ServerWorks CNB20HE Host Bridge (rev 01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 64, cache line size 08

00:00.2 Host bridge: ServerWorks: Unknown device 0006
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-

00:00.3 Host bridge: ServerWorks: Unknown device 0006
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-

00:06.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 08)
	Subsystem: Hewlett-Packard Company: Unknown device 10ca
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min, 14000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 18
	Region 0: Memory at f4001000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at 1800 [size=64]
	Region 2: Memory at f4100000 (32-bit, non-prefetchable) [size=1M]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:07.0 VGA compatible controller: ATI Technologies Inc 3D Rage IIC (rev 7a) (prog-if 00 [VGA])
	Subsystem: Hewlett-Packard Company: Unknown device 10c4
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 66 (2000ns min), cache line size 08
	Region 0: Memory at f5000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: I/O ports at 1400 [size=256]
	Region 2: Memory at f4002000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [5c] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0f.0 ISA bridge: ServerWorks OSB4 South Bridge (rev 4f)
	Subsystem: ServerWorks OSB4 South Bridge
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:0f.1 IDE interface: ServerWorks OSB4 IDE Controller (prog-if 8a [Master SecP PriP])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at 1840 [size=16]

02:02.0 System peripheral: Hewlett-Packard Company NetServer PCI Hot-Plug Controller (rev 0d)
	Subsystem: Hewlett-Packard Company: Unknown device 0001
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 16
	Region 0: I/O ports at 2000 [size=256]

02:02.1 InfiniBand: Hewlett-Packard Company NetServer SMIC Controller (rev 09)
	Subsystem: Hewlett-Packard Company: Unknown device 0001
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 17
	Region 0: I/O ports at 2400 [size=256]

02:03.0 PCI bridge: Intel Corporation 80960RP [i960 RP Microprocessor/Bridge] (rev 01) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, cache line size 08
	Bus: primary=02, secondary=03, subordinate=03, sec-latency=64
	I/O behind bridge: 00003000-00003fff
	Memory behind bridge: f6200000-f62fffff
	Prefetchable memory behind bridge: fff00000-000fffff
	BridgeCtl: Parity+ SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [68] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:03.1 I2O: Intel Corporation 80960RP [i960RP Microprocessor] (rev 01) (prog-if 01)
	Subsystem: Hewlett-Packard Company: Unknown device 10cc
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B+
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, cache line size 08
	Interrupt: pin A routed to IRQ 20
	Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
	Expansion ROM at <unassigned> [disabled] [size=32K]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:04.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 08)
	Subsystem: Hewlett-Packard Company: Unknown device 10cb
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min, 14000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 21
	Region 0: Memory at f6100000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at 2800 [size=64]
	Region 2: Memory at f6000000 (32-bit, non-prefetchable) [size=1M]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

03:02.0 Class ff00: Hewlett-Packard Company TopTools Remote Control (rev 02)
	Subsystem: Hewlett-Packard Company: Unknown device 10c8
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, cache line size 08
	Interrupt: pin A routed to IRQ 22
	Region 0: Memory at f6208000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at 3010 [size=8]
	Region 2: I/O ports at 3008 [size=4]
	Region 3: I/O ports at 3000 [size=8]
	Region 4: Memory at f6240000 (32-bit, non-prefetchable) [size=256K]
	Expansion ROM at <unassigned> [disabled] [size=64K]

03:08.0 System peripheral: Hewlett-Packard Company NetServer Smart IRQ Router (rev a0)
	Subsystem: Hewlett-Packard Company: Unknown device 0001
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Region 0: Memory at f6200000 (32-bit, non-prefetchable) [size=32K]


[7.6.] SCSI information (from /proc/scsi/scsi)
Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: MegaRAID Model: LD0 RAID1 34730R Rev:   E 
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 04 Id: 05 Lun: 00
  Vendor: HP       Model: SAFTE; U160/M BP Rev: 1023
  Type:   Processor                        ANSI SCSI revision: 02


[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

Filesystem mounts:
rootfs / rootfs rw 0 0
/dev/root / ext3 rw 0 0
/proc /proc proc rw 0 0
/dev/sda1 /boot ext3 rw 0 0
none /dev/pts devpts rw 0 0
/dev/sda2 /opt ext3 rw 0 0
none /dev/shm tmpfs rw 0 0
/dev/sda7 /tmp ext3 rw 0 0
/dev/sda3 /var ext3 rw 0 0
/dev/sda8 /workplace ext3 rw,noatime 0 0
linux-test-1:(pid787) /net nfs rw,sync,v2,rsize=1024,wsize=1024,acregmin=0,acregmax=0,acdirmin=0,acdirmax=0,hard,intr,udp,noac,lock,addr=pid787@linux-test-1:/net 0 0
linux-test-2:/workplace1 /.automount/linux-test-2/root/workplace1 nfs rw,nosuid,nodev,v3,rsize=8192,wsize=8192,hard,intr,tcp,lock,addr=linux-test-2 0 0

$ df -h
Filesystem            Size  Used Avail Use% Mounted on
/dev/sda5             2.0G  719M  1.1G  38% /
/dev/sda1              61M   38M   20M  65% /boot
/dev/sda2             7.9G  4.4G  3.0G  59% /opt
none                 1010M     0 1010M   0% /dev/shm
/dev/sda7            1011M   43M  917M   5% /tmp
/dev/sda3             3.9G  102M  3.6G   3% /var
/dev/sda8              17G  3.7G   12G  23% /workplace
linux-test-2:/workplace1
                       20G   15G  4.3G  77% /.automount/linux-test-2/root/workplace1


Kernel .config:

#
# Automatically generated by make menuconfig: don't edit
#
CONFIG_X86=y
# CONFIG_SBUS is not set
CONFIG_UID16=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y

#
# Processor type and features
#
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
CONFIG_M686=y
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MELAN is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_CMPXCHG8=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_HAS_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_PPRO_FENCE=y
CONFIG_X86_F00F_WORKS_OK=y
CONFIG_X86_MCE=y
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_THINKPAD is not set
CONFIG_MICROCODE=m
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=y
# CONFIG_HIGHMEM64G is not set
CONFIG_HIGHMEM=y
CONFIG_FORCE_MAX_ZONEORDER=11
CONFIG_1GB=y
# CONFIG_2GB is not set
# CONFIG_3GB is not set
# CONFIG_05GB is not set
CONFIG_HIGHIO=y
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
CONFIG_SMP=y
# CONFIG_X86_NUMA is not set
# CONFIG_X86_TSC_DISABLE is not set
CONFIG_X86_TSC=y
CONFIG_HAVE_DEC_LOCK=y

#
# General setup
#
CONFIG_NET=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_ISA=y
CONFIG_PCI_NAMES=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
# CONFIG_HOTPLUG is not set
# CONFIG_PCMCIA is not set
# CONFIG_HOTPLUG_PCI is not set
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_MAX_USER_RT_PRIO=100
CONFIG_MAX_RT_PRIO=0
CONFIG_KCORE_ELF=y
# CONFIG_KCORE_AOUT is not set
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=m
# CONFIG_PM is not set
# CONFIG_ACPI is not set
# CONFIG_APM is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_CML1=m
CONFIG_PARPORT_SERIAL=m
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_AMIGA is not set
# CONFIG_PARPORT_MFC3 is not set
# CONFIG_PARPORT_ATARI is not set
# CONFIG_PARPORT_GSC is not set
# CONFIG_PARPORT_SUNBPP is not set
# CONFIG_PARPORT_OTHER is not set
CONFIG_PARPORT_1284=y

#
# Plug and Play configuration
#
CONFIG_PNP=y
CONFIG_ISAPNP=y

#
# Block devices
#
CONFIG_BLK_DEV_FD=y
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
CONFIG_BLK_CPQ_DA=m
CONFIG_BLK_CPQ_CISS_DA=m
CONFIG_CISS_SCSI_TAPE=y
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y
CONFIG_BLK_STATS=y

#
# Multi-device support (RAID and LVM)
#
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_LINEAR=y
CONFIG_MD_RAID0=y
CONFIG_MD_RAID1=y
CONFIG_MD_RAID5=y
CONFIG_MD_MULTIPATH=y
CONFIG_BLK_DEV_LVM=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_NETLINK_DEV=y
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set
CONFIG_FILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
# CONFIG_TUX is not set
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
# CONFIG_ARPD is not set
# CONFIG_INET_ECN is not set
CONFIG_SYN_COOKIES=y

#
#   IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_IRC=m
CONFIG_IP_NF_QUEUE=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_PKTTYPE=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
# CONFIG_IP_NF_MATCH_ECN is not set
# CONFIG_IP_NF_MATCH_DSCP is not set
# CONFIG_IP_NF_MATCH_AH_ESP is not set
CONFIG_IP_NF_MATCH_LENGTH=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_MATCH_TCPMSS=m
# CONFIG_IP_NF_MATCH_HELPER is not set
CONFIG_IP_NF_MATCH_STATE=m
CONFIG_IP_NF_MATCH_CONNTRACK=m
CONFIG_IP_NF_MATCH_UNCLEAN=m
CONFIG_IP_NF_MATCH_OWNER=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_MIRROR=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
# CONFIG_IP_NF_NAT_LOCAL is not set
CONFIG_IP_NF_NAT_SNMP_BASIC=m
CONFIG_IP_NF_NAT_IRC=m
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
# CONFIG_IP_NF_TARGET_ECN is not set
# CONFIG_IP_NF_TARGET_DSCP is not set
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_ULOG=m
CONFIG_IP_NF_TARGET_TCPMSS=m
CONFIG_IP_NF_ARPTABLES=m
# CONFIG_IP_NF_ARPFILTER is not set
# CONFIG_IP_NF_COMPAT_IPCHAINS is not set
# CONFIG_IP_NF_COMPAT_IPFWADM is not set
CONFIG_IPV6=m

#
#   IPv6: Netfilter Configuration
#
# CONFIG_IP6_NF_QUEUE is not set
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_LIMIT=m
CONFIG_IP6_NF_MATCH_MAC=m
CONFIG_IP6_NF_MATCH_MULTIPORT=m
CONFIG_IP6_NF_MATCH_OWNER=m
CONFIG_IP6_NF_MATCH_MARK=m
# CONFIG_IP6_NF_MATCH_LENGTH is not set
# CONFIG_IP6_NF_MATCH_EUI64 is not set
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_LOG=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_TARGET_MARK=m
# CONFIG_KHTTPD is not set
# CONFIG_ATM is not set
CONFIG_VLAN_8021Q=m
# CONFIG_IPX is not set
CONFIG_ATALK=m

#
# Appletalk devices
#
# CONFIG_DEV_APPLETALK is not set
# CONFIG_DECNET is not set
CONFIG_BRIDGE=m
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_LLC is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set
# CONFIG_PHONE_IXJ is not set
# CONFIG_PHONE_IXJ_PCMCIA is not set

#
# ATA/IDE/MFM/RLL support
#
CONFIG_IDE=y

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
# CONFIG_IDEDISK_STROKE is not set
# CONFIG_BLK_DEV_IDECS is not set
CONFIG_BLK_DEV_IDECD=m
CONFIG_BLK_DEV_IDETAPE=m
CONFIG_BLK_DEV_IDEFLOPPY=y
CONFIG_BLK_DEV_IDESCSI=m
# CONFIG_IDE_TASK_IOCTL is not set
CONFIG_BLK_DEV_CMD640=y
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
CONFIG_BLK_DEV_ISAPNP=y
CONFIG_BLK_DEV_IDEPCI=y
# CONFIG_BLK_DEV_GENERIC is not set
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
# CONFIG_IDEDMA_PCI_AUTO is not set
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_PCI_WIP is not set
CONFIG_BLK_DEV_ADMA=y
CONFIG_BLK_DEV_AEC62XX=m
CONFIG_BLK_DEV_ALI15X3=m
# CONFIG_WDC_ALI15X3 is not set
CONFIG_BLK_DEV_AMD74XX=m
# CONFIG_AMD74XX_OVERRIDE is not set
CONFIG_BLK_DEV_CMD64X=m
CONFIG_BLK_DEV_TRIFLEX=m
CONFIG_BLK_DEV_CY82C693=m
CONFIG_BLK_DEV_CS5530=m
CONFIG_BLK_DEV_HPT34X=m
# CONFIG_HPT34X_AUTODMA is not set
CONFIG_BLK_DEV_HPT366=m
CONFIG_BLK_DEV_PIIX=m
CONFIG_BLK_DEV_NFORCE=m
CONFIG_BLK_DEV_NS87415=m
CONFIG_BLK_DEV_OPTI621=m
CONFIG_BLK_DEV_PDC202XX_OLD=m
# CONFIG_PDC202XX_BURST is not set
CONFIG_BLK_DEV_PDC202XX_NEW=m
# CONFIG_PDC202XX_FORCE is not set
CONFIG_BLK_DEV_RZ1000=m
CONFIG_BLK_DEV_SC1200=m
CONFIG_BLK_DEV_SVWKS=m
# CONFIG_BLK_DEV_SIIMAGE is not set
CONFIG_BLK_DEV_SIS5513=m
CONFIG_BLK_DEV_SLC90E66=m
CONFIG_BLK_DEV_TRM290=m
CONFIG_BLK_DEV_VIA82CXXX=m
CONFIG_IDE_CHIPSETS=y
# CONFIG_BLK_DEV_4DRIVES is not set
# CONFIG_BLK_DEV_ALI14XX is not set
# CONFIG_BLK_DEV_DTC2278 is not set
# CONFIG_BLK_DEV_HT6560B is not set
# CONFIG_BLK_DEV_PDC4030 is not set
# CONFIG_BLK_DEV_QD65XX is not set
# CONFIG_BLK_DEV_UMC8672 is not set
# CONFIG_IDEDMA_AUTO is not set
# CONFIG_IDEDMA_IVB is not set
# CONFIG_DMA_NONPCI is not set
CONFIG_BLK_DEV_PDC202XX=y
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_BLK_DEV_ATARAID=m
CONFIG_BLK_DEV_ATARAID_PDC=m
CONFIG_BLK_DEV_ATARAID_HPT=m
# CONFIG_BLK_DEV_ATARAID_SII is not set

#
# SCSI support
#
CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=y
CONFIG_SD_EXTRA_DEVS=40
CONFIG_CHR_DEV_ST=m
CONFIG_CHR_DEV_OSST=m
CONFIG_BLK_DEV_SR=m
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_SR_EXTRA_DEVS=4
CONFIG_CHR_DEV_SG=m
# CONFIG_SCSI_DEBUG_QUEUES is not set
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y

#
# SCSI low-level drivers
#
CONFIG_BLK_DEV_3W_XXXX_RAID=m
CONFIG_SCSI_7000FASST=m
CONFIG_SCSI_ACARD=m
CONFIG_SCSI_AHA152X=m
CONFIG_SCSI_AHA1542=m
CONFIG_SCSI_AHA1740=m
CONFIG_SCSI_AACRAID=m
CONFIG_SCSI_AIC7XXX=m
CONFIG_AIC7XXX_CMDS_PER_DEVICE=253
CONFIG_AIC7XXX_RESET_DELAY_MS=15000
# CONFIG_AIC7XXX_PROBE_EISA_VL is not set
# CONFIG_AIC7XXX_BUILD_FIRMWARE is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
CONFIG_SCSI_DPT_I2O=m
CONFIG_SCSI_ADVANSYS=m
CONFIG_SCSI_IN2000=m
CONFIG_SCSI_AM53C974=m
CONFIG_SCSI_MEGARAID=y
CONFIG_SCSI_BUSLOGIC=m
# CONFIG_SCSI_OMIT_FLASHPOINT is not set
CONFIG_SCSI_CPQFCTS=m
CONFIG_SCSI_DMX3191D=m
CONFIG_SCSI_DTC3280=m
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_DMA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
CONFIG_SCSI_GDTH=m
# CONFIG_SCSI_GENERIC_NCR5380 is not set
CONFIG_SCSI_IPS=m
CONFIG_SCSI_INITIO=m
CONFIG_SCSI_INIA100=m
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_NCR53C406A is not set
CONFIG_SCSI_NCR53C7xx=m
# CONFIG_SCSI_NCR53C7xx_sync is not set
CONFIG_SCSI_NCR53C7xx_FAST=y
CONFIG_SCSI_NCR53C7xx_DISCONNECT=y
CONFIG_SCSI_SYM53C8XX_2=m
CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=1
CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=16
CONFIG_SCSI_SYM53C8XX_MAX_TAGS=64
# CONFIG_SCSI_SYM53C8XX_IOMAPPED is not set
CONFIG_SCSI_NCR53C8XX=m
CONFIG_SCSI_SYM53C8XX=m
CONFIG_SCSI_NCR53C8XX_DEFAULT_TAGS=8
CONFIG_SCSI_NCR53C8XX_MAX_TAGS=32
CONFIG_SCSI_NCR53C8XX_SYNC=40
# CONFIG_SCSI_NCR53C8XX_PROFILE is not set
# CONFIG_SCSI_NCR53C8XX_IOMAPPED is not set
# CONFIG_SCSI_NCR53C8XX_PQS_PDS is not set
# CONFIG_SCSI_NCR53C8XX_SYMBIOS_COMPAT is not set
# CONFIG_SCSI_PAS16 is not set
CONFIG_SCSI_PCI2000=m
CONFIG_SCSI_PCI2220I=m
CONFIG_SCSI_PSI240I=m
CONFIG_SCSI_QLOGIC_FAS=m
CONFIG_SCSI_QLOGIC_ISP=m
CONFIG_SCSI_QLOGIC_FC=m
# CONFIG_SCSI_QLOGIC_FC_FIRMWARE is not set
CONFIG_SCSI_QLOGIC_1280=m
# CONFIG_SCSI_QLOGIC_QLA2XXX is not set
CONFIG_SCSI_SEAGATE=m
CONFIG_SCSI_SIM710=m
CONFIG_SCSI_SYM53C416=m
CONFIG_SCSI_DC390T=m
# CONFIG_SCSI_DC390T_NOGENSUPP is not set
CONFIG_SCSI_T128=m
CONFIG_SCSI_U14_34F=m
# CONFIG_SCSI_U14_34F_LINKED_COMMANDS is not set
CONFIG_SCSI_U14_34F_MAX_TAGS=8
CONFIG_SCSI_ULTRASTOR=m
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set
# CONFIG_FUSION_BOOT is not set
# CONFIG_FUSION_ISENSE is not set
# CONFIG_FUSION_CTL is not set
# CONFIG_FUSION_LAN is not set

#
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
CONFIG_I2O=m
CONFIG_I2O_PCI=m
CONFIG_I2O_BLOCK=m
CONFIG_I2O_LAN=m
CONFIG_I2O_SCSI=m
CONFIG_I2O_PROC=m

#
# Network device support
#
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
CONFIG_DUMMY=m
CONFIG_BONDING=m
CONFIG_EQUALIZER=m
# CONFIG_TUN is not set
# CONFIG_ETHERTAP is not set
# CONFIG_NET_SB1000 is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
# CONFIG_SUNLANCE is not set
CONFIG_HAPPYMEAL=m
# CONFIG_SUNBMAC is not set
# CONFIG_SUNQE is not set
CONFIG_SUNGEM=m
CONFIG_NET_VENDOR_3COM=y
# CONFIG_EL1 is not set
# CONFIG_EL2 is not set
# CONFIG_ELPLUS is not set
# CONFIG_EL16 is not set
CONFIG_EL3=m
CONFIG_3C515=m
# CONFIG_ELMC is not set
# CONFIG_ELMC_II is not set
CONFIG_VORTEX=m
CONFIG_TYPHOON=m
CONFIG_LANCE=m
CONFIG_NET_VENDOR_SMC=y
# CONFIG_WD80x3 is not set
# CONFIG_ULTRAMCA is not set
CONFIG_ULTRA=m
# CONFIG_ULTRA32 is not set
CONFIG_SMC9194=m
# CONFIG_NET_VENDOR_RACAL is not set
# CONFIG_AT1700 is not set
CONFIG_DEPCA=m
# CONFIG_HP100 is not set
# CONFIG_NET_ISA is not set
CONFIG_NET_PCI=y
CONFIG_PCNET32=m
CONFIG_AMD8111_ETH=m
CONFIG_ADAPTEC_STARFIRE=m
CONFIG_AC3200=m
CONFIG_APRICOT=m
CONFIG_CS89x0=m
CONFIG_TULIP=m
# CONFIG_TULIP_MWI is not set
CONFIG_TULIP_MMIO=m
CONFIG_DE4X5=m
CONFIG_DGRS=m
CONFIG_DM9102=m
CONFIG_EEPRO100=m
# CONFIG_EEPRO100_PIO is not set
CONFIG_E100=m
# CONFIG_LNE390 is not set
CONFIG_FEALNX=m
CONFIG_NATSEMI=m
CONFIG_NE2K_PCI=m
# CONFIG_NE3210 is not set
# CONFIG_ES3210 is not set
CONFIG_8139CP=m
CONFIG_8139TOO=m
# CONFIG_8139TOO_PIO is not set
# CONFIG_8139TOO_TUNE_TWISTER is not set
CONFIG_8139TOO_8129=y
# CONFIG_8139_OLD_RX_RESET is not set
CONFIG_SIS900=m
CONFIG_EPIC100=m
CONFIG_SUNDANCE=m
# CONFIG_SUNDANCE_MMIO is not set
CONFIG_TLAN=m
CONFIG_TC35815=m
CONFIG_VIA_RHINE=m
# CONFIG_VIA_RHINE_MMIO is not set
CONFIG_WINBOND_840=m
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
CONFIG_ACENIC=m
# CONFIG_ACENIC_OMIT_TIGON_I is not set
CONFIG_DL2K=m
CONFIG_E1000=m
# CONFIG_MYRI_SBUS is not set
CONFIG_NS83820=m
CONFIG_HAMACHI=m
CONFIG_YELLOWFIN=m
CONFIG_R8169=m
CONFIG_SK98LIN=m
CONFIG_TIGON3=m
# CONFIG_FDDI is not set
CONFIG_NETCONSOLE=m
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
CONFIG_PPP=m
CONFIG_PPP_MULTILINK=y
CONFIG_PPP_FILTER=y
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_PPP_DEFLATE=m
# CONFIG_PPP_BSDCOMP is not set
# CONFIG_PPPOE is not set
# CONFIG_SLIP is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set
CONFIG_NET_FC=y
CONFIG_IPHASE5526=m
CONFIG_RCPCI=m
CONFIG_SHAPER=m

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
# CONFIG_IRDA is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Input core support
#
# CONFIG_INPUT is not set
# CONFIG_INPUT_KEYBDEV is not set
# CONFIG_INPUT_MOUSEDEV is not set
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_EVDEV is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_SERIAL_CONSOLE=y
CONFIG_SERIAL_EXTENDED=y
CONFIG_SERIAL_MANY_PORTS=y
CONFIG_SERIAL_SHARE_IRQ=y
# CONFIG_SERIAL_DETECT_IRQ is not set
CONFIG_SERIAL_MULTIPORT=y
# CONFIG_HUB6 is not set
CONFIG_SERIAL_NONSTANDARD=y
CONFIG_COMPUTONE=m
CONFIG_ROCKETPORT=m
CONFIG_CYCLADES=m
# CONFIG_CYZ_INTR is not set
CONFIG_DIGIEPCA=m
CONFIG_ESPSERIAL=m
CONFIG_MOXA_INTELLIO=m
CONFIG_MOXA_SMARTIO=m
CONFIG_ISI=m
CONFIG_SYNCLINK=m
# CONFIG_SYNCLINKMP is not set
CONFIG_N_HDLC=m
CONFIG_RISCOM8=m
CONFIG_SPECIALIX=m
CONFIG_SPECIALIX_RTSCTS=y
CONFIG_SX=m
# CONFIG_RIO is not set
CONFIG_STALDRV=y
CONFIG_STALLION=m
CONFIG_ISTALLION=m
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=2048
CONFIG_PRINTER=m
CONFIG_LP_CONSOLE=y
CONFIG_PPDEV=m
# CONFIG_TIPAR is not set

#
# I2C support
#
CONFIG_I2C=m
CONFIG_I2C_ALGOBIT=m
CONFIG_I2C_PHILIPSPAR=m
CONFIG_I2C_ELV=m
CONFIG_I2C_VELLEMAN=m
# CONFIG_SCx200_I2C is not set
# CONFIG_SCx200_ACB is not set
CONFIG_I2C_ALGOPCF=m
CONFIG_I2C_ELEKTOR=m
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_PROC=m

#
# Mice
#
# CONFIG_BUSMOUSE is not set
CONFIG_MOUSE=y
CONFIG_PSMOUSE=y
# CONFIG_82C710_MOUSE is not set
# CONFIG_PC110_PAD is not set
# CONFIG_MK712_MOUSE is not set

#
# Joysticks
#
# CONFIG_INPUT_GAMEPORT is not set
# CONFIG_QIC02_TAPE is not set
# CONFIG_IPMI_HANDLER is not set
# CONFIG_IPMI_PANIC_EVENT is not set
# CONFIG_IPMI_DEVICE_INTERFACE is not set
# CONFIG_IPMI_KCS is not set
# CONFIG_IPMI_WATCHDOG is not set

#
# Watchdog Cards
#
CONFIG_WATCHDOG=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_ACQUIRE_WDT=m
CONFIG_ADVANTECH_WDT=m
CONFIG_ALIM7101_WDT=m
CONFIG_SC520_WDT=m
CONFIG_PCWATCHDOG=m
CONFIG_EUROTECH_WDT=m
CONFIG_IB700_WDT=m
CONFIG_WAFER_WDT=m
CONFIG_I810_TCO=m
# CONFIG_MIXCOMWD is not set
# CONFIG_60XX_WDT is not set
CONFIG_SC1200_WDT=m
# CONFIG_SCx200_WDT is not set
CONFIG_SOFT_WATCHDOG=m
CONFIG_W83877F_WDT=m
CONFIG_WDT=m
CONFIG_WDTPCI=m
# CONFIG_WDT_501 is not set
CONFIG_MACHZ_WDT=m
# CONFIG_AMD7XX_TCO is not set
# CONFIG_SCx200_GPIO is not set
CONFIG_AMD_RNG=m
CONFIG_INTEL_RNG=m
CONFIG_AMD_PM768=m
CONFIG_NVRAM=m
CONFIG_RTC=y
CONFIG_DTLK=m
CONFIG_R3964=m
# CONFIG_APPLICOM is not set
CONFIG_SONYPI=m

#
# Ftape, the floppy tape device driver
#
CONFIG_FTAPE=m
CONFIG_ZFTAPE=m
CONFIG_ZFT_DFLT_BLK_SZ=10240
CONFIG_ZFT_COMPRESSOR=m
CONFIG_FT_NR_BUFFERS=3
# CONFIG_FT_PROC_FS is not set
CONFIG_FT_NORMAL_DEBUG=y
# CONFIG_FT_FULL_DEBUG is not set
# CONFIG_FT_NO_TRACE is not set
# CONFIG_FT_NO_TRACE_AT_ALL is not set
CONFIG_FT_STD_FDC=y
# CONFIG_FT_MACH2 is not set
# CONFIG_FT_PROBE_FC10 is not set
# CONFIG_FT_ALT_FDC is not set
CONFIG_FT_FDC_THR=8
CONFIG_FT_FDC_MAX_RATE=2000
CONFIG_FT_ALPHA_CLOCK=0
CONFIG_AGP=m
CONFIG_AGP_INTEL=y
CONFIG_AGP_I810=y
CONFIG_AGP_VIA=y
CONFIG_AGP_AMD=y
# CONFIG_AGP_AMD_8151 is not set
CONFIG_AGP_SIS=y
CONFIG_AGP_ALI=y
CONFIG_AGP_SWORKS=y
CONFIG_DRM=y
# CONFIG_DRM_OLD is not set
CONFIG_DRM_NEW=y
CONFIG_DRM_TDFX=m
CONFIG_DRM_R128=m
CONFIG_DRM_RADEON=m
CONFIG_DRM_I810=m
CONFIG_DRM_I810_XFREE_41=y
CONFIG_DRM_I830=m
CONFIG_DRM_MGA=m
# CONFIG_DRM_SIS is not set
# CONFIG_MWAVE is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# File systems
#
# CONFIG_FS_POSIX_ACL is not set
CONFIG_QUOTA=y
# CONFIG_QFMT_V1 is not set
# CONFIG_QFMT_V2 is not set
# CONFIG_QIFACE_COMPAT is not set
CONFIG_AUTOFS_FS=m
CONFIG_AUTOFS4_FS=m
CONFIG_REISERFS_FS=m
# CONFIG_REISERFS_CHECK is not set
CONFIG_REISERFS_PROC_INFO=y
# CONFIG_ADFS_FS is not set
# CONFIG_ADFS_FS_RW is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BEFS_DEBUG is not set
# CONFIG_BFS_FS is not set
CONFIG_EXT3_FS=y
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
# CONFIG_UMSDOS_FS is not set
CONFIG_VFAT_FS=y
# CONFIG_EFS_FS is not set
# CONFIG_JFFS_FS is not set
# CONFIG_JFFS2_FS is not set
CONFIG_CRAMFS=m
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_JFS_FS=m
# CONFIG_JFS_DEBUG is not set
CONFIG_JFS_STATISTICS=y
CONFIG_MINIX_FS=m
CONFIG_VXFS_FS=m
# CONFIG_NTFS_FS is not set
# CONFIG_NTFS_RW is not set
# CONFIG_HPFS_FS is not set
CONFIG_PROC_FS=y
# CONFIG_DEVFS_FS is not set
# CONFIG_DEVFS_MOUNT is not set
# CONFIG_DEVFS_DEBUG is not set
CONFIG_DEVPTS_FS=y
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX4FS_RW is not set
CONFIG_ROMFS_FS=m
CONFIG_EXT2_FS=y
CONFIG_SYSV_FS=m
CONFIG_UDF_FS=m
# CONFIG_UDF_RW is not set
CONFIG_UFS_FS=m
# CONFIG_UFS_FS_WRITE is not set
# CONFIG_XFS_FS is not set
# CONFIG_XFS_RT is not set
# CONFIG_XFS_QUOTA is not set
# CONFIG_XFS_DMAPI is not set
# CONFIG_XFS_DEBUG is not set
# CONFIG_PAGEBUF_DEBUG is not set
# CONFIG_OCFS_FS is not set

#
# Network File Systems
#
CONFIG_CODA_FS=m
# CONFIG_INTERMEZZO_FS is not set
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
# CONFIG_NFS_DIRECTIO is not set
CONFIG_ROOT_NFS=y
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
CONFIG_NFSD_TCP=y
CONFIG_SUNRPC=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_SMB_FS=m
# CONFIG_SMB_NLS_DEFAULT is not set
# CONFIG_NCP_FS is not set
# CONFIG_NCPFS_PACKET_SIGNING is not set
# CONFIG_NCPFS_IOCTL_LOCKING is not set
# CONFIG_NCPFS_STRONG is not set
# CONFIG_NCPFS_NFS_NS is not set
# CONFIG_NCPFS_OS2_NS is not set
# CONFIG_NCPFS_SMALLDOS is not set
# CONFIG_NCPFS_NLS is not set
# CONFIG_NCPFS_EXTRAS is not set
CONFIG_ZISOFS_FS=y

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y

#
# Native Language Support
#
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=m
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_UTF8=m

#
# Console drivers
#
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
# CONFIG_MDA_CONSOLE is not set

#
# Frame-buffer support
#
# CONFIG_FB is not set

#
# Sound
#
# CONFIG_SOUND is not set

#
# USB support
#
# CONFIG_USB is not set

#
# Bluetooth support
#
# CONFIG_BLUEZ is not set

#
# Kernel hacking
#
CONFIG_DEBUG_KERNEL=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
# CONFIG_DEBUG_HIGHMEM is not set
# CONFIG_DEBUG_SLAB is not set
# CONFIG_DEBUG_IOVIRT is not set
CONFIG_MAGIC_SYSRQ=y
# CONFIG_KMSGDUMP is not set
# CONFIG_DEBUG_SPINLOCK is not set
CONFIG_FRAME_POINTER=y
# CONFIG_HIGHMEM_EMULATION is not set
# CONFIG_X86_REMOTE_DEBUG is not set

#
# Library routines
#
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=m

