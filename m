Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135608AbREFBEC>; Sat, 5 May 2001 21:04:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135613AbREFBDw>; Sat, 5 May 2001 21:03:52 -0400
Received: from shimura.Math.Berkeley.EDU ([169.229.58.53]:3200 "EHLO
	shimura.math.berkeley.edu") by vger.kernel.org with ESMTP
	id <S135608AbREFBDm>; Sat, 5 May 2001 21:03:42 -0400
Date: Sat, 5 May 2001 18:03:30 -0700 (PDT)
From: Wayne Whitney <whitney@math.berkeley.edu>
Reply-To: <whitney@math.berkeley.edu>
To: Manfred Spraul <manfred@colorfullife.com>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: How to debug a 2.4.4 tulip problem?
In-Reply-To: <3AF35246.420B2E1A@colorfullife.com>
Message-ID: <Pine.LNX.4.33.0105051750020.1522-100000@mf1.private>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


OK, I captured some tulip-diag info about my tulip problem.  Again,
intermittently my tulip card gets "slow", so that, for example, pinging it
from another machine on the same segment takes on the order of seconds,
rather than milliseconds (this time it was 0.4 seconds instead of the
usual 0.19 milliseconds).

Below is a unified diff of the output of "tulip-diag -aaf -mm"
(actually, -aaf and -mm separately, then merged by hand when I saw most of
the output was the same), both before and during the problem.  I'm happy
to provide any more information that would be helpful; I didn't yet have a
chance to figure out whether the delay occurs during send or receive or
both, but the next time it happens I will endeavor to do so.

Note that this is the PCI rev 32 version of the card; I also have a rev 33
version of the card on the same network, which I think does not have the
have the problem.

I should mention that this data was collected under kernel 2.4.4 with
MOSIX 1.0.0, but I have observed the same problem under kernels 2.2.x and
2.4.x.

Cheers,
Wayne

--- tulip card is working OK
+++ tulip card is "slow"
[whitney]$ tulip-diag -aaf -mm
 tulip-diag.c:v2.07 3/31/2001 Donald Becker (becker@scyld.com)
  http://www.scyld.com/diag/index.html
 Index #1: Found a Lite-On 82c168 PNIC adapter at 0xb800.
 Lite-On 82c168 PNIC chip registers at 0xb800:
- 0x00: 00008000 01ff0000 10450008 378a2000 378a2200 02660010 810c2202 0001fbef
- 0x40: 00000000 00000000 378a22d0 26eb685c 00000020 00000000 00000000 10000001
+ 0x00: 00008000 01ff0007 10450008 33acb000 33acb200 026e0010 810c2202 0001fbef
+ 0x40: 00000000 00000000 33acb250 338a48a0 00000020 00000000 00000000 10000001
  Extended registers:
  80: 00000000 00000000 00000000 00000000 f0022646 f0022646 000000bf 000000bf
- a0: 60fe0000 60fe0000 378a2090 378a2090 26f2d010 26f2d010 0201f978 0201f978
+ a0: 609645e1 609645e1 33acb000 33acb000 3387f840 3387f840 0201f978 0201f978
  c0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
  e0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
  Port selection is MII, full-duplex.
  Transmit started, Receive started, full-duplex.
-  The Rx process state is 'Waiting for packets'.
+  The Rx process state is 'Transferring Rx frame into memory'.
   The Tx process state is 'Idle'.
   The transmit threshold is 128.
  MII PHY found at address 1, status 0x782d.
  MII PHY #1 transceiver registers:
    3100 782d 0302 d008 01e1 45e1 0005 2001
    0000 0000 0000 0000 0000 0000 0000 0000
-   0000 0001 0000 0000 0000 003f 0000 8062
+   0000 0001 0000 0001 0000 0150 0000 8062
    0000 04a1 0000 0000 0039 0000 0000 0000.

