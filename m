Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278327AbRJMQE5>; Sat, 13 Oct 2001 12:04:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278322AbRJMQEt>; Sat, 13 Oct 2001 12:04:49 -0400
Received: from 213-99-145-45.uc.nombres.ttd.es ([213.99.145.45]:21742 "EHLO
	torre.localnet") by vger.kernel.org with ESMTP id <S278321AbRJMQEX> convert rfc822-to-8bit;
	Sat, 13 Oct 2001 12:04:23 -0400
Content-Type: text/plain; charset=US-ASCII
From: =?iso-8859-1?q?Jos=E9=20M=AA=20Perez=20C=E1ncer?= 
	<jose.perez@upcnet.es>
Message-Id: <200110131756.07799@jm-es-el-mejor>
To: linux-kernel@vger.kernel.org
Subject: 19 oopses in 1 second
Date: Sat, 13 Oct 2001 18:04:26 +0200
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
I've had some oopses today. They have occured sequentially killing all my 
processes as soon as I tried to do anything with any of them.
At the console I could repeat the oppses doing an "ls /tmp".
All the data except the oopses has been taken after rebooting the machine.

The /tmp is inside a reiser filesystem with 77% free space.


Please CC me.


The first oops:
Oct 13 14:59:00 torre kernel: Unable to handle kernel paging request at 
virtual
address 00547098
Oct 13 14:59:00 torre kernel:  printing eip:
Oct 13 14:59:00 torre kernel: c013fec0
Oct 13 14:59:00 torre kernel: *pde = 00000000
Oct 13 14:59:00 torre kernel: Oops: 0000
Oct 13 14:59:00 torre kernel: CPU:    0
Oct 13 14:59:00 torre kernel: EIP:    0010:[d_lookup+96/256]    Not tainted
Oct 13 14:59:00 torre kernel: EFLAGS: 00010207
Oct 13 14:59:00 torre kernel: eax: dff1e110   ebx: 00547088   ecx: 00000010   
edx: fc2d1128
Oct 13 14:59:00 torre kernel: esi: 00000000   edi: d0aa3fa4   ebp: 00547098   
esp: d0aa3f14
Oct 13 14:59:00 torre kernel: ds: 0018   es: 0018   ss: 0018
Oct 13 14:59:00 torre kernel: Process kdeinit (pid: 2102, stackpage=d0aa3000)
Oct 13 14:59:00 torre kernel: Stack: d0aa3f74 00000000 d0aa3fa4 df835b80 
dff1e110 d2223005 fc2d1128 0000000a
Oct 13 14:59:00 torre kernel:        c0137b10 dfac9840 d0aa3f74 d0aa3f74 
c0138248 dfac9840 d0aa3f74 00000000
Oct 13 14:59:00 torre kernel:        d2223000 00000000 d0aa3fa4 00000009 
c013790d 0000000b d2223010 00000000
Oct 13 14:59:00 torre kernel: Call Trace: [cached_lookup+16/96] 
[link_path_walk+1288/1888] [getname+93/160] [path_walk+26/32] 
[__user_walk+53/80]
Oct 13 14:59:00 torre kernel:    [sys_stat64+25/112] [system_call+51/56]
Oct 13 14:59:00 torre kernel:
Oct 13 14:59:00 torre kernel: Code: 8b 6d 00 8b 54 24 18 39 53 44 75 7c 8b 44 
24 24 39 43 0c 75

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 6d 00                  mov    0x0(%ebp),%ebp
Code;  00000002 Before first symbol
   3:   8b 54 24 18               mov    0x18(%esp,1),%edx
Code;  00000006 Before first symbol
   7:   39 53 44                  cmp    %edx,0x44(%ebx)
Code;  0000000a Before first symbol
   a:   75 7c                     jne    88 <_EIP+0x88> 00000088 Before first 
symbol
Code;  0000000c Before first symbol
   c:   8b 44 24 24               mov    0x24(%esp,1),%eax
Code;  00000010 Before first symbol
  10:   39 43 0c                  cmp    %eax,0xc(%ebx)
Code;  00000012 Before first symbol
  13:   75 00                     jne    15 <_EIP+0x15> 00000014 Before first 
symbol


I can't reproduce the oops after rebooting, and my rc scripts deleted the 
/tmp contents.


Software:
Linux torre.localnet 2.4.12 #3 jue oct 11 19:42:59 CEST 2001 i686 AuthenticAMD

Gnu C                  2.95.2
Gnu make               3.79.1
binutils               2.11.90.0.31
util-linux             2.11h
mount                  2.11h
modutils               2.4.0
e2fsprogs              1.22
reiserfsprogs          3.x.0j
PPP                    2.4.1
Linux C Library        2.2.4
Dynamic linker (ldd)   2.2.4
Procps                 2.0.2
Net-tools              1.60
Kbd                    0.99
Sh-utils               1.16
Modules Loaded         NVdriver


Processor info:
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 4
model name      : AMD Athlon(tm) processor
stepping        : 2
cpu MHz         : 1196.640
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
bogomips        : 2385.51


Modules:
NVdriver              714176  17 (autoclean)


ioports:
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
02f8-02ff : serial(auto)
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
5000-500f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
6000-607f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
d000-d003 : Advanced Micro Devices [AMD] AMD-760 [Irongate] System Controller
d400-d40f : VIA Technologies, Inc. Bus Master IDE
  d400-d407 : ide0
  d408-d40f : ide1
e400-e41f : Creative Labs SB Live! EMU10k1
  e400-e41f : EMU10K1
e800-e807 : Creative Labs SB Live!
ec00-ecff : Realtek Semiconductor Co., Ltd. RTL-8139
  ec00-ecff : 8139too


iomem:
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-1ffeffff : System RAM
  00100000-002b1007 : Kernel code
  002b1008-00348263 : Kernel data
1fff0000-1fff2fff : ACPI Non-volatile Storage
1fff3000-1fffffff : ACPI Tables
d0000000-d7ffffff : Advanced Micro Devices [AMD] AMD-760 [Irongate] System 
Controller
d8000000-dfffffff : PCI Bus #01
  d8000000-dfffffff : nVidia Corporation NV11 (GeForce2 MX DDR)
e0000000-e1ffffff : PCI Bus #01
  e0000000-e0ffffff : nVidia Corporation NV11 (GeForce2 MX DDR)
e2000000-e2000fff : Advanced Micro Devices [AMD] AMD-760 [Irongate] System 
Controller
e2001000-e20010ff : Realtek Semiconductor Co., Ltd. RTL-8139
  e2001000-e20010ff : 8139too
ffff0000-ffffffff : reserved


PCI info:
00:00.0 Host bridge: Advanced Micro Devices [AMD]: Unknown device 700e (rev 
13)         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 32 set
        Region 0: Memory at d0000000 (32-bit, prefetchable) [size=128M]
        Region 1: Memory at e2000000 (32-bit, prefetchable) [size=4K]
        Region 2: I/O ports at d000 [disabled] [size=4]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=15 SBA+ 64bit- FW+ Rate=421
                Command: RQ=0 SBA- AGP+ 64bit- FW- Rate=4

00:01.0 PCI bridge: Advanced Micro Devices [AMD]: Unknown device 700f 
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 set
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: e0000000-e1ffffff
        Prefetchable memory behind bridge: d8000000-dfffffff
        BridgeCtl: Parity- SERR+ NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super] (rev 40)
        Subsystem: VIA Technologies, Inc.: Unknown device 0686
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 set
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- AuxPwr- DSI- D1- D2- PME-
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 06) 
(prog-if 8a [Master SecP PriP])
        Subsystem: VIA Technologies, Inc.: Unknown device 0571
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 set
        Region 4: I/O ports at d400 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- AuxPwr- DSI- D1- D2- PME-
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.4 SMBus: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
        Subsystem: VIA Technologies, Inc.: Unknown device 3057
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin ? routed to IRQ 9
        Capabilities: [68] Power Management version 2
                Flags: PMEClk- AuxPwr- DSI- D1- D2- PME-
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 Multimedia audio controller: Creative Labs SB Live! EMU10000 (rev 04)
        Subsystem: Creative Labs CT4850 SBLive! Value
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 2 min, 20 max, 32 set
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at e400 [size=32]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- AuxPwr- DSI- D1- D2- PME-
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.1 Input device controller: Creative Labs SB Live! (rev 01)
        Subsystem: Creative Labs Gameport Joystick
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 set
        Region 0: I/O ports at e800 [size=8]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- AuxPwr- DSI- D1- D2- PME-
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RT8139 (rev 10)
        Subsystem: Realtek Semiconductor Co., Ltd. RT8139
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 min, 64 max, 32 set
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at ec00 [size=256]
        Region 1: Memory at e2001000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- AuxPwr- DSI- D1+ D2+ PME-
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:05.0 VGA compatible controller: nVidia Corporation: Unknown device 0111 
(rev
b2) (prog-if 00 [VGA])
        Subsystem: Micro-star International Co Ltd: Unknown device 8261
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 5 min, 1 max, 248 set
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at e0000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: Memory at d8000000 (32-bit, prefetchable) [size=128M]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- AuxPwr- DSI- D1- D2- PME-
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [44] AGP version 2.0
                Status: RQ=31 SBA- 64bit- FW+ Rate=421
                Command: RQ=15 SBA- AGP+ 64bit- FW- Rate=4


SCSI info:
Attached devices: none


Additional comments:
The /tmp dir is in the root partition on a reiser filesystem. That partition 
has two directories exported using the kernel NFS server.
No heavy I/O nor heavy CPU utilization at the time of the oopses.


Kernel configuration:
CONFIG_X86=y
CONFIG_ISA=y
CONFIG_UID16=y
CONFIG_EXPERIMENTAL=y
CONFIG_MODULES=y
CONFIG_KMOD=y
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
CONFIG_X86_MSR=y
CONFIG_NOHIGHMEM=y
CONFIG_MTRR=y
CONFIG_NET=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_HOTPLUG=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=y
CONFIG_PM=y
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
CONFIG_PARPORT_PC_CML1=y
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_1284=y
CONFIG_PNP=y
CONFIG_ISAPNP=y
CONFIG_PNPBIOS=y
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_NBD=y
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y
CONFIG_PACKET=y
CONFIG_NETLINK=y
CONFIG_NETFILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_NET_IPIP=y
CONFIG_NET_IPGRE=y
CONFIG_SYN_COOKIES=y
CONFIG_IP_NF_CONNTRACK=y
CONFIG_IP_NF_FTP=y
CONFIG_IP_NF_IPTABLES=y
CONFIG_IP_NF_MATCH_MAC=y
CONFIG_IP_NF_MATCH_MARK=y
CONFIG_IP_NF_MATCH_MULTIPORT=y
CONFIG_IP_NF_MATCH_TOS=y
CONFIG_IP_NF_MATCH_TCPMSS=y
CONFIG_IP_NF_MATCH_STATE=y
CONFIG_IP_NF_FILTER=y
CONFIG_IP_NF_TARGET_REJECT=y
CONFIG_IP_NF_TARGET_MIRROR=y
CONFIG_IP_NF_NAT=y
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=y
CONFIG_IP_NF_TARGET_REDIRECT=y
CONFIG_IP_NF_NAT_FTP=y
CONFIG_IP_NF_MANGLE=y
CONFIG_IP_NF_TARGET_TOS=y
CONFIG_IP_NF_TARGET_MARK=y
CONFIG_IP_NF_TARGET_LOG=y
CONFIG_IP_NF_TARGET_TCPMSS=y
CONFIG_IPV6=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
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
CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=y
CONFIG_SD_EXTRA_DEVS=40
CONFIG_BLK_DEV_SR=y
CONFIG_SR_EXTRA_DEVS=2
CONFIG_CHR_DEV_SG=y
CONFIG_SCSI_DEBUG_QUEUES=y
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
CONFIG_TUN=y
CONFIG_ETHERTAP=y
CONFIG_NET_ETHERNET=y
CONFIG_NET_PCI=y
CONFIG_EEPRO100=y
CONFIG_8139TOO=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_SERIAL_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=y
CONFIG_BUSMOUSE=y
CONFIG_LOGIBUSMOUSE=y
CONFIG_MS_BUSMOUSE=y
CONFIG_MOUSE=y
CONFIG_PSMOUSE=y
CONFIG_WATCHDOG=y
CONFIG_SOFT_WATCHDOG=y
CONFIG_NVRAM=y
CONFIG_RTC=y
CONFIG_AGP=y
CONFIG_AGP_VIA=y
CONFIG_AGP_AMD=y
CONFIG_DRM=y
CONFIG_QUOTA=y
CONFIG_REISERFS_FS=y
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_UMSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_CRAMFS=y
CONFIG_TMPFS=y
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_NTFS_FS=y
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_ROMFS_FS=y
CONFIG_EXT2_FS=y
CONFIG_UDF_FS=y
CONFIG_CODA_FS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
CONFIG_NFSD=y
CONFIG_NFSD_V3=y
CONFIG_SUNRPC=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_SMB_FS=y
CONFIG_MSDOS_PARTITION=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_850=y
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_ISO8859_15=y
CONFIG_NLS_UTF8=y
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
CONFIG_SOUND=y
CONFIG_SOUND_EMU10K1=y
CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_DEBUG_BUGVERBOSE=y


Log of oopses (note that there are some oopses occur at different code 
positions):
Oct 13 14:59:00 torre kernel: Unable to handle kernel paging request at 
virtual
address 00547098
Oct 13 14:59:00 torre kernel:  printing eip:
Oct 13 14:59:00 torre kernel: c013fec0
Oct 13 14:59:00 torre kernel: *pde = 00000000
Oct 13 14:59:00 torre kernel: Oops: 0000
Oct 13 14:59:00 torre kernel: CPU:    0
Oct 13 14:59:00 torre kernel: EIP:    0010:[d_lookup+96/256]    Not tainted
Oct 13 14:59:00 torre kernel: EFLAGS: 00010207
Oct 13 14:59:00 torre kernel: eax: dff1e110   ebx: 00547088   ecx: 00000010   
edx: fc2d1128
Oct 13 14:59:00 torre kernel: esi: 00000000   edi: d0aa3fa4   ebp: 00547098   
esp: d0aa3f14
Oct 13 14:59:00 torre kernel: ds: 0018   es: 0018   ss: 0018
Oct 13 14:59:00 torre kernel: Process kdeinit (pid: 2102, stackpage=d0aa3000)
Oct 13 14:59:00 torre kernel: Stack: d0aa3f74 00000000 d0aa3fa4 df835b80 
dff1e110 d2223005 fc2d1128 0000000a
Oct 13 14:59:00 torre kernel:        c0137b10 dfac9840 d0aa3f74 d0aa3f74 
c0138248 dfac9840 d0aa3f74 00000000
Oct 13 14:59:00 torre kernel:        d2223000 00000000 d0aa3fa4 00000009 
c013790d 0000000b d2223010 00000000
Oct 13 14:59:00 torre kernel: Call Trace: [cached_lookup+16/96] 
[link_path_walk+1288/1888] [getname+93/160] [path_walk+26/32] 
[__user_walk+53/80]
Oct 13 14:59:00 torre kernel:    [sys_stat64+25/112] [system_call+51/56]
Oct 13 14:59:00 torre kernel:
Oct 13 14:59:00 torre kernel: Code: 8b 6d 00 8b 54 24 18 39 53 44 75 7c 8b 44 
24 24 39 43 0c 75
Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 6d 00                  mov    0x0(%ebp),%ebp
Code;  00000002 Before first symbol
   3:   8b 54 24 18               mov    0x18(%esp,1),%edx
Code;  00000006 Before first symbol
   7:   39 53 44                  cmp    %edx,0x44(%ebx)
Code;  0000000a Before first symbol
   a:   75 7c                     jne    88 <_EIP+0x88> 00000088 Before first 
symbol
Code;  0000000c Before first symbol
   c:   8b 44 24 24               mov    0x24(%esp,1),%eax
Code;  00000010 Before first symbol
  10:   39 43 0c                  cmp    %eax,0xc(%ebx)
Code;  00000012 Before first symbol
  13:   75 00                     jne    15 <_EIP+0x15> 00000014 Before first 
symbol

Oct 13 14:59:21 torre kernel:  <1>Unable to handle kernel paging request at 
virtual address 00547098
Oct 13 14:59:21 torre kernel:  printing eip:
Oct 13 14:59:21 torre kernel: c013fec0
Oct 13 14:59:21 torre kernel: *pde = 00000000
Oct 13 14:59:21 torre kernel: Oops: 0000
Oct 13 14:59:21 torre kernel: CPU:    0
Oct 13 14:59:21 torre kernel: EIP:    0010:[d_lookup+96/256]    Not tainted
Oct 13 14:59:21 torre kernel: EFLAGS: 00010203
Oct 13 14:59:21 torre kernel: eax: dff1e828   ebx: 00547088   ecx: 00000010   
edx: 002697fa
Oct 13 14:59:21 torre kernel: esi: 00000000   edi: d3ae7f84   ebp: 00547098   
esp: d3ae7ed0
Oct 13 14:59:21 torre kernel: ds: 0018   es: 0018   ss: 0018
Oct 13 14:59:21 torre kernel: Process kdeinit (pid: 4845, stackpage=d3ae7000)
Oct 13 14:59:21 torre kernel: Stack: d3ae7f30 00000000 d3ae7f84 dbe31580 
dff1e828 dc99000f 002697fa 00000003
Oct 13 14:59:21 torre kernel:        c0137b10 dbe9a640 d3ae7f30 d3ae7f30 
c0137f42 dbe9a640 d3ae7f30 00000004
Oct 13 14:59:21 torre kernel:        00000001 00000000 dc990000 d3ae7f84 
00000007 00000001 dc990013 00000000
Oct 13 14:59:21 torre kernel: Call Trace: [cached_lookup+16/96] 
[link_path_walk+514/1888] [path_walk+26/32] [open_namei+125/1488] 
[filp_open+59/96]
Oct 13 14:59:21 torre kernel:    [sys_open+56/192] [system_call+51/56]
Oct 13 14:59:21 torre kernel:
Oct 13 14:59:21 torre kernel: Code: 8b 6d 00 8b 54 24 18 39 53 44 75 7c 8b 44 
24 24 39 43 0c 75

Oct 13 15:02:19 torre kernel:  <1>Unable to handle kernel paging request at 
virtual address 00547098
Oct 13 15:02:19 torre kernel:  printing eip:
Oct 13 15:02:19 torre kernel: c013fec0
Oct 13 15:02:19 torre kernel: *pde = 00000000
Oct 13 15:02:19 torre kernel: Oops: 0000
Oct 13 15:02:19 torre kernel: CPU:    0
Oct 13 15:02:19 torre kernel: EIP:    0010:[d_lookup+96/256]    Not tainted
Oct 13 15:02:19 torre kernel: EFLAGS: 00010207
Oct 13 15:02:19 torre kernel: eax: dff1e110   ebx: 00547088   ecx: 00000010   
edx: fc2d1128
Oct 13 15:02:19 torre kernel: esi: 00000000   edi: d7b15fa4   ebp: 00547098   
esp: d7b15f14
Oct 13 15:02:19 torre kernel: ds: 0018   es: 0018   ss: 0018
Oct 13 15:02:19 torre kernel: Process kdeinit (pid: 377, stackpage=d7b15000)
Oct 13 15:02:19 torre kernel: Stack: d7b15f74 00000000 d7b15fa4 df835b80 
dff1e110 caac8005 fc2d1128 0000000a
Oct 13 15:02:19 torre kernel:        c0137b10 dfac9840 d7b15f74 d7b15f74 
c0138248 dfac9840 d7b15f74 00000000
Oct 13 15:02:19 torre kernel:        caac8000 00000000 d7b15fa4 00000009 
c013790d 0000000b caac8010 00000000
Oct 13 15:02:19 torre kernel: Call Trace: [cached_lookup+16/96] 
[link_path_walk+1288/1888] [getname+93/160] [path_walk+26/32] 
[__user_walk+53/80]
Oct 13 15:02:19 torre kernel:    [sys_stat64+25/112] [sys_write+195/208] 
[system_call+51/56]
Oct 13 15:02:19 torre kernel:
Oct 13 15:02:19 torre kernel: Code: 8b 6d 00 8b 54 24 18 39 53 44 75 7c 8b 44 
24 24 39 43 0c 75

Oct 13 15:02:31 torre kernel:  <1>Unable to handle kernel paging request at 
virtual address 00547144
Oct 13 15:02:31 torre kernel:  printing eip:
Oct 13 15:02:31 torre kernel: c0123c00
Oct 13 15:02:31 torre kernel: *pde = 00000000
Oct 13 15:02:31 torre kernel: Oops: 0000
Oct 13 15:02:31 torre kernel: CPU:    0
Oct 13 15:02:31 torre kernel: EIP:    0010:[filemap_nopage+32/752]    Not 
tainted
Oct 13 15:02:31 torre kernel: EFLAGS: 00010296
Oct 13 15:02:31 torre kernel: eax: 00547098   ebx: c032ab6c   ecx: d9be19c0   
edx: 00000000
Oct 13 15:02:31 torre kernel: esi: d9be19c0   edi: 403e4000   ebp: daff9740   
esp: d826dea4
Oct 13 15:02:31 torre kernel: ds: 0018   es: 0018   ss: 0018
Oct 13 15:02:31 torre kernel: Process kdeinit (pid: 374, stackpage=d826d000)
Oct 13 15:02:31 torre kernel: Stack: c032ab6c d9be19c0 d9a92380 00000000 
c032ae48 00000000 00547098 c0120b82
Oct 13 15:02:31 torre kernel:        d9be19c0 403e4000 00000000 403e412d 
d9a92380 ffffffff 00000000 c0120c5b
Oct 13 15:02:31 torre kernel:        d9a92380 d9be19c0 403e412d 00000000 
d8f2cf90 d9a92380 00000000 d9be19c0
Oct 13 15:02:31 torre kernel: Call Trace: [do_no_page+82/208] 
[handle_mm_fault+91/192] [do_page_fault+355/1184] [do_page_fault+0/1184] 
[free_pages+26/32]
Oct 13 15:02:31 torre kernel:    [select_bits_free+10/16] 
[sys_select+1135/1152] [sys_gettimeofday+33/304] [error_code+52/60]
Oct 13 15:02:31 torre kernel:
Oct 13 15:02:31 torre kernel: Code: 8b 90 ac 00 00 00 89 54 24 14 8b 41 04 29 
c7 c1 ef 0c 03 79
Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 90 ac 00 00 00         mov    0xac(%eax),%edx
Code;  00000006 Before first symbol
   6:   89 54 24 14               mov    %edx,0x14(%esp,1)
Code;  0000000a Before first symbol
   a:   8b 41 04                  mov    0x4(%ecx),%eax
Code;  0000000c Before first symbol
   d:   29 c7                     sub    %eax,%edi
Code;  0000000e Before first symbol
   f:   c1 ef 0c                  shr    $0xc,%edi
Code;  00000012 Before first symbol
  12:   03 79 00                  add    0x0(%ecx),%edi

Oct 13 15:03:21 torre kernel:  <1>Unable to handle kernel paging request at 
virtual address 00547144
Oct 13 15:03:21 torre kernel:  printing eip:
Oct 13 15:03:21 torre kernel: c0123c00
Oct 13 15:03:21 torre kernel: *pde = 00000000
Oct 13 15:03:21 torre kernel: Oops: 0000
Oct 13 15:03:21 torre kernel: CPU:    0
Oct 13 15:03:21 torre kernel: EIP:    0010:[filemap_nopage+32/752]    Not 
tainted
Oct 13 15:03:21 torre kernel: EFLAGS: 00010296
Oct 13 15:03:21 torre kernel: eax: 00547098   ebx: c032ab6c   ecx: da885240   
edx: 00000000
Oct 13 15:03:21 torre kernel: esi: da885240   edi: 40459000   ebp: daff9740   
esp: da611ea4
Oct 13 15:03:21 torre kernel: ds: 0018   es: 0018   ss: 0018
Oct 13 15:03:21 torre kernel: Process kdeinit (pid: 343, stackpage=da611000)
Oct 13 15:03:21 torre kernel: Stack: c032ab6c da885240 dec15cc0 00000000 
000007e1 dbcb01b0 00547098 c0120b82
Oct 13 15:03:21 torre kernel:        da885240 40459000 00000000 4045912c 
dec15cc0 ffffffff 00000000 c0120c5b
Oct 13 15:03:21 torre kernel:        dec15cc0 da885240 4045912c 00000000 
dc0e9164 dec15cc0 00000000 da885240
Oct 13 15:03:21 torre kernel: Call Trace: [do_no_page+82/208] 
[handle_mm_fault+91/192] [do_page_fault+355/1184] [do_page_fault+0/1184] 
[sock_read+142/160]
Oct 13 15:03:21 torre kernel:    [sys_read+195/208] [error_code+52/60]
Oct 13 15:03:21 torre kernel:
Oct 13 15:03:21 torre kernel: Code: 8b 90 ac 00 00 00 89 54 24 14 8b 41 04 29 
c7 c1 ef 0c 03 79

Oct 13 15:03:21 torre kernel:  <1>Unable to handle kernel paging request at 
virtual address 00547098
Oct 13 15:03:21 torre kernel:  printing eip:
Oct 13 15:03:21 torre kernel: c013fec0
Oct 13 15:03:21 torre kernel: *pde = 00000000
Oct 13 15:03:21 torre kernel: Oops: 0000
Oct 13 15:03:21 torre kernel: CPU:    0
Oct 13 15:03:21 torre kernel: EIP:    0010:[d_lookup+96/256]    Not tainted
Oct 13 15:03:21 torre kernel: EFLAGS: 00010207
Oct 13 15:03:21 torre kernel: eax: dff1e110   ebx: 00547088   ecx: 00000010   
edx: fc2d1128
Oct 13 15:03:21 torre kernel: esi: 00000000   edi: da769fa4   ebp: 00547098   
esp: da769f20
Oct 13 15:03:21 torre kernel: ds: 0018   es: 0018   ss: 0018
Oct 13 15:03:21 torre kernel: Process kdeinit (pid: 364, stackpage=da769000)
Oct 13 15:03:21 torre kernel: Stack: da769f80 00000000 da769fa4 df835b80 
dff1e110 d38b7005 fc2d1128 0000000a
Oct 13 15:03:21 torre kernel:        c0137b10 dfac9840 da769f80 da769f80 
c0137f42 dfac9840 da769f80 00000004
Oct 13 15:03:21 torre kernel:        da769fa4 00000000 d38b7000 da769fa4 
c013790d 00000010 d38b7010 00000000
Oct 13 15:03:21 torre kernel: Call Trace: [cached_lookup+16/96] 
[link_path_walk+514/1888] [getname+93/160] [path_walk+26/32] 
[sys_unlink+69/288]
Oct 13 15:03:21 torre kernel:    [sys_write+195/208] [system_call+51/56]
Oct 13 15:03:21 torre kernel:
Oct 13 15:03:21 torre kernel: Code: 8b 6d 00 8b 54 24 18 39 53 44 75 7c 8b 44 
24 24 39 43 0c 75

Oct 13 15:03:21 torre kernel:  <1>Unable to handle kernel paging request at 
virtual address 00547098
Oct 13 15:03:21 torre kernel:  printing eip:
Oct 13 15:03:21 torre kernel: c013fec0
Oct 13 15:03:21 torre kernel: *pde = 00000000
Oct 13 15:03:21 torre kernel: Oops: 0000
Oct 13 15:03:21 torre kernel: CPU:    0
Oct 13 15:03:21 torre kernel: EIP:    0010:[d_lookup+96/256]    Not tainted
Oct 13 15:03:21 torre kernel: EFLAGS: 00010207
Oct 13 15:03:21 torre kernel: eax: dff1e110   ebx: 00547088   ecx: 00000010   
edx: fc2d1128
Oct 13 15:03:21 torre kernel: esi: 00000000   edi: da6fbfa4   ebp: 00547098   
esp: da6fbf20
Oct 13 15:03:21 torre kernel: ds: 0018   es: 0018   ss: 0018
Oct 13 15:03:21 torre kernel: Process kdeinit (pid: 341, stackpage=da6fb000)
Oct 13 15:03:21 torre kernel: Stack: da6fbf80 00000000 da6fbfa4 df835b80 
dff1e110 c26ee005 fc2d1128 0000000a
Oct 13 15:03:21 torre kernel:        c0137b10 dfac9840 da6fbf80 da6fbf80 
c0137f42 dfac9840 da6fbf80 00000004
Oct 13 15:03:21 torre kernel:        da6fbfa4 00000000 c26ee000 da6fbfa4 
c013790d 00000010 c26ee010 00000000
Oct 13 15:03:21 torre kernel: Call Trace: [cached_lookup+16/96] 
[link_path_walk+514/1888] [getname+93/160] [path_walk+26/32] 
[sys_unlink+69/288]
Oct 13 15:03:21 torre kernel:    [sys_write+195/208] [system_call+51/56]
Oct 13 15:03:21 torre kernel:
Oct 13 15:03:21 torre kernel: Code: 8b 6d 00 8b 54 24 18 39 53 44 75 7c 8b 44 
24 24 39 43 0c 75

Oct 13 15:03:21 torre kernel:  <1>Unable to handle kernel paging request at 
virtual address 00547144
Oct 13 15:03:21 torre kernel:  printing eip:
Oct 13 15:03:21 torre kernel: c0123c00
Oct 13 15:03:21 torre kernel: *pde = 00000000
Oct 13 15:03:21 torre kernel: Oops: 0000
Oct 13 15:03:21 torre kernel: CPU:    0
Oct 13 15:03:21 torre kernel: EIP:    0010:[filemap_nopage+32/752]    Not 
tainted
Oct 13 15:03:21 torre kernel: EFLAGS: 00010296
Oct 13 15:03:21 torre kernel: eax: 00547098   ebx: c032ab6c   ecx: d9fa7dc0   
edx: 00000000
Oct 13 15:03:21 torre kernel: esi: d9fa7dc0   edi: 40459000   ebp: daff9740   
esp: d98cfea4
Oct 13 15:03:21 torre kernel: ds: 0018   es: 0018   ss: 0018
Oct 13 15:03:21 torre kernel: Process kdeinit (pid: 353, stackpage=d98cf000)
Oct 13 15:03:21 torre kernel: Stack: c032ab6c d9fa7dc0 dec15f00 00000000 
000007e1 dbcb01b0 00547098 c0120b82
Oct 13 15:03:21 torre kernel:        d9fa7dc0 40459000 00000000 4045912c 
dec15f00 ffffffff 00000000 c0120c5b
Oct 13 15:03:21 torre kernel:        dec15f00 d9fa7dc0 4045912c 00000000 
d98cd164 dec15f00 00000000 d9fa7dc0
Oct 13 15:03:21 torre kernel: Call Trace: [do_no_page+82/208] 
[handle_mm_fault+91/192] [do_page_fault+355/1184] [do_page_fault+0/1184] 
[sock_read+142/160]
Oct 13 15:03:21 torre kernel:    [sys_read+195/208] [error_code+52/60]
Oct 13 15:03:21 torre kernel:
Oct 13 15:03:21 torre kernel: Code: 8b 90 ac 00 00 00 89 54 24 14 8b 41 04 29 
c7 c1 ef 0c 03 79

Oct 13 15:03:21 torre kernel:  <1>Unable to handle kernel paging request at 
virtual address 00547144
Oct 13 15:03:21 torre kernel:  printing eip:
Oct 13 15:03:21 torre kernel: c0123c00
Oct 13 15:03:21 torre kernel: *pde = 00000000
Oct 13 15:03:21 torre kernel: Oops: 0000
Oct 13 15:03:21 torre kernel: CPU:    0
Oct 13 15:03:21 torre kernel: EIP:    0010:[filemap_nopage+32/752]    Not 
tainted
Oct 13 15:03:21 torre kernel: EFLAGS: 00010296
Oct 13 15:03:21 torre kernel: eax: 00547098   ebx: c032ab6c   ecx: d97f1340   
edx: 00000000
Oct 13 15:03:21 torre kernel: esi: d97f1340   edi: 40459000   ebp: daff9740   
esp: d976bea4
Oct 13 15:03:21 torre kernel: ds: 0018   es: 0018   ss: 0018
Oct 13 15:03:21 torre kernel: Process kdeinit (pid: 370, stackpage=d976b000)
Oct 13 15:03:21 torre kernel: Stack: c032ab6c d97f1340 dec15e40 00000000 
000000ad da805730 00547098 c0120b82
Oct 13 15:03:21 torre kernel:        d97f1340 40459000 00000000 4045912c 
dec15e40 ffffffff 00000000 c0120c5b
Oct 13 15:03:21 torre kernel:        dec15e40 d97f1340 4045912c 00000000 
d97ad164 dec15e40 00000000 d97f1340
Oct 13 15:03:21 torre kernel: Call Trace: [do_no_page+82/208] 
[handle_mm_fault+91/192] [do_page_fault+355/1184] [do_page_fault+0/1184] 
[sock_read+142/160]
Oct 13 15:03:21 torre kernel:    [sys_read+195/208] [error_code+52/60]
Oct 13 15:03:21 torre kernel:
Oct 13 15:03:21 torre kernel: Code: 8b 90 ac 00 00 00 89 54 24 14 8b 41 04 29 
c7 c1 ef 0c 03 79

Oct 13 15:03:21 torre kernel:  <1>Unable to handle kernel paging request at 
virtual address 00547144
Oct 13 15:03:21 torre kernel:  printing eip:
Oct 13 15:03:21 torre kernel: c0123c00
Oct 13 15:03:21 torre kernel: *pde = 00000000
Oct 13 15:03:21 torre kernel: Oops: 0000
Oct 13 15:03:21 torre kernel: CPU:    0
Oct 13 15:03:21 torre kernel: EIP:    0010:[filemap_nopage+32/752]    Not 
tainted
Oct 13 15:03:21 torre kernel: EFLAGS: 00010296
Oct 13 15:03:21 torre kernel: eax: 00547098   ebx: c032ab6c   ecx: d97f3b40   
edx: 00000000
Oct 13 15:03:21 torre kernel: esi: d97f3b40   edi: 40459000   ebp: daff9740   
esp: d83dfea4
Oct 13 15:03:21 torre kernel: ds: 0018   es: 0018   ss: 0018
Oct 13 15:03:21 torre kernel: Process kdeinit (pid: 372, stackpage=d83df000)
Oct 13 15:03:21 torre kernel: Stack: c032ab6c d97f3b40 d9a92080 00000000 
000007e1 dbcb01b0 00547098 c0120b82
Oct 13 15:03:21 torre kernel:        d97f3b40 40459000 00000000 4045912c 
d9a92080 ffffffff 00000000 c0120c5b
Oct 13 15:03:21 torre kernel:        d9a92080 d97f3b40 4045912c 00000000 
d948d164 d9a92080 00000000 d97f3b40
Oct 13 15:03:21 torre kernel: Call Trace: [do_no_page+82/208] 
[handle_mm_fault+91/192] [do_page_fault+355/1184] [do_page_fault+0/1184] 
[sock_read+142/160]
Oct 13 15:03:21 torre kernel:    [sys_read+195/208] [error_code+52/60]
Oct 13 15:03:21 torre kernel:
Oct 13 15:03:21 torre kernel: Code: 8b 90 ac 00 00 00 89 54 24 14 8b 41 04 29 
c7 c1 ef 0c 03 79

Oct 13 15:03:21 torre kernel:  <1>Unable to handle kernel paging request at 
virtual address 00547144
Oct 13 15:03:21 torre kernel:  printing eip:
Oct 13 15:03:21 torre kernel: c0123c00
Oct 13 15:03:21 torre kernel: *pde = 00000000
Oct 13 15:03:21 torre kernel: Oops: 0000
Oct 13 15:03:21 torre kernel: CPU:    0
Oct 13 15:03:21 torre kernel: EIP:    0010:[filemap_nopage+32/752]    Not 
tainted
Oct 13 15:03:21 torre kernel: EFLAGS: 00010296
Oct 13 15:03:21 torre kernel: eax: 00547098   ebx: c032ab6c   ecx: d7cee5c0   
edx: 00000000
Oct 13 15:03:21 torre kernel: esi: d7cee5c0   edi: 40461000   ebp: daff9740   
esp: d7cf3ea4
Oct 13 15:03:21 torre kernel: ds: 0018   es: 0018   ss: 0018
Oct 13 15:03:21 torre kernel: Process kdeinit (pid: 380, stackpage=d7cf3000)
Oct 13 15:03:21 torre kernel: Stack: c032ab6c d7cee5c0 d9a925c0 00000000 
000000ad da805730 00547098 c0120b82
Oct 13 15:03:21 torre kernel:        d7cee5c0 40461000 00000000 4046102c 
d9a925c0 ffffffff 00000000 c0120c5b
Oct 13 15:03:21 torre kernel:        d9a925c0 d7cee5c0 4046102c 00000000 
d7ced184 d9a925c0 00000000 d7cee5c0
Oct 13 15:03:21 torre kernel: Call Trace: [do_no_page+82/208] 
[handle_mm_fault+91/192] [do_page_fault+355/1184] [do_page_fault+0/1184] 
[sock_read+142/160]
Oct 13 15:03:21 torre kernel:    [sys_read+195/208] [error_code+52/60]
Oct 13 15:03:21 torre kernel:
Oct 13 15:03:21 torre kernel: Code: 8b 90 ac 00 00 00 89 54 24 14 8b 41 04 29 
c7 c1 ef 0c 03 79

Oct 13 15:03:21 torre kernel:  <1>Unable to handle kernel paging request at 
virtual address 00547098
Oct 13 15:03:21 torre kernel:  printing eip:
Oct 13 15:03:21 torre kernel: c013fec0
Oct 13 15:03:21 torre kernel: *pde = 00000000
Oct 13 15:03:21 torre kernel: Oops: 0000
Oct 13 15:03:21 torre kernel: CPU:    0
Oct 13 15:03:21 torre kernel: EIP:    0010:[d_lookup+96/256]    Not tainted
Oct 13 15:03:21 torre kernel: EFLAGS: 00010207
Oct 13 15:03:21 torre kernel: eax: dff1e110   ebx: 00547088   ecx: 00000010   
edx: fc2d1128
Oct 13 15:03:21 torre kernel: esi: 00000000   edi: dbd3dfa4   ebp: 00547098   
esp: dbd3df14
Oct 13 15:03:21 torre kernel: ds: 0018   es: 0018   ss: 0018
Oct 13 15:03:21 torre kernel: Process ksmserver (pid: 365, stackpage=dbd3d000)
Oct 13 15:03:21 torre kernel: Stack: dbd3df74 00000000 dbd3dfa4 df835b80 
dff1e110 da8c7005 fc2d1128 0000000a
Oct 13 15:03:21 torre kernel:        c0137b10 dfac9840 dbd3df74 dbd3df74 
c0138248 dfac9840 dbd3df74 00000000
Oct 13 15:03:21 torre kernel:        da8c7000 00000000 dbd3dfa4 00000009 
c013790d 0000000b da8c7010 00000000
Oct 13 15:03:21 torre kernel: Call Trace: [cached_lookup+16/96] 
[link_path_walk+1288/1888] [getname+93/160] [path_walk+26/32] 
[__user_walk+53/80]
Oct 13 15:03:21 torre kernel:    [sys_stat64+25/112] [system_call+51/56]
Oct 13 15:03:21 torre kernel:
Oct 13 15:03:21 torre kernel: Code: 8b 6d 00 8b 54 24 18 39 53 44 75 7c 8b 44 
24 24 39 43 0c 75

Oct 13 15:03:21 torre kernel:  <1>Unable to handle kernel paging request at 
virtual address 00547144
Oct 13 15:03:21 torre kernel:  printing eip:
Oct 13 15:03:21 torre kernel: c0123c00
Oct 13 15:03:21 torre kernel: *pde = 00000000
Oct 13 15:03:21 torre kernel: Oops: 0000
Oct 13 15:03:21 torre kernel: CPU:    0
Oct 13 15:03:21 torre kernel: EIP:    0010:[filemap_nopage+32/752]    Not 
tainted
Oct 13 15:03:21 torre kernel: EFLAGS: 00010296
Oct 13 15:03:21 torre kernel: eax: 00547098   ebx: c032ab6c   ecx: d37d3cc0   
edx: 00000000
Oct 13 15:03:21 torre kernel: esi: d37d3cc0   edi: 40461000   ebp: daff9740   
esp: d2d8bea4
Oct 13 15:03:21 torre kernel: ds: 0018   es: 0018   ss: 0018
Oct 13 15:03:21 torre kernel: Process kdeinit (pid: 420, stackpage=d2d8b000)
Oct 13 15:03:21 torre kernel: Stack: c032ab6c d37d3cc0 d9a92e00 00000000 
000000ad da805730 00547098 c0120b82
Oct 13 15:03:21 torre kernel:        d37d3cc0 40461000 00000000 4046102c 
d9a92e00 ffffffff 00000000 c0120c5b
Oct 13 15:03:21 torre kernel:        d9a92e00 d37d3cc0 4046102c 00000000 
d3775184 d9a92e00 00000000 d37d3cc0
Oct 13 15:03:21 torre kernel: Call Trace: [do_no_page+82/208] 
[handle_mm_fault+91/192] [do_page_fault+355/1184] [do_page_fault+0/1184] 
[tty_write+344/464]
Oct 13 15:03:21 torre kernel:    [write_chan+0/512] [sys_write+195/208] 
[error_code+52/60]
Oct 13 15:03:21 torre kernel:
Oct 13 15:03:21 torre kernel: Code: 8b 90 ac 00 00 00 89 54 24 14 8b 41 04 29 
c7 c1 ef 0c 03 79

Oct 13 15:03:21 torre kernel:  <1>Unable to handle kernel paging request at 
virtual address 00547144
Oct 13 15:03:21 torre kernel:  printing eip:
Oct 13 15:03:21 torre kernel: c0123c00
Oct 13 15:03:21 torre kernel: *pde = 00000000
Oct 13 15:03:21 torre kernel: Oops: 0000
Oct 13 15:03:21 torre kernel: CPU:    0
Oct 13 15:03:21 torre kernel: EIP:    0010:[filemap_nopage+32/752]    Not 
tainted
Oct 13 15:03:21 torre kernel: EFLAGS: 00010296
Oct 13 15:03:21 torre kernel: eax: 00547098   ebx: c032ab6c   ecx: d4619240   
edx: 00000000
Oct 13 15:03:21 torre kernel: esi: d4619240   edi: 40459000   ebp: daff9740   
esp: d461fea4
Oct 13 15:03:21 torre kernel: ds: 0018   es: 0018   ss: 0018
Oct 13 15:03:21 torre kernel: Process kdeinit (pid: 404, stackpage=d461f000)
Oct 13 15:03:21 torre kernel: Stack: c032ab6c d4619240 d9a92bc0 00000000 
000007e1 dbcb01b0 00547098 c0120b82
Oct 13 15:03:21 torre kernel:        d4619240 40459000 00000000 4045912c 
d9a92bc0 ffffffff 00000000 c0120c5b
Oct 13 15:03:21 torre kernel:        d9a92bc0 d4619240 4045912c 00000000 
d4618164 d9a92bc0 00000000 d4619240
Oct 13 15:03:21 torre kernel: Call Trace: [do_no_page+82/208] 
[handle_mm_fault+91/192] [do_page_fault+355/1184] [do_page_fault+0/1184] 
[tty_write+344/464]
Oct 13 15:03:21 torre kernel:    [write_chan+0/512] [sys_write+195/208] 
[error_code+52/60]
Oct 13 15:03:21 torre kernel:
Oct 13 15:03:21 torre kernel: Code: 8b 90 ac 00 00 00 89 54 24 14 8b 41 04 29 
c7 c1 ef 0c 03 79

Oct 13 15:03:21 torre kernel:  <1>Unable to handle kernel paging request at 
virtual address 00547144
Oct 13 15:03:21 torre kernel:  printing eip:
Oct 13 15:03:21 torre kernel: c0123c00
Oct 13 15:03:21 torre kernel: *pde = 00000000
Oct 13 15:03:21 torre kernel: Oops: 0000
Oct 13 15:03:21 torre kernel: CPU:    0
Oct 13 15:03:21 torre kernel: EIP:    0010:[filemap_nopage+32/752]    Not 
tainted
Oct 13 15:03:21 torre kernel: EFLAGS: 00010296
Oct 13 15:03:21 torre kernel: eax: 00547098   ebx: c032ab6c   ecx: d6efdac0   
edx: 00000000
Oct 13 15:03:21 torre kernel: esi: d6efdac0   edi: 401f6000   ebp: d7be10c0   
esp: d68d5ea4
Oct 13 15:03:21 torre kernel: ds: 0018   es: 0018   ss: 0018
Oct 13 15:03:21 torre kernel: Process kmix (pid: 383, stackpage=d68d5000)
Oct 13 15:03:21 torre kernel: Stack: c032ab6c d6efdac0 d9a92800 00000000 
c0113743 0000000a 00547098 c0120b82
Oct 13 15:03:21 torre kernel:        d6efdac0 401f6000 00000000 401f6adb 
d9a92800 ffffffff 00000000 c0120c5b
Oct 13 15:03:21 torre kernel:        d9a92800 d6efdac0 401f6adb 00000000 
d68d17d8 d9a92800 00000000 d6efdac0
Oct 13 15:03:21 torre kernel: Call Trace: [release_console_sem+115/128] 
[do_no_page+82/208] [handle_mm_fault+91/192] [do_page_fault+355/1184] 
[do_page_fault+0/1184]
Oct 13 15:03:21 torre kernel:    [tty_write+344/464] [write_chan+0/512] 
[sys_write+195/208] [error_code+52/60]
Oct 13 15:03:21 torre kernel:
Oct 13 15:03:21 torre kernel: Code: 8b 90 ac 00 00 00 89 54 24 14 8b 41 04 29 
c7 c1 ef 0c 03 79

Oct 13 15:03:21 torre kernel:  <1>Unable to handle kernel paging request at 
virtual address 00547140
Oct 13 15:03:21 torre kernel:  printing eip:
Oct 13 15:03:21 torre kernel: c013f0dc
Oct 13 15:03:21 torre kernel: *pde = 00000000
Oct 13 15:03:21 torre kernel: Oops: 0000
Oct 13 15:03:21 torre kernel: CPU:    0
Oct 13 15:03:21 torre kernel: EIP:    0010:[locks_remove_flock+12/80]    Not 
tainted
Oct 13 15:03:21 torre kernel: EFLAGS: 00010202
Oct 13 15:03:21 torre kernel: eax: 00547098   ebx: d7be10c0   ecx: d9a92800   
edx: d9a92800
Oct 13 15:03:21 torre kernel: esi: d7be10c0   edi: c180f300   ebp: dbd3af40   
esp: d68d5d54
Oct 13 15:03:21 torre kernel: ds: 0018   es: 0018   ss: 0018
Oct 13 15:03:21 torre kernel: Process kmix (pid: 383, stackpage=d68d5000)
Oct 13 15:03:21 torre kernel: Stack: d7be10c0 00547098 c012ff33 d7be10c0 
d6efdb40 d9a92800 401fb000 00019000
Oct 13 15:03:21 torre kernel:        c01220b4 d9a92800 d68d4000 0000000b 
00547144 d6efdbc0 c0111e19 d9a92800
Oct 13 15:03:21 torre kernel:        d9a92800 c0115ecd d9a92800 00000000 
d9a9281c d6efd840 c01073cf 0000000b
Oct 13 15:03:21 torre kernel: Call Trace: [fput+35/224] [exit_mmap+196/304] 
[mmput+57/96] [do_exit+157/512] [die+79/80]
Oct 13 15:03:21 torre kernel:    [do_page_fault+855/1184] 
[do_page_fault+0/1184] [do_softirq+90/176] [do_IRQ+157/176] 
[_mmx_memcpy+83/256] [scrup+226/304]
Oct 13 15:03:21 torre kernel:    [error_code+52/60] [filemap_nopage+32/752] 
[release_console_sem+115/128] [do_no_page+82/208] [handle_mm_fault+91/192] 
[do_page_fault+355/1184]
Oct 13 15:03:21 torre kernel:    [do_page_fault+0/1184] [tty_write+344/464] 
[write_chan+0/512] [sys_write+195/208] [error_code+52/60]
Oct 13 15:03:21 torre kernel:
Oct 13 15:03:21 torre kernel: Code: 8b 90 a8 00 00 00 85 d2 74 2a 8d 98 a8 00 
00 00 89 d0 89 f6
Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 90 a8 00 00 00         mov    0xa8(%eax),%edx
Code;  00000006 Before first symbol
   6:   85 d2                     test   %edx,%edx
Code;  00000008 Before first symbol
   8:   74 2a                     je     34 <_EIP+0x34> 00000034 Before first 
symbol
Code;  0000000a Before first symbol
   a:   8d 98 a8 00 00 00         lea    0xa8(%eax),%ebx
Code;  00000010 Before first symbol
  10:   89 d0                     mov    %edx,%eax
Code;  00000012 Before first symbol
  12:   89 f6                     mov    %esi,%esi

Oct 13 15:03:21 torre kernel:  printing eip:
Oct 13 15:03:21 torre kernel: c013fec0
Oct 13 15:03:21 torre kernel: *pde = 00000000
Oct 13 15:03:21 torre kernel: Oops: 0000
Oct 13 15:03:21 torre kernel: CPU:    0
Oct 13 15:03:21 torre kernel: EIP:    0010:[d_lookup+96/256]    Not tainted
Oct 13 15:03:21 torre kernel: EFLAGS: 00010207
Oct 13 15:03:21 torre kernel: eax: dff1e110   ebx: 00547088   ecx: 00000010   
edx: fc2d1128
Oct 13 15:03:21 torre kernel: esi: 00000000   edi: d3f7ffa4   ebp: 00547098   
esp: d3f7ff20
Oct 13 15:03:21 torre kernel: ds: 0018   es: 0018   ss: 0018
Oct 13 15:03:21 torre kernel: Process kdesud (pid: 407, stackpage=d3f7f000)
Oct 13 15:03:21 torre kernel: Stack: d3f7ff80 00000000 d3f7ffa4 df835b80 
dff1e110 da883005 fc2d1128 0000000a
Oct 13 15:03:21 torre kernel:        c0137b10 dfac9840 d3f7ff80 d3f7ff80 
c0137f42 dfac9840 d3f7ff80 00000004
Oct 13 15:03:21 torre kernel:        d3f7ffa4 00000000 da883000 d3f7ffa4 
c013790d 00000010 da883010 00000000
Oct 13 15:03:21 torre kernel: Call Trace: [cached_lookup+16/96] 
[link_path_walk+514/1888] [getname+93/160] [path_walk+26/32] 
[sys_unlink+69/288]
Oct 13 15:03:21 torre kernel:    [sys_write+195/208] [system_call+51/56]
Oct 13 15:03:21 torre kernel:
Oct 13 15:03:21 torre kernel: Code: 8b 6d 00 8b 54 24 18 39 53 44 75 7c 8b 44 
24 24 39 43 0c 75

Oct 13 15:03:21 torre kernel:  <1>Unable to handle kernel paging request at 
virtual address 00547144
Oct 13 15:03:21 torre kernel:  printing eip:
Oct 13 15:03:21 torre kernel: c0123c00
Oct 13 15:03:21 torre kernel: *pde = 00000000
Oct 13 15:03:21 torre kernel: Oops: 0000
Oct 13 15:03:21 torre kernel: CPU:    0
Oct 13 15:03:21 torre kernel: EIP:    0010:[filemap_nopage+32/752]    Not 
tainted
Oct 13 15:03:21 torre kernel: EFLAGS: 00010296
Oct 13 15:03:21 torre kernel: eax: 00547098   ebx: c032ab6c   ecx: dc190bc0   
edx: 00000000
Oct 13 15:03:21 torre kernel: esi: dc190bc0   edi: 404f0000   ebp: d71a56c0   
esp: d674bea4
Oct 13 15:03:21 torre kernel: ds: 0018   es: 0018   ss: 0018
Oct 13 15:03:21 torre kernel: Process alarmd (pid: 385, stackpage=d674b000)
Oct 13 15:03:21 torre kernel: Stack: c032ab6c dc190bc0 d9a928c0 00000000 
00000032 dafbed30 00547098 c0120b82
Oct 13 15:03:21 torre kernel:        dc190bc0 404f0000 00000000 404f0b6b 
d9a928c0 ffffffff 00000000 c0120c5b
Oct 13 15:03:21 torre kernel:        d9a928c0 dc190bc0 404f0b6b 00000000 
d8f243c0 d9a928c0 00000000 dc190bc0
Oct 13 15:03:21 torre kernel: Call Trace: [do_no_page+82/208] 
[handle_mm_fault+91/192] [do_page_fault+355/1184] [do_page_fault+0/1184] 
[tty_write+344/464]
Oct 13 15:03:21 torre kernel:    [write_chan+0/512] [sys_write+195/208] 
[error_code+52/60]
Oct 13 15:03:21 torre kernel:
Oct 13 15:03:21 torre kernel: Code: 8b 90 ac 00 00 00 89 54 24 14 8b 41 04 29 
c7 c1 ef 0c 03 79

Oct 13 15:03:21 torre kernel:  <1>Unable to handle kernel paging request at 
virtual address 00547140
Oct 13 15:03:21 torre kernel:  printing eip:
Oct 13 15:03:21 torre kernel: c013f0dc
Oct 13 15:03:21 torre kernel: *pde = 00000000
Oct 13 15:03:21 torre kernel: Oops: 0000
Oct 13 15:03:21 torre kernel: CPU:    0
Oct 13 15:03:21 torre kernel: EIP:    0010:[locks_remove_flock+12/80]    Not 
tainted
Oct 13 15:03:21 torre kernel: EFLAGS: 00010202
Oct 13 15:03:21 torre kernel: eax: 00547098   ebx: d71a56c0   ecx: d9a928c0   
edx: d9a928c0
Oct 13 15:03:21 torre kernel: esi: d71a56c0   edi: c180f300   ebp: dbd3af40   
esp: d674bd54
Oct 13 15:03:21 torre kernel: ds: 0018   es: 0018   ss: 0018
Oct 13 15:03:21 torre kernel: Process alarmd (pid: 385, stackpage=d674b000)
Oct 13 15:03:21 torre kernel: Stack: d71a56c0 00547098 c012ff33 d71a56c0 
dc190ec0 d9a928c0 404f7000 00019000
Oct 13 15:03:21 torre kernel:        c01220b4 d9a928c0 d674a000 0000000b 
00547144 dc190b40 c0111e19 d9a928c0
Oct 13 15:03:21 torre kernel:        d9a928c0 c0115ecd d9a928c0 00000000 
d9a928dc d948a340 c01073cf 0000000b
Oct 13 15:03:21 torre kernel: Call Trace: [fput+35/224] [exit_mmap+196/304] 
[mmput+57/96] [do_exit+157/512] [die+79/80]
Oct 13 15:03:21 torre kernel:    [do_page_fault+855/1184] 
[do_page_fault+0/1184] [generic_make_request+300/320] [submit_bh+82/112] 
[block_read_full_page+508/528] [schedule+604/912]
Oct 13 15:03:21 torre kernel:    [error_code+52/60] [filemap_nopage+32/752] 
[do_no_page+82/208] [handle_mm_fault+91/192] [do_page_fault+355/1184] 
[do_page_fault+0/1184]
Oct 13 15:03:21 torre kernel:    [tty_write+344/464] [write_chan+0/512] 
[sys_write+195/208] [error_code+52/60]
Oct 13 15:03:21 torre kernel:
Oct 13 15:03:21 torre kernel: Code: 8b 90 a8 00 00 00 85 d2 74 2a 8d 98 a8 00 
00 00 89 d0 89 f6

Oct 13 15:03:21 torre kernel:  <1>Unable to handle kernel paging request at 
virtual address 00547144
Oct 13 15:03:21 torre kernel:  printing eip:
Oct 13 15:03:21 torre kernel: c0123c00
Oct 13 15:03:21 torre kernel: *pde = 00000000
Oct 13 15:03:21 torre kernel: Oops: 0000
Oct 13 15:03:21 torre kernel: CPU:    0
Oct 13 15:03:21 torre kernel: EIP:    0010:[filemap_nopage+32/752]    Not 
tainted
Oct 13 15:03:21 torre kernel: EFLAGS: 00010296
Oct 13 15:03:21 torre kernel: eax: 00547098   ebx: c032ab6c   ecx: d2bb0440   
edx: 00000000
Oct 13 15:03:21 torre kernel: esi: d2bb0440   edi: 4085d000   ebp: d2bbc2c0   
esp: d1ef3ea4
Oct 13 15:03:21 torre kernel: ds: 0018   es: 0018   ss: 0018
Oct 13 15:03:21 torre kernel: Process kmail (pid: 621, stackpage=d1ef3000)
Oct 13 15:03:21 torre kernel: Stack: c032ab6c d2bb0440 d9a92980 00000000 
00000028 d0b55770 00547098 c0120b82
Oct 13 15:03:21 torre kernel:        d2bb0440 4085d000 00000000 4085dadb 
d9a92980 ffffffff 00000000 c0120c5b
Oct 13 15:03:21 torre kernel:        d9a92980 d2bb0440 4085dadb 00000000 
d1eef174 d9a92980 00000000 d2bb0440
Oct 13 15:03:21 torre kernel: Call Trace: [do_no_page+82/208] 
[handle_mm_fault+91/192] [do_page_fault+355/1184] [do_page_fault+0/1184] 
[emu10k1_wavein_update+32/80]
Oct 13 15:03:21 torre kernel:    [emu10k1_wavein_bh+52/112] 
[schedule+604/912] [error_code+52/60]
Oct 13 15:03:21 torre kernel:
Oct 13 15:03:21 torre kernel: Code: 8b 90 ac 00 00 00 89 54 24 14 8b 41 04 29 
c7 c1 ef 0c 03 79

Oct 13 15:03:21 torre kernel:  <1>Unable to handle kernel paging request at 
virtual address 00547140
Oct 13 15:03:21 torre kernel:  printing eip:
Oct 13 15:03:21 torre kernel: c013f0dc
Oct 13 15:03:21 torre kernel: *pde = 00000000
Oct 13 15:03:21 torre kernel: Oops: 0000
Oct 13 15:03:21 torre kernel: CPU:    0
Oct 13 15:03:21 torre kernel: EIP:    0010:[locks_remove_flock+12/80]    Not 
tainted
Oct 13 15:03:21 torre kernel: EFLAGS: 00010202
Oct 13 15:03:21 torre kernel: eax: 00547098   ebx: d2bbc2c0   ecx: d9a92980   
edx: d9a92980
Oct 13 15:03:21 torre kernel: esi: d2bbc2c0   edi: c180f300   ebp: dbd3af40   
esp: d1ef3d54
Oct 13 15:03:21 torre kernel: ds: 0018   es: 0018   ss: 0018
Oct 13 15:03:21 torre kernel: Process kmail (pid: 621, stackpage=d1ef3000)
Oct 13 15:03:21 torre kernel: Stack: d2bbc2c0 00547098 c012ff33 d2bbc2c0 
d2bb03c0 d9a92980 40862000 00019000
Oct 13 15:03:21 torre kernel:        c01220b4 d9a92980 d1ef2000 0000000b 
00547144 d2bb0340 c0111e19 d9a92980
Oct 13 15:03:21 torre kernel:        d9a92980 c0115ecd d9a92980 00000000 
d9a9299c d46f51c0 c01073cf 0000000b
Oct 13 15:03:21 torre kernel: Call Trace: [fput+35/224] [exit_mmap+196/304] 
[mmput+57/96] [do_exit+157/512] [die+79/80]
Oct 13 15:03:21 torre kernel:    [do_page_fault+855/1184] 
[do_page_fault+0/1184] [check_journal_end+527/576] [error_code+52/60] 
[filemap_nopage+32/752] [do_no_page+82/208]
Oct 13 15:03:21 torre kernel:    [handle_mm_fault+91/192] 
[do_page_fault+355/1184] [do_page_fault+0/1184] [emu10k1_wavein_update+32/80] 
[emu10k1_wavein_bh+52/112] [schedule+604/912]
Oct 13 15:03:21 torre kernel:    [error_code+52/60]
Oct 13 15:03:21 torre kernel:
Oct 13 15:03:21 torre kernel: Code: 8b 90 a8 00 00 00 85 d2 74 2a 8d 98 a8 00 
00 00 89 d0 89 f6

Oct 13 15:03:21 torre kernel:  <6>NVRM: AGPGART: freed 16 pages
Oct 13 15:03:21 torre kernel: NVRM: AGPGART: backend released

Oct 13 15:03:21 torre kernel: Unable to handle kernel paging request at 
virtual
address 00547098
Oct 13 15:03:21 torre kernel:  printing eip:
Oct 13 15:03:21 torre kernel: c013fec0
Oct 13 15:03:21 torre kernel: *pde = 00000000
Oct 13 15:03:21 torre kernel: Oops: 0000
Oct 13 15:03:21 torre kernel: CPU:    0
Oct 13 15:03:21 torre kernel: EIP:    0010:[d_lookup+96/256]    Not tainted
Oct 13 15:03:21 torre kernel: EFLAGS: 00010207
Oct 13 15:03:21 torre kernel: eax: dff510e0   ebx: 00547088   ecx: 00000010   
edx: ab1965ee
Oct 13 15:03:21 torre kernel: esi: 00000000   edi: dc329e98   ebp: 00547098   
esp: dc329e14
Oct 13 15:03:21 torre kernel: ds: 0018   es: 0018   ss: 0018
Oct 13 15:03:21 torre kernel: Process kdeinit_shutdow (pid: 4873, 
stackpage=dc329000)
Oct 13 15:03:21 torre kernel: Stack: dc329e74 00000000 dc329e98 dbe31d80 
dff510e0 dc329f24 ab1965ee 00000015
Oct 13 15:03:21 torre kernel:        c0137b10 dbe9a9c0 dc329e74 dc329e74 
c0137f42 dbe9a9c0 dc329e74 00000004
Oct 13 15:03:21 torre kernel:        dc329e98 dc329f16 dc329e98 00000000 
37363534 00000009 dc329f3a 00000000
Oct 13 15:03:21 torre kernel: Call Trace: [cached_lookup+16/96] 
[link_path_walk+514/1888] [path_walk+26/32] [unix_find_other+59/256] 
[sock_wmalloc+38/96]
Oct 13 15:03:21 torre kernel:    [unix_stream_connect+219/864] 
[sys_connect+91/128] [sys_socket+48/96] [sys_socketcall+144/512] 
[error_code+52/60] [system_call+51/56]
Oct 13 15:03:21 torre kernel:
Oct 13 15:03:21 torre kernel: Code: 8b 6d 00 8b 54 24 18 39 53 44 75 7c 8b 44 
24 24 39 43 0c 75

Oct 13 15:03:21 torre kernel:  <1>Unable to handle kernel paging request at 
virtual address 00547098
Oct 13 15:03:21 torre kernel:  printing eip:
Oct 13 15:03:21 torre kernel: c013fec0
Oct 13 15:03:21 torre kernel: *pde = 00000000
Oct 13 15:03:21 torre kernel: Oops: 0000
Oct 13 15:03:21 torre kernel: CPU:    0
Oct 13 15:03:21 torre kernel: EIP:    0010:[d_lookup+96/256]    Not tainted
Oct 13 15:03:21 torre kernel: EFLAGS: 00010207
Oct 13 15:03:21 torre kernel: eax: dff1e110   ebx: 00547088   ecx: 00000010   
edx: fc2d1128
Oct 13 15:03:21 torre kernel: esi: 00000000   edi: c270de98   ebp: 00547098   
esp: c270de14
Oct 13 15:03:21 torre kernel: ds: 0018   es: 0018   ss: 0018
Oct 13 15:03:21 torre kernel: Process kdeinit (pid: 4648, stackpage=c270d000)
Oct 13 15:03:21 torre kernel: Stack: c270de74 00000000 c270de98 df835b80 
dff1e110 c270df1b fc2d1128 0000000a
Oct 13 15:03:21 torre kernel:        c0137b10 dfac9840 c270de74 c270de74 
c0137f42 dfac9840 c270de74 00000004
Oct 13 15:03:21 torre kernel:        c270de98 c270df16 c270de98 00000000 
37363534 00000009 c270df26 00000000
Oct 13 15:03:21 torre kernel: Call Trace: [cached_lookup+16/96] 
[link_path_walk+514/1888] [path_walk+26/32] [unix_find_other+59/256] 
[sock_wmalloc+38/96]
Oct 13 15:03:21 torre kernel:    [unix_stream_connect+219/864] 
[sys_connect+91/128] [do_munmap+553/576] [sys_socket+48/96] 
[sys_socketcall+144/512] [system_call+51/56]
Oct 13 15:03:21 torre kernel:
Oct 13 15:03:21 torre kernel: Code: 8b 6d 00 8b 54 24 18 39 53 44 75 7c 8b 44 
24 24 39 43 0c 75

Oct 13 15:03:22 torre kernel:  <1>Unable to handle kernel paging request at 
virtual address 00547098
Oct 13 15:03:22 torre kernel:  printing eip:
Oct 13 15:03:22 torre kernel: c013fec0
Oct 13 15:03:22 torre kernel: *pde = 00000000
Oct 13 15:03:22 torre kernel: Oops: 0000
Oct 13 15:03:22 torre kernel: CPU:    0
Oct 13 15:03:22 torre kernel: EIP:    0010:[d_lookup+96/256]    Not tainted
Oct 13 15:03:22 torre kernel: EFLAGS: 00010207
Oct 13 15:03:22 torre kernel: eax: dff1e110   ebx: 00547088   ecx: 00000010   
edx: fc2d1128
Oct 13 15:03:22 torre kernel: esi: 00000000   edi: d8e95e98   ebp: 00547098   
esp: d8e95e14
Oct 13 15:03:22 torre kernel: ds: 0018   es: 0018   ss: 0018
Oct 13 15:03:22 torre kernel: Process kdeinit (pid: 4647, stackpage=d8e95000)
Oct 13 15:03:22 torre kernel: Stack: d8e95e74 00000000 d8e95e98 df835b80 
dff1e110 d8e95f1b fc2d1128 0000000a
Oct 13 15:03:22 torre kernel:        c0137b10 dfac9840 d8e95e74 d8e95e74 
c0137f42 dfac9840 d8e95e74 00000004
Oct 13 15:03:22 torre kernel:        d8e95e98 d8e95f16 d8e95e98 00000000 
37363534 00000009 d8e95f26 00000000
Oct 13 15:03:22 torre kernel: Call Trace: [cached_lookup+16/96] 
[link_path_walk+514/1888] [path_walk+26/32] [unix_find_other+59/256] 
[sock_wmalloc+38/96]
Oct 13 15:03:22 torre kernel:    [unix_stream_connect+219/864] 
[sys_connect+91/128] [do_munmap+553/576] [sys_socket+48/96] 
[sys_socketcall+144/512] [system_call+51/56]
Oct 13 15:03:22 torre kernel:
Oct 13 15:03:22 torre kernel: Code: 8b 6d 00 8b 54 24 18 39 53 44 75 7c 8b 44 
24 24 39 43 0c 75

Oct 13 15:04:52 torre kernel:  <6>NVRM: AGPGART: unknown chipset
Oct 13 15:04:52 torre kernel: NVRM: AGPGART: aperture: 128M @ 0xd0000000
Oct 13 15:04:52 torre kernel: NVRM: AGPGART: aperture mapped from 0xd0000000 
to
0xe5b19000
Oct 13 15:04:52 torre kernel: NVRM: AGPGART: mode 4x
Oct 13 15:04:52 torre kernel: NVRM: AGPGART: allocated 16 pages

Oct 13 15:04:55 torre kernel: Unable to handle kernel paging request at 
virtual
address 00547098
Oct 13 15:04:55 torre kernel:  printing eip:
Oct 13 15:04:55 torre kernel: c013fec0
Oct 13 15:04:55 torre kernel: *pde = 00000000
Oct 13 15:04:55 torre kernel: Oops: 0000
Oct 13 15:04:55 torre kernel: CPU:    0
Oct 13 15:04:55 torre kernel: EIP:    0010:[d_lookup+96/256]    Not tainted
Oct 13 15:04:55 torre kernel: EFLAGS: 00010203
Oct 13 15:04:55 torre kernel: eax: dff2fef0   ebx: 00547088   ecx: 00000010   
edx: 135346f6
Oct 13 15:04:55 torre kernel: esi: 00000000   edi: ca635fa4   ebp: 00547098   
esp: ca635f14
Oct 13 15:04:55 torre kernel: ds: 0018   es: 0018   ss: 0018
Oct 13 15:04:55 torre kernel: Process startkde (pid: 4903, stackpage=ca635000)
Oct 13 15:04:55 torre kernel: Stack: ca635f74 00000000 ca635fa4 c1876880 
dff2fef0 d8084001 135346f6 00000005
Oct 13 15:04:55 torre kernel:        c0137b10 c180a440 ca635f74 ca635f74 
c0137f42 c180a440 ca635f74 00000004
Oct 13 15:04:55 torre kernel:        d8084000 00000000 ca635fa4 00000009 
c013790d 00000009 d8084007 00000000
Oct 13 15:04:55 torre kernel: Call Trace: [cached_lookup+16/96] 
[link_path_walk+514/1888] [getname+93/160] [path_walk+26/32] 
[__user_walk+53/80]
Oct 13 15:04:55 torre kernel:    [sys_stat64+25/112] [system_call+51/56]
Oct 13 15:04:55 torre kernel:
Oct 13 15:04:55 torre kernel: Code: 8b 6d 00 8b 54 24 18 39 53 44 75 7c 8b 44 
24 24 39 43 0c 75

Oct 13 15:04:55 torre kernel:  <6>NVRM: AGPGART: freed 16 pages
Oct 13 15:04:55 torre kernel: NVRM: AGPGART: backend released
Oct 13 15:05:22 torre kernel: NVRM: AGPGART: unknown chipset
Oct 13 15:05:22 torre kernel: NVRM: AGPGART: aperture: 128M @ 0xd0000000
Oct 13 15:05:22 torre kernel: NVRM: AGPGART: aperture mapped from 0xd0000000 
to
0xe5b1b000
Oct 13 15:05:22 torre kernel: NVRM: AGPGART: mode 4x
Oct 13 15:05:22 torre kernel: NVRM: AGPGART: allocated 16 pages

Oct 13 15:05:24 torre kernel: Unable to handle kernel paging request at 
virtual
address 00547098
Oct 13 15:05:24 torre kernel:  printing eip:
Oct 13 15:05:24 torre kernel: c013fec0
Oct 13 15:05:24 torre kernel: *pde = 00000000
Oct 13 15:05:24 torre kernel: Oops: 0000
Oct 13 15:05:24 torre kernel: CPU:    0
Oct 13 15:05:24 torre kernel: EIP:    0010:[d_lookup+96/256]    Not tainted
Oct 13 15:05:24 torre kernel: EFLAGS: 00010203
Oct 13 15:05:24 torre kernel: eax: dff2fef0   ebx: 00547088   ecx: 00000010   
edx: 135346f6
Oct 13 15:05:24 torre kernel: esi: 00000000   edi: c2aedfa4   ebp: 00547098   
esp: c2aedf14
Oct 13 15:05:24 torre kernel: ds: 0018   es: 0018   ss: 0018
Oct 13 15:05:24 torre kernel: Process startkde (pid: 4922, stackpage=c2aed000)
Oct 13 15:05:24 torre kernel: Stack: c2aedf74 00000000 c2aedfa4 c1876880 
dff2fef0 d43d9001 135346f6 00000005
Oct 13 15:05:24 torre kernel:        c0137b10 c180a440 c2aedf74 c2aedf74 
c0137f42 c180a440 c2aedf74 00000004
Oct 13 15:05:24 torre kernel:        d43d9000 00000000 c2aedfa4 00000009 
c013790d 00000009 d43d9007 00000000
Oct 13 15:05:24 torre kernel: Call Trace: [cached_lookup+16/96] 
[link_path_walk+514/1888] [getname+93/160] [path_walk+26/32] 
[__user_walk+53/80]
Oct 13 15:05:24 torre kernel:    [sys_stat64+25/112] [system_call+51/56]
Oct 13 15:05:24 torre kernel:
Oct 13 15:05:24 torre kernel: Code: 8b 6d 00 8b 54 24 18 39 53 44 75 7c 8b 44 
24 24 39 43 0c 75

Oct 13 15:05:24 torre kernel:  <6>NVRM: AGPGART: freed 16 pages
Oct 13 15:05:24 torre kernel: NVRM: AGPGART: backend released

Oct 13 15:05:38 torre kernel: Unable to handle kernel paging request at 
virtual
address 00547144
Oct 13 15:05:38 torre kernel:  printing eip:
Oct 13 15:05:38 torre kernel: c0123c00
Oct 13 15:05:38 torre kernel: *pde = 00000000
Oct 13 15:05:38 torre kernel: Oops: 0000
Oct 13 15:05:38 torre kernel: CPU:    0
Oct 13 15:05:38 torre kernel: EIP:    0010:[filemap_nopage+32/752]    Not 
tainted
Oct 13 15:05:38 torre kernel: EFLAGS: 00010296
Oct 13 15:05:38 torre kernel: eax: 00547098   ebx: c032ab6c   ecx: da839440   
edx: 00000000
Oct 13 15:05:38 torre kernel: esi: da839440   edi: 40450000   ebp: daff9740   
esp: da83dea4
Oct 13 15:05:38 torre kernel: ds: 0018   es: 0018   ss: 0018
Oct 13 15:05:38 torre kernel: Process kdeinit (pid: 338, stackpage=da83d000)
Oct 13 15:05:38 torre kernel: Stack: c032ab6c da839440 dec15c00 00000000 
00000000 c01ce3a3 00547098 c0120b82
Oct 13 15:05:38 torre kernel:        da839440 40450000 00000000 404509c8 
dec15c00 ffffffff 00000000 c0120c5b
Oct 13 15:05:38 torre kernel:        dec15c00 da839440 404509c8 00000000 
dc0f1140 dec15c00 00000000 da839440
Oct 13 15:05:38 torre kernel: Call Trace: [do_journal_end+179/2704] 
[do_no_page+82/208] [handle_mm_fault+91/192] [do_page_fault+355/1184] 
[do_page_fault+0/1184]
Oct 13 15:05:38 torre kernel:    [reiserfs_delete_inode+0/144] 
[destroy_inode+47/64] [iput+463/480] [d_delete+76/112] [sys_unlink+222/288] 
[error_code+52/60]
Oct 13 15:05:38 torre kernel:
Oct 13 15:05:38 torre kernel: Code: 8b 90 ac 00 00 00 89 54 24 14 8b 41 04 29 
c7 c1 ef 0c 03 79
Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 90 ac 00 00 00         mov    0xac(%eax),%edx
Code;  00000006 Before first symbol
   6:   89 54 24 14               mov    %edx,0x14(%esp,1)
Code;  0000000a Before first symbol
   a:   8b 41 04                  mov    0x4(%ecx),%eax
Code;  0000000c Before first symbol
   d:   29 c7                     sub    %eax,%edi
Code;  0000000e Before first symbol
   f:   c1 ef 0c                  shr    $0xc,%edi
Code;  00000012 Before first symbol
  12:   03 79 00                  add    0x0(%ecx),%edi

Oct 13 15:05:38 torre kernel:  <1>Unable to handle kernel paging request at 
virtual address 00547140
Oct 13 15:05:38 torre kernel:  printing eip:
Oct 13 15:05:38 torre kernel: c013f0dc
Oct 13 15:05:38 torre kernel: *pde = 00000000
Oct 13 15:05:38 torre kernel: Oops: 0000
Oct 13 15:05:38 torre kernel: CPU:    0
Oct 13 15:05:38 torre kernel: EIP:    0010:[locks_remove_flock+12/80]    Not 
tainted
Oct 13 15:05:38 torre kernel: EFLAGS: 00010202
Oct 13 15:05:38 torre kernel: eax: 00547098   ebx: daff9740   ecx: dec15c00   
edx: dec15c00
Oct 13 15:05:38 torre kernel: esi: daff9740   edi: c180f300   ebp: dbd3af40   
esp: da83dd54
Oct 13 15:05:38 torre kernel: ds: 0018   es: 0018   ss: 0018
Oct 13 15:05:38 torre kernel: Process kdeinit (pid: 338, stackpage=da83d000)
Oct 13 15:05:38 torre kernel: Stack: daff9740 00547098 c012ff33 daff9740 
da8394c0 dec15c00 40467000 00019000
Oct 13 15:05:38 torre kernel:        c01220b4 dec15c00 da83c000 0000000b 
00547144 da839540 c0111e19 dec15c00
Oct 13 15:05:38 torre kernel:        dec15c00 c0115ecd dec15c00 00000000 
dec15c1c da8419c0 c01073cf 0000000b
Oct 13 15:05:38 torre kernel: Call Trace: [fput+35/224] [exit_mmap+196/304] 
[mmput+57/96] [do_exit+157/512] [die+79/80]
Oct 13 15:05:38 torre kernel:    [do_page_fault+855/1184] 
[do_page_fault+0/1184] [error_code+52/60] [filemap_nopage+32/752] 
[do_journal_end+179/2704] [do_no_page+82/208]
Oct 13 15:05:38 torre kernel:    [handle_mm_fault+91/192] 
[do_page_fault+355/1184] [do_page_fault+0/1184] [reiserfs_delete_inode+0/144] 
[destroy_inode+47/64] [iput+463/480]
Oct 13 15:05:38 torre kernel:    [d_delete+76/112] [sys_unlink+222/288] 
[error_code+52/60]
Oct 13 15:05:38 torre kernel:
Oct 13 15:05:38 torre kernel: Code: 8b 90 a8 00 00 00 85 d2 74 2a 8d 98 a8 00 
00 00 89 d0 89 f6

Oct 13 15:05:57 torre kernel:  <6>NVRM: AGPGART: unknown chipset
Oct 13 15:05:57 torre kernel: NVRM: AGPGART: aperture: 128M @ 0xd0000000
Oct 13 15:05:57 torre kernel: NVRM: AGPGART: aperture mapped from 0xd0000000 
to
0xe5b1d000
Oct 13 15:05:57 torre kernel: NVRM: AGPGART: mode 4x
Oct 13 15:05:57 torre kernel: NVRM: AGPGART: allocated 16 pages

Oct 13 15:05:59 torre kernel: Unable to handle kernel paging request at 
virtual
address 00547098
Oct 13 15:05:59 torre kernel:  printing eip:
Oct 13 15:05:59 torre kernel: c013fec0
Oct 13 15:05:59 torre kernel: *pde = 00000000
Oct 13 15:05:59 torre kernel: Oops: 0000
Oct 13 15:05:59 torre kernel: CPU:    0
Oct 13 15:05:59 torre kernel: EIP:    0010:[d_lookup+96/256]    Not tainted
Oct 13 15:05:59 torre kernel: EFLAGS: 00010203
Oct 13 15:05:59 torre kernel: eax: dff2fef0   ebx: 00547088   ecx: 00000010   
edx: 135346f6
Oct 13 15:05:59 torre kernel: esi: 00000000   edi: d9ccffa4   ebp: 00547098   
esp: d9ccff14
Oct 13 15:05:59 torre kernel: ds: 0018   es: 0018   ss: 0018
Oct 13 15:05:59 torre kernel: Process startkde (pid: 4946, stackpage=d9ccf000)
Oct 13 15:05:59 torre kernel: Stack: d9ccff74 00000000 d9ccffa4 c1876880 
dff2fef0 cb159001 135346f6 00000005
Oct 13 15:05:59 torre kernel:        c0137b10 c180a440 d9ccff74 d9ccff74 
c0137f42 c180a440 d9ccff74 00000004
Oct 13 15:05:59 torre kernel:        cb159000 00000000 d9ccffa4 00000009 
c013790d 00000009 cb159007 00000000
Oct 13 15:05:59 torre kernel: Call Trace: [cached_lookup+16/96] 
[link_path_walk+514/1888] [getname+93/160] [path_walk+26/32] 
[__user_walk+53/80]
Oct 13 15:05:59 torre kernel:    [sys_stat64+25/112] [system_call+51/56]
Oct 13 15:05:59 torre kernel:
Oct 13 15:05:59 torre kernel: Code: 8b 6d 00 8b 54 24 18 39 53 44 75 7c 8b 44 
24 24 39 43 0c 75

Oct 13 15:05:59 torre kernel:  <6>NVRM: AGPGART: freed 16 pages
Oct 13 15:05:59 torre kernel: NVRM: AGPGART: backend released

Oct 13 15:06:36 torre kernel: Unable to handle kernel paging request at 
virtual
address 00547098
Oct 13 15:06:36 torre kernel:  printing eip:
Oct 13 15:06:36 torre kernel: c013fec0
Oct 13 15:06:36 torre kernel: *pde = 00000000
Oct 13 15:06:36 torre kernel: Oops: 0000
Oct 13 15:06:36 torre kernel: CPU:    0
Oct 13 15:06:36 torre kernel: EIP:    0010:[d_lookup+96/256]    Not tainted
Oct 13 15:06:36 torre kernel: EFLAGS: 00010207
Oct 13 15:06:36 torre kernel: eax: dff1e110   ebx: 00547088   ecx: 00000010   
edx: fc2d1128
Oct 13 15:06:36 torre kernel: esi: 00000000   edi: d9fa9fa4   ebp: 00547098   
esp: d9fa9f14
Oct 13 15:06:36 torre kernel: ds: 0018   es: 0018   ss: 0018
Oct 13 15:06:36 torre kernel: Process ls (pid: 4958, stackpage=d9fa9000)
Oct 13 15:06:36 torre kernel: Stack: d9fa9f74 00000000 d9fa9fa4 df835b80 
dff1e110 c3a28000 fc2d1128 0000000a
Oct 13 15:06:36 torre kernel:        c0137b10 dfac9840 d9fa9f74 d9fa9f74 
c0138248 dfac9840 d9fa9f74 00000000
Oct 13 15:06:36 torre kernel:        c3a28000 00000000 d9fa9fa4 00000008 
c013790d 00000008 c3a2800a 00000000
Oct 13 15:06:36 torre kernel: Call Trace: [cached_lookup+16/96] 
[link_path_walk+1288/1888] [getname+93/160] [path_walk+26/32] 
[__user_walk+53/80]
Oct 13 15:06:36 torre kernel:    [sys_lstat64+25/112] [system_call+51/56]
Oct 13 15:06:36 torre kernel:
Oct 13 15:06:36 torre kernel: Code: 8b 6d 00 8b 54 24 18 39 53 44 75 7c 8b 44 
24 24 39 43 0c 75

Oct 13 15:06:58 torre kernel:  <1>Unable to handle kernel paging request at 
virtual address 00547098
Oct 13 15:06:58 torre kernel:  printing eip:
Oct 13 15:06:58 torre kernel: c013fec0
Oct 13 15:06:58 torre kernel: *pde = 00000000
Oct 13 15:06:58 torre kernel: Oops: 0000
Oct 13 15:06:58 torre kernel: CPU:    0
Oct 13 15:06:58 torre kernel: EIP:    0010:[d_lookup+96/256]    Not tainted
Oct 13 15:06:58 torre kernel: EFLAGS: 00010207
Oct 13 15:06:58 torre kernel: eax: dff1e110   ebx: 00547088   ecx: 00000010   
edx: fc2d1128
Oct 13 15:06:58 torre kernel: esi: 00000000   edi: d9fa9fa4   ebp: 00547098   
esp: d9fa9f14
Oct 13 15:06:58 torre kernel: ds: 0018   es: 0018   ss: 0018
Oct 13 15:06:58 torre kernel: Process ls (pid: 4960, stackpage=d9fa9000)
Oct 13 15:06:58 torre kernel: Stack: d9fa9f74 00000000 d9fa9fa4 df835b80 
dff1e110 d168c000 fc2d1128 0000000a
Oct 13 15:06:58 torre kernel:        c0137b10 dfac9840 d9fa9f74 d9fa9f74 
c0138248 dfac9840 d9fa9f74 00000000
Oct 13 15:06:58 torre kernel:        d168c000 00000000 d9fa9fa4 00000008 
c013790d 00000008 d168c00a 00000000
Oct 13 15:06:58 torre kernel: Call Trace: [cached_lookup+16/96] 
[link_path_walk+1288/1888] [getname+93/160] [path_walk+26/32] 
[__user_walk+53/80]
Oct 13 15:06:58 torre kernel:    [sys_lstat64+25/112] [system_call+51/56]
Oct 13 15:06:58 torre kernel:
Oct 13 15:06:58 torre kernel: Code: 8b 6d 00 8b 54 24 18 39 53 44 75 7c 8b 44 
24 24 39 43 0c 75

Last oops repeated for "ls /tmp" 2 more times.

Started shutdown and got an oops unmounting which didn't get logged.


Thanks for reading so far!
