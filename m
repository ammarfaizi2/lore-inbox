Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266042AbUAFAxI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 19:53:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266052AbUAFAw4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 19:52:56 -0500
Received: from mail.gmx.net ([213.165.64.20]:8416 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266042AbUAFAvP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 19:51:15 -0500
X-Authenticated: #20450766
Date: Tue, 6 Jan 2004 01:46:30 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0 NFS-server low to 0 performance
Message-ID: <Pine.LNX.4.44.0401060055570.1417-100000@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

The NFS server on a PC with a 2.6.0 (release) kernel slows down to a crawl
or stops completely.

Searched archives - nothing fits exact enough.

The server (PC1) is a 900MHz Duron with 384M RAM and a tulip 10/100
(LinkSys) network card (Linksys Network Everywhere Fast Ethernet 10/100
model NC100 (rev 17)).

Clients:
PC2 - Pentium 133MHz with 24M RAM and an onboard Lance 79C970 10mbps
network card,
a SA1100 platform (Tuxscreen / Shannon) with 16M RAM, PCMCIA Netgear
10/100mbps ne2000-compatible (pcnet_cs + 8390) card
a PXA250 platform (Inphinity / Triton starter-kit) with 64M RAM, onboard
SMC91C11xFD (smc91x driver) 10/100 chip

In the tests below I was copying a 4M file from an NFS-mounted
directory to a RAM-based fs (ramfs / tmpfs). Here are results:

server with 2.6.0 kernel:

fast:2.6.0-test11	2m21s (*)
fast:2.4.20		16.5s
SA1100:2.4		never finishes (*)
PXA:2.4.21-rmk1-pxa1	as above
PXA:2.6.0-rmk1-pxa	as above

server: 2.4.21

fast:2.6.0-test11	6s
fast:2.4.20		5s
SA1100:2.4.19-rmk7	3.22s
PXA:2.4.21-rmk1-pxa1	7s
PXA:2.6.0-rmk2-pxa	1) 50s (**)
(***)			2) 27s (**)

(*) Messages "NFS server not responding" / "NFS server OK", "mount version
older than kernel" on mount

(**) Messages "NFS server not responding" / "NFS server OK", "mount version
older than kernel" on mount, trafic shows as several peaks

(***) 2.6.0-rmk2-pxa corresponds to the 2.6.0-rmk2 kernel with a PXA-patch
forward-ported from diff-2.6.0-test2-rmk1-pxa1.

The LinkSys card I bought recently, before I used a RTL (3c59x) card, only
capable of 10mbps, I never saw such problems with it, but I, probably,
never tried NFS under 2.6.0 with it - have to try too.

It is not just a problem of 2.6 with those specific network configurations
- ftp / http / tftp transfers work fine. E.g. wget of the same file on the
PXA with 2.6.0 from the PC1 with 2.4.21 over http takes about 2s. So, it
is 2.6 + NFS.

Is it fixed somewhere (2.6.1-rcx?), or what should I try / what further
information is required?

Thanks
Guennadi
---
Guennadi Liakhovetski


