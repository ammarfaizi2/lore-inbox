Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261176AbTKIXTc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 18:19:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261190AbTKIXTc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 18:19:32 -0500
Received: from cc19990-a.groni1.gr.home.nl ([217.122.216.16]:35079 "EHLO
	zolder.ath.cx") by vger.kernel.org with ESMTP id S261176AbTKIXTW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 18:19:22 -0500
Message-ID: <3FAECB79.8060108@goliath.darktech.org>
Date: Mon, 10 Nov 2003 00:19:21 +0100
From: "W.J." <miathan@goliath.darktech.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031013 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: "kernel BUG at drivers/scsi/ide-scsi.c:493!"
Content-Type: multipart/mixed;
 boundary="------------070702060404090609020204"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070702060404090609020204
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

Concerns: Kernel 2.6.0-test9
SCSI emulation driver crash/hang

I encountered this error while ripping an audio CD with CDParanoia, very 
soon after starting the rip.
The process now hangs.. it seems indefinitly.
Hardware always functioned fine with older kernels.

Spec:
- Kernel 2.6.0-test9
- CPUInfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 7
model name      : Pentium III (Katmai)
stepping        : 3
cpu MHz         : 551.372
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat pse36 mmx fxsr sse
bogomips        : 1089.53
- Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: Creative Model:  CD-ROM CD4832E  Rev: C1.3
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: HP       Model: CD-Writer+ 9100b Rev: 1.06
  Type:   CD-ROM                           ANSI SCSI revision: 02
- SCSI CD-ROM support is loaded as module
- SCSI emulation in kernel, and used for both drives

dmesg log:
----------------------------
Uniform CD-ROM driver Revision: 3.12
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
sr1: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray
Attached scsi CD-ROM sr1 at scsi1, channel 0, id 0, lun 0
hdd: lost interrupt
ide-scsi: abort called for 18039
ide-scsi: abort called for 18038
ide-scsi: reset called for 18039
hdd: DMA disabled
------------[ cut here ]------------
kernel BUG at drivers/scsi/ide-scsi.c:493!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<c025eedc>]    Tainted: P
EFLAGS: 00010286
EIP is at idescsi_transfer_pc+0x9c/0x130
eax: c0243460   ebx: c03f874c   ecx: e2164a31   edx: 00000172
esi: deef5660   edi: efcb5bc0   ebp: efc71e00   esp: efc71ddc
ds: 007b   es: 007b   ss: 0068
Process scsi_eh_1 (pid: 11, threadinfo=efc70000 task=efc73900)
Stack: 00000172 c03f874c 00000008 00000080 0000001e efcb5bc0 c03f874c 
ce872180
       00000000 efc71e2c c023f7b1 c03f874c deef5660 00000000 00000088 
0000001e
       0000000f ce872180 c03f874c c03f84f0 efc71e5c c023fae1 c03f874c 
ce872180
Call Trace:
 [<c023f7b1>] start_request+0x181/0x290
 [<c023fae1>] ide_do_request+0x1f1/0x370
 [<c022ae67>] __elv_add_request+0x27/0x40
 [<c02402fe>] ide_do_drive_cmd+0xce/0x140
 [<c025f7dc>] idescsi_queue+0x1ec/0x650
 [<c0258696>] scsi_send_eh_cmnd+0xa6/0x180
 [<c02585a0>] scsi_eh_done+0x0/0x50
 [<c0258570>] scsi_eh_times_out+0x0/0x30
 [<c0258a90>] scsi_eh_tur+0x90/0xd0
 [<c0258cf5>] scsi_eh_bus_device_reset+0x105/0x130
 [<c02593f8>] scsi_eh_ready_devs+0x28/0x80
 [<c0259590>] scsi_unjam_host+0xc0/0xd0
 [<c0259670>] scsi_error_handler+0xd0/0x110
 [<c02595a0>] scsi_error_handler+0x0/0x110
 [<c01082d9>] kernel_thread_helper+0x5/0xc
 
Code: 0f 0b ed 01 cf 09 32 c0 8b 56 38 a1 c0 9e 34 c0 89 d1 29 c1
 hdd: ATAPI reset complete
hdd: lost interrupt

Please ask if you need more info.

Wladimir


--------------070702060404090609020204
Content-Type: text/plain;
 name="ver_linux.out"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ver_linux.out"

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux mercury 2.6.0-test9 #1 Sat Nov 8 23:22:48 CET 2003 i686 unknown
 
Gnu C                  3.2.3
Gnu make               3.80
util-linux             2.12
mount                  2.12
module-init-tools      0.9.14
e2fsprogs              1.34
jfsutils               1.1.3
quota-tools            3.09.
PPP                    2.4.1
nfs-utils              1.0.6
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Linux C++ Library      5.0.3
Procps                 3.1.6
Net-tools              1.60
Kbd                    1.08
Sh-utils               2.0
Modules Loaded         sr_mod vfat fat snd_sbawe snd_opl3_lib snd_hwdep snd_sb16_dsp snd_sb_common snd_pcm snd_page_alloc snd_timer snd_mpu401_uart snd_rawmidi snd_seq_device snd ip_conntrack nvidia

--------------070702060404090609020204
Content-Type: text/plain;
 name="lspci.out"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lspci.out"

00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge (rev 02)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 64
	Region 0: Memory at e4000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 1.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP+ GART64- 64bit- FW- Rate=x2

00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 0000e000-0000dfff
	Memory behind bridge: e1000000-e2dfffff
	Prefetchable memory behind bridge: e2f00000-e3ffffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B+

00:04.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:04.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01) (prog-if 80 [Master])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at d800 [size=16]

00:04.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01) (prog-if 00 [UHCI])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin D routed to IRQ 9
	Region 4: I/O ports at d400 [size=32]

00:04.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 02)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 9

00:09.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
	Subsystem: Unex Technology Corp. ND010
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at d000 [size=256]
	Region 1: Memory at e0800000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 Unknown mass storage controller: Promise Technology, Inc. 20268 (rev 01) (prog-if 85)
	Subsystem: Promise Technology, Inc. Ultra100TX2
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (1000ns min, 4500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at b800 [size=8]
	Region 1: I/O ports at b400 [size=4]
	Region 2: I/O ports at b000 [size=8]
	Region 3: I/O ports at a800 [size=4]
	Region 4: I/O ports at a400 [size=16]
	Region 5: Memory at e0000000 (32-bit, non-prefetchable) [size=16K]
	Expansion ROM at <unassigned> [disabled] [size=16K]
	Capabilities: [60] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.0 USB Controller: VIA Technologies, Inc. USB (rev 50) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin A routed to IRQ 9
	Region 4: I/O ports at a000 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.1 USB Controller: VIA Technologies, Inc. USB (rev 50) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin B routed to IRQ 9
	Region 4: I/O ports at 9800 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.2 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 51) (prog-if 20 [EHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID): Unknown device 1234
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin C routed to IRQ 9
	Region 0: Memory at df800000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk+ DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0c.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
	Subsystem: Unex Technology Corp. ND010
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at 9400 [size=256]
	Region 1: Memory at df000000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: nVidia Corporation NV4 [RIVA TNT] (rev 04) (prog-if 00 [VGA])
	Subsystem: Diamond Multimedia Systems Viper V550
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 248 (1250ns min, 250ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at e1000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at e3000000 (32-bit, prefetchable) [size=16M]
	Expansion ROM at e2ff0000 [disabled] [size=64K]
	Capabilities: [60] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [44] AGP version 1.0
		Status: RQ=16 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2
		Command: RQ=16 ArqSz=0 Cal=0 SBA- AGP+ GART64- 64bit- FW- Rate=x2


--------------070702060404090609020204--

