Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129044AbQKHXsR>; Wed, 8 Nov 2000 18:48:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129047AbQKHXsH>; Wed, 8 Nov 2000 18:48:07 -0500
Received: from piglet.twiddle.net ([207.104.6.26]:56583 "EHLO
	piglet.twiddle.net") by vger.kernel.org with ESMTP
	id <S129044AbQKHXsA>; Wed, 8 Nov 2000 18:48:00 -0500
Date: Wed, 8 Nov 2000 15:48:11 -0800
From: Richard Henderson <rth@twiddle.net>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: axp-list@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: PCI-PCI bridges mess in 2.4.x
Message-ID: <20001108154811.A28101@twiddle.net>
In-Reply-To: <20001101153420.A2823@jurassic.park.msu.ru> <20001101093319.A18144@twiddle.net> <20001103111647.A8079@jurassic.park.msu.ru> <20001103011640.A20494@twiddle.net> <20001106192930.A837@jurassic.park.msu.ru> <20001108013931.A26972@twiddle.net> <20001108142513.A5244@jurassic.park.msu.ru> <20001108093744.D27324@twiddle.net> <20001109010336.A1367@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <20001109010336.A1367@jurassic.park.msu.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2000 at 01:03:36AM +0300, Ivan Kokshaysky wrote:
> But actually I'm concerned that all this code doesn't work at all -
> see reports from Michal Jaegermann (the bridge acts as if it drops
> config space transactions randomly).

I have no idea what Michal is seeing.  It does, however, work
just dandy on my rawhide:

-+-[01]-+-01.0
 |      +-02.0-[02]----00.0
 |      +-04.0
 |      \-04.1
 \-[00]-+-01.0
        +-02.0
        \-05.0

01:02.0 PCI bridge: Digital Equipment Corporation DECchip 21050 (rev 02) \
		(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- \
		Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- \
		<TAbort- <MAbort- >SERR- <PERR-
        Latency: 248, cache line size 10
        Bus: primary=01, secondary=02, subordinate=02, sec-latency=0
        I/O behind bridge: 00009000-00009fff
        Memory behind bridge: 02300000-023fffff
        BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-

02:00.0 SCSI storage controller: Q Logic ISP1020 (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ \
		Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- \
		<TAbort- <MAbort- >SERR- <PERR-
        Latency: 248, cache line size 10
        Interrupt: pin A routed to IRQ 40
        Region 0: I/O ports at 200009000 [size=256]
        Region 1: Memory at 0000000202310000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at 0000000202300000 [disabled] [size=64K]

Whee!  We're back in Bootsville.


r~
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
