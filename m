Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268971AbRH3AFq>; Wed, 29 Aug 2001 20:05:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269100AbRH3AF2>; Wed, 29 Aug 2001 20:05:28 -0400
Received: from mail.networkone.net ([209.144.112.246]:24327 "HELO
	mail.networkone.net") by vger.kernel.org with SMTP
	id <S268971AbRH3AFV>; Wed, 29 Aug 2001 20:05:21 -0400
Content-Type: text/plain; charset=US-ASCII
From: Joe <sparky@ptw.com>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: 2.4.9 bootup oops on kmalloc
Date: Wed, 29 Aug 2001 17:05:29 -0700
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010830000525Z268971-760+7250@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Short Descr: Oops on kmalloc
Long Descr: Kernel crashes with an oops on loading of rc/rcS/any other init 
loadup, however with a precompiled kernel from Debian I do not suffer this 
problem. (Old box never had any problem, new box does). Complains of kmalloc, 
dies randomly on init processes with errors that aren't always the same. 
Sysem is a 1.33ghz T-Bird on a KK266 w/ 2x512mb DIMM's @133mhz. Highmem is 
turned on.
Area of problem: kmalloc
Kernel Version: Linux 2.4.9
Copy of Oops:
Aug 29 13:47:51 roach kernel: c012725d
Aug 29 13:47:51 roach kernel: Oops: 0000
Aug 29 13:47:51 roach kernel: CPU:    0
Aug 29 13:47:51 roach kernel: EIP:    0010:[<c012725d>]
Using defaults from ksymoops -t elf32-i386 -a i386
Aug 29 13:47:51 roach kernel: EFLAGS: 00010003
Aug 29 13:47:51 roach kernel: eax: ec706c3c   ebx: c210b0c0   ecx: 0890a040   
edx: ec759000
Aug 29 13:47:51 roach kernel: esi: 00000246   edi: 000000f0   ebp: f7dc8ea0   
esp: f7d3dc38
Aug 29 13:47:51 roach kernel: ds: 0018   es: 0018   ss: 0018
Aug 29 13:47:51 roach kernel: Process rc (pid: 173, stackpage=f7d3d000)
Aug 29 13:47:51 roach kernel: Stack: f7d46200 f7d5ae40 c023a24c c0146653 
00000013 000000f0 c0282cfc c0146410
Aug 29 13:47:51 roach kernel:        00000000 f7d3de6c fffffff4 c023a248 
c02fdc20 0002b6e8 00000296 c0281f18
Aug 29 13:47:51 roach kernel:        00000000 00000000 00000000 00000000 
ffffffff f7d2ed00 00000001 00000003
Aug 29 13:47:51 roach kernel: Call Trace: [<c0146653>] [<c0146410>] 
[<c0139c10>] [<c0143764>] [<c0122f32>]
Aug 29 13:47:51 roach kernel:    [<c0123083>] [<c0122f40>] [<c0138957>] 
[<c0145d02>] [<c0145b50>] [<c0122f32>]
Aug 29 13:47:51 roach kernel:    [<c0138957>] [<c0138b93>] [<c010591f>] 
[<c0106c3b>]
Aug 29 13:47:51 roach kernel: Code: 8b 44 82 18 89 42 14 83 f8 ff 75 07 8b 02 
89 43 08 89 f6 56
 
>>EIP; c012725d <kmalloc+4d/90>   <=====
Trace; c0146653 <load_elf_binary+243/a80>
Trace; c0146410 <load_elf_binary+0/a80>
Trace; c0139c10 <cached_lookup+10/60>
Trace; c0143764 <update_atime+44/50>
Trace; c0122f32 <do_generic_file_read+502/510>
Trace; c0123083 <generic_file_read+63/80>
Trace; c0122f40 <file_read_actor+0/e0>
Trace; c0138957 <search_binary_handler+67/110>
Trace; c0145d02 <load_script+1b2/1c0>
Trace; c0145b50 <load_script+0/1c0>
Trace; c0122f32 <do_generic_file_read+502/510>
Trace; c0138957 <search_binary_handler+67/110>
Trace; c0138b93 <do_execve+193/1f0>
Trace; c010591f <sys_execve+2f/60>
Trace; c0106c3b <system_call+33/38>
Code;  c012725d <kmalloc+4d/90>
00000000 <_EIP>:
Code;  c012725d <kmalloc+4d/90>   <=====
   0:   8b 44 82 18               mov    0x18(%edx,%eax,4),%eax   <=====
Code;  c0127261 <kmalloc+51/90>
   4:   89 42 14                  mov    %eax,0x14(%edx)
Code;  c0127264 <kmalloc+54/90>
   7:   83 f8 ff                  cmp    $0xffffffff,%eax
Code;  c0127267 <kmalloc+57/90>
   a:   75 07                     jne    13 <_EIP+0x13> c0127270 
<kmalloc+60/90>Code;  c0127269 <kmalloc+59/90>
   c:   8b 02                     mov    (%edx),%eax
Code;  c012726b <kmalloc+5b/90>
   e:   89 43 08                  mov    %eax,0x8(%ebx)
Code;  c012726e <kmalloc+5e/90>
  11:   89 f6                     mov    %esi,%esi
Code;  c0127270 <kmalloc+60/90>
  13:   56                        push   %esi

and so forth, to fill about 180k of oops with not much changing between 
oops's.

Output of ver_linux:
Gnu C                  2.95.4
Gnu make               3.79.1
binutils               2.11.90.0.27
util-linux             2.11h
mount                  2.11h
modutils               2.4.7
e2fsprogs              1.22
Linux C Library        2.2.4
Dynamic linker (ldd)   2.2.4
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.11

Cpuinfo:
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 4
model name      : AMD Athlon(tm) Processor
stepping        : 2
cpu MHz         : 1330.415
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov 
pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips        : 2654.20

Everything is builtin, i am not using any modules,

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
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial(set)
0300-0301 : i2c (isa bus adapter)
0376-0376 : ide1
0378-037f : i2c (Vellemann adapter)
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(set)
0cf8-0cff : PCI conf1
5000-500f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
6000-607f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
c000-cfff : PCI Bus #01
  c000-c0ff : 3Dfx Interactive, Inc. Voodoo Banshee
d000-d00f : VIA Technologies, Inc. Bus Master IDE
  d000-d007 : ide0
  d008-d00f : ide1
dc00-dc1f : Realtek Semiconductor Co., Ltd. RTL-8029(AS)
  dc00-dc1f : ne2k-pci
e000-e0ff : C-Media Electronics Inc CM8738
  e000-e0ff : cmpci

cat /proc/iomem:

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-3ffeffff : System RAM
  00100000-001c0fb9 : Kernel code
  001c0fba-0020f24b : Kernel data
3fff0000-3fff2fff : ACPI Non-volatile Storage
3fff3000-3fffffff : ACPI Tables
d0000000-d3ffffff : VIA Technologies, Inc. VT8363/8365 [KT133/KM133]
d4000000-d7ffffff : PCI Bus #01
  d4000000-d5ffffff : 3Dfx Interactive, Inc. Voodoo Banshee
d8000000-d9ffffff : PCI Bus #01
  d8000000-d9ffffff : 3Dfx Interactive, Inc. Voodoo Banshee
da000000-da000fff : Brooktree Corporation Bt878
da001000-da001fff : Brooktree Corporation Bt878
ffff0000-ffffffff : reserved


lspci -vvv : 
00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 03)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR+
        Latency: 0
        Region 0: Memory at d0000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW+ Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP] 
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000c000-0000cfff
        Memory behind bridge: d4000000-d7ffffff
        Prefetchable memory behind bridge: d8000000-d9ffffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 
40)
        Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06) 
(prog-if 8a [Master SecP PriP])
        Subsystem: VIA Technologies, Inc. Bus Master IDE
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 4: I/O ports at d000 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
        Subsystem: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin ? routed to IRQ 7
        Capabilities: [68] Power Management version 2
               Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
00:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8029(AS)
        Subsystem: Realtek Semiconductor Co., Ltd. RT8029(AS)
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at dc00 [size=32]
 
00:0d.0 Multimedia video controller: Brooktree Corporation Bt878 (rev 02)
        Subsystem: Hauppauge computer works Inc. WinTV/GO
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (4000ns min, 10000ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at da000000 (32-bit, prefetchable) [size=4K]
 
00:0d.1 Multimedia controller: Brooktree Corporation Bt878 (rev 02)
        Subsystem: Hauppauge computer works Inc. WinTV/GO
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (1000ns min, 63750ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at da001000 (32-bit, prefetchable) [size=4K]
 
00:0f.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
        Subsystem: C-Media Electronics Inc CMI8738/C3DX PCI Audio Device
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (500ns min, 6000ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at e000 [size=256]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-) 
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
01:00.0 VGA compatible controller: 3Dfx Interactive, Inc. Voodoo Banshee (rev 
03) (prog-if 00 [VGA])
        Subsystem: Diamond Multimedia Systems Monster Fusion AGP
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort-
<MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 0
        Region 0: Memory at d4000000 (32-bit, non-prefetchable) [size=32M]
        Region 1: Memory at d8000000 (32-bit, prefetchable) [size=32M]
        Region 2: I/O ports at c000 [size=256]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [54] AGP version 1.0
                Status: RQ=7 SBA+ 64bit+ FW- Rate=x1
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
        Capabilities: [60] Power Management version 1
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

Config:

CONFIG_X86=y
CONFIG_ISA=y
CONFIG_UID16=y  
CONFIG_EXPERIMENTAL=y 
CONFIG_MODULES=y                 
CONFIG_MK7=y  
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_USE_3DNOW=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_CPUID=y  
CONFIG_HIGHMEM4G=y   
CONFIG_HIGHMEM=y     
CONFIG_MTRR=y   
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_NET=y  
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=y
CONFIG_PNP=y 
CONFIG_PNPBIOS=y 
CONFIG_PACKET=y     
CONFIG_NETLINK=y 
CONFIG_NETLINK_DEV=y 
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_BLK_DEV_IDE=y   
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=y   
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_VIA82CXXX=y 
CONFIG_IDEDMA_AUTO=y    
CONFIG_BLK_DEV_IDE_MODES=y 
CONFIG_DUMMY=y 
CONFIG_NET_ETHERNET=y   
CONFIG_NET_PCI=y   
CONFIG_NE2K_PCI=y  
CONFIG_PPP=y  
CONFIG_PPP_ASYNC=y  
IG_PPP_DEFLATE=y
CONFIG_PPP_BSDCOMP=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_I2C=y
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCF=y  
CONFIG_I2C_CHARDEV=y    
CONFIG_MOUSE=y
CONFIG_PSMOUSE=y
CONFIG_AGP=y 
CONFIG_AGP_VIA=y        
CONFIG_DRM=y
CONFIG_DRM_TDFX=y
CONFIG_VIDEO_DEV=y    
CONFIG_VIDEO_PROC_FS=y  
CONFIG_VIDEO_BT848=y 
CONFIG_FAT_FS=y
CONFIG_VFAT_FS=y  
CONFIG_TMPFS=y           
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
ONFIG_PROC_FS=y   
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y 
CONFIG_NFS_FS=y
CONFIG_NFS_V3=yCONFIG_NFSD=y
CONFIG_NFSD_V3=y
CONFIG_SUNRPC=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_PARTITION_ADVANCED=y 
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_ISO8859_1=y   
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
CONFIG_SOUND=y   
CONFIG_SOUND_CMPCI=y 
CONFIG_SOUND_CMPCI_MIDI=y 
CONFIG_SOUND_CMPCI_MPUIO=330   
CONFIG_SOUND_CMPCI_CM8738=y   
CONFIG_SOUND_CMPCI_SPEAKERS=5
CONFIG_SOUND_CMPCI_LINE_REAR=y
CONFIG_SOUND_TVMIXER=y 
CONFIG_MAGIC_SYSRQ=y  
