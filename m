Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264643AbUFRVwq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264643AbUFRVwq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 17:52:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264641AbUFRVts
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 17:49:48 -0400
Received: from cfcafw.sgi.com ([198.149.23.1]:31380 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S264527AbUFRVpB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 17:45:01 -0400
From: Dimitri Sivanich <sivanich@sgi.com>
Message-Id: <200406182144.i5ILiIFG001492@fsgi142.americas.sgi.com>
Subject: Re: [PATCH]: Option to run cache reap in thread mode
To: manfred@colorfullife.com (Manfred Spraul)
Date: Fri, 18 Jun 2004 16:44:18 -0500 (CDT)
Cc: akpm@osdl.org (Andrew Morton), sivanich@sgi.com (Dimitri Sivanich),
       linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net,
       linux-mm@kvack.org
In-Reply-To: <40D358C5.9060003@colorfullife.com> from "Manfred Spraul" at Jun 18, 2004 11:04:05 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> I'll write something:
> - allow to disable the DMA kmalloc caches for archs that do not need them.
> - increase the timer frequency and scan only a few caches in each timer.
> - perhaps a quicker test for cache_reap to notice that nothing needs to 
> be done. Right now four tests are done (!flags & _NO_REAP, 
> ac->touched==0, ac->avail != 0, global timer not yet expired). It's 
> possible to skip some tests. e.g. move the _NO_REAP caches on a separate 
> list, replace the time_after(.next_reap,jiffies) with a separate timer.
> 
> --
>     Manfred
>
Thanks for addressing this.  Sounds like some good improvements overall.

One question though:  What about possible spinlock contention issues in the
cache_reap timer processing, or is that unlikely here (even on a heavily loaded
system with a large number of CPUs)?

Dimitri Sivanich <sivanich@sgi.com>
