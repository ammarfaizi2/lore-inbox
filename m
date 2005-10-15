Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751138AbVJOMJ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751138AbVJOMJ1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Oct 2005 08:09:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751140AbVJOMJ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Oct 2005 08:09:27 -0400
Received: from 22.107.233.220.exetel.com.au ([220.233.107.22]:31506 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1751138AbVJOMJ1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Oct 2005 08:09:27 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: nickpiggin@yahoo.com.au (Nick Piggin)
Subject: Re: Possible memory ordering bug in page reclaim?
Cc: benh@kernel.crashing.org, hugh@veritas.com, paulus@samba.org,
       anton@samba.org, torvalds@osdl.org, akpm@osdl.org, andrea@suse.de,
       linux-kernel@vger.kernel.org
Organization: Core
In-Reply-To: <4350C4F6.4030807@yahoo.com.au>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1EQkpc-0007FI-00@gondolin.me.apana.org.au>
Date: Sat, 15 Oct 2005 22:08:08 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
> Well yes, that's on the store side (1, above). However can't a CPU
> still speculatively (eg. guess the branch) load the page->flags
> cacheline which might be satisfied from memory before the page->count
> cacheline loads? Ie. you can still have the correct write ordering
> but have incorrect read ordering?
> 
> Because neither PageDirty nor page_count is a barrier, and there is
> no read barrier between them.

Yes you're right.  A read barrier is required here.

I think Ben was actually agreeing with you.  He's just questioning
whether the corresponding write barrier existed on CPU 1 (the answer
to which is affirmative).
 
Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
