Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263118AbUKTRGP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263118AbUKTRGP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 12:06:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263123AbUKTREt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 12:04:49 -0500
Received: from jade.aracnet.com ([216.99.193.136]:55211 "EHLO
	jade.spiritone.com") by vger.kernel.org with ESMTP id S263118AbUKTRBz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 12:01:55 -0500
Date: Sat, 20 Nov 2004 08:59:36 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>
cc: wli@holomorphy.com, torvalds@osdl.org, clameter@sgi.com,
       benh@kernel.crashing.org, hugh@veritas.com, linux-mm@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: page fault scalability patch V11 [0/7]: overview
Message-ID: <1834180000.1100969975@[10.10.2.4]>
In-Reply-To: <419EEE7F.3070509@yahoo.com.au>
References: <Pine.LNX.4.58.0411190704330.5145@schroedinger.engr.sgi.com>	<Pine.LNX.4.58.0411191155180.2222@ppc970.osdl.org>	<20041120020306.GA2714@holomorphy.com>	<419EBBE0.4010303@yahoo.com.au>	<20041120035510.GH2714@holomorphy.com>	<419EC205.5030604@yahoo.com.au>	<20041120042340.GJ2714@holomorphy.com>	<419EC829.4040704@yahoo.com.au>	<20041120053802.GL2714@holomorphy.com>	<419EDB21.3070707@yahoo.com.au>	<20041120062341.GM2714@holomorphy.com>	<419EE911.20205@yahoo.com.au> <20041119225701.0279f846.akpm@osdl.org> <419EEE7F.3070509@yahoo.com.au>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Given that we have contention problems updating a single mm-wide rss and
>> given that the way to fix that up is to spread things out a bit, it seems
>> wildly arbitrary to me that the way in which we choose to spread the
>> counter out is to stick a bit of it into each task_struct.
>> 
>> I'd expect that just shoving a pointer into mm_struct which points at a
>> dynamically allocated array[NR_CPUS] of longs would suffice.  We probably
>> don't even need to spread them out on cachelines - having four or eight
>> cpus sharing the same cacheline probably isn't going to hurt much.
>> 
>> At least, that'd be my first attempt.  If it's still not good enough, try
>> something else.
>> 
>> 
> 
> That is what Bill thought too. I guess per-cpu and per-thread rss are
> the leading candidates.
> 
> Per thread rss has the benefits of cacheline exclusivity, and not
> causing task bloat in the common case.
> 
> Per CPU array has better worst case /proc properties, but shares
> cachelines (or not, if using percpu_counter as you suggested).

Per thread seems much nicer to me - mainly because it degrades cleanly to 
a single counter for 99% of processes, which are single threaded.

M.

