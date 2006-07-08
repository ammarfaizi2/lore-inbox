Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964773AbWGHKAV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964773AbWGHKAV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 06:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964788AbWGHKAV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 06:00:21 -0400
Received: from khc.piap.pl ([195.187.100.11]:37073 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S964773AbWGHKAS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 06:00:18 -0400
To: Chase Venters <chase.venters@clientec.com>
Cc: "linux-os \\\\(Dick Johnson\\\\)" <linux-os@analogic.com>,
       Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>,
       Linux kernel <linux-kernel@vger.kernel.org>, arjan@infradead.org
Subject: Re: [patch] spinlocks: remove 'volatile'
References: <20060705114630.GA3134@elte.hu>
	<20060705101059.66a762bf.akpm@osdl.org>
	<20060705193551.GA13070@elte.hu>
	<20060705131824.52fa20ec.akpm@osdl.org>
	<Pine.LNX.4.64.0607051332430.12404@g5.osdl.org>
	<20060705204727.GA16615@elte.hu>
	<Pine.LNX.4.64.0607051411460.12404@g5.osdl.org>
	<20060705214502.GA27597@elte.hu>
	<Pine.LNX.4.64.0607051458200.12404@g5.osdl.org>
	<Pine.LNX.4.64.0607051555140.12404@g5.osdl.org>
	<20060706081639.GA24179@elte.hu>
	<Pine.LNX.4.61.0607060756050.8312@chaos.analogic.com>
	<Pine.LNX.4.64.0607060856080.12404@g5.osdl.org>
	<Pine.LNX.4.64.0607060911530.12404@g5.osdl.org>
	<Pine.LNX.4.61.0607061333450.11071@chaos.analogic.com>
	<m34pxt8emn.fsf@defiant.localdomain>
	<Pine.LNX.4.61.0607071535020.13007@chaos.analogic.com>
	<Pine.LNX.4.64.0607071318570.3869@g5.osdl.org>
	<Pine.LNX.4.61.0607071657580.15580@chaos.analogic.com>
	<Pine.LNX.4.64.0607071635130.23767@turbotaz.ourhouse>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Sat, 08 Jul 2006 12:00:15 +0200
In-Reply-To: <Pine.LNX.4.64.0607071635130.23767@turbotaz.ourhouse> (Chase Venters's message of "Fri, 7 Jul 2006 16:48:56 -0500 (CDT)")
Message-ID: <m3wtaoe7rk.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chase Venters <chase.venters@clientec.com> writes:

> Locks are supposed to be syncronization points, which is why they
> ALREADY HAVE "memory" on the clobber list! "memory" IS NECESSARY. The
> fact that "=m" is changing to "+m" in Linus's patches is because "=m"
> is in fact insufficient, because it would let the compiler believe
> we're just going to over-write the value. "volatile" merely hides that
> bug -- once that bug is _fixed_ (by going to "+m"), "volatile" is no
> longer useful.

This is a completely different story. "volatile", barrier() and "+m"/"=m"
aren't sync points. If the variable access isn't atomic you must use
locking even with volatiles, barriers etc.

> If "volatile" is in use elsewhere (other than locks), it's still
> probably wrong. In these cases, you can use a barrier, a volatile
> cast, or an inline asm with a specific clobber.

A volatile cast is just a volatile, moved from data declaration to
all access points. It doesn't buy you anything.
barrier() is basically "all-volatile". All of them operate on the same,
compiler level.

If the "volatile" is used the wrong way (which is probably true for most
cases), then volatile cast and barrier() will be wrong as well. You need
locks or atomic access, meaningful on hardware level.
-- 
Krzysztof Halasa
