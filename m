Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262263AbTIAE3T (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 00:29:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262567AbTIAE3T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 00:29:19 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:30089 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S262263AbTIAE3N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 00:29:13 -0400
Date: Mon, 1 Sep 2003 05:29:09 +0100
From: Jamie Lokier <jamie@shareable.org>
To: dean gaudet <dean-list-linux-kernel@arctic.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: x86, ARM, PARISC, PPC, MIPS and Sparc folks please run this
Message-ID: <20030901042909.GA748@mail.jlokier.co.uk>
References: <20030829053510.GA12663@mail.jlokier.co.uk> <Pine.LNX.4.53.0308311742420.2043@twinlark.arctic.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0308311742420.2043@twinlark.arctic.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dean gaudet wrote:
> On Fri, 29 Aug 2003, Jamie Lokier wrote:
> > I already got a surprise (to me): my Athlon MP is much slower
> > accessing multiple mappings which are within 32k of each other, than
> > mappings which are further apart, although it is coherent.  The L1
> > data cache is 64k.  (The explanation is easy: virtually indexed,
> > physically tagged cache moves data among cache lines, possibly via L2).
> 
> opteron has 64KiB / 2-way L1 which means 15-bits of indexing... which
> totally predicts the 32KiB spacing i saw someone else post about.

Aha, thanks!  All Athlons are the same with 64KiB L1 and 32KiB
threshold, and K6 is the same but with 16KiB threshold instead.

> there's a real oddity i found on p4 just yesterday.  i was doing some
> pointer-chasing experiments, and i set up two 8192B shared mappings to the
> same file, for example:
> 
> 0x50000000 => /var/tmp/foo offset 0
> 0x50002000 => /var/tmp/foo offset 0
> 
> then i set up a 4 element cycle:
> 
> 0x50000000 => 0x50001004 => 0x50002008 => 0x5000300c => 0x50000000
> 
> when i do this it seems to trip up a p4 badly ... i'm seeing 3000 cycles
> per load on a 2.4GHz p4, and 300 cycles per load on a 2.4GHz xeon.  the
> crazy thing is that small variations in the experiment (such as longer
> cycles) make the oddity go away!

I have no idea of the explanation, unless P4 is doing the same as the
Athlon, 3000 cycles is the cost of an L1/L2 miss, and P4 has virtual
aliasing in both L1 and L2.  Hmm.

I would certainly like to detect that if it occurs with typical
instruction streams, otherwise it'll clobber my application's
performance on a P4.  I don't have a P4 to test on, btw.  If you can
investigate further that would be very good.

-- Jamie
