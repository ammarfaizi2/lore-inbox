Return-Path: <linux-kernel-owner+w=401wt.eu-S1750729AbXAKPvG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750729AbXAKPvG (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 10:51:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750738AbXAKPvG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 10:51:06 -0500
Received: from smtp.osdl.org ([65.172.181.24]:41753 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750729AbXAKPvF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 10:51:05 -0500
Date: Thu, 11 Jan 2007 07:50:26 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Aubrey <aubreylee@gmail.com>, Hua Zhong <hzhong@gmail.com>,
       Hugh Dickins <hugh@veritas.com>, linux-kernel@vger.kernel.org,
       hch@infradead.org, kenneth.w.chen@intel.com, akpm@osdl.org,
       mjt@tls.msk.ru
Subject: Re: O_DIRECT question
In-Reply-To: <45A5D4A7.7020202@yahoo.com.au>
Message-ID: <Pine.LNX.4.64.0701110746360.3594@woody.osdl.org>
References: <6d6a94c50701101857v2af1e097xde69e592135e54ae@mail.gmail.com>
 <Pine.LNX.4.64.0701101902270.3594@woody.osdl.org>
 <Pine.LNX.4.64.0701101910110.3594@woody.osdl.org> <45A5D4A7.7020202@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 11 Jan 2007, Nick Piggin wrote:
> 
> Speaking of which, why did we obsolete raw devices? And/or why not just
> go with a minimal O_DIRECT on block device support? Not a rhetorical
> question -- I wasn't involved in the discussions when they happened, so
> I would be interested.

Lots of people want to put their databases in a file. Partitions really 
weren't nearly flexible enough. So the whole raw device or O_DIRECT just 
to the block device thing isn't really helping any.

> O_DIRECT is still crazily racy versus pagecache operations.

Yes. O_DIRECT is really fundamentally broken. There's just no way to fix 
it sanely. Except by teaching people not to use it, and making the normal 
paths fast enough (and that _includes_ doing things like dropping caches 
more aggressively, but it probably would include more work on the device 
queue merging stuff etc etc).

The "good" news is that CPU really is outperforming disk more and more, so 
the extra cost of managing the page cache keeps on getting smaller and 
smaller, and (fingers crossed) some day we can hopefully just drop 
O_DIRECT and nobody will care.

		Linus
