Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265200AbUAJICd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 03:02:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265201AbUAJICd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 03:02:33 -0500
Received: from odpn1.odpn.net ([212.40.96.53]:6535 "EHLO odpn1.odpn.net")
	by vger.kernel.org with ESMTP id S265200AbUAJICa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 03:02:30 -0500
To: linux-kernel@vger.kernel.org
Cc: jgarzik@pobox.com
Subject: 2.4.24 eth0: TX underrun, threshold adjusted.
From: "Gabor Z. Papp" <gzp@papp.hu>
Date: Sat, 10 Jan 2004 09:02:27 +0100
Message-ID: <x665fkb59o@gzp>
User-Agent: Gnus/5.1004 (Gnus v5.10.4)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Authenticated: gzp1 odpn1.odpn.net a3085bdc7b32ae4d7418f70f85f7cf5f
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replacing 2.4.23 with 2.4.24 went without any error I noticed.

After 8h uptime I have connected the first nfsroot client.

In the server host klog got 12 "eth0: TX underrun, threshold adjusted."
messages while the client started to mount the dirs.

etherwake uses obsolete (PF_INET,SOCK_PACKET)
IN=eth0 OUT= MAC=ff:ff:ff:ff:ff:ff:00:07:e9:12:49:34:08:00 SRC=0.0.0.0 DST=255.255.255.255 LEN=576 TOS=0x00 PREC=0x00 TTL=20 ID=0 PROTO=UDP SPT=68 DPT=67 LEN=556 IN=eth0 OUT= MAC=ff:ff:ff:ff:ff:ff:00:07:e9:12:49:34:08:00 SRC=0.0.0.0 DST=255.255.255.255 LEN=576 TOS=0x00 PREC=0x00 TTL=20 ID=1 PROTO=UDP SPT=68 DPT=67 LEN=556 
IN=eth0 OUT= MAC=ff:ff:ff:ff:ff:ff:00:07:e9:12:49:34:08:00 SRC=0.0.0.0 DST=255.255.255.255 LEN=576 TOS=0x00 PREC=0x00 TTL=60 ID=0 PROTO=UDP SPT=68 DPT=67 LEN=556 IN=eth0 OUT= MAC=ff:ff:ff:ff:ff:ff:00:07:e9:12:49:34:08:00 SRC=0.0.0.0 DST=255.255.255.255 LEN=576 TOS=0x00 PREC=0x00 TTL=64 ID=0 DF PROTO=UDP SPT=68 DPT=67 LEN=556
IN=eth0 OUT= MAC=ff:ff:ff:ff:ff:ff:00:07:e9:12:49:34:08:00 SRC=0.0.0.0 DST=255.255.255.255 LEN=576 TOS=0x00 PREC=0x00 TTL=64 ID=0 DF PROTO=UDP SPT=68 DPT=67 LEN=556
eth0: TX underrun, threshold adjusted.
[10 times]
eth0: TX underrun, threshold adjusted.

Host bridge: Intel Corp. 82845G/GL [Brookdale-G]
P4-2.4GHz 512MB RAM
eth0 intel eepro100
eth1 onboard b44 (for pppoe)

Never noticed such problem with 2.4.23 or earlier kernels.

Just noticed, on the nfsroot client getting the same message 4 times.
There is only one eepro100:

Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 10)
        Subsystem: Intel Corp.: Unknown device 0070
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
        ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
        >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min, 14000ns max), Cache Line Size 08
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at f7800000 (32-bit, non-prefetchable) [size=4K]
        Region 1: I/O ports at d000 [size=64]
        Region 2: Memory at f7000000 (32-bit, non-prefetchable) [size=128K]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
        PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

Additional debug infos available on request.

