Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265305AbTL0ECG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 23:02:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265307AbTL0ECG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 23:02:06 -0500
Received: from fw.osdl.org ([65.172.181.6]:39075 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265305AbTL0ECD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 23:02:03 -0500
Date: Fri, 26 Dec 2003 20:01:57 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
cc: Nick Craig-Wood <ncw1@axis.demon.co.uk>,
       William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org, Rohit Seth <rohit.seth@intel.com>
Subject: Re: 2.6.0 Huge pages not working as expected
In-Reply-To: <20031227033620.GG1676@dualathlon.random>
Message-ID: <Pine.LNX.4.58.0312261956510.14874@home.osdl.org>
References: <20031226105433.GA25970@axis.demon.co.uk> <20031226115647.GH27687@holomorphy.com>
 <20031226201011.GA32316@axis.demon.co.uk> <Pine.LNX.4.58.0312261226560.14874@home.osdl.org>
 <20031227033620.GG1676@dualathlon.random>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 27 Dec 2003, Andrea Arcangeli wrote:
> 
> well, at least on the alpha the above mode = 1 is reproducibly a lot
> better (we're talking about a wall time 2/3 times shorter IIRC) than
> random placement. The l2 is huge and one way cache associative,

What kind of strange and misguided hw engineer did that?

I can understand a one-way L1, simply to keep the cycle time low, but 
what's the point of a one-way L2? Braindead external cache controller?

> The current patch is for 2.2 with an horrible API (it uses a kernel
> module to set those params instead of a sysctl, despite all the real
> code is linked into the kernel), while developing it I only focused on
> the algorithms and the final behaviour in production. the engine to ask
> the allocator a page of the right color works O(1) with the number of
> free pages and it's from Jason.

Does it keep fragmentation down?

That's the problem that Davem had in one of his cache-coloring patches: it
worked well enough if you had lots of memory, but it _totally_ broke down
when memory was low. You couldn't allocate higher-order pages at all after
a while because of the fragmented memory.

			Linus
