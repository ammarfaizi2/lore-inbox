Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317306AbSFGQtH>; Fri, 7 Jun 2002 12:49:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317307AbSFGQtG>; Fri, 7 Jun 2002 12:49:06 -0400
Received: from [64.76.155.18] ([64.76.155.18]:36243 "EHLO alumno.inacap.cl")
	by vger.kernel.org with ESMTP id <S317306AbSFGQtD>;
	Fri, 7 Jun 2002 12:49:03 -0400
Date: Fri, 7 Jun 2002 12:43:11 -0400 (CLT)
From: Robinson Maureira Castillo <rmaureira@alumno.inacap.cl>
To: linux-kernel@vger.kernel.org
Subject: kernel BUG at page_alloc.c:115!
Message-ID: <Pine.LNX.4.44.0206071233520.5254-100000@alumno.inacap.cl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all, I'm having this wonderful BUG on my pII box. It's a newly 
installed RedHat 7.3, the same happens with RH's stock kernel (2.4.18-3) 
and the errata (2.4.18-4), and now it's happening with 2.4.19-pre10-ac2.

Could this be a case of bad RAM? I'm not able to reproduce this, it 
happens randomly.

Hope this info would be helpful.

Best Regards.

ksymoops:
ksymoops 2.4.4 on i686 2.4.19-pre10-ac1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19-pre10-ac1/ (default)
     -m /boot/System.map-2.4.19-pre10-ac1 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Jun  7 09:45:01 inter kernel: kernel BUG at page_alloc.c:115!
Jun  7 09:45:01 inter kernel: invalid operand: 0000
Jun  7 09:45:01 inter kernel: CPU:    0
Jun  7 09:45:01 inter kernel: EIP:    0010:[<c012f7c4>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Jun  7 09:45:01 inter kernel: EFLAGS: 00010206
Jun  7 09:45:01 inter kernel: eax: 00000000   ebx: c100a35c   ecx: c0214420   edx: c0214448
Jun  7 09:45:01 inter kernel: esi: 00000000   edi: 00100000   ebp: 00000000   esp: c1631ed8
Jun  7 09:45:01 inter kernel: ds: 0018   es: 0018   ss: 0018
Jun  7 09:45:01 inter kernel: Process python (pid: 13196, stackpage=c1631000)
Jun  7 09:45:01 inter kernel: Stack: ccd50018 cdfbd7e0 c100a35c 00000000 c013450e c009e000 00000000 c100a35c 
Jun  7 09:45:02 inter kernel:        00001000 c0008060 00000000 c0123ec2 c100a35c 00324067 00000001 00000000 
Jun  7 09:45:02 inter kernel:        40019000 c009a400 40018000 00000000 40019000 c009a400 cce6f578 00000000 
Jun  7 09:45:02 inter kernel: Call Trace: [<c013450e>] [<c0123ec2>] [<c012833c>] [<c01264ad>] [<c0126584>] 
Jun  7 09:45:02 inter kernel:    [<c0108903>] 
Jun  7 09:45:02 inter kernel: Code: 0f 0b 73 00 7c c3 1e c0 8b 53 08 85 d2 74 08 0f 0b 75 00 7c 

>>EIP; c012f7c4 <__free_pages_ok+34/280>   <=====
Trace; c013450e <page_remove_rmap+8e/b0>
Trace; c0123ec2 <zap_page_range+192/250>
Trace; c012833c <generic_file_read+7c/130>
Trace; c01264ad <do_munmap+1ed/290>
Trace; c0126584 <sys_munmap+34/50>
Trace; c0108903 <system_call+33/38>
Code;  c012f7c4 <__free_pages_ok+34/280>
00000000 <_EIP>:
Code;  c012f7c4 <__free_pages_ok+34/280>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c012f7c6 <__free_pages_ok+36/280>
   2:   73 00                     jae    4 <_EIP+0x4> c012f7c8 <__free_pages_ok+38/280>
Code;  c012f7c8 <__free_pages_ok+38/280>
   4:   7c c3                     jl     ffffffc9 <_EIP+0xffffffc9> c012f78d <rw_swap_page_nolock+8d/90>
Code;  c012f7ca <__free_pages_ok+3a/280>
   6:   1e                        push   %ds
Code;  c012f7cb <__free_pages_ok+3b/280>
   7:   c0 8b 53 08 85 d2 74      rorb   $0x74,0xd2850853(%ebx)
Code;  c012f7d2 <__free_pages_ok+42/280>
   e:   08 0f                     or     %cl,(%edi)
Code;  c012f7d4 <__free_pages_ok+44/280>
  10:   0b 75 00                  or     0x0(%ebp),%esi
Code;  c012f7d7 <__free_pages_ok+47/280>
  13:   7c 00                     jl     15 <_EIP+0x15> c012f7d9 <__free_pages_ok+49/280>


1 warning issued.  Results may not be reliable.

cat /proc/cpuinfo:
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 5
model name	: Pentium II (Deschutes)
stepping	: 2
cpu MHz		: 350.791
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr
bogomips	: 699.59

cat /proc/ioports:
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
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
c000-cfff : PCI Bus #01
  cc00-cc7f : Silicon Integrated Systems [SiS] 6306 3D-AGP
dc00-dcff : C-Media Electronics Inc CM8738
de00-de3f : 3Com Corporation 3c905 100BaseTX [Boomerang]
  de00-de3f : 00:09.0
ffa0-ffaf : Silicon Integrated Systems [SiS] 5513 [IDE]
  ffa0-ffa7 : ide0
  ffa8-ffaf : ide1

cat /proc/iomem:
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-0fffffff : System RAM
  00100000-001e2c0a : Kernel code
  001e2c0b-0022225f : Kernel data
e6c00000-e7cfffff : PCI Bus #01
  e7000000-e77fffff : Silicon Integrated Systems [SiS] 6306 3D-AGP
e7e00000-e7efffff : PCI Bus #01
  e7ef0000-e7efffff : Silicon Integrated Systems [SiS] 6306 3D-AGP
e8000000-ebffffff : Silicon Integrated Systems [SiS] 620 Host

lspci -vvv:
00:00.0 Host bridge: Silicon Integrated Systems [SiS] 620 Host (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 32
	Region 0: Memory at e8000000 (32-bit, non-prefetchable) [size=64M]
	Capabilities: [c0] AGP version 2.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:00.1 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev d0) (prog-if 8a [Master SecP PriP])
	Subsystem: Silicon Integrated Systems [SiS] SiS5513 EIDE Controller (A,B step)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 22
	Interrupt: pin A routed to IRQ 0
	Region 0: I/O ports at <ignored>
	Region 1: I/O ports at <ignored>
	Region 2: I/O ports at <ignored>
	Region 3: I/O ports at <ignored>
	Region 4: I/O ports at ffa0 [size=16]

00:01.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513 (rev b3)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:01.1 Class ff00: Silicon Integrated Systems [SiS] ACPI
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:02.0 PCI bridge: Silicon Integrated Systems [SiS] 5591/5592 AGP (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: e7e00000-e7efffff
	Prefetchable memory behind bridge: e6c00000-e7cfffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:09.0 Ethernet controller: 3Com Corporation 3c905 100BaseTX [Boomerang]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (750ns min, 2000ns max)
	Interrupt: pin A routed to IRQ 3
	Region 0: I/O ports at de00 [size=64]
	Expansion ROM at effe0000 [disabled] [size=64K]

00:0f.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
	Subsystem: C-Media Electronics Inc CMI8738/C3DX PCI Audio Device
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 6000ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at dc00 [size=256]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS] 6306 3D-AGP (rev 2a) (prog-if 00 [VGA])
	Subsystem: Silicon Integrated Systems [SiS] SiS530,620 GUI Accelerator+3D
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min)
	Region 0: Memory at e7000000 (32-bit, prefetchable) [size=8M]
	Region 1: Memory at e7ef0000 (32-bit, non-prefetchable) [size=64K]
	Region 2: I/O ports at cc00 [size=128]
	Capabilities: [40] Power Management version 1
		Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [50] AGP version 1.0
		Status: RQ=1 SBA- 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

grep ^C .config:
CONFIG_X86=y
CONFIG_ISA=y
CONFIG_UID16=y
CONFIG_EXPERIMENTAL=y
CONFIG_MODULES=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y
CONFIG_M686=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_PPRO_FENCE=y
CONFIG_X86_MCE=y
CONFIG_NOHIGHMEM=y
CONFIG_MTRR=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_NET=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=m
CONFIG_PM=y
CONFIG_APM=m
CONFIG_APM_IGNORE_USER_SUSPEND=y
CONFIG_APM_ALLOW_INTS=y
CONFIG_APM_REAL_MODE_POWER_OFF=y
CONFIG_PNP=m
CONFIG_ISAPNP=m
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y
CONFIG_PACKET=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_SYN_COOKIES=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=m
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_PIIX=y
CONFIG_PIIX_TUNING=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
CONFIG_NET_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
CONFIG_VORTEX=m
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_MOUSE=y
CONFIG_PSMOUSE=y
CONFIG_RTC=m
CONFIG_AGP=m
CONFIG_AGP_INTEL=y
CONFIG_AGP_SIS=y
CONFIG_AUTOFS4_FS=y
CONFIG_EXT3_FS=y
CONFIG_JBD=y
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y
CONFIG_ZISOFS_FS=m
CONFIG_MSDOS_PARTITION=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_VGA_CONSOLE=y
CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_ZLIB_INFLATE=m
CONFIG_ZLIB_DEFLATE=m

cat /proc/version:
Linux version 2.4.19-pre10-ac1 (root@alumno.inacap.cl) (gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-85)) #1 Wed Jun 5 11:36:43 CLT 2002
Kernel was compiled on another machine, included ver_linux from both

ver_linux target machine:
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux inter.net.irc.cl 2.4.19-pre10-ac1 #1 Wed Jun 5 11:36:43 CLT 2002 i686 unknown
 
Gnu C                  2.96
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.14
e2fsprogs              1.27
reiserfsprogs          3.x.0j
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.3.3
Sh-utils               2.0.11
Modules Loaded         3c59x ide-cd cdrom rtc

ver_linux compiler machine:
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux alumno.inacap.cl 2.4.16-0.5smp #1 SMP Mon Dec 3 13:34:13 EST 2001 
i686 unknown
 
Gnu C                  2.96
Gnu make               3.79.1
binutils               2.10.91.0.2
util-linux             2.11f
mount                  2.11b
modutils               2.4.13
e2fsprogs              1.26
Linux C Library        2.2.4
Dynamic linker (ldd)   2.2.4
Procps                 2.0.7
Net-tools              1.57
Console-tools          0.3.3
Sh-utils               2.0
Modules Loaded         nls_cp437 vfat fat nfsd lockd sunrpc nls_iso8859-1 
ide-cd cdrom loop autofs eepro100 aic7xxx sd_mod scsi_mod

-- 
Robinson Maureira Castillo
Asesor DAI
INACAP

