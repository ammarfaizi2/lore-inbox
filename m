Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964996AbWHHQtb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964996AbWHHQtb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 12:49:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964997AbWHHQtb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 12:49:31 -0400
Received: from pfx2.jmh.fr ([194.153.89.55]:3243 "EHLO pfx2.jmh.fr")
	by vger.kernel.org with ESMTP id S964996AbWHHQta (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 12:49:30 -0400
From: Eric Dumazet <dada1@cosmosbay.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [RFC] NUMA futex hashing
Date: Tue, 8 Aug 2006 18:49:28 +0200
User-Agent: KMail/1.9.1
Cc: Ulrich Drepper <drepper@gmail.com>, Andi Kleen <ak@suse.de>,
       Ravikiran G Thirumalai <kiran@scalex86.org>,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>,
       pravin b shelar <pravin.shelar@calsoftinc.com>,
       linux-kernel@vger.kernel.org
References: <20060808070708.GA3931@localhost.localdomain> <200608081808.34708.dada1@cosmosbay.com> <44D8BD29.4010102@yahoo.com.au>
In-Reply-To: <44D8BD29.4010102@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608081849.28458.dada1@cosmosbay.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 08 August 2006 18:34, Nick Piggin wrote:
> Eric Dumazet wrote:
> > We certainly can. But if you insist of using mmap sem at all, then we
> > have a problem.
> >
> > rbtree would not reduce cacheline bouncing, so :
> >
> > We could use a hashtable (allocated on demand) of size N, N depending on
> > NR_CPUS for example. each chain protected by a private spinlock. If N is
> > well chosen, we might reduce lock cacheline bouncing. (different threads
> > fighting on different private futexes would have a good chance to get
> > different cachelines in this hashtable)
>
> See other mail. We already have a hash table ;)

Yes but still you want at FUTEX_WAIT time to tell the kernel the futex is 
private to this process.

Giving the same info at FUTEX_WAKE time could avoid the kernel to make the 
second pass (using only a private futex lookup), avoiding again the mmap_sem 
touch in case no threads are waiting anymore on this futex.

Eric
