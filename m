Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261206AbUCKNh2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 08:37:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261258AbUCKNh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 08:37:28 -0500
Received: from mx.deam.org ([195.24.105.112]:54279 "EHLO mx.deam.org")
	by vger.kernel.org with ESMTP id S261206AbUCKNhF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 08:37:05 -0500
Mime-Version: 1.0 (Apple Message framework v612)
Content-Transfer-Encoding: 7bit
Message-Id: <29759D23-7361-11D8-A905-000A9575DB74@deam.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
To: linux-kernel@vger.kernel.org
From: "Klaus M. Brantl" <kmb@deam.org>
Subject: bug-report about a stability-problem with highmem and nfs
Date: Thu, 11 Mar 2004 14:36:55 +0100
X-Pgp-Agent: GPGMail 1.0.1 (v33, 10.3)
X-Mailer: Apple Mail (2.612)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

sear kernel-team,

i hope the following report gives you enought information to figure out 
whats wrong/ or tell me that i did something wrong :-)

if you have further questions tell me.

best regards
klaus m. brantl



[1.] One line summary of the problem:
Total halt of the machine without kernel-panic-message; reboot only 
possible with hardware-reset.

[2.] Full description of the problem/report:
[2.0.] Background
We are using a number of machines as webserver an two machines as 
fileserver for part of the filesystem that is needed for all nodes.
At the beginning (with kernel 2.4.20) there was no problem at all, but 
there was also not much load and traffic :-)
During autumn 2003 we had a number of those "silent crashes" - the 
uptime between shrinkened during this period from two months to three 
weeks.
We started testing on the backup-fileserver at the very first crash and 
it took us until february to get closer.
We always used the current kernel-version (2.4.25) in our tests during 
february.

[2.1.] Summary
Finally we "developed" a simple method to provoke a crash. We simply 
wrote tons of files from a nfs-client to the nfs-server - and deleted 
and over-wrote....
Finally the only thing that prevented a crash (so far) was limiting the 
HIGHMEM to 4GB - we have 6GB build in.

It looks like the machine crashes only if you can fill up the memory 
(cached mem) over a longer period.
The provoked crashes happend within one hour (see 6.) of out testing.


[3.] Keywords (i.e., modules, networking, kernel):
Memory/ RAM, PAE, NFS-Kernel-Server


[4.] Kernel version (from /proc/version):
Linux version 2.4.25 (root@myserver) (gcc version 2.95.4 20011002 
(Debian prerelease)) #6 SMP Tue Feb 24 11:46:24 CET 2004


[5.] Output of Oops.. message (if applicable) with symbolic information 
resolved (see Documentation/oops-tracing.txt)
none.


[6.] A small shell script or example program which triggers the problem 
(if possible)
We simply started multiple dd's to write and overwrite lot of files.
In the crash-test we only needed to write around 80.000 small files (dd 
count=60 if=/dev/zero of=/server/smallN) and around 3.000 larger files 
(dd count=230000 if=/dev/zero of=/server/largeN).
In addition we used a lot of memory on the Server with an Apache (this 
action only shortend the time until it crashed).


[7.] Environment
[7.0.] Systembase
Debian-Woody-Installation - no backports.

Hardware:
- - Compaq DL380 R03
- - 2 x XEON 2.8 GHz
- - 6 GB RAM
- - 2 x 18 GB HD mirrored (system)
- - 3 x 36 GB RAID-5 (shared files)
- - 1 x AIT 50/100 GB Tape
- - 2 x GE NIC " 1 x 100 Mbit NIC


[7.1.] Software (add the output of the ver_linux script here)
Linux myserver 2.4.25 #6 SMP Tue Feb 24 11:46:24 CET 2004 i686 unknown

Gnu C                  2.95.4
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.15
e2fsprogs              1.27
PPP                    2.4.1
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.11

[7.2.] Processor information (from /proc/cpuinfo):
Linux version 2.4.25 (root@myserver) (gcc version 2.95.4 20011002 
(Debian prerelease)) #6 SMP Tue Feb 24 11:46:24 CET 2004
klaus@myserver:~$ cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Xeon(TM) CPU 2.80GHz
stepping        : 7
cpu MHz         : 2786.278
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
bogomips        : 5557.45

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Xeon(TM) CPU 2.80GHz
stepping        : 7
cpu MHz         : 2786.278
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
bogomips        : 5570.56

processor       : 2
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Xeon(TM) CPU 2.80GHz
stepping        : 7
cpu MHz         : 2786.278
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
bogomips        : 5570.56

processor       : 3
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Xeon(TM) CPU 2.80GHz
stepping        : 7
cpu MHz         : 2786.278
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
bogomips        : 5570.56


[7.3.] Module information (from /proc/modules):
no loaded modules (everything is compiled into the kernel)

[7.4.] Loaded driver and hardware information (/proc/ioports, 
/proc/iomem)
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(set)
0cf8-0cff : PCI conf1
1800-18ff : PCI device 0e11:b203 (Compaq Computer Corporation)
2000-200f : ServerWorks CSB5 IDE Controller
2400-24ff : ATI Technologies Inc Rage XL
2800-28ff : PCI device 0e11:b204 (Compaq Computer Corporation)
3000-30ff : Compaq Computer Corporation Smart Array 5i/532
   3000-30ff : cciss
4000-403f : Intel Corp. 82557/8/9 [Ethernet Pro 100]
   4000-403f : eepro100


00000000-0009f3ff : System RAM
0009f400-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000cbfff : Extension ROM
000cc000-000cd7ff : Extension ROM
000cd800-000cefff : Extension ROM
000f0000-000fffff : System ROM
00100000-efff9fff : System RAM
   00100000-002a6f88 : Kernel code
   002a6f89-0034beff : Kernel data
efffa000-efffffff : ACPI Tables
f0ef0000-f0ef0fff : ServerWorks OSB4/CSB5 OHCI USB Controller
   f0ef0000-f0ef0fff : usb-ohci
f0f00000-f0f7ffff : PCI device 0e11:b204 (Compaq Computer Corporation)
f0fc0000-f0fc1fff : PCI device 0e11:b204 (Compaq Computer Corporation)
f0fd0000-f0fd07ff : PCI device 0e11:b204 (Compaq Computer Corporation)
f0fe0000-f0fe01ff : PCI device 0e11:b203 (Compaq Computer Corporation)
f0ff0000-f0ff0fff : ATI Technologies Inc Rage XL
f1000000-f1ffffff : ATI Technologies Inc Rage XL
f2af0000-f2af3fff : Compaq Computer Corporation Smart Array 5i/532
f2bc0000-f2bfffff : Compaq Computer Corporation Smart Array 5i/532
f2ce0000-f2ceffff : Broadcom Corporation NetXtreme BCM5703 Gigabit 
Ethernet (#2)
   f2ce0000-f2ceffff : tg3
f2cf0000-f2cfffff : Broadcom Corporation NetXtreme BCM5703 Gigabit 
Ethernet
   f2cf0000-f2cfffff : tg3
f7df0000-f7df0fff : Compaq Computer Corporation PCI Hotplug Controller
f7e00000-f7efffff : Intel Corp. 82557/8/9 [Ethernet Pro 100]
f7ff0000-f7ff0fff : Intel Corp. 82557/8/9 [Ethernet Pro 100]
   f7ff0000-f7ff0fff : eepro100
fec00000-fec0ffff : reserved
fee00000-fee0ffff : reserved
ffc00000-ffffffff : reserved


[7.5.] PCI information ('lspci -vvv' as root)
00:00.0 Host bridge: ServerWorks: Unknown device 0012 (rev 13)
         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-

00:00.1 Host bridge: ServerWorks: Unknown device 0012
         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-

00:00.2 Host bridge: ServerWorks: Unknown device 0000
         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-

00:03.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 
27) (prog-if 00 [VGA])
         Subsystem: Compaq Computer Corporation: Unknown device 001e
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping+ SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 64 (2000ns min), cache line size 10
         Region 0: Memory at f1000000 (32-bit, non-prefetchable) 
[size=16M]
         Region 1: I/O ports at 2400 [size=256]
         Region 2: Memory at f0ff0000 (32-bit, non-prefetchable) 
[size=4K]
         Expansion ROM at <unassigned> [disabled] [size=128K]
         Capabilities: [5c] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.0 System peripheral: Compaq Computer Corporation: Unknown device 
b203 (rev 01)
         Subsystem: Compaq Computer Corporation: Unknown device b206
         Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Interrupt: pin A routed to IRQ 16
         Region 0: I/O ports at 1800 [size=256]
         Region 1: Memory at f0fe0000 (32-bit, non-prefetchable) 
[size=512]
         Capabilities: [f0] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.2 System peripheral: Compaq Computer Corporation: Unknown device 
b204 (rev 01)
         Subsystem: Compaq Computer Corporation: Unknown device b206
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping+ SERR+ FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 64, cache line size 10
         Interrupt: pin B routed to IRQ 17
         Region 0: I/O ports at 2800 [size=256]
         Region 1: Memory at f0fd0000 (32-bit, non-prefetchable) 
[size=2K]
         Region 2: Memory at f0fc0000 (32-bit, non-prefetchable) 
[size=8K]
         Region 3: Memory at f0f00000 (32-bit, non-prefetchable) 
[size=512K]
         Expansion ROM at <unassigned> [disabled] [size=64K]
         Capabilities: [f0] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                 Status: D0 PME-Enable+ DSel=0 DScale=0 PME-

00:0f.0 ISA bridge: ServerWorks CSB5 South Bridge (rev 93)
         Subsystem: ServerWorks CSB5 South Bridge
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr+ Stepping- SERR+ FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
         Latency: 32

00:0f.1 IDE interface: ServerWorks CSB5 IDE Controller (rev 93) 
(prog-if 8a [Master SecP PriP])
         Subsystem: ServerWorks CSB5 IDE Controller
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr+ Stepping- SERR+ FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Region 0: I/O ports at <ignored>
         Region 1: I/O ports at <ignored>
         Region 2: I/O ports at <ignored>
         Region 3: I/O ports at <ignored>
         Region 4: I/O ports at 2000 [size=16]

00:0f.2 USB Controller: ServerWorks OSB4/CSB5 OHCI USB Controller (rev 
05) (prog-if 10 [OHCI])
         Subsystem: ServerWorks OSB4/CSB5 OHCI USB Controller
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr+ Stepping- SERR+ FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 64 (20000ns max)
         Interrupt: pin A routed to IRQ 7
         Region 0: Memory at f0ef0000 (32-bit, non-prefetchable) 
[size=4K]

00:0f.3 Host bridge: ServerWorks: Unknown device 0225
         Subsystem: ServerWorks: Unknown device 0230
         Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0

00:10.0 Host bridge: ServerWorks: Unknown device 0101 (rev 05)
         Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr+ Stepping- SERR+ FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
         Capabilities: [60] #07 [0040]

00:10.2 Host bridge: ServerWorks: Unknown device 0101 (rev 05)
         Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr+ Stepping- SERR+ FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
         Capabilities: [60] #07 [0040]

00:11.0 Host bridge: ServerWorks: Unknown device 0101 (rev 05)
         Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr+ Stepping- SERR+ FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
         Capabilities: [60] #07 [0040]

00:11.2 Host bridge: ServerWorks: Unknown device 0101 (rev 05)
         Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr+ Stepping- SERR+ FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
         Capabilities: [60] #07 [0040]

01:03.0 RAID bus controller: Compaq Computer Corporation Smart Array 
5i/532 (rev 01)
         Subsystem: Compaq Computer Corporation: Unknown device 4080
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr+ Stepping- SERR+ FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 71, cache line size 10
         Interrupt: pin A routed to IRQ 30
         Region 0: Memory at f2bc0000 (64-bit, non-prefetchable) 
[size=256K]
         Region 2: I/O ports at 3000 [size=256]
         Region 3: Memory at f2af0000 (64-bit, prefetchable) [size=16K]
         Expansion ROM at <unassigned> [disabled] [size=16K]
         Capabilities: [c0] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [cc] Message Signalled Interrupts: 64bit+ 
Queue=0/1 Enable-
                 Address: 0000000000000000  Data: 0000
         Capabilities: [dc] #07 [0030]

02:01.0 Ethernet controller: BROADCOM Corporation: Unknown device 16a7 
(rev 02)
         Subsystem: Compaq Computer Corporation: Unknown device 00cb
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr+ Stepping- SERR+ FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 64 (16000ns min), cache line size 10
         Interrupt: pin A routed to IRQ 29
         Region 0: Memory at f2cf0000 (64-bit, non-prefetchable) 
[size=64K]
         Expansion ROM at <unassigned> [disabled] [size=64K]
         Capabilities: [40] #07 [0008]
         Capabilities: [48] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=1 PME-
         Capabilities: [50] Vital Product Data
         Capabilities: [58] Message Signalled Interrupts: 64bit+ 
Queue=0/3 Enable-
                 Address: 4b08241000100400  Data: 1124

02:02.0 Ethernet controller: BROADCOM Corporation: Unknown device 16a7 
(rev 02)
         Subsystem: Compaq Computer Corporation: Unknown device 00cb
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr+ Stepping- SERR+ FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 64 (16000ns min), cache line size 10
         Interrupt: pin A routed to IRQ 31
         Region 0: Memory at f2ce0000 (64-bit, non-prefetchable) 
[size=64K]
         Expansion ROM at <unassigned> [disabled] [size=64K]
         Capabilities: [40] #07 [0008]
         Capabilities: [48] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=1 PME-
         Capabilities: [50] Vital Product Data
         Capabilities: [58] Message Signalled Interrupts: 64bit+ 
Queue=0/3 Enable-
                 Address: 6104441068880aa0  Data: 0180

06:02.0 Ethernet controller: Intel Corp. 82557 [Ethernet Pro 100] (rev 
08)
         Subsystem: Compaq Computer Corporation NC3123 (82559)
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr+ Stepping- SERR+ FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 64 (2000ns min, 14000ns max), cache line size 10
         Interrupt: pin A routed to IRQ 26
         Region 0: Memory at f7ff0000 (32-bit, non-prefetchable) 
[size=4K]
         Region 1: I/O ports at 4000 [size=64]
         Region 2: Memory at f7e00000 (32-bit, non-prefetchable) 
[size=1M]
         Expansion ROM at <unassigned> [disabled] [size=1M]
         Capabilities: [dc] Power Management version 2
                 Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=2 PME-

06:1e.0 PCI Hot-plug controller: Compaq Computer Corporation PCI 
Hotplug Controller (rev 14)
         Subsystem: Compaq Computer Corporation: Unknown device a2fe
         Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr+ Stepping- SERR+ FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Interrupt: pin A routed to IRQ 18
         Region 0: Memory at f7df0000 (32-bit, non-prefetchable) 
[size=4K]
         Capabilities: [58] Message Signalled Interrupts: 64bit+ 
Queue=0/0 Enable-
                 Address: 0000000000000000  Data: 0000
         Capabilities: [68] #07 [0000]
         Capabilities: [70] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-


[7.6.] SCSI information (from /proc/scsi/scsi)
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
   Vendor: COMPAQ   Model: SDX-500C         Rev: 1.35
   Type:   Sequential-Access                ANSI SCSI revision: 02



[7.7.] Other information that might be relevant to the problem
We haven't got time to evaluate things with a serial console.
If you need more information we can try this, but it could take a while 
until we can present the results.


[8.] Other notes, patches, fixes, workarounds:
disabled Himem-support (limit to 4GB) and diabled SWAP.
stable now for over two weeks under changing and heavy load.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (Darwin)

iD8DBQFAUGt5vkHn/oGTPXURAn6SAKDBfplLsUUrCX0MQql3IkxOz7GMowCfRkYY
DTzxc5ZlGc1Rfxicr09fdbY=
=gZg6
-----END PGP SIGNATURE-----

