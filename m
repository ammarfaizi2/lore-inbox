Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264147AbUDRUkf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Apr 2004 16:40:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264150AbUDRUkf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Apr 2004 16:40:35 -0400
Received: from p508AC5E5.dip0.t-ipconnect.de ([80.138.197.229]:15232 "EHLO
	okolni.de") by vger.kernel.org with ESMTP id S264147AbUDRUkS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Apr 2004 16:40:18 -0400
Date: Sun, 18 Apr 2004 22:37:28 +0200
From: Michael Sauer <sauer@okolni.de>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: mount blocks / kernel oops / no rebooting possible
Message-ID: <20040418203728.GA840@vivane.okolni.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	Format=Flowed	DelSp=Yes
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 2.0.16
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.]
mounting a nfs volume results in a kernel oops / no rebooting possible  
anymore (hard reset...)

[2.]
i've mounted a partition on my server with nfs, the connection was  
'lost', i don't know, however i couldn't access the files anymore.  
after unmounting the volume, i tried to mount them again, mount blocks  
(no effect with kill -9). I found a kernel oops related to running  
mount. Rebooting was not possible anymore, i had to do a hard reset.
The fileserver has an uptime over 92 days, the bugged system an uptime  
over 9 days.

[3.]
networking, filesystems, nfs, mount, paging

[4.]
2.6.5

[5.]
<1>Unable to handle kernel paging request at virtual address 10ddc000
  printing eip:
 c016d432
 Oops: 0000 [#2]
 PREEMPT
 CPU:    0
 EIP:    0060:[<c016d432>]    Tainted: P
 EFLAGS: 00210203   (2.6.5)
 EIP is at invalidate_list+0x22/0xc0
 eax: f09a0200   ebx: 10ddc000   ecx: c0402c00   edx: 00000001
 esi: caf7f18c   edi: 10ddc000   ebp: c0402bf0   esp: f517ded8
 ds: 007b   es: 007b   ss: 0068
 Process umount (pid: 31431, threadinfo=f517c000 task=e173d9c0)
 Stack: 00200246 00000000 00000000 f09a0200 f517c000 c04063c0 f517df04  
c016d52a
        c0402bf0 f09a0200 f517df04 f517df04 f517df04 f09a024c f09a0200  
c04063c0
        c0406500 c015a5ad f09a0200 00000077 f517c000 0000000d f517c000  
c015b0c1
 Call Trace:
  [<c016d52a>] invalidate_inodes+0x5a/0xd0
  [<c015a5ad>] generic_shutdown_super+0x8d/0x1a0
  [<c015b0c1>] kill_anon_super+0x21/0x60
  [<c01e8339>] nfs_kill_super+0x19/0x30
  [<c015a3cc>] deactivate_super+0x7c/0xe0
  [<c017090f>] sys_umount+0x3f/0x90
  [<c0170977>] sys_oldumount+0x17/0x20
  [<c010741b>] syscall_call+0x7/0xb
 Code: 8b 3f 39 eb 74 7f 8d 73 f8 8b 44 24 24 39 86 80 00 00 00 75
  <6>note: umount[31431] exited with preempt_count 2
 in_atomic():1, irqs_disabled():0
 Call Trace:
  [<c011b34b>] __might_sleep+0xab/0xd0
  [<c011fa67>] do_exit+0xa7/0x440
  [<c0117c40>] do_page_fault+0x0/0x52f
  [<c0108519>] die+0xf9/0x100
  [<c0117e1e>] do_page_fault+0x1de/0x52f
  [<c011970a>] scheduler_tick+0x27a/0x510
  [<c0125bc6>] update_process_times+0x46/0x60
  [<c0125d0a>] run_timer_softirq+0x10a/0x1b0
  [<c012dc43>] rcu_process_callbacks+0x83/0x100
  [<c01218f6>] tasklet_action+0x46/0x70
  [<c0109a6d>] do_IRQ+0xfd/0x130
  [<c0117c40>] do_page_fault+0x0/0x52f
  [<c0107e45>] error_code+0x2d/0x38
  [<c016d432>] invalidate_list+0x22/0xc0
  [<c016d52a>] invalidate_inodes+0x5a/0xd0
  [<c015a5ad>] generic_shutdown_super+0x8d/0x1a0
  [<c015b0c1>] kill_anon_super+0x21/0x60
  [<c01e8339>] nfs_kill_super+0x19/0x30
  [<c015a3cc>] deactivate_super+0x7c/0xe0
  [<c017090f>] sys_umount+0x3f/0x90
  [<c0170977>] sys_oldumount+0x17/0x20
  [<c010741b>] syscall_call+0x7/0xb
 Call Trace:
  [<c0119f3a>] schedule+0x58a/0x590
  [<c0144463>] unmap_page_range+0x43/0x70
  [<c014464e>] unmap_vmas+0x1be/0x220
  [<c014869b>] exit_mmap+0x7b/0x190
  [<c011ba84>] mmput+0x64/0x90
  [<c011fac6>] do_exit+0x106/0x440
  [<c0117c40>] do_page_fault+0x0/0x52f
  [<c0108519>] die+0xf9/0x100
  [<c0117e1e>] do_page_fault+0x1de/0x52f
  [<c011970a>] scheduler_tick+0x27a/0x510
  [<c0125bc6>] update_process_times+0x46/0x60
  [<c0125d0a>] run_timer_softirq+0x10a/0x1b0
  [<c012dc43>] rcu_process_callbacks+0x83/0x100
  [<c01218f6>] tasklet_action+0x46/0x70
  [<c0109a6d>] do_IRQ+0xfd/0x130
  [<c0117c40>] do_page_fault+0x0/0x52f
  [<c0107e45>] error_code+0x2d/0x38
  [<c016d432>] invalidate_list+0x22/0xc0
  [<c016d52a>] invalidate_inodes+0x5a/0xd0
  [<c015a5ad>] generic_shutdown_super+0x8d/0x1a0
  [<c015b0c1>] kill_anon_super+0x21/0x60
  [<c01e8339>] nfs_kill_super+0x19/0x30
  [<c015a3cc>] deactivate_super+0x7c/0xe0
  [<c017090f>] sys_umount+0x3f/0x90
  [<c0170977>] sys_oldumount+0x17/0x20
  [<c010741b>] syscall_call+0x7/0xb

[6.]
umount NFSMOUNTPOINT && mount NFSMOUNTPOINT (sadly nondeterministic)

[7.]
[7.1]
Linux vivane 2.6.5 #2 Fri Apr 9 14:54:32 CEST 2004 i686 GNU/Linux

Gnu C                  3.3.3
Gnu make               3.80
binutils               2.14.90.0.7
util-linux             2.12
mount                  2.12
module-init-tools      3.0-pre10
e2fsprogs              1.35
nfs-utils              1.0.6
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.2.0
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.0.91
Modules Loaded         nvidia tuner tvaudio msp3400 bttv video_buf  
i2c_algo_bit v4l2_common btcx_risc i2c_core videodev analog gameport  
joydev hid ehci_hcd ohci_hcd uhci_hcd usbcore rtc

[7.2]
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 7
model name      : AMD Duron(tm)
stepping        : 1
cpu MHz         : 1303.413
cache size      : 64 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge  
mca cmov pat pse36 mmx fxsr sse syscall mp mmxext 3dnowext 3dnow
bogomips        : 2564.09

[7.3]
nvidia 2071336 12 - Live 0xf8c66000
tuner 17100 0 - Live 0xf89e8000
tvaudio 20428 0 - Live 0xf89e2000
msp3400 22164 0 - Live 0xf89ce000
bttv 142508 0 - Live 0xf89fd000
video_buf 17092 1 bttv, Live 0xf89d5000
i2c_algo_bit 8904 1 bttv, Live 0xf89ca000
v4l2_common 4928 1 bttv, Live 0xf89b9000
btcx_risc 3848 1 bttv, Live 0xf89bc000
i2c_core 19140 5 tuner,tvaudio,msp3400,bttv,i2c_algo_bit, Live  
0xf89c0000
videodev 7616 1 bttv, Live 0xf8990000
analog 10016 0 - Live 0xf8977000
gameport 3584 1 analog, Live 0xf897f000
joydev 8768 0 - Live 0xf897b000
hid 23296 0 - Live 0xf89b2000
ehci_hcd 24132 0 - Live 0xf89ab000
ohci_hcd 16900 0 - Live 0xf898a000
uhci_hcd 29904 0 - Live 0xf8981000
usbcore 93276 6 hid,ehci_hcd,ohci_hcd,uhci_hcd, Live 0xf8993000
rtc 10616 0 - Live 0xf88c7000

[7.4]
00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133]  
(rev 03)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-  
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 8
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=128M]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64-  
HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP+ GART64- 64bit-  
FW- Rate=x4
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-, 
D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133  
AGP] (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-  
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 00007000-00007fff
        Memory behind bridge: dde00000-dfefffff
        Prefetchable memory behind bridge: cdc00000-ddcfffff
        BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-, 
D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super  
South] (rev 22)
        Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-  
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/ 
VT8233/A/C/VT8235 PIPC Bus Master IDE (rev 10) (prog-if 8a [Master SecP  
PriP])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-  
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 4: I/O ports at ffa0 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-, 
D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.2 USB Controller: VIA Technologies, Inc. USB (rev 10) (prog-if 00  
[UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-  
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin D routed to IRQ 10
        Region 4: I/O ports at b800 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-, 
D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.3 USB Controller: VIA Technologies, Inc. USB (rev 10) (prog-if 00  
[UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-  
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin D routed to IRQ 10
        Region 4: I/O ports at bc00 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-, 
D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.4 SMBus: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev  
30)
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-  
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Capabilities: [68] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-, 
D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8029 
(AS)
        Subsystem: Realtek Semiconductor Co., Ltd. RTL-8029(AS)
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-  
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 9
        Region 0: I/O ports at c000 [size=32]

00:0d.0 Multimedia video controller: Brooktree Corporation Bt878 Video  
Capture (rev 02)
        Subsystem: Hauppauge computer works Inc. WinTV Series
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-  
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (4000ns min, 10000ns max)
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at dddfe000 (32-bit, prefetchable) [size=4K]

00:0d.1 Multimedia controller: Brooktree Corporation Bt878 Audio  
Capture (rev 02)
        Subsystem: Hauppauge computer works Inc. WinTV Series
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-  
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (1000ns min, 63750ns max)
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at dddff000 (32-bit, prefetchable) [size=4K]

00:0e.0 Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 02)
        Subsystem: Giga-byte Technology 5880 AudioPCI On Motherboard  
6OXET
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-  
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort-  
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (3000ns min, 32000ns max)
        Interrupt: pin A routed to IRQ 9
        Region 0: I/O ports at c400 [size=64]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA PME(D0-,D1-, 
D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0f.0 Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 02)
        Subsystem: Ensoniq Creative Sound Blaster AudioPCI128
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-  
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort-  
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 64 (3000ns min, 32000ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at c800 [size=64]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA PME(D0-,D1-, 
D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.0 Unknown mass storage controller: Promise Technology, Inc. 20265  
(rev 02)
        Subsystem: Promise Technology, Inc. Ultra100
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-  
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at dc00 [size=8]
        Region 1: I/O ports at d800 [size=4]
        Region 2: I/O ports at d400 [size=8]
        Region 3: I/O ports at d000 [size=4]
        Region 4: I/O ports at cc00 [size=64]
        Region 5: Memory at dffe0000 (32-bit, non-prefetchable)  
[size=128K]
        Expansion ROM at dffd0000 [disabled] [size=64K]
        Capabilities: [58] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-, 
D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: nVidia Corporation NV15 [GeForce2  
GTS/Pro] (rev a4) (prog-if 00 [VGA])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-  
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 248 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at de000000 (32-bit, non-prefetchable)  
[size=16M]
        Region 1: Memory at d0000000 (32-bit, prefetchable) [size=128M]
        Expansion ROM at dfef0000 [disabled] [size=64K]
        Capabilities: [60] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-, 
D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [44] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA- ITACoh- GART64-  
HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
                Command: RQ=32 ArqSz=0 Cal=0 SBA- AGP+ GART64- 64bit-  
FW- Rate=x4

[7.6]
Attached devices:

[7.7]
n/a

[X.]
n/a

thx in advance

--
  mIc

(please answer me if this bug is known / processed)
