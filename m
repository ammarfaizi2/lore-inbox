Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286443AbRLTW5k>; Thu, 20 Dec 2001 17:57:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286458AbRLTW5a>; Thu, 20 Dec 2001 17:57:30 -0500
Received: from mailout11.sul.t-online.com ([194.25.134.85]:42180 "EHLO
	mailout11.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S286457AbRLTW5R>; Thu, 20 Dec 2001 17:57:17 -0500
Date: Thu, 20 Dec 2001 23:56:48 +0100
From: Andi Kleen <ak@muc.de>
To: James Cleverdon <jamesclv@us.ibm.com>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>, mingo@elte.hu
Subject: Re: [PATCH] MAX_MP_BUSSES increase
Message-ID: <20011220235648.A1663@averell>
In-Reply-To: <Pine.LNX.4.33.0112192154190.19321-100000@penguin.transmeta.com> <Pine.LNX.4.33.0112201405550.6212-100000@localhost.localdomain> <m3y9jxesd3.fsf@averell.firstfloor.org> <200112202229.fBKMTXq06694@butler1.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <200112202229.fBKMTXq06694@butler1.beaverton.ibm.com>; from jamesclv@us.ibm.com on Thu, Dec 20, 2001 at 11:29:32PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2001 at 11:29:32PM +0100, James Cleverdon wrote:
> Thanks to all who replied.  My rationale for simply increasing the size of 
> static arrays was to have a minimum impact on 2.4, as well as to make 
> something that Cannot Fail(TM).  If you like, I could make one for 2.5 that 
> would do an initial scan of the MPS table, allocate the arrays using the 
> bootmem allocator, then go about its business as usual.  (Special offer for a 
> limited time only!  mpc_* array overflow checking added at NO EXTRA CHARGE!!  
> ;^)

Shouldn't be that hard. In the worst case I can do it, but I don't have
hardware to test it properly. 

> 
> The catch with bootmem allocation is that it only allocates in pages (unless 
> wli's new bootmem allocator is adopted).  So, expect some extra memory to be 
> lost to internal fragmentation anyway.

I don't think that's true, unless I'm misreading the code in 
__alloc_bootmem_core badly. It may not be the most fragmentation avoiding 
allocator in the world, but for linear allocations with no frees it shouldn't
waste space. 

> Another suggestion through private mail was to make MAX_MP_BUSSES a tunable 
> config parameter.  I didn't know about that.  Early boot stuff should work 
> without fuss, not rely on config tweaks.  At the very least, I'd have to add 
> array overflow checking, because this crashes before the console is opened or 
> kdb is initialized.  Silent crashes like that are bad news.

I agree that it shouldn't be tunable. 

-Andi
-- 
Life would be so much easier if we could just look at the source code.
