Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030335AbVI3P05@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030335AbVI3P05 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 11:26:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030336AbVI3P05
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 11:26:57 -0400
Received: from amsfep13-int.chello.nl ([213.46.243.23]:9800 "EHLO
	amsfep13-int.chello.nl") by vger.kernel.org with ESMTP
	id S1030335AbVI3P04 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 11:26:56 -0400
Subject: Re: [PATCH 0/7] CART - an advanced page replacement policy
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Paul.McKenney@us.ibm.com, Bill Davidsen <davidsen@tmr.com>
Cc: linux-mm@kvack.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <433C4343.20205@tmr.com>
References: <20050929180845.910895444@twins>  <433C4343.20205@tmr.com>
Content-Type: text/plain
Date: Fri, 30 Sep 2005 17:26:32 +0200
Message-Id: <1128093992.14695.22.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-09-29 at 15:40 -0400, Bill Davidsen wrote:
> Peter Zijlstra wrote:
> > Multiple memory zone CART implementation for Linux.
> > An advanced page replacement policy.
> > 
> > http://www.almaden.ibm.com/cs/people/dmodha/clockfast.pdf
> > (IBM does hold patent rights to the base algorithm ARC)
> 
> Peter, this is a large patch, perhaps you could describe what configs 
> benefit, 

All those that use swap. Those that exploit the weak side of LRU more
than others.

CART is an adaptive algorithm that will act like LFU on one side and LRU
on the other, capturing both behaviours. Therefore it is also scan
proof, eg. 'use once' scans should not flush the full cache.

Hence people with LFU friendly applications will see an improvement
while those who have an LRU friendly application should see no decrease
in swap performance.

Non of the algorithms handle cyclic access very well, that is what patch
5 tries to tackle.

> how much, 

In the cyclic case (n+a: a << n) I've seen speedups of over 300%. Other
cases much less. However I've yet to encounter a case where it gives
worse performance.

I'm still constructing some corner case tests to give more hard numbers.

> and what the right to use status of the patent might 
> be. 

AFAIK IBM allows Linux implementation of their patents.
See: http://news.com.com/IBM+pledges+no+patent+attacks+against+Linux/2100-7344_3-5296787.html

> In other words, why would a reader of LKML put in this patch and try it?
> The description of how it works is clear, but the problem solved isn't.

I hope to have answered these questions. If any questions still remain,
please let me know.

Kind regards,

Peter Zijlstra


-- 
Peter Zijlstra <a.p.zijlstra@chello.nl>

