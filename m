Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2993102AbWJUPjL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993102AbWJUPjL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 11:39:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993107AbWJUPjL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 11:39:11 -0400
Received: from stinky.trash.net ([213.144.137.162]:13813 "EHLO
	stinky.trash.net") by vger.kernel.org with ESMTP id S2993102AbWJUPjK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 11:39:10 -0400
Message-ID: <453A3F0C.3000406@trash.net>
Date: Sat, 21 Oct 2006 17:38:52 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: htejun@gmail.com
CC: jeff@garzik.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: "libata: fix non-uniform ports handling" breaks sata_sis secondary
 port
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch "libata: fix non-uniform ports handling" breaks the
secondary SATA port with the sata_sis driver for me (no link
detected). The reason seems to be that the SIS_FLAG_CFGSCR flag
is only set on probe_ent->port_flags in sis_init_one(), but
ata_port_init() uses ent->pinfo2->flags for initialization of
the flags in struct ata_port for the secondary port.

lspci entry of the controller below, if more information is needed
please ask.


0000:00:05.0 RAID bus controller: Silicon Integrated Systems [SiS] RAID
bus controller 180 SATA/PATA  [SiS] (rev 01) (prog-if 85)
        Subsystem: ASUSTeK Computer Inc.: Unknown device 810e
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 128
        Interrupt: pin A routed to IRQ 18
        Region 0: I/O ports at eff0 [size=8]
        Region 1: I/O ports at efe4 [size=4]
        Region 2: I/O ports at efa8 [size=8]
        Region 3: I/O ports at efe0 [size=4]
        Region 4: I/O ports at ef90 [size=16]
        Region 5: I/O ports at <unassigned>
