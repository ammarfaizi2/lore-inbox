Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265445AbRFVPNb>; Fri, 22 Jun 2001 11:13:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265433AbRFVPNW>; Fri, 22 Jun 2001 11:13:22 -0400
Received: from mail.uni-kl.de ([131.246.137.52]:44931 "EHLO mail.uni-kl.de")
	by vger.kernel.org with ESMTP id <S265445AbRFVPNM>;
	Fri, 22 Jun 2001 11:13:12 -0400
Date: Fri, 22 Jun 2001 17:13:06 +0200
From: Christian Mudra <mudra@informatik.uni-kl.de>
To: linux-kernel@vger.kernel.org
Cc: Christian Mudra <mudra@informatik.uni-kl.de>
Subject: 2.4.5 kernel oops in inode.c:486
Message-ID: <20010622171306.A2887@thot.informatik.uni-kl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

the following kernel-oops message I've found in my syslogs.
As it's a production system, I'd very happy for a feedback/help. If you need
further information, please let me know.

As I'm not on the list, please cc: me.

Christian.

----------------------------------------------------------------------------
Christian Mudra              Just remember what your mother always told you:
mudra@informatik.uni-kl.de       "When you open windows you let in bugs".


======================= snip here ===========================

[1.] 2.4.5 kernel oops in inode.c:486

[2.] The bug itself happened on a NFS-client, running 2.4.5 while doing
some file access (copy, move).
The corresponding NFS-server is also running kernel 2.4.5, both machines
are using knfsd with NFS v3, and the nfs-volume is mounted static,
no automount.  The filesystem on the server is ext2fs.

[3.] knfsd, ext2, 2.4.5

[4.] Linux version 2.4.5 (root@thot) (gcc version 2.95.2 19991024 (release))
     #1 Sun Jun 17 13:59:52 MEST 2001

[5.]
Reading Oops report from the terminal
 kernel BUG at inode.c:486! 
 invalid operand: 0000 
 CPU:    0 
 EIP:    0010:[clear_inode+51/256] 
 EFLAGS: 00010286 
 eax: 0000001b   ebx: c42b9c80   ecx: c54b8000   edx: c46e8cc0 
 esi: c02647c0   edi: c54b9fa4   ebp: c54b9fa4   esp: c54b9eec 
 ds: 0018   es: 0018   ss: 0018 
 Process ls (pid: 32694, stackpage=c54b9000) 
 Stack: c0220fac c022100b 000001e6 c42b9c80 c01407d7 c42b9c80 c297e440 c42b9c80 
        c0163fed c42b9c80 c013e246 c297e440 c42b9c80 c297e440 00000000 c0136c68 
        c297e440 c54b9f68 c01373aa c7a0d740 c54b9f68 00000000 c30f8000 00000000 
 Call Trace: [iput+311/336] [nfs_dentry_iput+29/48] [dput+214/336] [cached_lookup+72/96] [path_walk+1338/1936] [getname+90/160] [__user_walk+60/96]  
        [sys_newlstat+22/112] [system_call+51/56]  
  
 Code: 0f 0b 83 c4 0c f6 83 f4 00 00 00 10 75 1f 68 e8 01 00 00 68  
 invalid operand: 0000 
 CPU:    0 
 EIP:    0010:[clear_inode+51/256] 
 EFLAGS: 00010286 
 eax: 0000001b   ebx: c42b9c80   ecx: c54b8000   edx: c46e8cc0 
 esi: c02647c0   edi: c54b9fa4   ebp: c54b9fa4   esp: c54b9eec 
 ds: 0018   es: 0018   ss: 0018 
 Process ls (pid: 32694, stackpage=c54b9000) 
 Stack: c0220fac c022100b 000001e6 c42b9c80 c01407d7 c42b9c80 c297e440 c42b9c80 
        c0163fed c42b9c80 c013e246 c297e440 c42b9c80 c297e440 00000000 c0136c68 
        c297e440 c54b9f68 c01373aa c7a0d740 c54b9f68 00000000 c30f8000 00000000 
 Call Trace: [iput+311/336] [nfs_dentry_iput+29/48] [dput+214/336] [cached_lookup+72/96] [path_walk+1338/1936] [getname+90/160] [__user_walk+60/96]  
 Code: 0f 0b 83 c4 0c f6 83 f4 00 00 00 10 75 1f 68 e8 01 00 00 68  
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a   
Code;  00000002 Before first symbol
   2:   83 c4 0c                  add    $0xc,%esp
Code;  00000005 Before first symbol
   5:   f6 83 f4 00 00 00 10      testb  $0x10,0xf4(%ebx)
Code;  0000000c Before first symbol
   c:   75 1f                     jne    2d <_EIP+0x2d> 0000002d Before first symbol
Code;  0000000e Before first symbol
   e:   68 e8 01 00 00            push   $0x1e8
Code;  00000013 Before first symbol
  13:   68 00 00 00 00            push   $0x0



[6.] n/a

[7.] Environment
[7.1.]
Linux cheperen 2.4.5 #4 Tue Jun 19 12:16:27 MEST 2001 i686 unknown
 
Gnu C                  2.95.2
Gnu make               3.78.1
binutils               2.9.5.0.24
util-linux             2.10f
mount                  2.11d
modutils               2.4.2
e2fsprogs              1.18
Linux C Library        x   1 root     root      4060896 Jan 17 16:37 /lib/libc.so.6
Dynamic linker (ldd)   2.1.3
Procps                 2.0.6
Net-tools              1.54
Kbd                    0.99
Sh-utils               2.0
Modules Loaded         snd-pcm-oss snd-pcm-plugin snd-mixer-oss snd-card-ens1371 snd-ens1371 snd-pcm snd-timer snd-rawmidi snd-seq-device snd-ac97-codec snd-mixer snd netlink_dev

[7.2.] Processor information (from /proc/cpuinfo):
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 2
model name      : AMD Athlon(tm) Processor
stepping        : 1
cpu MHz         : 656.480
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr 
syscall mmxext 3dnowext 3dnow
bogomips        : 1310.72

[7.3.] Module information (from /proc/modules):
snd-pcm-oss            18752   0 (autoclean)
snd-pcm-plugin         15888   0 (autoclean) [snd-pcm-oss]
snd-mixer-oss           5152   0 (autoclean) [snd-pcm-oss]
snd-card-ens1371        2208   0 (autoclean)
snd-ens1371            10032   0 (autoclean) [snd-card-ens1371]
snd-pcm                31264   0 (autoclean) [snd-pcm-oss snd-pcm-plugin snd-ens1371]
snd-timer               8576   0 (autoclean) [snd-pcm]
snd-rawmidi             9952   0 (autoclean) [snd-ens1371]
snd-seq-device          4080   0 (autoclean) [snd-rawmidi]
snd-ac97-codec         24928   0 (autoclean) [snd-ens1371]
snd-mixer              24304   0 (autoclean) [snd-mixer-oss snd-ens1371 snd-ac97-codec]
snd                    34656   1 (autoclean) [snd-pcm-oss snd-pcm-plugin snd-mixer-oss snd-car
d-ens1371 snd-ens1371 snd-pcm snd-timer snd-rawmidi snd-seq-device snd-ac97-codec snd-mixer]
netlink_dev             1984   1 (autoclean)

[7.4.] Loaded driver and hardware information
/proc/ioports:
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
02f8-02ff : serial(auto)
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
b000-cfff : PCI Bus #01
  c800-c8ff : ATI Technologies Inc Rage 128 RF
da00-da03 : Advanced Micro Devices [AMD] AMD-751 [Irongate] System Controller
dc00-dc3f : Ensoniq ES1371 [AudioPCI-97]
  dc00-dc3f : Ensoniq AudioPCI
de00-deff : Realtek Semiconductor Co., Ltd. RTL-8139
  de00-deff : 8139too
f000-f00f : Advanced Micro Devices [AMD] AMD-756 [Viper] IDE
  f000-f007 : ide0
  f008-f00f : ide1

/proc/iomem:
00000000-0009efff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-07ffffff : System RAM
  00100000-00216173 : Kernel code
  00216174-00277e17 : Kernel data
dfc00000-e7cfffff : PCI Bus #01
  e0000000-e3ffffff : ATI Technologies Inc Rage 128 RF
e8000000-ebffffff : Advanced Micro Devices [AMD] AMD-751 [Irongate] System Controller
efdff000-efdfffff : Advanced Micro Devices [AMD] AMD-751 [Irongate] System Controller
efe00000-efefffff : PCI Bus #01
  efefc000-efefffff : ATI Technologies Inc Rage 128 RF
effdf000-effdffff : Advanced Micro Devices [AMD] AMD-756 [Viper] USB
efffff00-efffffff : Realtek Semiconductor Co., Ltd. RTL-8139
  efffff00-efffffff : 8139too

[7.5.] PCI information ('lspci -vvv' as root)
00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-751 [Irongate] System Controller (rev 25)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 120 set
        Region 0: Memory at e8000000 (32-bit, prefetchable) [size=64M]
        Region 1: Memory at efdff000 (32-bit, prefetchable) [size=4K]
        Region 2: I/O ports at da00 [disabled] [size=4]
        Capabilities: [a0] AGP version 1.0
                Status: RQ=15 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP+ 64bit- FW- Rate=x1

00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-751 [Irongate] AGP Bridge (rev 01) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 120 set
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
        I/O behind bridge: 0000b000-0000cfff
        Memory behind bridge: efe00000-efefffff
        Prefetchable memory behind bridge: dfc00000-e7cfffff
        BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-

00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-756 [Viper] ISA (rev 01)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 set

00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-756 [Viper] IDE (rev 07) (prog-if 8a [Master SecP PriP])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 set
        Region 4: I/O ports at f000 [size=16]

00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-756 [Viper] ACPI (rev 03)
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:07.4 USB Controller: Advanced Micro Devices [AMD] AMD-756 [Viper] USB (rev 06) (prog-if 10 [OHCI])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 80 max, 16 set, cache line size 08
        Interrupt: pin D routed to IRQ 5
        Region 0: Memory at effdf000 (32-bit, non-prefetchable) [size=4K]

00:08.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev 08)
        Subsystem: Ensoniq: Unknown device 1371
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort+ <MAbort+ >SERR- <PERR-
        Latency: 12 min, 128 max, 64 set
        Interrupt: pin A routed to IRQ 9
        Region 0: I/O ports at dc00 [size=64]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- AuxPwr- DSI+ D1- D2+ PME-
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RT8139 (rev 10)
        Subsystem: Realtek Semiconductor Co., Ltd. RT8139
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 min, 64 max, 64 set
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at de00 [size=256]
        Region 1: Memory at efffff00 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- AuxPwr- DSI- D1+ D2+ PME-
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:05.0 VGA compatible controller: ATI Technologies Inc Rage 128 RF (prog-if 00 [VGA])
        Subsystem: ATI Technologies Inc: Unknown device 0008
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 8 min, 64 set, cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
        Region 1: I/O ports at c800 [size=256]
        Region 2: Memory at efefc000 (32-bit, non-prefetchable) [size=16K]
        Expansion ROM at efec0000 [disabled] [size=128K]
        Capabilities: [50] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA+ AGP- 64bit- FW- Rate=<none>
        Capabilities: [5c] Power Management version 1
                Flags: PMEClk- AuxPwr- DSI- D1+ D2- PME-
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-


[7.6.] SCSI information (from /proc/scsi/scsi)
n/a

[7.7.] Other information that might be relevant:
n/a

[X.] Other notes, patches, fixes, workarounds:
none.

