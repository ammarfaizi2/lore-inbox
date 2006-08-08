Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964771AbWHHJ6M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964771AbWHHJ6M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 05:58:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964773AbWHHJ6M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 05:58:12 -0400
Received: from ns2.suse.de ([195.135.220.15]:3498 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964772AbWHHJ6L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 05:58:11 -0400
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Cc: "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>,
       pravin b shelar <pravin.shelar@calsoftinc.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] NUMA futex hashing
References: <20060808070708.GA3931@localhost.localdomain>
From: Andi Kleen <ak@suse.de>
Date: 08 Aug 2006 11:57:59 +0200
In-Reply-To: <20060808070708.GA3931@localhost.localdomain>
Message-ID: <p73bqqvpn14.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ravikiran G Thirumalai <kiran@scalex86.org> writes:

> Current futex hash scheme is not the best for NUMA.   The futex hash table is 
> an array of struct futex_hash_bucket, which is just a spinlock and a 
> list_head -- this means multiple spinlocks on the same cacheline and on NUMA 
> machines, on the same internode cacheline.  If futexes of two unrelated 
> threads running on two different nodes happen to hash onto adjacent hash 
> buckets, or buckets on the same internode cacheline, then we have the 
> internode cacheline bouncing between nodes.

When I did some testing with a (arguably far too lock intensive) benchmark
on a bigger box I got most bouncing cycles not in the futex locks itself,
but in the down_read on the mm semaphore.

I guess that is not addressed?

-Andi
