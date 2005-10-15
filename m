Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751212AbVJOTtr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212AbVJOTtr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Oct 2005 15:49:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751213AbVJOTtr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Oct 2005 15:49:47 -0400
Received: from 22.107.233.220.exetel.com.au ([220.233.107.22]:34564 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1751212AbVJOTtr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Oct 2005 15:49:47 -0400
Date: Sun, 16 Oct 2005 05:48:55 +1000
To: Andrea Arcangeli <andrea@suse.de>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, benh@kernel.crashing.org,
       hugh@veritas.com, paulus@samba.org, anton@samba.org, torvalds@osdl.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Possible memory ordering bug in page reclaim?
Message-ID: <20051015194855.GA1164@gondor.apana.org.au>
References: <4350C4F6.4030807@yahoo.com.au> <E1EQkpc-0007FI-00@gondolin.me.apana.org.au> <20051015180018.GN18159@opteron.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051015180018.GN18159@opteron.random>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 15, 2005 at 06:00:18PM +0000, Andrea Arcangeli wrote:
> 
> Note that the barrier in atomic_add_negative is useless here because it
> happens way too late, _after_ the count is decremented (not _before_)
> so the decreased count could be already visible to the other cpu.

Could you please point me to an architecture that does this?

This assumption is in fact made in a number of places in the kernel
where constructs such as atomic_add_negative or atomic_dec_and_test
are used and assumed to imply a memory barrier.

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
