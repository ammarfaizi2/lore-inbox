Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261801AbTJFVXc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 17:23:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261806AbTJFVXb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 17:23:31 -0400
Received: from [66.212.224.118] ([66.212.224.118]:4109 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S261801AbTJFVX0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 17:23:26 -0400
Date: Mon, 6 Oct 2003 17:23:17 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Domen Puncer <domen@coderock.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 3c59x on 2.6.0-test3->test6 slow
In-Reply-To: <200310061529.56959.domen@coderock.org>
Message-ID: <Pine.LNX.4.53.0310061710300.19396@montezuma.fsmlabs.com>
References: <200310061529.56959.domen@coderock.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Oct 2003, Domen Puncer wrote:

> Works slow (~35kB/s) on kernels 2.6.0-test3 and newer. I can trace this to wol
> removal patch. (reloading doesn't help, like in test2 case, see below)
> 
> But there's another problem:
> On 2.6.0-test2 it works normal, but only when i reload (rmmod/modprobe) the
> driver.
> After this reloading i can't get it back into "slow" mode even if i use test3 or
> newer driver.
> One thing to note: when it works ok, i get this in dmesg:
> eth0: Setting full-duplex based on MII #24 link partner capability of 0141.

Ok, could you send your .config too, i use the 3c59x driver and haven't 
noticed this in 2.6.0-test5-mm4. My card is;

00:10.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] (rev 30)
00:11.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone]

> 
> erikm suggested running mii-tool -r eth0, output i get:
> # mii-tool -r eth0
> SIOCGMIIPHY on 'eth0' failed: Operation not supported
> # mii-tool
> SIOCGMIIPHY on 'eth0' failed: Operation not supported
> no MII interfaces found

And when done as root?

zwane@montezuma /tmp {0:1} sudo mii-tool
eth0: negotiated 100baseTx-FD, link ok
eth1: negotiated 100baseTx-FD, link ok

> # lspci -v
> 00:0a.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] (rev 34)
>         Subsystem: 3Com Corporation 3C905B Fast Etherlink XL 10/100
>         Flags: bus master, medium devsel, latency 32, IRQ 10
>         I/O ports at d000 [size=128]
>         Memory at db000000 (32-bit, non-prefetchable) [size=128]
>         Expansion ROM at <unassigned> [disabled] [size=128K]
>         Capabilities: [dc] Power Management version 1
> 
> # lspci -vv
> 00:0a.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] (rev 34)
>         Subsystem: 3Com Corporation 3C905B Fast Etherlink XL 10/100
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 32 (2500ns min, 2500ns max), cache line size 08
>         Interrupt: pin A routed to IRQ 10
>         Region 0: I/O ports at d000 [size=128]
>         Region 1: Memory at db000000 (32-bit, non-prefetchable) [size=128]
>         Expansion ROM at <unassigned> [disabled] [size=128K]
>         Capabilities: [dc] Power Management version 1
>                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold-)
>                 Status: D0 PME-Enable+ DSel=0 DScale=0 PME-
> 
> 
> 
> If there's any more testing/trying patches i can do, i'll be glad to.

Just your .config,

cheers,
	Zwane

