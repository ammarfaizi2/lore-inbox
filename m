Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263150AbUKTTIe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263150AbUKTTIe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 14:08:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263155AbUKTTIe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 14:08:34 -0500
Received: from holomorphy.com ([207.189.100.168]:22664 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263154AbUKTTIa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 14:08:30 -0500
Date: Sat, 20 Nov 2004 11:08:18 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       clameter@sgi.com, benh@kernel.crashing.org, hugh@veritas.com,
       linux-mm@kvack.org, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: page fault scalability patch V11 [0/7]: overview
Message-ID: <20041120190818.GX2714@holomorphy.com>
References: <20041120042340.GJ2714@holomorphy.com> <419EC829.4040704@yahoo.com.au> <20041120053802.GL2714@holomorphy.com> <419EDB21.3070707@yahoo.com.au> <20041120062341.GM2714@holomorphy.com> <419EE911.20205@yahoo.com.au> <20041119225701.0279f846.akpm@osdl.org> <419EEE7F.3070509@yahoo.com.au> <1834180000.1100969975@[10.10.2.4]> <Pine.LNX.4.58.0411200911540.20993@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0411200911540.20993@ppc970.osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 20, 2004 at 09:14:11AM -0800, Linus Torvalds wrote:
> I will pretty much guarantee that if you put the per-thread patches next
> to some abomination with per-cpu allocation for each mm, the choice will
> be clear. Especially if the per-cpu/per-mm thing tries to avoid false
> cacheline sharing, which sounds really "interesting" in itself.
> And without the cacheline sharing avoidance, what's the point of this 
> again? It sure wasn't to make the code simpler. It was about performance 
> and scalability.

"The perfect is the enemy of the good."

The "perfect" cacheline separation achieved that way is at the cost of
destabilizing the kernel. The dense per-cpu business is only really a
concession to the notion that the counter needs to be split up at all,
which has never been demonstrated with performance measurements. In fact,
Robin Holt has performance measurements demonstrating the opposite.

The "good" alternatives are negligibly different wrt. performance, and
don't carry the high cost of rwlock starvation that breaks boxen.


-- wli
