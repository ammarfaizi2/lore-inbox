Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317517AbSGTVMl>; Sat, 20 Jul 2002 17:12:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317520AbSGTVMk>; Sat, 20 Jul 2002 17:12:40 -0400
Received: from holomorphy.com ([66.224.33.161]:3989 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S317517AbSGTVMk>;
	Sat, 20 Jul 2002 17:12:40 -0400
Date: Sat, 20 Jul 2002 14:15:39 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, riel@conectiva.com.br
Subject: Re: [PATCH] generalized spin_lock_bit
Message-ID: <20020720211539.GG1096@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, riel@conectiva.com.br
References: <1027196511.1555.767.camel@sinai> <Pine.LNX.4.44.0207201335560.1492-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0207201335560.1492-100000@home.transmeta.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 Jul 2002, Robert Love wrote:
>> The attached patch implements bit-sized spinlocks via the following
>> interfaces:

On Sat, Jul 20, 2002 at 01:40:22PM -0700, Linus Torvalds wrote:
> In particular, with the current pte_chain_lock() interface, it will be
> _trivial_ to turn that bit in page->flags to be instead a hash based on
> the page address into an array of spinlocks. Which is a lot more portable
> than the current code.
> (The current code works, but look at what it generates on old sparcs, for
> example).

I was hoping to devolve the issue of the implementation of it to arch
maintainers by asking for this. I was vaguely aware that the atomic bit
operations are implemented via hashed spinlocks on PA-RISC and some
others, so by asking for the right primitives to come back up from arch
code I hoped those who spin elsewhere might take advantage of their
window of exclusive ownership.

Would saying "Here is an address, please lock it, and if you must flip
a bit, use this bit" suffice? I thought it might give arch code enough
room to wiggle, but is it enough?


Thanks,
Bill
