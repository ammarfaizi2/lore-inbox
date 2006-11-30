Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031581AbWK3Wbr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031581AbWK3Wbr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 17:31:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031582AbWK3Wbr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 17:31:47 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:25184 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1031581AbWK3Wbq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 17:31:46 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=XY/GcVL2T+fBunFQ7IG6K1EM/10H0jNLjuz8Q7703PQ2AO+bc9qRu3Ri/ULzy27QcF6zGosbKUgZ9iff8DuzdYYd7Up3Nobs73REDBjtLGLrtJuHoJgN9FS1T3I/B6J8snKZ2K5jE1PiRb9gEHPzmgIQAx8OsMWAiB4raN3pH3k=
Message-ID: <6b4e42d10611301431g6f2541fak8dc353875f8d2147@mail.gmail.com>
Date: Thu, 30 Nov 2006 14:31:43 -0800
From: "Om Narasimhan" <om.turyx@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: pcie Hotplug problem.
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a machine with PCIe Hotplug capability. I am trying to run
2.6.19 and get hotplug working. It is (AMD64, Dual core, Dual
processor, CK804 south bridge). The card I am trying to hotplug is
based on Intel   82571EB Gigabit Ethernet Controller (rev 06) )

1. loading pcieph crashes the system. So I am assuming pcie native
hotplug is not currently supported by HW/BIOS

2. Loading acpiphp.ko gives these messages. But the cards are not
visible after insertion. The (green) light does not glow. lspci does
not list the inserted cards.

[  598.126985] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[  598.143390] acpiphp: Slot [6] registered
[  598.144163] acpiphp: Slot [5] registered

3. If the cards were present (i.e, cold plugging) when the system
boots up, lspci lists them. After modprobe-ing acpiphp.ko, pressing
the attention button on the card make the status light blink for 10
sec or so and stays green. Card does not power off. (even when the
corresponding ethX are down)

83:00.0 Ethernet controller: Intel Corporation 82571EB Gigabit
Ethernet Controller (rev 06)
        Subsystem: Sun Microsystems Computer Corp. Unknown device f25e
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-        Status: Cap+ 66MHz- UDF-
FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, Cache Line Size 10
        Interrupt: pin A routed to IRQ 43
        Region 0: Memory at fa9e0000 (32-bit, non-prefetchable) [size=128K]
        Region 1: Memory at fa9c0000 (32-bit, non-prefetchable) [size=128K]
        Region 2: I/O ports at ec00 [size=32]
        Expansion ROM at fa9a0000 [disabled] [size=128K]
        Capabilities: [c8] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=1 PME-
        Capabilities: [d0] Message Signalled Interrupts: 64bit+
Queue=0/0 Enable-
                Address: 0000000000000000  Data: 0000
        Capabilities: [e0] Express Endpoint IRQ 0
                Device: Supported: MaxPayload 256 bytes, PhantFunc 0, ExtTag-
                Device: Latency L0s <512ns, L1 <64us
                Device: AtnBtn- AtnInd- PwrInd-
                Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
                Device: RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
                Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
                Link: Supported Speed 2.5Gb/s, Width x4, ASPM L0s L1, Port 1
                Link: Latency L0s <4us, L1 <64us
                Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
                Link: Speed 2.5Gb/s, Width x4

83:00.1 Ethernet controller: Intel Corporation 82571EB Gigabit
Ethernet Controller (rev 06)
        Subsystem: Sun Microsystems Computer Corp. Unknown device f25e
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-        Status: Cap+ 66MHz- UDF-
FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, Cache Line Size 10
        Interrupt: pin B routed to IRQ 42
        Region 0: Memory at fa980000 (32-bit, non-prefetchable) [size=128K]
        Region 1: Memory at fa960000 (32-bit, non-prefetchable) [size=128K]
        Region 2: I/O ports at e800 [size=32]
        Expansion ROM at fa940000 [disabled] [size=128K]
        Capabilities: [c8] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=1 PME-
        Capabilities: [d0] Message Signalled Interrupts: 64bit+
Queue=0/0 Enable-
                Address: 0000000000000000  Data: 0000
        Capabilities: [e0] Express Endpoint IRQ 0
                Device: Supported: MaxPayload 256 bytes, PhantFunc 0, ExtTag-
                Device: Latency L0s <512ns, L1 <64us
                Device: AtnBtn- AtnInd- PwrInd-
                Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
                Device: RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
                Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
                Link: Supported Speed 2.5Gb/s, Width x4, ASPM L0s L1, Port 1
                Link: Latency L0s <4us, L1 <64us
                Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
                Link: Speed 2.5Gb/s, Width x4


Googling does give one relevant link :
http://www.mail-archive.com/linux-newbie@vger.kernel.org/msg06757.html
) But does not help much since even acpiphp.ko does not work.

Any pointers?
