Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030477AbWJ3AUu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030477AbWJ3AUu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 19:20:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030476AbWJ3AUt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 19:20:49 -0500
Received: from mail.gmx.net ([213.165.64.20]:53192 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030474AbWJ3AUt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 19:20:49 -0500
X-Authenticated: #20450766
Date: Mon, 30 Oct 2006 01:20:45 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Francois Romieu <romieu@fr.zoreil.com>
cc: Linus Torvalds <torvalds@osdl.org>,
       Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
       Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       tmattox@gmail.com, spiky.kiwi@gmail.com, r.bhatia@ipax.at
Subject: Re: r8169 mac address change (was Re: [0/3] 2.6.19-rc2: known
 regressions)
In-Reply-To: <20061029223410.GA15413@electric-eye.fr.zoreil.com>
Message-ID: <Pine.LNX.4.60.0610300032190.1435@poirot.grange>
References: <20061029223410.GA15413@electric-eye.fr.zoreil.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Oct 2006, Francois Romieu wrote:

> Linus Torvalds <torvalds@osdl.org> :
> [regression related to r8169 MAC address change]
> > Francois ? Jeff ?
> 
> Go revert it.
> 
> Despite what I claimed, I can not find a third-party confirmation by email
> that it works elsewhere.
> 
> It would probably be enough to remove the call to __rtl8169_set_mac_addr()
> in rtl8169_hw_start() though.
> 
> In place of the test suggested in bugzilla, I'd rather see Guennadi test
> the thing below (acked on netdev by the initial victim if someone wonders
> why it has not changed the status of bugzilla so far):

AFAIU, you wanted it applied on the top of the "non-working" kernel 
(2.6.19-rc2-ish)? No, it didn't work. And, worse yet, I think, it is after 
testing that patch that the interface got into a state, when netconsole 
worked, ping worked, but ssh didn't. A poweroff was needed to recover. In 
case you still need it, here's the info you requested:

00:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8169 Gigabit Ethernet (rev 10)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 128 (8000ns min, 16000ns max), Cache Line Size: 32 bytes
        Interrupt: pin A routed to IRQ 16
        Region 0: I/O ports at febfff00 [size=256]
        Region 1: Memory at bffffc00 (32-bit, non-prefetchable) [size=256]
        Capabilities: [dc] Power Management version 0
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: ec 10 69 81 17 00 b0 02 10 00 00 02 08 80 00 00
10: 01 ff bf 00 00 fc ff bf 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 dc 00 00 00 00 00 00 00 10 01 20 40

dmesg when it didn't work (I do use netconsole, don't think it matters?):

r8169 Gigabit Ethernet driver 2.2LK loaded
eth0: RTL8169s/8110s at 0xc9004c00, 00:0d:0b:99:44:70, IRQ 16
netconsole: device eth0 not up yet, forcing it
r8169: eth0: link down
r8169: eth0: link up

The same when it's working.

Yes, just commenting out the line

	__rtl8169_set_mac_addr(dev, ioaddr);

fixes it (without the patch from your previous email).

Thanks
Guennadi
---
Guennadi Liakhovetski
