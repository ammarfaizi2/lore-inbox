Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751006AbVHQJCY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751006AbVHQJCY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 05:02:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751007AbVHQJCY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 05:02:24 -0400
Received: from smtp2.brturbo.com.br ([200.199.201.158]:53397 "EHLO
	smtp2.brturbo.com.br") by vger.kernel.org with ESMTP
	id S1751005AbVHQJCY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 05:02:24 -0400
Subject: [Fwd: help with PCI hotplug and a PCI device enabled after boot]
From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Wed, 17 Aug 2005 06:02:22 -0300
Message-Id: <1124269343.4423.35.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3-6mdk 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    I need some help with PCI hotplug for allowing a new driver at
Video4Linux.

    I'm trying to develop a kernel module to handle audio support for a
video chipset (cx2388x from conexant). This chipset does provide several
PCI ID according with its function:

14f1:8800 function 0: for video stuff
14f1:8801 or 14f1:8811 - function 1: for audio stuff
14f1:8802 - function 2: mpeg
14f1:8803 - function 3: VESA VIP
14f1:8804 - function 4: Host

    8800 is enabled in all cards, but the other PCI IDs only if the
board has an eeprom inside, and, at the first byte, bits 0 to 4 enables
each function. Functions 2 to 4 does require additional hardware, but
function 1 doesn't seem to require, since it will only enable DMA audio
transfers from board to memory the same way as function 0 does for
video. The board I have to test it doesn't have an eeprom, so, only
function 0 is enabled at boot. There's a way to enable other modes via
changing an internal register at cx88.
    At current kernel, module cx8800 does implement function 0; module
cx8801 is intended to implement function 1, but it is only a skeleton. I
have a modified version of cx8800 that enables function 1. After
enabling it, and with the help of fakephp, i got it recognized, but
without memory resources.

    I need memory to set its internal registers. Is there a way to make
PCI drivers to allocate a memory region for the board?

Thanks in advance,
Mauro

--------------------
Hotplug enabled by using:

modprobe cx8800
modprobe fakephp
echo 1 >/sys/bus/pci/slots/0000\\:01\\:07.0/power

lspci after fake hotplug:

01:07.0 Multimedia video controller: Conexant CX23880/1/2/3 PCI Video
and Audio Decoder (rev 05)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (5000ns min, 13750ns max), cache line size 08
        Interrupt: pin A routed to IRQ 19
        Region 0: Memory at e2000000 (32-bit, non-prefetchable)
[size=16M]
        Capabilities: [44] Vital Product Data
        Capabilities: [4c] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:07.1 Multimedia controller: Conexant CX23880/1/2/3 PCI Video and
Audio Decoder [Audio Port] (rev 05)
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 0
        Region 0: Memory at <unassigned> (32-bit, non-prefetchable)
[disabled] [size=16M]
        Capabilities: [4c] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

errors when loading cx8801:

cx88/1: Trying to enable PCI device
PCI: Device 0000:01:07.1 not available because of resource collisions
cx88_audio: probe of 0000:01:07.1 failed with error -22



Cheers, 
Mauro.
Cheers, 
Mauro.

