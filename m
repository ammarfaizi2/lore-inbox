Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263315AbTF0CKx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 22:10:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263319AbTF0CKw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 22:10:52 -0400
Received: from [65.118.82.9] ([65.118.82.9]:47315 "EHLO firesvr1.luminex.com")
	by vger.kernel.org with ESMTP id S263315AbTF0CKn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 22:10:43 -0400
Date: Thu, 26 Jun 2003 19:16:14 -0700 (PDT)
From: Ryan White <rwhite@luminex.com>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: Kernel Bug Report
Message-ID: <Pine.LNX.4.44.0306261850110.6190-100000@rwhite.luminex.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1.  Linux system hangs when being shared Helios directory is accessed my 
Macintosh client

2.  This is exactly what I am doing.  I have installed Helios Ethershare 
on my linux box.  I am using an iMac (MacOS 9.22) to access the shared 
directories.  This all works fine up until a certain point.

I put in an HFS disc into the local drive on my linux box.  I mount this 
as an HFS disc by doing: "mount -t hfs /dev/hdc /mount_pt_1"

I am then NFS mounting that directory to another directory on the same 
box.  "mount -t nfs localhost:/mount_pt_1 /mount_pt_2".  This works fine 
and can view the contents of the disc over the two mount points perfectly.

The /mount_pt_2 directory is the shared directory from 
Helios Ethershare and will be allowed readonly access by the iMac.  I go 
to the Chooser on the iMac and open up this directory and it just hangs.  
I go back over to the linux box and I can not access that directory 
anymore.  It is hung and have to quit out of my shell.  I can no longer 
umount any of my mounted directories.  I have to reboot.

3.  Keywords:  NFS, HFS, Helios, Ethershare

4.  I tried this on Kernel Version: 2.4.7-10 and also on 2.4.21.  The same 
thing happened on both of them.

5.  OOPS:
Jun 26 18:38:21 linux2 rebuild[1216]: starting rebuild in /root
Jun 26 18:38:21 linux2 rebuild[1216]: stat /root/.netscape/lock: No such 
file or directory
Jun 26 18:38:23 linux2 rebuild[1216]: rebuild done in /root
Jun 26 18:38:26 linux2 kernel: hfs_cat_put: trying to free free entry: 
c7d2b200
Jun 26 18:38:32 linux2 last message repeated 12 times
Jun 26 18:38:32 linux2 kernel: hfs_cat_put: trying to free free entry: 
c3f38200
Jun 26 18:38:32 linux2 kernel: hfs_cat_put: trying to free free entry: 
c3f38200
Jun 26 18:38:32 linux2 kernel: Unable to handle kernel NULL pointer 
dereference at virtual address 00000070
Jun 26 18:38:32 linux2 kernel:  printing eip:
Jun 26 18:38:32 linux2 kernel: c88a04c8
Jun 26 18:38:32 linux2 kernel: *pde = 00000000
Jun 26 18:38:32 linux2 kernel: Oops: 0000
Jun 26 18:38:32 linux2 kernel: CPU:    0
Jun 26 18:38:32 linux2 kernel: EIP:    0010:[<c88a04c8>]    Not tainted
Jun 26 18:38:32 linux2 kernel: EFLAGS: 00010202
Jun 26 18:38:32 linux2 kernel: eax: c61dbe70   ebx: c3f38200   ecx: 
00000000   edx: c88ab488
Jun 26 18:38:32 linux2 kernel: esi: c61dbe96   edi: c3f38256   ebp: 
00000000   esp: c61dbd34
Jun 26 18:38:32 linux2 kernel: ds: 0018   es: 0018   ss: 0018
Jun 26 18:38:32 linux2 kernel: Process nfsd (pid: 1209, 
stackpage=c61db000)
Jun 26 18:38:32 linux2 kernel: Stack: c61dbe70 00000011 00000000 c61dbe70 
00000000 c3db6260 c0346a80 000002e2
Jun 26 18:38:32 linux2 kernel:        00000000 c3f3820c c01cb1da 00000006 
c033f740 c03ba8a8 00002208 00002239
Jun 26 18:38:32 linux2 kernel:        000ca82e c02bc39a 00000018 c03b867f 
00000006 c0116eeb c033f740 c03ba8a8
Jun 26 18:38:32 linux2 kernel: Call Trace:    [vt_console_print+122/760] 
[vsnprintf+1146/1228] [__call_console_drivers+59/76] 
[_call_console_drivers+83/88] [release_console_sem+146/152]
Jun 26 18:38:32 linux2 kernel:   [<c88a034a>] [<c88a06a8>] [<c88a0bc1>] 
[<c88a2885>] [sys_select+1142/1448] [lookup_hash+157/224]
Jun 26 18:38:32 linux2 kernel:   [lookup_one_len+87/108] 
[nfsd_lookup+832/1192] [nfssvc_decode_diropargs+93/196] 
[nfsd_proc_lookup+141/160] [nfsd_dispatch+211/410] [svc_process+700/1374]
Jun 26 18:38:32 linux2 kernel:   [nfsd+433/872] [arch_kernel_thread+35/48]
Jun 26 18:38:32 linux2 kernel:
Jun 26 18:38:32 linux2 kernel: Code: 8b 6d 70 89 ee 89 6c 24 1c 56 8d 44 
24 34 89 c6 89 44 24 24
Jun 26 18:39:55 linux2 kernel:  <5>nfs: server localhost not responding, 
still trying
Jun 26 18:41:57 linux2 inetd[498]: auth/tcp: bind: Address already in use
Jun 26 18:42:23 linux2 PAM_pwdb[1221]: (login) session opened for user 
rjw-engr by (uid=0)
Jun 26 18:42:26 linux2 PAM_pwdb[1258]: (su) session opened for user root 
by rjw-engr(uid=4033)


6.  Do not have a shell script to reproduce environment.  

7.  ENVIRONMENT
   7.1  Didn't have access to the ver_linux script
   7.2  
[root@linux2 /root]# cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 2
model name      : AMD Athlon(tm) Processor
stepping        : 2
cpu MHz         : 698.668
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips        : 1392.64

   7.3
[root@linux2 /root]# cat /proc/modules
hfs                    76656   1 (autoclean)
appletalk              23376  11

   7.4
[root@linux2 /root]# cat /proc/ioports ; cat /proc/iomem
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
03f8-03ff : serial(auto)
0400-040f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
0cf8-0cff : PCI conf1
6000-607f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
8000-9fff : PCI Bus #01
  9800-98ff : ATI Technologies Inc 3D Rage Pro AGP 1X/2X
d000-d0ff : Adaptec AHA-2940U2/U2W
d400-d43f : Intel Corp. 82557/8/9 [Ethernet Pro 100]
  d400-d43f : eepro100
d800-d803 : Advanced Micro Devices [AMD] AMD-751 [Irongate] System 
Controller
dc00-dcff : Adaptec AIC-7892B U160/m
ffa0-ffaf : VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000d6000-000d7fff : Extension ROM
000f0000-000fffff : System ROM
00100000-07feffff : System RAM
  00100000-002bf7b3 : Kernel code
  002bf7b4-00378e1f : Kernel data
07ff0000-07ff7fff : ACPI Tables
07ff8000-07ffffff : ACPI Non-volatile Storage
dd800000-dd8fffff : PCI Bus #01
e0000000-e7ffffff : Advanced Micro Devices [AMD] AMD-751 [Irongate] System 
Controller
ed9ff000-ed9fffff : Advanced Micro Devices [AMD] AMD-751 [Irongate] System 
Controller
eda00000-efafffff : PCI Bus #01
  ee000000-eeffffff : ATI Technologies Inc 3D Rage Pro AGP 1X/2X
  efaff000-efafffff : ATI Technologies Inc 3D Rage Pro AGP 1X/2X
efe00000-efefffff : Intel Corp. 82557/8/9 [Ethernet Pro 100]
efffd000-efffdfff : Adaptec AHA-2940U2/U2W
  efffd000-efffdfff : aic7xxx
efffe000-efffefff : Intel Corp. 82557/8/9 [Ethernet Pro 100]
  efffe000-efffefff : eepro100
effff000-efffffff : Adaptec AIC-7892B U160/m
  effff000-efffffff : aic7xxx
ffff0000-ffffffff : reserved

   7.5
lspci -vvv
00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-751 [Irongate] 
System Controller (rev 25)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 64 set
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=128M]
        Region 1: Memory at ed9ff000 (32-bit, prefetchable) [size=4K]
        Region 2: I/O ports at d800 [disabled] [size=4]
        Capabilities: [a0] AGP version 1.0
                Status: RQ=15 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-751 [Irongate] AGP 
Bridge (rev 01) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 set
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 00008000-00009fff
        Memory behind bridge: eda00000-efafffff
        Prefetchable memory behind bridge: dd800000-dd8fffff
        BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-

00:03.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] 
(rev 08)
        Subsystem: Intel Corporation EtherExpress PRO/100+ Management 
Adapter
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 8 min, 56 max, 64 set, cache line size 08

        Interrupt: pin A routed to IRQ 9
        Region 0: Memory at efffe000 (32-bit, non-prefetchable) [size=4K]
        Region 1: I/O ports at d400 [size=64]
        Region 2: Memory at efe00000 (32-bit, non-prefetchable) [size=1M]
        Expansion ROM at efd00000 [disabled] [size=1M]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- AuxPwr- DSI+ D1+ D2+ PME+
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:04.0 SCSI storage controller: Adaptec 7892B (rev 02)
        Subsystem: Adaptec: Unknown device 62a1
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 40 min, 25 max, 64 set, cache line size 08
        Interrupt: pin A routed to IRQ 10
        BIST result: 00
        Region 0: I/O ports at dc00 [disabled] [size=256]
        Region 1: Memory at effff000 (64-bit, non-prefetchable) [size=4K]
        Expansion ROM at effc0000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- AuxPwr- DSI- D1- D2- PME-
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super] (rev 
1b)
        Subsystem: VIA Technologies, Inc.: Unknown device 0000
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 set

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 
06) (prog-if 8a [Master SecP PriP])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 set
        Region 4: I/O ports at ffa0 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- AuxPwr- DSI- D1- D2- PME-
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.4 SMBus: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 
20)
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-

00:09.0 SCSI storage controller: Adaptec AHA-2940U2/W
        Subsystem: Adaptec: Unknown device a180
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 39 min, 25 max, 64 set, cache line size 08
        Interrupt: pin A routed to IRQ 11
        BIST result: 00
        Region 0: I/O ports at d000 [disabled] [size=256]
        Region 1: Memory at efffd000 (64-bit, non-prefetchable) [size=4K]
        Expansion ROM at effa0000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- AuxPwr- DSI- D1- D2- PME-
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:05.0 VGA compatible controller: ATI Technologies Inc 3D Rage Pro AGP 
1X/2X (rev 5c) (prog-if 00 [VGA])
        Subsystem: ATI Technologies Inc: Unknown device 0084
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 8 min, 64 set, cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at ee000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: I/O ports at 9800 [size=256]
        Region 2: Memory at efaff000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at efac0000 [disabled] [size=128K]
        Capabilities: [50] AGP version 1.0
                Status: RQ=255 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

   7.6
[root@linux2 /root]# cat /proc/scsi/scsi
Attached devices: 
Host: scsi1 Channel: 00 Id: 02 Lun: 00
  Vendor: IBM      Model: DNES-309170      Rev: SA30
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi1 Channel: 00 Id: 03 Lun: 00
  Vendor: PLEXTOR  Model: CD-R   PX-W1210S Rev: 1.01
  Type:   CD-ROM                           ANSI SCSI revision: 02


  7.7  OTHER INFORMATION:  Kernel 2.4.21 was downloaded and compiled and 
installed.  I added now patches to it whatsoever.  This is a fairly simple 
problem to reproduce I feel.  The only difficulty will be getting Helios 
Ethershare software if you do not have it.  

We are using Ethershare Version 2.6, CD-17.

Please let me know if you need any other information.

-- 
Ryan White
Software Engineer

Luminex Software, Inc.
6840 Indiana Avenue, Suite 130
Riverside, CA 92506
909.781.4100 x159
rwhite@luminex.com

