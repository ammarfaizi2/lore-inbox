Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263671AbUEKV11@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263671AbUEKV11 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 17:27:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263673AbUEKV10
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 17:27:26 -0400
Received: from uhura.netgate.net.nz ([202.37.247.17]:26758 "EHLO
	uhura.netgate.net.nz") by vger.kernel.org with ESMTP
	id S263671AbUEKVZO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 17:25:14 -0400
From: "Kevin Stewart" <kevins@netgate.net.nz>
To: <linux-kernel@vger.kernel.org>
Subject: PROBLEM: in.tftpd + iptables kernel panic
Date: Wed, 12 May 2004 09:22:15 +1200
Message-ID: <003701c4379e$0b75b380$2a1625ca@SKAVIN>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am running a stable debian install with tftpd 0.17-9 kernel 2.4.26
While backing up cisco configs via tftp I caused a kernel panic
tftpd is run from inetd with
#grep tftp /etc/inetd.conf
tftp            dgram   udp     wait    nobody  /usr/sbin/tcpd
/usr/sbin/in.tftpd /tftpboot
#ls -ld /tftpboot/
drwxrwxrwx    2 root     root         4096 May 10 15:32 /tftpboot/
the tftp target file had been created and was set 777 I had been tftping
configs for most of the AM
I was also adding items to my iptables rules to allow tftp from specific
hosts
Eg
iptables -A INPUT -p udp --dport 69 -j TFTP
iptables -A INPUT -j LOG
iptables -A INPUT -j DROP

iptables -A TFTP -j ACCEPT --source x.x.x.x
iptables -A TFTP -j ACCEPT --source x.x.x.y

and I had a
tail -f /var/log/messages 
looking at the source of the tftp (first drop) then cut past the ip to the
accept and the tftp continues.
I had just hit enter on the iptables -A TFTP ... when the panic occurred
It did not return a prompt

The box is not yet in production so I can test patches

Hope I have all relevant info
Thank you
Kevin Stewart

# cat /proc/version
Linux version 2.4.26 (root@TKHCollector2) (gcc version 2.95.4 20011002
(Debian prerelease)) #2 Thu Apr 22 13:29:23 NZST 2004

# ksymoops -k /proc/ksyms -l /proc/modules -o /lib/modules/2.4.26/ -m
/System.map-2.4.26 Oops.txt
ksymoops 2.4.5 on i686 2.4.26.  Options used
     -V (default)
     -k /proc/ksyms (specified)
     -l /proc/modules (specified)
     -o /lib/modules/2.4.26/ (specified)
     -m /System.map-2.4.26 (specified)

Unable to handle kernel NULL pointer derefrence at virtual address 00000018
c0244a3a
*pde = 00000000
EFLAGS: 00010286
eax: 00000000   ebx:   f569e7a0   ebx:   f569e7a0   edx: 00000000
esi: 00000001   edi:   d0d15d18   ebp:   d0d15ce4   esp: d0d15cb8
Process in.ftpd (pid: 10457, stackpage=d0d15000)
Stack: d0d15d14 d0d15d18 f533c800 e1729300 e1729308 223236d2 f569e7a0
04b01bca
       4013a2d2 223236d2 0011748d d0d15dac c0244c1d d0d15d18 c02d30a0
f533c800
       d0d15d9c c032a8d8 c021fedc f7e4a800 d0d15d10 c02d30a0 08051a20
00000000
Call Trace:    [<c0244c1d>] [<c021fedc>] [<c0243970>] [<c021fedc>]
[<c0215998>]
  [<c021fedc>] [<c021fedc>] [<c0215c4d>] [<c021fedc>] [<c021f7f9>]
[<c021fedc>]
  [<c0238a55>] [<c02385f8>] [<c016498c>] [<c023e886>] [<c0207cb5>]
[<c0208a05>]
  [<c012fdc7>] [<c0122972>] [<c0122ede>] [<c0122eea>] [<c0208a42>]
[<c02091e1>]
  [<c0108613>]
Code: 83 78 18 00 74 15 8d 43 2c 50 e8 df 74 ed ff 89 c2 83 c4 04
Using defaults from ksymoops -t elf32-i386 -a i386


>>ebx; f569e7a0 <_end+353705c4/38562e24>
>>ebx; f569e7a0 <_end+353705c4/38562e24>
>>edi; d0d15d18 <_end+109e7b3c/38562e24>
>>ebp; d0d15ce4 <_end+109e7b08/38562e24>
>>esp; d0d15cb8 <_end+109e7adc/38562e24>

Trace; c0244c1d <ip_conntrack_in+139/26c>
Trace; c021fedc <output_maybe_reroute+0/14>
Trace; c0243970 <ip_conntrack_local+54/58>
Trace; c021fedc <output_maybe_reroute+0/14>
Trace; c0215998 <nf_iterate+30/84>
Trace; c021fedc <output_maybe_reroute+0/14>
Trace; c021fedc <output_maybe_reroute+0/14>
Trace; c0215c4d <nf_hook_slow+b5/144>
Trace; c021fedc <output_maybe_reroute+0/14>
Trace; c021f7f9 <ip_build_xmit+2a9/328>
Trace; c021fedc <output_maybe_reroute+0/14>
Trace; c0238a55 <udp_sendmsg+351/3cc>
Trace; c02385f8 <udp_getfrag+0/c4>
Trace; c016498c <ext2_truncate+3c8/3d4>
Trace; c023e886 <inet_sendmsg+3a/40>
Trace; c0207cb5 <sock_sendmsg+69/88>
Trace; c0208a05 <sys_sendto+d9/f8>
Trace; c012fdc7 <do_truncate+6b/98>
Trace; c0122972 <__vma_link+62/b0>
Trace; c0122ede <do_mmap_pgoff+42e/4ec>
Trace; c0122eea <do_mmap_pgoff+43a/4ec>
Trace; c0208a42 <sys_send+1e/24>
Trace; c02091e1 <sys_socketcall+119/200>
Trace; c0108613 <system_call+33/38>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   83 78 18 00               cmpl   $0x0,0x18(%eax)
Code;  00000004 Before first symbol
   4:   74 15                     je     1b <_EIP+0x1b> 0000001b Before
first symbol
Code;  00000006 Before first symbol
   6:   8d 43 2c                  lea    0x2c(%ebx),%eax
Code;  00000009 Before first symbol
   9:   50                        push   %eax
Code;  0000000a Before first symbol
   a:   e8 df 74 ed ff            call   ffed74ee <_EIP+0xffed74ee> ffed74ee
<END_OF_CODE+76443e7/????>
Code;  0000000f Before first symbol
   f:   89 c2                     mov    %eax,%edx
Code;  00000011 Before first symbol
  11:   83 c4 04                  add    $0x4,%esp

 <0>Kernel panic: Aiee, killing interrupt handler!

# sh ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux TKHCollector2 2.4.26 #2 Thu Apr 22 13:29:23 NZST 2004 i686 unknown

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
Modules Loaded         af_packet

cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 2.40GHz
stepping        : 7
cpu MHz         : 2399.764
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
bogomips        : 4613.73

# cat /proc/modules
af_packet               8456   0 (unused)

# cat /proc/ioports
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
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(set)
0cf8-0cff : PCI conf1
4000-400f : PCI device 1039:5513
  4000-4007 : ide0
  4008-400f : ide1
d000-dfff : PCI Bus #01
  d000-d07f : PCI device 1039:6325
e000-e0ff : PCI device 1039:7012
e400-e47f : PCI device 1039:7012
e800-e87f : PCI device 10b7:9805
  e800-e87f : 00:06.0
ec00-ecff : PCI device 10ec:8139

# cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000d4000-000d67ff : Extension ROM
000f0000-000fffff : System ROM
00100000-3dfeffff : System RAM
  00100000-0025fde6 : Kernel code
  0025fde7-002d469b : Kernel data
3dff0000-3dff2fff : ACPI Non-volatile Storage
3dff3000-3dffffff : ACPI Tables
e0000000-e7ffffff : PCI Bus #01
  e0000000-e7ffffff : PCI device 1039:6325
e8000000-ebffffff : PCI device 1039:0651
ed000000-ed0fffff : PCI Bus #01
  ed000000-ed01ffff : PCI device 1039:6325
ed100000-ed100fff : PCI device 1039:7001
ed101000-ed101fff : PCI device 1039:7002
ed102000-ed10207f : PCI device 10b7:9805
ed103000-ed103fff : PCI device 1039:7001
ed104000-ed1040ff : PCI device 10ec:8139
fec00000-ffffffff : reserved

# lspci -vvv
00:00.0 Host bridge: Silicon Integrated Systems [SiS]: Unknown device 0651
(rev 02)
        Subsystem: Silicon Integrated Systems [SiS]: Unknown device 0651
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 32
        Region 0: Memory at e8000000 (32-bit, non-prefetchable) [size=64M]
        Capabilities: [c0] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Silicon Integrated Systems [SiS] 5591/5592 AGP (prog-if
00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: ed000000-ed0fffff
        Prefetchable memory behind bridge: e0000000-e7ffffff
        BridgeCtl: Parity- SERR+ NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:02.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513 (rev 25)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (prog-if
80 [Master])
        Subsystem: Micro-star International Co Ltd: Unknown device 5332
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 128
        Interrupt: pin ? routed to IRQ 3
        Region 4: I/O ports at 4000 [size=16]
        Capabilities: [58] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:02.7 Multimedia audio controller: Silicon Integrated Systems [SiS]
SiS7012 PCI Audio Accelerator (rev a0)
        Subsystem: Micro-star International Co Ltd: Unknown device 5332
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (13000ns min, 2750ns max)
        Interrupt: pin C routed to IRQ 11
        Region 0: I/O ports at e000 [size=256]
        Region 1: I/O ports at e400 [size=128]
        Capabilities: [48] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=55mA
PME(D0-,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:03.0 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 0f)
(prog-if 10 [OHCI])
        Subsystem: Micro-star International Co Ltd: Unknown device 5332
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR+
        Latency: 32 (20000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at ed103000 (32-bit, non-prefetchable) [size=4K]

00:03.1 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 0f)
(prog-if 10 [OHCI])
        Subsystem: Micro-star International Co Ltd: Unknown device 5332
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR+
        Latency: 32 (20000ns max), cache line size 08
        Interrupt: pin B routed to IRQ 11
        Region 0: Memory at ed100000 (32-bit, non-prefetchable) [size=4K]

00:03.3 USB Controller: Silicon Integrated Systems [SiS]: Unknown device
7002 (prog-if 20)
        Subsystem: Micro-star International Co Ltd: Unknown device 5332
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (20000ns max), cache line size 08
        Interrupt: pin D routed to IRQ 9
        Region 0: Memory at ed101000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:06.0 Ethernet controller: 3Com Corporation 3c980-TX 10/100baseTX NIC
[Python-T] (rev 78)
        Subsystem: 3Com Corporation: Unknown device 1000
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2500ns min, 2500ns max), cache line size 08
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at e800 [size=128]
        Region 1: Memory at ed102000 (32-bit, non-prefetchable) [size=128]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:0f.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev
10)
        Subsystem: Realtek Semiconductor Co., Ltd. RT8139
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (8000ns min, 16000ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at ec00 [size=256]
        Region 1: Memory at ed104000 (32-bit, non-prefetchable) [size=256]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
PME(D0-,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS]: Unknown
device 6325 (prog-if 00 [VGA])
        Subsystem: Micro-star International Co Ltd: Unknown device 5339
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 3
        BIST result: 00
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=128M]
        Region 1: Memory at ed000000 (32-bit, non-prefetchable) [size=128K]
        Region 2: I/O ports at d000 [size=128]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [50] AGP version 2.0
                Status: RQ=15 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>


