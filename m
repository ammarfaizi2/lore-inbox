Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964816AbWEBNna@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964816AbWEBNna (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 09:43:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964817AbWEBNn3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 09:43:29 -0400
Received: from durman.ibot.cas.cz ([147.231.110.3]:15245 "EHLO
	durman.ibot.cas.cz") by vger.kernel.org with ESMTP id S964816AbWEBNn2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 09:43:28 -0400
Message-ID: <3027.147.231.88.191.1146573961.squirrel@durman.ibot.cas.cz>
Date: Tue, 2 May 2006 14:46:01 +0200 (CEST)
Subject: Oops - Fedora 5 kernel 2.6.16-1.2096_FC5 x86_64
From: admin1@ibot.cas.cz
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.6-5.fc4
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

I have there kernel panic on Fedora core 5 with kernel 2.6.16-1.2096_FC5
on x86_64 hardware.
It is based on Intel Corporation E7230 chipset, CPU Intel(R) Pentium(R) D
CPU 2.80GHz, 2 GB RAM.

There is Adaptec AAR 2420SA with RAID 5.


Server runs fine without users about 14 days and about 2.5 day with normal
user load. And now it crashed again with same message after 6 hour.


There is nothing suspect in log files.


I got this screenshot (and the one after the second crash is absolutely
the same):

Badness in panic at kernel/panic.c:140 (Not tainted)

Call Trace: <IRQ> <ffffffff801321a0>{panic+488} {_spin_unlock_irq+12}
<ffffffff8033aefe>{__down_read+52}<ffffff8033b58e>{_spin_lock_irqsave+9)
<ffffffff8020168e>{__up_read+19} <ffffffff80135977>{do_exit+140}
<ffffffff8010c1ec>{kernel_math_error+0}<ffffffff8010c779>{do_invalid_op+163}
<ffffffff880440d8>{:aacraid:aac_intr_normal+411}<ffffffff8033b58e>{_spin_lock_irqsave+9}
<ffffffff88006e07>{:scsi_mod:scsi_run_queue+361}<ffffffff8010b6f9>{error_exit+0}
<ffffffff80339cbe>{thread_return+0}<ffffffff880440d8>{:aacraid:aac_intr_normal+411}
<ffffffff880304d3>{:sd_mod:sd_rw_intr+589}<ffffffff8804529b>{aacraid:aac_rktt_intr+55}
<ffffffff8015a30c>{handle_IRQ_event+414}<ffffffff8015a3d9>{__do_IRQ+156}
<ffffffff8010ce01>{do_IRQ+59}<ffffffff801098b2>{mwait_idle+0}
<ffffffff8010ad3e>{ret_from_intr+0}<EOI><ffffffff801098b2>{mwait_idle+0}
<ffffffff80339cbe>{thread_return+0}<ffffffff801098e8>{mwait_idle+54}
<ffffffff8010988f>{cpu_idle+151}<ffffffff8053a81b>{start_kernel+470}
<ffffffff8053a298>{_sinittext+664}


Has anybody seen this before? Is there a workaround or patch?
Is failing the AAR2420?
I flashed the RAID using latest firmware build nr. 9117 after the crash.


Thank you, David Kredba


lsmod :

Module                  Size  Used by
nls_utf8               35265  0
ncpfs                  88673  0
nfs                   251289  1
nfsd                  286249  17
exportfs               38977  1 nfsd
lockd                  96977  3 nfs,nfsd
nfs_acl                36801  2 nfs,nfsd
sunrpc                192137  13 nfs,nfsd,lockd,nfs_acl
autofs4                55241  1
hidp                   83137  2
l2cap                  91585  5 hidp
bluetooth             116933  2 hidp,l2cap
ipv6                  398689  127
ipx                    95497  0
p8023                  35265  1 ipx
dm_mirror              54593  0
dm_mod                 90385  1 dm_mirror
video                  50505  0
button                 40545  0
battery                43337  0
ac                     38473  0
lp                     47633  0
parport_pc             62697  0
parport                74061  2 lp,parport_pc
floppy                100617  0
nvram                  42441  0
sg                     69097  0
ehci_hcd               65229  0
uhci_hcd               65505  0
e1000                 141869  0
i2c_i801               42581  0
i2c_core               57409  1 i2c_i801
ext3                  164177  6
jbd                    93545  1 ext3
ata_piix               44357  0
libata                 93913  1 ata_piix
aacraid                92353  7
sd_mod                 50753  8
scsi_mod              181137  4 sg,libata,aacraid,sd_mod

lspci -vv :

00:00.0 Host bridge: Intel Corporation E7230 Memory Controller Hub
        Subsystem: Intel Corporation Unknown device 346a
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Capabilities: [e0] Vendor Specific Information

00:1c.0 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express
Port 1 (rev 01) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, Cache Line Size 10
        Bus: primary=00, secondary=01, subordinate=02, sec-latency=0
        Memory behind bridge: 88000000-882fffff
        Prefetchable memory behind bridge: 0000000088600000-0000000088600000
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-
        BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
        Capabilities: [40] Express Root Port (Slot+) IRQ 0
                Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
                Device: Latency L0s unlimited, L1 unlimited
                Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
                Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
                Link: Supported Speed 2.5Gb/s, Width x4, ASPM L0s L1, Port 1
                Link: Latency L0s <1us, L1 <4us
                Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
                Link: Speed 2.5Gb/s, Width x4
                Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug+ Surpise+
                Slot: Number 1, PowerLimit 25.000000
                Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
                Slot: AttnInd Unknown, PwrInd Unknown, Power-
                Root: Correctable- Non-Fatal- Fatal- PME-
        Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0
Enable-
                Address: 00000000  Data: 0000
        Capabilities: [90] #0d [0000]
        Capabilities: [a0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [100] Virtual Channel
        Capabilities: [180] Unknown (5)

00:1c.4 PCI bridge: Intel Corporation 82801GR/GH/GHM (ICH7 Family) PCI
Express Port 5 (rev 01) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, Cache Line Size 10
        Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-
        BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
        Capabilities: [40] Express Root Port (Slot+) IRQ 0
                Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
                Device: Latency L0s unlimited, L1 unlimited
                Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
                Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
                Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s L1, Port 5
                Link: Latency L0s <1us, L1 <4us
                Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
                Link: Speed 2.5Gb/s, Width x1
                Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug+ Surpise+
                Slot: Number 5, PowerLimit 10.000000
                Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
                Slot: AttnInd Unknown, PwrInd Unknown, Power-
                Root: Correctable- Non-Fatal- Fatal- PME-
        Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0
Enable-
                Address: 00000000  Data: 0000
        Capabilities: [90] #0d [0000]
        Capabilities: [a0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [100] Virtual Channel
        Capabilities: [180] Unknown (5)

00:1c.5 PCI bridge: Intel Corporation 82801GR/GH/GHM (ICH7 Family) PCI
Express Port 6 (rev 01) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, Cache Line Size 10
        Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
        I/O behind bridge: 00002000-00002fff
        Memory behind bridge: 88400000-884fffff
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
        Capabilities: [40] Express Root Port (Slot+) IRQ 0
                Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
                Device: Latency L0s unlimited, L1 unlimited
                Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
                Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
                Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s L1, Port 6
                Link: Latency L0s <256ns, L1 <4us
                Link: ASPM Disabled RCB 64 bytes CommClk+ ExtSynch-
                Link: Speed 2.5Gb/s, Width x1
                Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug+ Surpise+
                Slot: Number 6, PowerLimit 10.000000
                Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
                Slot: AttnInd Unknown, PwrInd Unknown, Power-
                Root: Correctable- Non-Fatal- Fatal- PME-
        Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0
Enable-
                Address: 00000000  Data: 0000
        Capabilities: [90] #0d [0000]
        Capabilities: [a0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [100] Virtual Channel
        Capabilities: [180] Unknown (5)

00:1d.0 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #1
(rev 01) (prog-if 00 [UHCI])
        Subsystem: Intel Corporation Unknown device 346a
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 21
        Region 4: I/O ports at 3080 [size=32]

00:1d.1 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #2
(rev 01) (prog-if 00 [UHCI])
        Subsystem: Intel Corporation Unknown device 346a
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 18
        Region 4: I/O ports at 3060 [size=32]

00:1d.2 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #3
(rev 01) (prog-if 00 [UHCI])
        Subsystem: Intel Corporation Unknown device 346a
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin C routed to IRQ 19
        Region 4: I/O ports at 3040 [size=32]

00:1d.3 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #4
(rev 01) (prog-if 00 [UHCI])
        Subsystem: Intel Corporation Unknown device 346a
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin D routed to IRQ 17
        Region 4: I/O ports at 3020 [size=32]

00:1d.7 USB Controller: Intel Corporation 82801G (ICH7 Family) USB2 EHCI
Controller (rev 01) (prog-if 20 [EHCI])
        Subsystem: Intel Corporation Unknown device 346a
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 21
        Region 0: Memory at 88500400 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [58] Debug port

00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev e1) (prog-if
01 [Subtractive decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=05, subordinate=05, sec-latency=32
        I/O behind bridge: 00001000-00001fff
        Memory behind bridge: 88300000-883fffff
        Prefetchable memory behind bridge: 0000000080000000-0000000087f00000
        Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-
        BridgeCtl: Parity+ SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-
        Capabilities: [50] #0d [0000]

00:1f.0 ISA bridge: Intel Corporation 82801GB/GR (ICH7 Family) LPC
Interface Bridge (rev 01)
        Subsystem: Intel Corporation Unknown device 346a
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [e0] Vendor Specific Information

00:1f.1 IDE interface: Intel Corporation 82801G (ICH7 Family) IDE
Controller (rev 01) (prog-if 8a [Master SecP PriP])
        Subsystem: Intel Corporation Unknown device 346a
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 19
        Region 0: I/O ports at <unassigned>
        Region 1: I/O ports at <unassigned>
        Region 2: I/O ports at <unassigned>
        Region 3: I/O ports at <unassigned>
        Region 4: I/O ports at 30b0 [size=16]

00:1f.2 IDE interface: Intel Corporation 82801GB/GR/GH (ICH7 Family)
Serial ATA Storage Controllers cc=IDE (rev 01) (prog-if 8f [Master SecP
SecO PriP PriO])
        Subsystem: Intel Corporation Unknown device 346a
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr+ Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 18
        Region 0: I/O ports at 30c8 [size=8]
        Region 1: I/O ports at 30e4 [size=4]
        Region 2: I/O ports at 30c0 [size=8]
        Region 3: I/O ports at 30e0 [size=4]
        Region 4: I/O ports at 30a0 [size=16]
        Region 5: Memory at 88500000 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [70] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1f.3 SMBus: Intel Corporation 82801G (ICH7 Family) SMBus Controller
(rev 01)
        Subsystem: Intel Corporation Unknown device 346a
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 10
        Region 4: I/O ports at 3000 [size=32]

01:00.0 PCI bridge: Intel Corporation 6702PXH PCI Express-to-PCI Bridge A
(rev 09) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, Cache Line Size 10
        Bus: primary=01, secondary=02, subordinate=02, sec-latency=64
        Memory behind bridge: 88000000-882fffff
        Prefetchable memory behind bridge: 0000000088600000-0000000088600000
        Secondary status: 66MHz+ FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-
        BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
        Capabilities: [44] Express PCI/PCI-X Bridge IRQ 0
                Device: Supported: MaxPayload 256 bytes, PhantFunc 0, ExtTag-
                Device: Latency L0s <64ns, L1 <1us
                Device: AtnBtn- AtnInd- PwrInd-
                Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
                Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                Device: MaxPayload 512 bytes, MaxReadReq 512 bytes
                Link: Supported Speed 2.5Gb/s, Width x8, ASPM L0s, Port 0
                Link: Latency L0s unlimited, L1 unlimited
                Link: ASPM Disabled CommClk- ExtSynch-
                Link: Speed 2.5Gb/s, Width x8
        Capabilities: [5c] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable-
                Address: 0000000000000000  Data: 0000
        Capabilities: [6c] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [d8] PCI-X bridge device
                Secondary Status: 64bit+ 133MHz+ SCD- USC- SCO- SRD-
Freq=133MHz
                Status: Dev=01:00.0 64bit- 133MHz- SCD- USC- SCO- SRD-
                Upstream: Capacity=65535 CommitmentLimit=65535
                Downstream: Capacity=65535 CommitmentLimit=65535
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [300] Power Budgeting

02:02.0 RAID bus controller: Adaptec AAC-RAID (Rocket) (rev 02)
        Subsystem: Adaptec ASR-2420SA
        Control: I/O- Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop-
ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (250ns min, 250ns max), Cache Line Size 10
        Interrupt: pin A routed to IRQ 20
        Region 0: Memory at 88000000 (64-bit, non-prefetchable) [size=2M]
        Region 2: Memory at 88200000 (64-bit, non-prefetchable) [size=4K]
        Expansion ROM at 88600000 [disabled] [size=32K]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [48] Message Signalled Interrupts: 64bit+ Queue=0/2
Enable-
                Address: 0000000000000000  Data: 0000
        Capabilities: [58] PCI-X non-bridge device
                Command: DPERE- ERO- RBC=512 OST=16
                Status: Dev=02:02.0 64bit+ 133MHz+ SCD- USC- DC=simple
DMMRBC=4096 DMOST=2 DMCRS=128 RSCEM- 266MHz- 533MHz-
        Capabilities: [60] Vital Product Data

04:00.0 Ethernet controller: Intel Corporation 82573E Gigabit Ethernet
Controller (Copper) (rev 03)
        Subsystem: Intel Corporation Unknown device 30a2
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, Cache Line Size 10
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at 88480000 (32-bit, non-prefetchable) [size=128K]
        Region 1: Memory at 88400000 (32-bit, non-prefetchable) [size=512K]
        Region 2: I/O ports at 2000 [size=32]
        Capabilities: [c8] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=1 PME-
        Capabilities: [d0] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable-
                Address: 0000000000000000  Data: 0000
        Capabilities: [e0] Express Endpoint IRQ 0
                Device: Supported: MaxPayload 256 bytes, PhantFunc 0, ExtTag-
                Device: Latency L0s <512ns, L1 <64us
                Device: AtnBtn- AtnInd- PwrInd-
                Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
                Device: RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
                Device: MaxPayload 128 bytes, MaxReadReq 512 bytes
                Link: Supported Speed 2.5Gb/s, Width x1, ASPM unknown, Port 0
                Link: Latency L0s <128ns, L1 <64us
                Link: ASPM Disabled RCB 64 bytes CommClk+ ExtSynch-
                Link: Speed 2.5Gb/s, Width x1
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [140] Device Serial Number 63-3b-d6-ff-ff-20-13-00

04:00.2 IDE interface: Intel Corporation Unknown device 108d (rev 03)
(prog-if 85 [Master SecO PriO])
        Subsystem: Intel Corporation Unknown device 0000
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, Cache Line Size 10
        Interrupt: pin B routed to IRQ 11
        Region 0: I/O ports at 2040 [size=8]
        Region 1: I/O ports at 2050 [size=4]
        Region 2: I/O ports at 2038 [size=8]
        Region 3: I/O ports at 204c [size=4]
        Region 4: I/O ports at 2020 [size=16]
        Capabilities: [c8] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-
        Capabilities: [d0] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable-
                Address: 0000000000000000  Data: 0000
        Capabilities: [e0] Express Legacy Endpoint IRQ 0
                Device: Supported: MaxPayload 256 bytes, PhantFunc 0, ExtTag-
                Device: Latency L0s <512ns, L1 <64us
                Device: AtnBtn- AtnInd- PwrInd-
                Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
                Device: RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
                Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
                Link: Supported Speed 2.5Gb/s, Width x1, ASPM unknown, Port 0
                Link: Latency L0s <128ns, L1 <64us
                Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
                Link: Speed 2.5Gb/s, Width x1
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [140] Device Serial Number 63-3b-d6-ff-ff-20-13-00

04:00.3 Serial controller: Intel Corporation Unknown device 108f (rev 03)
(prog-if 02 [16550])
        Subsystem: Intel Corporation Unknown device 0000
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, Cache Line Size 10
        Interrupt: pin C routed to IRQ 18
        Region 0: I/O ports at 2030 [size=8]
        Region 1: Memory at 884a1000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [c8] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-
        Capabilities: [d0] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable-
                Address: 0000000000000000  Data: 0000
        Capabilities: [e0] Express Endpoint IRQ 0
                Device: Supported: MaxPayload 256 bytes, PhantFunc 0, ExtTag-
                Device: Latency L0s <512ns, L1 <64us
                Device: AtnBtn- AtnInd- PwrInd-
                Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
                Device: RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
                Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
                Link: Supported Speed 2.5Gb/s, Width x1, ASPM unknown, Port 0
                Link: Latency L0s <128ns, L1 <64us
                Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
                Link: Speed 2.5Gb/s, Width x1
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [140] Device Serial Number 63-3b-d6-ff-ff-20-13-00

04:00.4 Class 0c07: Intel Corporation Unknown device 108e (rev 03)
(prog-if 01)
        Subsystem: Intel Corporation Unknown device 0000
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, Cache Line Size 10
        Interrupt: pin D routed to IRQ 11
        Region 0: Memory at 884a0000 (32-bit, non-prefetchable) [size=4K]
        Region 1: I/O ports at 2048 [size=4]
        Capabilities: [c8] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-
        Capabilities: [d0] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable-
                Address: 0000000000000000  Data: 0000
        Capabilities: [e0] Express Endpoint IRQ 0
                Device: Supported: MaxPayload 256 bytes, PhantFunc 0, ExtTag-
                Device: Latency L0s <512ns, L1 <64us
                Device: AtnBtn- AtnInd- PwrInd-
                Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
                Device: RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
                Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
                Link: Supported Speed 2.5Gb/s, Width x1, ASPM unknown, Port 0
                Link: Latency L0s <128ns, L1 <64us
                Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
                Link: Speed 2.5Gb/s, Width x1
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [140] Device Serial Number 63-3b-d6-ff-ff-20-13-00

05:04.0 VGA compatible controller: ATI Technologies Inc ES1000 (rev 02)
(prog-if 00 [VGA])
        Subsystem: Intel Corporation Unknown device 515e
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping+ SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min), Cache Line Size 10
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at 80000000 (32-bit, prefetchable) [size=128M]
        Region 1: I/O ports at 1000 [size=256]
        Region 2: Memory at 88340000 (32-bit, non-prefetchable) [size=64K]
        Expansion ROM at fffe0000 [disabled] [size=128K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

05:05.0 Ethernet controller: Intel Corporation 82541GI/PI Gigabit Ethernet
Controller (rev 05)
        Subsystem: Intel Corporation Unknown device 30a1
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (63750ns min), Cache Line Size 10
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at 88320000 (32-bit, non-prefetchable) [size=128K]
        Region 1: Memory at 88300000 (32-bit, non-prefetchable) [size=128K]
        Region 2: I/O ports at 1100 [size=64]
        Expansion ROM at 88360000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=1 PME-
        Capabilities: [e4] PCI-X non-bridge device
                Command: DPERE- ERO+ RBC=512 OST=1
                Status: Dev=00:00.0 64bit- 133MHz- SCD- USC- DC=simple
DMMRBC=2048 DMOST=1 DMCRS=8 RSCEM- 266MHz- 533MHz-

