Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266606AbTGKGG6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 02:06:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269803AbTGKGG6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 02:06:58 -0400
Received: from web40010.mail.yahoo.com ([66.218.78.28]:44191 "HELO
	web40010.mail.yahoo.com") by vger.kernel.org with SMTP
	id S269798AbTGKGGu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 02:06:50 -0400
Message-ID: <20030711062131.63757.qmail@web40010.mail.yahoo.com>
Date: Thu, 10 Jul 2003 23:21:31 -0700 (PDT)
From: Justin Swanhart <jswanhart@yahoo.com>
Reply-To: swany@hour13.com
Subject: PROBLEM: assert in inode.c (2.4.21)
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PROBLEM: assertion/crash in latest stable kernel
2.4.21 (inode.c)

DETAIL:
This server crashes under medium load running apache
(httpd).  It crashes consistently since the 
maxclients value wa increased to accomodate an
increased amount of traffic to the site.  The kernel
was crashing in a kernel page fault so we decided to
ugprade to 2.4.21.  After the upgrade the crash
occurs as before but with an assert in inode.c instead
of a kernel page fault.  

keywords: kernel, assertion, inode.c, autofs, apache

VERSION
Linux version 2.4.21 (root@ahp1) (gcc version 2.96
20000731 (Red Hat Linux 7.3 2.96-113)) #1 Wed Jul 9
07:09:36 MDT 2003

OOPS W/ TRACE
ksymoops 2.4.9 on i686 2.4.21.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.21/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol
information.  I will
assume that the log matches the kernel and modules
that are running
right now and I'll use the default options above for
symbol resolution.
If the current kernel and/or modules do not match the
log, you can get
more accurate output by telling me the kernel version
and where to find
map, modules, ksyms etc.  ksymoops -h explains the
options.

Jul 10 14:03:51 ahp1 kernel: kernel BUG at
inode.c:851!
Jul 10 14:03:51 ahp1 kernel: invalid operand: 0000
Jul 10 14:03:51 ahp1 kernel: CPU:    0
Jul 10 14:03:51 ahp1 kernel: EIP:   
0010:[autofs:__insmod_autofs_O/lib/modules/2.4.21/kernel/fs/autofs/autof+-2217349/96]
   Not tainted
Jul 10 14:03:51 ahp1 kernel: EFLAGS: 00010286
Jul 10 14:03:51 ahp1 kernel: eax: 0000004a   ebx:
f6692e40   ecx: 00000000   edx: 00000000
Jul 10 14:03:51 ahp1 kernel: esi: 00000000   edi:
00000000   ebp: 00000000   esp: f65bbbd0
Jul 10 14:03:51 ahp1 kernel: ds: 0018   es: 0018   ss:
0018
Jul 10 14:03:51 ahp1 kernel: Process httpd (pid: 5541,
stackpage=f65bb000)
Jul 10 14:03:51 ahp1 kernel: Stack: f886bc60 f8863d12
dff520fc f6692e00 00000000 00000000 f6b09cc0 dd89c0a0
Jul 10 14:03:51 ahp1 kernel:        dff520fc c01ef8ab
dff520fc 00000014 bfabe8d3 dff52110 dd89c0a0 00000014
Jul 10 14:03:51 ahp1 kernel:        0008e287 dd89c1c0
dff520fc c01ea9b8 000001cd 080c5df9 000001b9 c01c4a93
Jul 10 14:03:51 ahp1 kernel: Call Trace:   
[autofs:__insmod_autofs_O/lib/modules/2.4.21/kernel/fs/autofs/autof+-2184096/96]
[autofs:__insmod_autofs_O/lib/modules/2.4.21/kernel/fs/autofs/autof+-2216686/96]
[tcp_v4_send_check+107/176]
[tcp_transmit_skb+1368/1552]
[skb_copy_and_csum_datagram+131/912]
Jul 10 14:03:51 ahp1 kernel: Code: 0f 0b 53 03 6f dc
86 f8 83 c4 14 56 8b 44 24 18 50 8b 74 24
Using defaults from ksymoops -t elf32-i386 -a i386


>>ebx; f6692e40 <_end+363a68a4/38520a64>
>>esp; f65bbbd0 <_end+362cf634/38520a64>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a
Code;  00000002 Before first symbol
   2:   53                        push   %ebx
Code;  00000003 Before first symbol
   3:   03 6f dc                  add   
0xffffffdc(%edi),%ebp
Code;  00000006 Before first symbol
   6:   86 f8                     xchg   %bh,%al
Code;  00000008 Before first symbol
   8:   83 c4 14                  add    $0x14,%esp
Code;  0000000b Before first symbol
   b:   56                        push   %esi
Code;  0000000c Before first symbol
   c:   8b 44 24 18               mov   
0x18(%esp,1),%eax
Code;  00000010 Before first symbol
  10:   50                        push   %eax
Code;  00000011 Before first symbol
  11:   8b 74 24 00               mov   
0x0(%esp,1),%esi


1 warning issued.  Results may not be reliable.

PROCESSOR INFO:
[root@ahp1 tmp]# cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 10
cpu MHz         : 997.532
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8
apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse


MODULES:
[root@ahp1 linux]# cat /proc/modules
autofs                 11172   0 (autoclean) (unused)
eepro100               20652   1
mii                     3800   0 [eepro100]
ext3                   65152   2
jbd                    46924   2 [ext3]
aic7xxx               132160   3
sd_mod                 12412   6
scsi_mod              104916   2 [aic7xxx sd_mod]

IO PORTS
[root@ahp1 log]# cat /proc/ioports
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
08b0-08bf : ServerWorks OSB4 IDE Controller
  08b0-08b7 : ide0
  08b8-08bf : ide1
0cf8-0cff : PCI conf1
d800-d8ff : Adaptec AIC-7899P U160/m (#2)
dc00-dcff : Adaptec AIC-7899P U160/m
e800-e8ff : ATI Technologies Inc Rage XL
ecc0-ecff : Intel Corp. 82557/8/9 [Ethernet Pro 100]
  ecc0-ecff : eepro100

IOMEM
[root@ahp1 log]# cat /proc/iomem
00000000-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000cdfff : Extension ROM
000f0000-000fffff : System ROM
00100000-7fffdfff : System RAM
  00100000-00216c8b : Kernel code
  00216c8c-0028981f : Kernel data
7fffe000-7fffffff : reserved
f9000000-f9000fff : Adaptec AIC-7899P U160/m (#2)
  f9000000-f9000fff : aic7xxx
f9001000-f9001fff : Adaptec AIC-7899P U160/m
  f9001000-f9001fff : aic7xxx
fc000000-fcffffff : ATI Technologies Inc Rage XL
fe000000-fe0fffff : Intel Corp. 82557/8/9 [Ethernet
Pro 100]
fe100000-fe100fff : ServerWorks OSB4/CSB5 OHCI USB
Controller
fe101000-fe101fff : ATI Technologies Inc Rage XL
fe102000-fe102fff : Intel Corp. 82557/8/9 [Ethernet
Pro 100]
  fe102000-fe102fff : eepro100
fec00000-fec0ffff : reserved
fee00000-fee0ffff : reserved
fff80000-ffffffff : reserved

PCI DEVICES
[root@ahp1 log]# /sbin/lspci -vvv
00:00.0 Host bridge: ServerWorks CNB20LE Host Bridge
(rev 06)
        Control: I/O- Mem+ BusMaster+ SpecCycle-
MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 48, cache line size 08

00:00.1 Host bridge: ServerWorks CNB20LE Host Bridge
(rev 06)
        Control: I/O+ Mem+ BusMaster+ SpecCycle-
MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 48, cache line size 08

00:02.0 Ethernet controller: Intel Corp. 82557/8/9
[Ethernet Pro 100] (rev 08)
        Subsystem: Dell Computer Corporation: Unknown
device 009b
        Control: I/O+ Mem+ BusMaster+ SpecCycle-
MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min, 14000ns max), cache
line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at fe102000 (32-bit,
non-prefetchable) [size=4K]
        Region 1: I/O ports at ecc0 [size=64]
        Region 2: Memory at fe000000 (32-bit,
non-prefetchable) [size=1M]
        Expansion ROM at fd000000 [disabled] [size=1M]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+
AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2
PME-

00:0e.0 VGA compatible controller: ATI Technologies
Inc Rage XL (rev 27) (prog-if 00 [VGA])
        Subsystem: Dell Computer Corporation: Unknown
device 00ce
        Control: I/O+ Mem+ BusMaster+ SpecCycle-
MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min), cache line size 08
        Region 0: Memory at fc000000 (32-bit,
non-prefetchable) [size=16M]
        Region 1: I/O ports at e800 [size=256]
        Region 2: Memory at fe101000 (32-bit,
non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled]
[size=128K]
        Capabilities: [5c] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+
AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0
PME-

00:0f.0 ISA bridge: ServerWorks OSB4 South Bridge (rev
50)
        Subsystem: ServerWorks OSB4 South Bridge
        Control: I/O+ Mem+ BusMaster+ SpecCycle-
MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:0f.1 IDE interface: ServerWorks OSB4 IDE Controller
(prog-if 8a [Master SecP PriP])
        Control: I/O+ Mem- BusMaster+ SpecCycle-
MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Region 4: I/O ports at 08b0 [size=16]

00:0f.2 USB Controller: ServerWorks OSB4/CSB5 USB
Controller (rev 04) (prog-if 10 [OHCI])
        Subsystem: ServerWorks OSB4/CSB5 USB
Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle-
MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (20000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at fe100000 (32-bit,
non-prefetchable) [size=4K]

01:02.0 SCSI storage controller: Adaptec AIC-7899P
U160/m (rev 01)
        Subsystem: Dell Computer Corporation: Unknown
device 00ce
        Control: I/O- Mem+ BusMaster+ SpecCycle-
MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (10000ns min, 6250ns max), cache
line size 08
        Interrupt: pin A routed to IRQ 5
        BIST result: 00
        Region 0: I/O ports at dc00 [disabled]
[size=256]
        Region 1: Memory at f9001000 (64-bit,
non-prefetchable) [size=4K]
        Expansion ROM at f8000000 [disabled]
[size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1- D2-
AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0
PME-

01:02.1 SCSI storage controller: Adaptec AIC-7899P
U160/m (rev 01)
        Subsystem: Dell Computer Corporation: Unknown
device 00ce
        Control: I/O- Mem+ BusMaster+ SpecCycle-
MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (10000ns min, 6250ns max), cache
line size 08
        Interrupt: pin B routed to IRQ 11
        BIST result: 00
        Region 0: I/O ports at d800 [disabled]
[size=256]
        Region 1: Memory at f9000000 (64-bit,
non-prefetchable) [size=4K]
        Expansion ROM at f8000000 [disabled]
[size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1- D2-
AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0
PME-

SCSI DEVICES
[root@ahp1 log]# cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: FUJITSU  Model: MAN3735MP        Rev: 5507
  Type:   Direct-Access                    ANSI SCSI
revision: 03


FILESYSTEMS
LABEL=/                 /       ext3   
defaults,usrquota,grpquota      1      1
LABEL=/boot             /boot                   ext3  
 defaults        1 2
none                    /dev/pts                devpts
 gid=5,mode=620  0 0
none                    /proc                   proc  
 defaults        0 0
none                    /dev/shm                tmpfs 
 defaults        0 0
/dev/sda2               swap                    swap  
 defaults        0 0
/swapfile               swap                    swap  
 defaults        0 0
/swapfile1              swap                    swap  
 defaults        0 0
/swapfile2              swap                    swap  
 defaults        0 0
/dev/cdrom              /mnt/cdrom             
iso9660 noauto,owner,kudzu,ro 0 0
/dev/fd0                /mnt/floppy             auto  
 noauto,owner,kudzu 0 0



__________________________________
Do you Yahoo!?
SBC Yahoo! DSL - Now only $29.95 per month!
http://sbc.yahoo.com
