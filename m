Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262072AbTJFNaM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 09:30:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262092AbTJFNaM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 09:30:12 -0400
Received: from rcum.uni-mb.si ([164.8.2.10]:41195 "EHLO rcum.uni-mb.si")
	by vger.kernel.org with ESMTP id S262072AbTJFNaG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 09:30:06 -0400
Date: Mon, 06 Oct 2003 15:29:56 +0200
From: Domen Puncer <domen@coderock.org>
Subject: 3c59x on 2.6.0-test3->test6 slow
To: linux-kernel@vger.kernel.org
Message-id: <200310061529.56959.domen@coderock.org>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-2
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: KMail/1.5.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

[cc me in reply]

Works slow (~35kB/s) on kernels 2.6.0-test3 and newer. I can trace this to wol
removal patch. (reloading doesn't help, like in test2 case, see below)

But there's another problem:
On 2.6.0-test2 it works normal, but only when i reload (rmmod/modprobe) the
driver.
After this reloading i can't get it back into "slow" mode even if i use test3 or
newer driver.
One thing to note: when it works ok, i get this in dmesg:
eth0: Setting full-duplex based on MII #24 link partner capability of 0141.

erikm suggested running mii-tool -r eth0, output i get:
# mii-tool -r eth0
SIOCGMIIPHY on 'eth0' failed: Operation not supported
# mii-tool
SIOCGMIIPHY on 'eth0' failed: Operation not supported
no MII interfaces found

# lspci -v
00:0a.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] (rev 34)
        Subsystem: 3Com Corporation 3C905B Fast Etherlink XL 10/100
        Flags: bus master, medium devsel, latency 32, IRQ 10
        I/O ports at d000 [size=128]
        Memory at db000000 (32-bit, non-prefetchable) [size=128]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [dc] Power Management version 1

# lspci -vv
00:0a.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] (rev 34)
        Subsystem: 3Com Corporation 3C905B Fast Etherlink XL 10/100
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2500ns min, 2500ns max), cache line size 08
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at d000 [size=128]
        Region 1: Memory at db000000 (32-bit, non-prefetchable) [size=128]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable+ DSel=0 DScale=0 PME-



If there's any more testing/trying patches i can do, i'll be glad to.


	Domen

