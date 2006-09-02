Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751516AbWIBUO5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751516AbWIBUO5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Sep 2006 16:14:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751513AbWIBUO4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Sep 2006 16:14:56 -0400
Received: from khc.piap.pl ([195.187.100.11]:40153 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1751511AbWIBUOz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Sep 2006 16:14:55 -0400
To: <linux-kernel@vger.kernel.org>
Cc: netdev@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jeff Garzik <jeff@garzik.org>
Subject: 2.6.18-rc5 + pata-drivers on MSI K9N Ultra report, AMD64
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Sat, 02 Sep 2006 22:14:51 +0200
Message-ID: <m3psee58lg.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Keywords: nForce PCIe, forcedeth, nForce PATA, Radeon DRM, ALC883 HDA sound

FYI: running 2.6.18-rc5 + pata-drivers on MSI mb K9N Ultra (NVidia
MCP55, PCIe, Athlon64, x86_64, no SMP, no preempt) gives the following
(all details available on request, of course):

"Nvidia board detected. Ignoring ACPI timer override."
I don't know if it should be ignored or not, anymore. It's probably ok.


PCI: Setting latency timer of device 0000:00:0b.0 to 64
pcie_portdrv_probe->Dev[0374:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:0b.0:pcie00]
PCI: Setting latency timer of device 0000:00:0c.0 to 64
pcie_portdrv_probe->Dev[0374:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:0c.0:pcie00]
PCI: Setting latency timer of device 0000:00:0d.0 to 64
pcie_portdrv_probe->Dev[0378:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:0d.0:pcie00]
PCI: Setting latency timer of device 0000:00:0e.0 to 64
pcie_portdrv_probe->Dev[0375:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:0e.0:pcie00]
PCI: Setting latency timer of device 0000:00:0f.0 to 64
pcie_portdrv_probe->Dev[0377:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:0f.0:pcie00]

The above seem to be some PCIe bridges.

ata1 and ata2 are SATA.

ata3: PATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0xFFA0 irq 14
ata4: PATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0xFFA8 irq 15

There is no secondary IDE connector on this motherboard, I think
it's just disabled by BIOS.

scsi3 : pata_amd
ata4: port is slow to respond, please be patient
ata4: port failed to respond (30 secs)
ata4: SRST failed (status 0xFF)
ata4: SRST failed (err_mask=0x100)
ata4: softreset failed, retrying in 5 secs
ata4: SRST failed (status 0xFF)
ata4: SRST failed (err_mask=0x100)
ata4: softreset failed, retrying in 5 secs
ata4: SRST failed (status 0xFF)
ata4: SRST failed (err_mask=0x100)
ata4: reset failed, giving up

While not a big problem, the above sequence takes 40 seconds while
booting.


hda_codec: Unknown model for ALC883, trying auto-probe from BIOS...
ALSA device list:
  #0: HDA NVidia at 0xfeaf4000 irq 233


eth0: forcedeth.c: subsystem: 01462:7250 bound to 0000:00:08.0
eth1: forcedeth.c: subsystem: 01462:7250 bound to 0000:00:09.0

BUG: warning at /usr/src/linux-2.6/kernel/lockdep.c:1803/trace_hardirqs_on()

Call Trace:
 <IRQ> [<ffffffff80298395>] trace_hardirqs_on+0xc5/0x150
 [<ffffffff8026522b>] _spin_unlock_irq+0x2b/0x40
 [<ffffffff8800186e>] :forcedeth:nv_nic_irq_tx+0x7e/0x130
 [<ffffffff8020fb6c>] handle_IRQ_event+0x2c/0x70
 [<ffffffff802a4154>] __do_IRQ+0xc4/0x140
 [<ffffffff8026aedd>] do_IRQ+0xfd/0x110
 [<ffffffff8025fdba>] ret_from_intr+0x0/0xf
 <EOI> [<ffffffff8026522b>] _spin_unlock_irq+0x2b/0x40
 [<ffffffff80265230>] _spin_unlock_irq+0x30/0x40
 [<ffffffff80234fc9>] do_setitimer+0x159/0x480
 [<ffffffff8026489f>] trace_hardirqs_on_thunk+0x35/0x37
 [<ffffffff80284955>] alarm_setitimer+0x35/0x60
 [<ffffffff802896c9>] sys_alarm+0x9/0x10
 [<ffffffff80261100>] cstar_do_call+0x1b/0x6f

[drm] Initialized radeon 1.25.0 20060524 on minor 0
[drm:radeon_do_init_cp] *ERROR* Cannot initialise DRM on this card
This card requires a new X.org DDX

Apparently IA32 emulation doesn't work for
radeon_cp_setparam(DRM_IOCTL_ARGS) -> RADEON_SETPARAM_NEW_MEMMAP
(32-bit kernel doesn't have this problem).


$ /sbin/lspci 
00:00.0 RAM memory: nVidia Corporation MCP55 Memory Controller (rev a1)
00:01.0 ISA bridge: nVidia Corporation MCP55 LPC Bridge (rev a2)
00:01.1 SMBus: nVidia Corporation MCP55 SMBus (rev a2)
00:01.2 RAM memory: nVidia Corporation MCP55 Memory Controller (rev a2)
00:04.0 IDE interface: nVidia Corporation MCP55 IDE (rev a1)
00:05.0 IDE interface: nVidia Corporation MCP55 SATA Controller (rev a2)
00:06.0 PCI bridge: nVidia Corporation Unknown device 0370 (rev a2)
00:06.1 Audio device: nVidia Corporation MCP55 High Definition Audio (rev a2)
00:08.0 Bridge: nVidia Corporation MCP55 Ethernet (rev a2)
00:09.0 Bridge: nVidia Corporation MCP55 Ethernet (rev a2)
00:0b.0 PCI bridge: nVidia Corporation Unknown device 0374 (rev a2)
00:0c.0 PCI bridge: nVidia Corporation Unknown device 0374 (rev a2)
00:0d.0 PCI bridge: nVidia Corporation Unknown device 0378 (rev a2)
00:0e.0 PCI bridge: nVidia Corporation Unknown device 0375 (rev a2)
00:0f.0 PCI bridge: nVidia Corporation Unknown device 0377 (rev a2)
00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration
00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller
00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
01:02.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 08)
01:02.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 08)
06:00.0 VGA compatible controller: ATI Technologies Inc R430 [Radeon X800 XL] (PCIe)
06:00.1 Display controller: ATI Technologies Inc R430 [Radeon X800 XL] (PCIe) Secondary



00:0b.0 PCI bridge: nVidia Corporation Unknown device 0374 (rev a2) (prog-if 00 [Normal decode])
        Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- Fast
B2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- 
<PERR-
        Latency: 0, Cache Line Size 10
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- 
<PERR-
        BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
        Capabilities: [40] #0d [0000]
        Capabilities: [48] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [50] Message Signalled Interrupts: 64bit+ Queue=0/1 Enable+
                Address: 00000000fee00000  Data: 40b9
        Capabilities: [60] HyperTransport: MSI Mapping
        Capabilities: [80] Express Root Port (Slot+) IRQ 0
                Device: Supported: MaxPayload 256 bytes, PhantFunc 0, ExtTag-
                Device: Latency L0s <512ns, L1 <4us
                Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
                Device: RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
                Device: MaxPayload 128 bytes, MaxReadReq 512 bytes
                Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s L1, Port 4
                Link: Latency L0s <512ns, L1 <4us
                Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
                Link: Speed 2.5Gb/s, Width x1
                Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug- Surpise-
                Slot: Number 0, PowerLimit 0.000000
                Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
                Slot: AttnInd Off, PwrInd On, Power-
                Root: Correctable- Non-Fatal- Fatal- PME-

-- 
Krzysztof Halasa

-- 
VGER BF report: U 0.5
