Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265243AbTLZWGO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 17:06:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265250AbTLZWGO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 17:06:14 -0500
Received: from smtp.dkm.cz ([62.24.64.34]:45572 "HELO smtp.dkm.cz")
	by vger.kernel.org with SMTP id S265243AbTLZWGJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 17:06:09 -0500
Date: Fri, 26 Dec 2003 23:06:05 +0100
From: Arne Rusek <zonk@matfyz.cz>
To: linux-kernel@vger.kernel.org
Subject: PCI Bus Error & Too much work @ interrupt
Message-ID: <20031226220605.GA22898@laptop.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello to you all.

I've expirienced a rather unpleasant situation while using my home ftp
server. I tried to upload several files (cd images - 700MB). It worked
awhile. Then connection died. I found the following in my logs (lots of
lines like this):

Dec 24 12:31:12 snowflake kernel: eth1: Too much work at interrupt, IntrStatus=0x0001.

and this (about 10 times and only once)

Dec 24 12:01:01 snowflake kernel: eth1: PCI Bus error 2290.
Dec 24 12:01:01 snowflake kernel: eth1: PCI Bus error 0290.

then crash and reboot.

There is a GNU Linux/Debian stable installed on that machine w/2.4.23.
It's Intel P3/700MHz. There is a cheap BenQ NIC (100mbit - 8139too
driver) but there are two of them and the second didn't have any
problems. Moreover there were no problem before I've updated the kernel.
Furthermore when I used scp (which has a throughput about 5mb/s) the
problems stopped.

And now, I'd like to ask if it's a bug or a malfunctioning hw. If
there's more info needed I will do my best in providing it.

Thank you in advance!

Arne Rusek

PS: cc me, please, as i'm not a subscriber

MORE INFO:

KERNEL:
  Linux version 2.4.23 (root@snowflake) (gcc version 2.95.4 20011002
  (Debian prerelease)) #4 Po pro 1 08:58:59 CET 2003

NIC:
  e000-e01f : Intel Corp. 82557/8/9 [Ethernet Pro 100]
    e000-e01f : eepro100

  2 times:
  e800-e8ff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+
    e800-e8ff : 8139too

PCI (lspci -vvv):

00:12.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
	Subsystem: Realtek Semiconductor Co., Ltd. RT8139
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at e800 [size=256]
	Region 1: Memory at e5508000 (32-bit, non-prefetchable) [size=256]
	Expansion ROM at e4000000 [disabled] [size=64K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:14.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
	Subsystem: Realtek Semiconductor Co., Ltd. RT8139
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at ec00 [size=256]
	Region 1: Memory at e550a000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

