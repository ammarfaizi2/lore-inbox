Return-Path: <linux-kernel-owner+w=401wt.eu-S1030422AbXALVS5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030422AbXALVS5 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 16:18:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030504AbXALVS5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 16:18:57 -0500
Received: from smtp.osdl.org ([65.172.181.24]:34591 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030422AbXALVS4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 16:18:56 -0500
Date: Fri, 12 Jan 2007 16:17:38 -0500 (EST)
From: Linus Torvalds <torvalds@osdl.org>
To: Michael Tokarev <mjt@tls.msk.ru>
cc: Chris Mason <chris.mason@oracle.com>, dean gaudet <dean@arctic.org>,
       Viktor <vvp01@inbox.ru>, Aubrey <aubreylee@gmail.com>,
       Hua Zhong <hzhong@gmail.com>, Hugh Dickins <hugh@veritas.com>,
       linux-kernel@vger.kernel.org, hch@infradead.org,
       kenneth.w.chen@intel.com, akpm@osdl.org
Subject: Re: O_DIRECT question
In-Reply-To: <45A7F7A7.1080108@tls.msk.ru>
Message-ID: <Pine.LNX.4.64.0701121611370.3470@woody.osdl.org>
References: <6d6a94c50701101857v2af1e097xde69e592135e54ae@mail.gmail.com>
 <Pine.LNX.4.64.0701101902270.3594@woody.osdl.org> <45A629E9.70502@inbox.ru>
 <Pine.LNX.4.64.0701110750520.3594@woody.osdl.org>
 <Pine.LNX.4.64.0701112351520.18431@twinlark.arctic.org>
 <Pine.LNX.4.64.0701120955440.3594@woody.osdl.org> <20070112202316.GA28400@think.oraclecorp.com>
 <45A7F396.4080600@tls.msk.ru> <45A7F4F2.2080903@tls.msk.ru>
 <45A7F7A7.1080108@tls.msk.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 13 Jan 2007, Michael Tokarev wrote:
> 
> (No, really - this load isn't entirely synthetic.  It's a typical database
> workload - random I/O all over, on a large file.  If it can, it combines
> several I/Os into one, by requesting more than a single block at a time,
> but overall it is random.)

My point is that you can get basically ALL THE SAME GOOD BEHAVIOUR without 
having all the BAD behaviour that O_DIRECT adds.

For example, just the requirement that O_DIRECT can never create a file 
mapping, and can never interact with ftruncate would actually make 
O_DIRECT a lot more palatable to me. Together with just the requirement 
that an O_DIRECT open would literally disallow any non-O_DIRECT accesses, 
and flush the page cache entirely, would make all the aliases go away.

At that point, O_DIRECT would be a way of saying "we're going to do 
uncached accesses to this pre-allocated file". Which is a half-way 
sensible thing to do.

But what O_DIRECT does right now is _not_ really sensible, and the 
O_DIRECT propeller-heads seem to have some problem even admitting that 
there _is_ a problem, because they don't care. 

A lot of DB people seem to simply not care about security or anything 
else.anything else. I'm trying to tell you that quoting numbers is 
pointless, when simply the CORRECTNESS of O_DIRECT is very much in doubt.

I can calculate PI to a billion decimal places in my head in .1 seconds. 
If you don't care about the CORRECTNESS of the result, that is.

See? It's not about performance. It's about O_DIRECT being fundamentally 
broken as it behaves right now.

		Linus
