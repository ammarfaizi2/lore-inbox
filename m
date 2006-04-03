Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964879AbWDCVBP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964879AbWDCVBP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 17:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751542AbWDCVBP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 17:01:15 -0400
Received: from mta09-winn.ispmail.ntl.com ([81.103.221.49]:9517 "EHLO
	mtaout03-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1751406AbWDCVBO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 17:01:14 -0400
Date: Mon, 3 Apr 2006 22:01:08 +0100 (BST)
From: Ken Moffat <zarniwhoop@ntlworld.com>
To: linux-kernel@vger.kernel.org
cc: alsa-devel@alsa-project.org
Subject: 2.6.17-rc1: Oops in sound applications
Message-ID: <Pine.LNX.4.63.0604032155220.17605@deepthought.mydomain>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463809536-208548422-1144098068=:17605"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463809536-208548422-1144098068=:17605
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT

1. One line summary:

 On x86, sound applications oops when I refresh the browser.

2. Full description:

 I'm seeing oopses from the sound applications (audacious, also a
realplayer binary) when I open firefox or refresh a tab.  At first,
I didn't realise it was the browser, so I spent some time just
playing sound without problems.  Then I happened to refresh the
current tab in firefox and it happened again.  After rebooting, it
is trivially easy to cause by starting to play a sound file and then
opening firefox or refreshing an open tab.

 Remaining data follows, config is attached.

Ken

3. Keywords: alsa snd_via82xxx

4. Kernel Version: 2.6.17-rc1

5. Most recent version without the bug: 2.6.16.1

6. Oops message:

 This is the latest, I rebooted after each previous oops.

Apr  3 21:14:26 ac30 kernel: BUG: unable to handle kernel NULL pointer dereference at virtual address 00000098
Apr  3 21:14:26 ac30 kernel:  printing eip:
Apr  3 21:14:26 ac30 kernel: c02c627c
Apr  3 21:14:26 ac30 kernel: *pde = 00000000
Apr  3 21:14:26 ac30 kernel: Oops: 0000 [#1]
Apr  3 21:14:26 ac30 kernel: Modules linked in: via_velocity crc_ccitt
Apr  3 21:14:26 ac30 kernel: CPU:    0
Apr  3 21:14:26 ac30 kernel: EIP:    0060:[<c02c627c>]    Not tainted VLI
Apr  3 21:14:26 ac30 kernel: EFLAGS: 00010046   (2.6.17-rc1 #1) 
Apr  3 21:14:26 ac30 kernel: EIP is at snd_pcm_oss_poll+0x4e/0x192
Apr  3 21:14:26 ac30 kernel: eax: f4ef1201   ebx: c1a92480   ecx: 000000a4   edx: c02c6200
Apr  3 21:14:26 ac30 kernel: esi: 00000000   edi: 00000000   ebp: 00000000   esp: f4e54b5c
Apr  3 21:14:26 ac30 kernel: ds: 007b   es: 007b   ss: 0068
Apr  3 21:14:26 ac30 kernel: Process audacious (pid: 3105, threadinfo=f4e54000 task=f4e9a030)
Apr  3 21:14:26 ac30 kernel: Stack: <0>f4ef12c0 00000000 ffff537e 00000000 00200200 00000000 f351e240 00000009 
Apr  3 21:14:26 ac30 kernel:        00000200 c0150883 f351e240 00000000 ffccddec 00000000 f4e54e58 f4e54e5c 
Apr  3 21:14:26 ac30 kernel:        f4e54e60 f4e54e50 f4e54e54 f4e54e58 00000000 00000200 00000000 00000200 
Apr  3 21:14:26 ac30 kernel: Call Trace:
Apr  3 21:14:26 ac30 kernel:  <c0150883> do_select+0x268/0x41e   <c0150564> __pollwait+0x0/0xb7
Apr  3 21:14:26 ac30 kernel:  <c01109a4> default_wake_function+0x0/0x15   <c010426e> do_IRQ+0x48/0x50
Apr  3 21:14:26 ac30 kernel:  <c0102b82> common_interrupt+0x1a/0x20   <c010a7e1> delay_pmtmr+0xd/0x15
Apr  3 21:14:26 ac30 kernel:  <c02d7d5f> snd_via82xx_codec_read+0xe1/0xf2   <c010426e> do_IRQ+0x48/0x50
Apr  3 21:14:26 ac30 kernel:  <c0102b82> common_interrupt+0x1a/0x20   <c02d7d88> snd_via82xx_codec_ready+0x18/0x53
Apr  3 21:14:26 ac30 kernel:  <c02bdbb6> snd_pcm_update_hw_ptr+0x14d/0x15b   <c02ba828> snd_pcm_common_ioctl1+0x7d8/0xc9d
Apr  3 21:14:26 ac30 kernel:  <c033c54c> __mutex_unlock_slowpath+0x10d/0x134   <c02bacb7> snd_pcm_common_ioctl1+0xc67/0xc9d
Apr  3 21:14:26 ac30 kernel:  <c0150c1c> core_sys_select+0x1e3/0x2ac   <c010426e> do_IRQ+0x48/0x50
Apr  3 21:14:26 ac30 kernel:  <c01d8503> copy_from_user+0x3c/0x6e   <c02bc069> snd_pcm_lib_write_transfer+0x5b/0x70
Apr  3 21:14:26 ac30 kernel:  <c02be241> snd_pcm_lib_write1+0x284/0x37d   <c02bb38f> snd_pcm_playback_ioctl1+0x33f/0x355
Apr  3 21:14:26 ac30 kernel:  <c01d8721> copy_to_user+0x3c/0x57   <c02c71eb> snd_pcm_oss_ioctl+0x8dc/0x995
Apr  3 21:14:26 ac30 kernel:  <c0150fd6> sys_select+0x9a/0x164   <c01500b9> sys_ioctl+0x2b/0x46
Apr  3 21:14:26 ac30 kernel:  <c010294f> sysenter_past_esp+0x54/0x75  
Apr  3 21:14:26 ac30 kernel: Code: db 0f 84 9e 00 00 00 8b 7b 5c 85 ed 0f 95 c2 89 f9 81 c1 a4 00 00 00 0f 95 c0 84 d0 74 0c 55 51 ff 74 24 30 ff 55 00 83 c4 0c fa <8b> 97 98 00 00 00 8b 02 83 f8 05 74 5a 8b 02 83 f8 03 75 5d 8b 

7. How to trigger: play sound, then open or refresh firefox.

8. Environment:

ken@ac30 ~ $cat ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux ac30 2.6.17-rc1 #1 Mon Apr 3 17:58:39 BST 2006 i686 athlon-4 i386 GNU/Linux

Gnu C                  4.0.3
Gnu make               3.80
binutils               2.16.1
util-linux             2.12r
mount                  2.12r
module-init-tools      3.2.2
e2fsprogs              1.38
reiserfsprogs          line
reiser4progs           line
Linux C Library        2.3.6
Dynamic linker (ldd)   2.3.6
Linux C++ Library      6.0.7
Procps                 3.2.6
Kbd                    1.12
Sh-utils               5.94
udev                   088
Modules Loaded         via_velocity crc_ccitt


ken@ac30 ~ $cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 39
model name      : AMD Athlon(tm) 64 Processor 4000+
stepping        : 1
cpu MHz         : 2451.950
cache size      : 1024 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 syscall nx mmxext fxsr_opt lm 3dnowext 3dnow up pni lahf_lm ts fid vid ttp tm stc
bogomips        : 4909.80

ken@ac30 ~ $cat /proc/modules
via_velocity 25632 - - Live 0xf98e7000
crc_ccitt 1592 - - Live 0xf8874000

ken@ac30 ~ $cat /proc/ioports
0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
0376-0376 : ide1
03c0-03df : vga+
03f8-03ff : serial
4000-407f : motherboard
  4000-4003 : PM1a_EVT_BLK
  4004-4005 : PM1a_CNT_BLK
  4008-400b : PM_TMR
  4020-4023 : GPE0_BLK
5000-500f : motherboard
a000-afff : PCI Bus #01
  a000-a0ff : 0000:01:00.0
b000-b07f : 0000:00:07.0
b400-b4ff : 0000:00:0e.0
  b400-b4ff : via-velocity
b800-b807 : 0000:00:0f.0
  b800-b807 : sata_via
bc00-bc03 : 0000:00:0f.0
  bc00-bc03 : sata_via
c000-c007 : 0000:00:0f.0
  c000-c007 : sata_via
c400-c403 : 0000:00:0f.0
  c400-c403 : sata_via
c800-c80f : 0000:00:0f.0
  c800-c80f : sata_via
cc00-ccff : 0000:00:0f.0
  cc00-ccff : sata_via
d000-d00f : 0000:00:0f.1
  d000-d007 : ide0
  d008-d00f : ide1
d400-d41f : 0000:00:10.0
  d400-d41f : uhci_hcd
d800-d81f : 0000:00:10.1
  d800-d81f : uhci_hcd
dc00-dc1f : 0000:00:10.2
  dc00-dc1f : uhci_hcd
e000-e01f : 0000:00:10.3
  e000-e01f : uhci_hcd
e400-e4ff : 0000:00:11.5
  e400-e4ff : VIA8237

ken@ac30 ~ $cat /proc/iomem
00000000-0009efff : System RAM
0009f000-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000cbfff : Video ROM
000f0000-000fffff : System ROM
00100000-3ffeffff : System RAM
  00100000-0033db90 : Kernel code
  0033db91-0041229f : Kernel data
3fff0000-3fff2fff : ACPI Non-volatile Storage
3fff3000-3fffffff : ACPI Tables
50000000-5001ffff : 0000:00:0e.0
e8000000-efffffff : 0000:00:00.0
  e8000000-efffffff : aperture
f0000000-f7ffffff : PCI Bus #01
  f0000000-f7ffffff : 0000:01:00.0
    f0000000-f7ffffff : radeonfb framebuffer
f8000000-f80fffff : PCI Bus #01
  f8000000-f801ffff : 0000:01:00.0
  f8020000-f802ffff : 0000:01:00.0
    f8020000-f802ffff : radeonfb mmio
f8120000-f81200ff : 0000:00:0e.0
  f8120000-f81200ff : via-velocity
f8121000-f81217ff : 0000:00:07.0
  f8121000-f81217ff : ohci1394
f8122000-f81220ff : 0000:00:10.4
  f8122000-f81220ff : ehci_hcd
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved

ken@ac30 ~ $cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: WDC WD740GD-00FL Rev: 33.0
  Type:   Direct-Access                    ANSI SCSI revision: 05


output from lspci:
00:00.0 Host bridge: VIA Technologies, Inc. K8T800Pro Host Bridge
        Subsystem: ABIT Computer Corp. Unknown device 1415
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR+
        Latency: 8
        Region 0: Memory at e8000000 (32-bit, prefetchable) [size=128M]
        Capabilities: [80] AGP version 3.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x1
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [60] HyperTransport: Slave or Primary Interface
                !!! Possibly incomplete decoding
                Command: BaseUnitID=0 UnitCnt=3 MastHost- DefDir-
                Link Control 0: CFlE- CST- CFE- <LkFail- Init+ EOC- TXO- <CRCErr=0
                Link Config 0: MLWI=16bit MLWO=16bit LWI=16bit LWO=16bit
                Link Control 1: CFlE- CST- CFE- <LkFail+ Init- EOC+ TXO+ <CRCErr=0
                Link Config 1: MLWI=8bit MLWO=8bit LWI=8bit LWO=8bit
                Revision ID: 1.02
        Capabilities: [58] HyperTransport: Interrupt Discovery and Configuration

00:00.1 Host bridge: VIA Technologies, Inc. K8T800Pro Host Bridge
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:00.2 Host bridge: VIA Technologies, Inc. K8T800Pro Host Bridge
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:00.3 Host bridge: VIA Technologies, Inc. K8T800Pro Host Bridge
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:00.4 Host bridge: VIA Technologies, Inc. K8T800Pro Host Bridge
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:00.7 Host bridge: VIA Technologies, Inc. K8T800Pro Host Bridge
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI bridge [K8T800/K8T890 South] (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000a000-0000afff
        Memory behind bridge: f8000000-f80fffff
        Prefetchable memory behind bridge: f0000000-f7ffffff
        Secondary status: 66MHz+ FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity- SERR+ NoISA+ VGA+ MAbort- >Reset- FastB2B-
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Controller (rev 46) (prog-if 10 [OHCI])
        Subsystem: ABIT Computer Corp. Unknown device 1415
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (8000ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at f8121000 (32-bit, non-prefetchable) [size=2K]
        Region 1: I/O ports at b000 [size=128]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0e.0 Ethernet controller: VIA Technologies, Inc. VT6120/VT6121/VT6122 Gigabit Ethernet Adapter (rev 11)
        Subsystem: ABIT Computer Corp. Unknown device 1415
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (750ns min, 2000ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at b400 [size=256]
        Region 1: Memory at f8120000 (32-bit, non-prefetchable) [size=256]
        [virtual] Expansion ROM at 50000000 [disabled] [size=128K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0f.0 RAID bus controller: VIA Technologies, Inc. VIA VT6420 SATA RAID Controller (rev 80)
        Subsystem: ABIT Computer Corp. Unknown device 1415
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin B routed to IRQ 11
        Region 0: I/O ports at b800 [size=8]
        Region 1: I/O ports at bc00 [size=4]
        Region 2: I/O ports at c000 [size=8]
        Region 3: I/O ports at c400 [size=4]
        Region 4: I/O ports at c800 [size=16]
        Region 5: I/O ports at cc00 [size=256]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0f.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
        Subsystem: ABIT Computer Corp. Unknown device 1415
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 11
        Region 4: I/O ports at d000 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81) (prog-if 00 [UHCI])
        Subsystem: ABIT Computer Corp. Unknown device 1415
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 11
        Region 4: I/O ports at d400 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81) (prog-if 00 [UHCI])
        Subsystem: ABIT Computer Corp. Unknown device 1415
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 11
        Region 4: I/O ports at d800 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81) (prog-if 00 [UHCI])
        Subsystem: ABIT Computer Corp. Unknown device 1415
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin B routed to IRQ 11
        Region 4: I/O ports at dc00 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81) (prog-if 00 [UHCI])
        Subsystem: ABIT Computer Corp. Unknown device 1415
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin B routed to IRQ 11
        Region 4: I/O ports at e000 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86) (prog-if 20 [EHCI])
        Subsystem: ABIT Computer Corp. Unknown device 1415
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, Cache Line Size 10
        Interrupt: pin C routed to IRQ 11
        Region 0: Memory at f8122000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.0 ISA bridge: VIA Technologies, Inc. VT8237 ISA bridge [KT600/K8T800/K8T890 South]
        Subsystem: ABIT Computer Corp. Unknown device 1415
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235/8237 AC97 Audio Controller (rev 60)
        Subsystem: ABIT Computer Corp. Unknown device 1415
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin C routed to IRQ 11
        Region 0: I/O ports at e400 [size=256]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Capabilities: [80] HyperTransport: Host or Secondary Interface
                !!! Possibly incomplete decoding
                Command: WarmRst+ DblEnd-
                Link Control: CFlE- CST- CFE- <LkFail- Init+ EOC- TXO- <CRCErr=0
                Link Config: MLWI=16bit MLWO=16bit LWI=16bit LWO=16bit
                Revision ID: 1.02

00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

01:00.0 VGA compatible controller: ATI Technologies Inc Radeon RV200 QW [Radeon 7500] (prog-if 00 [VGA])
        Subsystem: Hightech Information System Ltd. Unknown device 0207
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at f0000000 (32-bit, prefetchable) [size=128M]
        Region 1: I/O ports at a000 [size=256]
        Region 2: Memory at f8020000 (32-bit, non-prefetchable) [size=64K]
        [virtual] Expansion ROM at f8000000 [disabled] [size=128K]
        Capabilities: [58] AGP version 2.0
                Status: RQ=48 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
                Command: RQ=32 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x1
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-


-- 
das eine Mal als Tragödie, das andere Mal als Farce
---1463809536-208548422-1144098068=:17605
Content-Type: APPLICATION/octet-stream; name=config-2.6.17-rc1.bz2
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.63.0604032201080.17605@deepthought.mydomain>
Content-Description: 
Content-Disposition: attachment; filename=config-2.6.17-rc1.bz2

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
z/+LuSKcKEg55M2ngA==

---1463809536-208548422-1144098068=:17605--
