Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262891AbUKTHN2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262891AbUKTHN2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 02:13:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261692AbUKTHNX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 02:13:23 -0500
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:11099 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263004AbUKTHNI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 02:13:08 -0500
Message-ID: <419EEE7F.3070509@yahoo.com.au>
Date: Sat, 20 Nov 2004 18:13:03 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: wli@holomorphy.com, torvalds@osdl.org, clameter@sgi.com,
       benh@kernel.crashing.org, hugh@veritas.com, linux-mm@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: page fault scalability patch V11 [0/7]: overview
References: <Pine.LNX.4.58.0411190704330.5145@schroedinger.engr.sgi.com>	<Pine.LNX.4.58.0411191155180.2222@ppc970.osdl.org>	<20041120020306.GA2714@holomorphy.com>	<419EBBE0.4010303@yahoo.com.au>	<20041120035510.GH2714@holomorphy.com>	<419EC205.5030604@yahoo.com.au>	<20041120042340.GJ2714@holomorphy.com>	<419EC829.4040704@yahoo.com.au>	<20041120053802.GL2714@holomorphy.com>	<419EDB21.3070707@yahoo.com.au>	<20041120062341.GM2714@holomorphy.com>	<419EE911.20205@yahoo.com.au> <20041119225701.0279f846.akpm@osdl.org>
In-Reply-To: <20041119225701.0279f846.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
>>per thread rss
> 
> 
> Given that we have contention problems updating a single mm-wide rss and
> given that the way to fix that up is to spread things out a bit, it seems
> wildly arbitrary to me that the way in which we choose to spread the
> counter out is to stick a bit of it into each task_struct.
> 
> I'd expect that just shoving a pointer into mm_struct which points at a
> dynamically allocated array[NR_CPUS] of longs would suffice.  We probably
> don't even need to spread them out on cachelines - having four or eight
> cpus sharing the same cacheline probably isn't going to hurt much.
> 
> At least, that'd be my first attempt.  If it's still not good enough, try
> something else.
> 
> 

That is what Bill thought too. I guess per-cpu and per-thread rss are
the leading candidates.

Per thread rss has the benefits of cacheline exclusivity, and not
causing task bloat in the common case.

Per CPU array has better worst case /proc properties, but shares
cachelines (or not, if using percpu_counter as you suggested).


I think I'd better leave it to others to finish off the arguments ;)
