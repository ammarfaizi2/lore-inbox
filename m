Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262461AbTIBVjq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 17:39:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262372AbTIBVjq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 17:39:46 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:57482 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S262461AbTIBVjo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 17:39:44 -0400
Date: Tue, 2 Sep 2003 22:39:05 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Kars de Jong <jongk@linux-m68k.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux/m68k kernel mailing list 
	<linux-m68k@lists.linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: x86, ARM, PARISC, PPC, MIPS and Sparc folks please run this
Message-ID: <20030902213905.GC16805@mail.jlokier.co.uk>
References: <Pine.GSO.4.21.0309011027310.5048-100000@waterleaf.sonytel.be> <1062407310.13046.6.camel@laptop.locamation.com> <20030901100807.GB1903@mail.jlokier.co.uk> <1062535375.3501.11.camel@kars.perseus.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1062535375.3501.11.camel@kars.perseus.home>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kars de Jong wrote:
> And no, this board has no way of getting a better time resolution than
> the 100 Hz tick timer either ;-)

The coherency test is fine.  That's just logic.

The clock granularity got me wondering whether the timing measurement
is meaningful on these machines.  It's possible for the shared test to
take 2000 microseconds and the unshared test to take 10 microseconds,
and they can still show up as 10ms if they both cross a clock tick
boundary.

The minimum of 128 tests of each type is likely to report 0 until
timing_loops is larger enough to make all 128 consistently almost
10ms, according to the timing when each test starts.  Then as we only
care if there is an approximately 2:1 ratio or more, it is fine.

That depends on the timing of each test not being synchronised with
the clock ticks, or when they are, that not affecting the result.

I'm not sure, but I have a feeling that the random shuffle makes it ok.

Hmm.

-- Jamie
