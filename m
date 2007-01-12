Return-Path: <linux-kernel-owner+w=401wt.eu-S1030478AbXALFTa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030478AbXALFTa (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 00:19:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030480AbXALFTa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 00:19:30 -0500
Received: from smtp.osdl.org ([65.172.181.24]:33795 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030478AbXALFT3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 00:19:29 -0500
Date: Thu, 11 Jan 2007 21:18:52 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Bill Davidsen <davidsen@tmr.com>, Andrew Morton <akpm@osdl.org>,
       Hua Zhong <hzhong@gmail.com>, Hugh Dickins <hugh@veritas.com>,
       linux-kernel@vger.kernel.org, hch@infradead.org,
       kenneth.w.chen@intel.com, mjt@tls.msk.ru
Subject: Re: O_DIRECT question
In-Reply-To: <45A714F8.6020600@yahoo.com.au>
Message-ID: <Pine.LNX.4.64.0701112114580.3594@woody.osdl.org>
References: <6d6a94c50701101857v2af1e097xde69e592135e54ae@mail.gmail.com> 
 <Pine.LNX.4.64.0701101902270.3594@woody.osdl.org> 
 <6d6a94c50701102150w4c3b46d0w6981267e2b873d37@mail.gmail.com> 
 <20070110220603.f3685385.akpm@osdl.org>  <6d6a94c50701102245g6afe6aacxfcb2136baee5cbfa@mail.gmail.com>
  <20070110225720.7a46e702.akpm@osdl.org>  <45A5E1B2.2050908@yahoo.com.au>
 <6d6a94c50701102354l7ab41a3bp4761566204f1d992@mail.gmail.com>
 <45A5F157.9030001@yahoo.com.au> <45A6F70E.1050902@tmr.com> <45A70EF9.40408@yahoo.com.au>
 <Pine.LNX.4.64.0701112044070.3594@woody.osdl.org> <45A714F8.6020600@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 12 Jan 2007, Nick Piggin wrote:
> 
> Yeah *smallish* higher order allocations are fine, and we use them all the
> time for things like stacks or networking.
> 
> But Aubrey (who somehow got removed from the cc list) wants to do order 9
> allocations from userspace in his nommu environment. I'm just trying to be
> realistic when I say that this isn't going to be robust and a userspace
> solution is needed.

I do agree that order-9 allocations simply is unlikely to work without 
some pre-allocation notion or some serious work at active de-fragmentation 
(and the page cache is likely to be the _least_ of the problems people 
will hit - slab and other kernel allocations are likely to be much much 
harder to handle, since you can't free them in quite as directed a 
manner).

But for smallish-order (eg perhaps 3-4 possibly even more if you are 
careful in other places), the page cache limiter may well be a "good 
enough" solution in practice, especially if other allocations can be 
controlled by strict usage patterns (which is not realistic in a general- 
purpose kind of situation, but might be realistic in embedded).

		Linus
