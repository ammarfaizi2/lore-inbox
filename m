Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422718AbVLONDr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422718AbVLONDr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 08:03:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422716AbVLONDr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 08:03:47 -0500
Received: from mail28.syd.optusnet.com.au ([211.29.133.169]:28854 "EHLO
	mail28.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1422712AbVLONDp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 08:03:45 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [RFC] Fine-grained memory priorities and PI
Date: Fri, 16 Dec 2005 00:02:48 +1100
User-Agent: KMail/1.9
Cc: "David S. Miller" <davem@davemloft.net>, sri@us.ibm.com, mpm@selenic.com,
       ak@suse.de, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20051215033937.GC11856@waste.org> <200512152345.25375.kernel@kolivas.org> <8803F1D1-E647-45A3-B2A4-E3C95AAC11C6@mac.com>
In-Reply-To: <8803F1D1-E647-45A3-B2A4-E3C95AAC11C6@mac.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512160002.49096.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 15 December 2005 23:58, Kyle Moffett wrote:
> On Dec 15, 2005, at 07:45, Con Kolivas wrote:
> > I have some basic process-that-called the memory allocator link in
> > the -ck tree already which alters how aggressively memory is
> > reclaimed according to priority. It does not affect out of memory
> > management but that could be added to said algorithm; however I
> > don't see much point at the moment since oom is still an uncommon
> > condition but regular memory allocation is routine.
>
> My thought would be to generalize the two special cases of writeback
> of dirty pages or dropping of clean pages under memory pressure and
> OOM to be the same general case.  When you are trying to free up
> pages, it may be permissible to drop dirty mbox pages and kill the
> postfix process writing them in order to satisfy allocations for the
> mission-critical database server.  (Or maybe it's the other way
> around).  If a large chunk of the allocated pages have priorities and
> lossless/lossy free functions, then the kernel can be much more
> flexible and configurable about what to do when running low on RAM.

Indeed the implementation I currently have is lightweight to say the least but 
I really didn't think bloating struct page was worth it since the memory cost 
would be prohibitive, but would allow all sorts of priority effects and vm 
scheduling to be possible. That is, struct page could have an extra entry 
keeping track of the highest priority of the process that used it and use 
that to determine further eviction etc.

Cheers,
Con
