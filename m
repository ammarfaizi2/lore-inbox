Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261762AbSIXTcP>; Tue, 24 Sep 2002 15:32:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261767AbSIXTcP>; Tue, 24 Sep 2002 15:32:15 -0400
Received: from tantale.fifi.org ([216.27.190.146]:2944 "EHLO tantale.fifi.org")
	by vger.kernel.org with ESMTP id <S261762AbSIXTcK>;
	Tue, 24 Sep 2002 15:32:10 -0400
To: linux-kernel@vger.kernel.org
Subject: 2.2.22: oops in ll_rw_block
From: Philippe Troin <phil@fifi.org>
Date: 24 Sep 2002 12:37:16 -0700
Message-ID: <873crzmb6b.fsf@ceramic.fifi.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:    

Accessing files can trigger this oops.

[2.] Full description of the problem/report:

The oops occured while I was running tripwire.

[3.] Keywords (i.e., modules, networking, kernel):

block-layer ll_rw_block oops

[4.] Kernel version (from /proc/version):

Linux version 2.2.22 (root@ceramic) (gcc version 2.95.4 20011002
(Debian prerelease)) #1 SMP Mon Sep 16 19:40:12 PDT 2002

[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)

ksymoops 2.3.4 on i686 2.2.22.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.2.22/ (default)
     -m /boot/System.map-2.2.22 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Unable to handle kernel paging request at virtual address 000ed0ac
current->tss.cr3 = 031ff000, %cr3 = 031ff000
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c018464e>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 000ed0a4   ebx: 00000000   ecx: 00000807   edx: cae8be00
esi: c1c63e24   edi: 00000004   ebp: 00000008   esp: c1c63dcc
ds: 0018   es: 0018   ss: 0018
Process tripwire (pid: 4524, process nr: 108, stackpage=c1c63000)
Stack: 00000000 00000100 c8384620 c8384620 00076855 00000400 c8384620 00000807 
       00076855 c012e640 00000000 00000004 c1c63e24 cfbcd880 00000374 cfbcd880 
       00000000 c1c63ea4 00000807 00000004 cae8be00 00000000 cae8be00 c8795d20 
Call Trace: [<c012e640>] [<c012e81c>] [<c0122f0e>] [<c0122e4b>] [<c012330c>] [<c01bd025>] [<c01236b3>] 
       [<c0123600>] [<c0112217>] [<c0111b8a>] [<c012be3e>] [<c010c7ad>] [<c010a7d0>] 
Code: 28 8b 14 9e 8b 42 08 c1 e8 09 50 8d 42 10 50 8d 42 0e 50 31 

>>EIP; c018464e <ll_rw_block+ce/228>   <=====
Trace; c012e640 <brw_page+26c/368>
Trace; c012e81c <generic_readpage+8c/9c>
Trace; c0122f0e <try_to_read_ahead+f2/10c>
Trace; c0122e4b <try_to_read_ahead+2f/10c>
Trace; c012330c <do_generic_file_read+294/588>
Trace; c01bd025 <do_aic7xxx_isr+79/98>
Trace; c01236b3 <generic_file_read+63/7c>
Trace; c0123600 <file_read_actor+0/50>
Trace; c0112217 <do_level_ioapic_IRQ+9b/b0>
Trace; c0111b8a <smp_apic_timer_interrupt+16/20>
Trace; c012be3e <sys_read+c6/f8>
Trace; c010c7ad <apic_timer_interrupt+1d/28>
Trace; c010a7d0 <system_call+34/38>
Code;  c018464e <ll_rw_block+ce/228>
00000000 <_EIP>:
Code;  c018464e <ll_rw_block+ce/228>   <=====
   0:   28 8b 14 9e 8b 42         sub    %cl,0x428b9e14(%ebx)   <=====
Code;  c0184654 <ll_rw_block+d4/228>
   6:   08 c1                     or     %al,%cl
Code;  c0184656 <ll_rw_block+d6/228>
   8:   e8 09 50 8d 42            call   428d5016 <_EIP+0x428d5016> 02a59664 Before first symbol
Code;  c018465b <ll_rw_block+db/228>
   d:   10 50 8d                  adc    %dl,0xffffff8d(%eax)
Code;  c018465e <ll_rw_block+de/228>
  10:   42                        inc    %edx
Code;  c018465f <ll_rw_block+df/228>
  11:   0e                        push   %cs
Code;  c0184660 <ll_rw_block+e0/228>
  12:   50                        push   %eax
Code;  c0184661 <ll_rw_block+e1/228>
  13:   31 00                     xor    %eax,(%eax)


1 warning issued.  Results may not be reliable.

[6.] A small shell script or example program which triggers the
     problem (if possible)

Not reproduced.

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)

Debian GNU/Linux 2.2 (potato)

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux tantale 2.2.22 #1 SMP Mon Sep 16 19:40:12 PDT 2002 i686 unknown
 
Gnu C                  2.95.2
Gnu make               3.79.1
binutils               2.9.5.0.37
util-linux             
util-linux             Note: /usr/bin/fdformat is obsolete and is no longer available.
util-linux             Please use /usr/bin/superformat instead (make sure you have the 
util-linux             fdutils package installed first).  Also, there had been some
util-linux             major changes from version 4.x.  Please refer to the documentation.
util-linux             
mount                  2.10q
modutils               2.3.11
e2fsprogs              1.18
Linux C Library        2.1.3
ldd: version 1.9.11
Procps                 2.0.6
Net-tools              1.54
Console-tools          0.2.3
Sh-utils               2.0
Modules Loaded         nfsd nfs lockd sunrpc vfat msdos fat isofs usbcore sr_mod cdrom lp parport_pc parport raid0 loop floppy cls_fw sch_sfq sch_tbf sch_prio ip_masq_ftp ne2k-pci 8390 3c509 3c59x af_packet

[7.2.] Processor information (from /proc/cpuinfo):

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 1
model name	: Pentium Pro
stepping	: 2
cpu MHz		: 149.694
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
sep_bug		: yes
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
bogomips	: 299.00

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 6
model		: 1
model name	: Pentium Pro
stepping	: 2
cpu MHz		: 149.694
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
sep_bug		: yes
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
bogomips	: 298.18

[7.3.] Module information (from /proc/modules):

nfsd                  182688   8
nfs                    69452   2
lockd                  46352   1 [nfsd nfs]
sunrpc                 64828   1 [nfsd nfs lockd]
vfat                    9644   0 (unused)
msdos                   5676   0 (unused)
fat                    30816   0 [vfat msdos]
isofs                  17280   0 (unused)
usbcore                47496   1
sr_mod                 16744   0 (unused)
cdrom                  27292   0 [sr_mod]
lp                      5324   0
parport_pc              7588   1
parport                 7832   1 [lp parport_pc]
raid0                   2180   1
loop                    7936   0 (unused)
floppy                 47408   0
cls_fw                  2032   1
sch_sfq                 3256   2
sch_tbf                 2360   1
sch_prio                2280   1
ip_masq_ftp             3816   0 (unused)
ne2k-pci                4404   1
8390                    6684   0 [ne2k-pci]
3c509                   6248   1
3c59x                  21992   1
af_packet               6424   3

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
02f8-02ff : serial(set)
0300-030f : 3c509
0378-037a : parport0
03c0-03df : vga+
03f8-03ff : serial(set)
0778-077a : parport0
8000-801f : eth2
8100-817f : eth0
8200-82fe : aic7xxx
8300-8307 : serial(set)
8400-8407 : serial(set)
8500-8507 : serial(set)
8600-8607 : serial(set)

[7.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: Intel Corporation 440FX - 82441FX PMC [Natoma] (rev 02)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 32 set

00:07.0 ISA bridge: Intel Corporation 82371SB PIIX3 ISA [Natoma/Triton II] (rev 01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 set

00:07.1 IDE interface: Intel Corporation 82371SB PIIX3 IDE [Natoma/Triton II] (prog-if 80 [Master])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 set
	Region 4: I/O ports at f000

00:0a.0 VGA compatible controller: S3 Inc. 86c988 [ViRGE/VX] (rev 02) (prog-if 00 [VGA])
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 15
	Region 0: Memory at e0000000 (32-bit, non-prefetchable)

00:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RT8029(AS)
	Subsystem: Realtek Semiconductor Co., Ltd. RT8029(AS)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 19
	Region 0: I/O ports at 8000

00:0c.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] (rev 30)
	Subsystem: 3Com Corporation: Unknown device 9055
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 10 min, 10 max, 32 set, cache line size 08
	Interrupt: pin A routed to IRQ 18
	Region 0: I/O ports at 8100
	Region 1: Memory at e4000000 (32-bit, non-prefetchable)
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- AuxPwr- DSI- D1+ D2+ PME-
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0d.0 SCSI storage controller: Adaptec 7892A (rev 02)
	Subsystem: Adaptec: Unknown device e2a0
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 40 min, 25 max, 32 set, cache line size 08
	Interrupt: pin A routed to IRQ 17
	BIST result: 00
	Region 0: I/O ports at 8200
	Region 1: Memory at e4001000 (64-bit, non-prefetchable)
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- AuxPwr- DSI- D1- D2- PME-
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0e.0 Serial controller: Siig Inc CyberSerial (4-port) 16650 (prog-if 02 [16550])
	Subsystem: Siig Inc: Unknown device 2051
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 16
	Region 0: I/O ports at 8300
	Region 1: I/O ports at 8400
	Region 2: I/O ports at 8500
	Region 3: I/O ports at 8600
	Capabilities: [a0] Power Management version 1
		Flags: PMEClk- AuxPwr- DSI- D1- D2- PME-
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

[7.6.] SCSI information (from /proc/scsi/scsi)

Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: SEAGATE  Model: ST336752LW       Rev: 0002
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: SEAGATE  Model: ST318451LW       Rev: 0002
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: SEAGATE  Model: ST39103LW        Rev: 0002
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 03 Lun: 00
  Vendor: IBM      Model: DRVS18V          Rev: 0140
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 04 Lun: 00
  Vendor: IBM      Model: DDRS-39130D      Rev: DC1B
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 05 Lun: 00
  Vendor: PIONEER  Model: CD-ROM DR-U24X   Rev: 1.01
  Type:   CD-ROM                           ANSI SCSI revision: 02

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

N/A

[X.] Other notes, patches, fixes, workarounds:

Vanilla 2.2.22 plus kmsgdump patches.
