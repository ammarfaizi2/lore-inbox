Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318197AbSHDSvf>; Sun, 4 Aug 2002 14:51:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318199AbSHDSvf>; Sun, 4 Aug 2002 14:51:35 -0400
Received: from horkos.telenet-ops.be ([195.130.132.45]:35263 "EHLO
	horkos.telenet-ops.be") by vger.kernel.org with ESMTP
	id <S318197AbSHDSvd> convert rfc822-to-8bit; Sun, 4 Aug 2002 14:51:33 -0400
X-Qmail-Scanner-Mail-From: Devilkin-LKML@blindguardian.org via whocares
X-Qmail-Scanner: 1.10 (Clear:0. Processed in 0.068843 secs)
Content-Type: text/plain; charset=US-ASCII
From: Devilkin <Devilkin-LKML@blindguardian.org>
To: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19-ac2
Date: Sun, 4 Aug 2002 20:57:57 +0200
User-Agent: KMail/1.4.1
References: <200208041746.g74Hkgr24437@devserv.devel.redhat.com>
In-Reply-To: <200208041746.g74Hkgr24437@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200208042057.57130.Devilkin-LKML@blindguardian.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 04 August 2002 19:46, Alan Cox wrote:
<snip>

There seems to be some problem with VIA IDE IRQ's on 2.4.19-ac2.

With 2.4.19-ac2 i get the following message in the logs:

PCI: No IRQ known for interrupt pin A of device 00:07.1. Please try using 
pci=biosirq.

00:07.1 is the IDE Interface on my mainboard!

checking with lspci gives this output:

----------------
00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06) (prog-if 
8f [Master SecP SecO PriP PriO])
        Subsystem: VIA Technologies, Inc. Bus Master IDE
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 0
        Region 0: I/O ports at <ignored>
        Region 1: I/O ports at <ignored>
        Region 2: I/O ports at <ignored>
        Region 3: I/O ports at <ignored>
        Region 4: I/O ports at d400 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
----------------

whereas with older kernels (2.4.19-ac1 and previous kernels) this error isn't 
given, and lspci looks as follows:

----------------
00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06) (prog-if 
8a [Master SecP PriP])
        Subsystem: VIA Technologies, Inc. Bus Master IDE
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 4: I/O ports at d400 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
----------------
which somehow looks healthier.

I've reverted to -ac1 for now, which works fine on my box.

DK
