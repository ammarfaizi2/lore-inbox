Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263206AbUKASQ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263206AbUKASQ3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 13:16:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269694AbUKASQ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 13:16:28 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:41400 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S273775AbUKASEZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 13:04:25 -0500
Date: Mon, 01 Nov 2004 10:03:56 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>,
       Andrea Arcangeli <andrea@novell.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: PG_zero
Message-ID: <161650000.1099332236@flay>
In-Reply-To: <418671AA.6020307@yahoo.com.au>
References: <20041030141059.GA16861@dualathlon.random> <418671AA.6020307@yahoo.com.au>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> And there was no
>> need of using two quicklists for cold and hot pages, less resources are
>> wasted by just using the lru ordering to diferentiate from hot/cold
>> allocations and hot/cold freeing. 
> 
> Not sure if this is wise. Reclaimed pages should definitely be cache
> cold. Other freeing is assumed cache hot and LRU ordered on the hot
> list which seems right... but I think you want the cold list for page
> reclaim, don't you?

You're completely correct about the hot vs cold, but I don't think that
precludes what Andrea is suggesting ... merge into one list and use the
hot/cold ends. Mmmm ... why did we do that? I think it was to stop cold
allocations from eating into hot pages - we'd prefer them to fall back
into the buddy instead.

>> Obvious improvements would be to implement a long_write_zero(ptr)
>> operation that doesn't pollute the cache. IIRC it exists on the alpha, I
>> assume it exists on x86/x86-64 too. But that's incremental on top of
>> this.
>> 
>> It seems stable, I'm running it while writing this.
>> 
>> I guess testing on a memory bound architecture would be more interesting
>> (more cpus will make it more memory bound somewhat).
>> 
>> Comments welcome.
> 
> I have the feeling that it might not be worthwhile doing zero on idle.
> You've got chance of blowing the cache on zeroing pages that won't be
> used for a while. If you do uncached writes then you've changed the
> problem to memory bandwidth (I guess doesn't matter much on UP).

Yeah, we got bugger-all benefit out of it. The only think it might do
is lower the latency on inital load-spikes, but basically you end up
paying the cache fetch cost twice. But ... numbers rule - if you can come
up with something that helps a real macro benchmark, I'll eat my non-existant
hat ;-)

M.

