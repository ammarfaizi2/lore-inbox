Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261420AbVBASo4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261420AbVBASo4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 13:44:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261394AbVBASo4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 13:44:56 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:54726 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261372AbVBASow (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 13:44:52 -0500
Date: Tue, 1 Feb 2005 10:44:25 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Andi Kleen <ak@muc.de>, Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       hugh@veritas.com, linux-mm@kvack.org, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, benh@kernel.crashing.org
Subject: Re: page fault scalability patch V16 [3/4]: Drop page_table_lock in
 handle_mm_fault
In-Reply-To: <41FF0281.6090903@yahoo.com.au>
Message-ID: <Pine.LNX.4.58.0502011039120.3205@schroedinger.engr.sgi.com>
References: <41E5B7AD.40304@yahoo.com.au> <Pine.LNX.4.58.0501121552170.12669@schroedinger.engr.sgi.com>
 <41E5BC60.3090309@yahoo.com.au> <Pine.LNX.4.58.0501121611590.12872@schroedinger.engr.sgi.com>
 <20050113031807.GA97340@muc.de> <Pine.LNX.4.58.0501130907050.18742@schroedinger.engr.sgi.com>
 <20050113180205.GA17600@muc.de> <Pine.LNX.4.58.0501131701150.21743@schroedinger.engr.sgi.com>
 <20050114043944.GB41559@muc.de> <Pine.LNX.4.58.0501140838240.27382@schroedinger.engr.sgi.com>
 <20050114170140.GB4634@muc.de> <Pine.LNX.4.58.0501281233560.19266@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0501281237010.19266@schroedinger.engr.sgi.com>
 <41FF0281.6090903@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Feb 2005, Nick Piggin wrote:

> Hmm, this is moving toward the direction my patches take.

You are right. But I am still weary of the transactional idea in your
patchset (which is really not comparable with a database transaction
after all...).

I think moving to cmpxchg and xchg operations will give this more
transparency and make it easier to understand and handle.

> Naturally I prefer the complete replacement that is made with
> my patch - however this of course means one has to move
> *everything* over to be pte_cmpxchg safe, which runs against
> your goal of getting the low hanging fruit with as little fuss
> as possible for the moment.

I would also prefer a replacement but there are certain cost-benefit
tradeoffs with atomic operations vs. spinlock that may better be tackled
on a case by case basis. Also this is pretty much at the core of the Linux
VM and thus highly sensitive. Given its history and the danger of breaking
things it may be best to preserve it intact as much as possible and move
in small steps.
