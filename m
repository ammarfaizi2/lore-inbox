Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266782AbUHOPLh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266782AbUHOPLh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 11:11:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266778AbUHOPLW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 11:11:22 -0400
Received: from holomorphy.com ([207.189.100.168]:17312 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266762AbUHOPKe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 11:10:34 -0400
Date: Sun, 15 Aug 2004 08:10:24 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Christoph Lameter <clameter@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: page fault fastpath: Increasing SMP scalability by introducing pte
Message-ID: <20040815151024.GI11200@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Manfred Spraul <manfred@colorfullife.com>,
	Christoph Lameter <clameter@sgi.com>, linux-kernel@vger.kernel.org
References: <411F7067.8040305@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <411F7067.8040305@colorfullife.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph wrote:
>> Well this is more an idea than a real patch yet. The page_table_lock
>> becomes a bottleneck if more than 4 CPUs are rapidly allocating and using
>> memory. "pft" is a program that measures the performance of page faults on
>> SMP system. It allocates memory simultaneously in multiple threads thereby
>> causing lots of page faults for anonymous pages.

On Sun, Aug 15, 2004 at 04:17:11PM +0200, Manfred Spraul wrote:
> Very odd. Why do you see a problem with the page_table_lock but no 
> problem from the mmap semaphore?
> The page fault codepath acquires both.
> How often is the page table lock acquired per page fault? Just once or 
> multiple spin_lock calls per page fault? Is the problem contention or 
> cache line trashing?
> Do you have profile/lockmeter output? Is the down_read() in 
> do_page_fault() a hot spot, too?

->mmap_sem would likely be useful to address as well. A different
structure for vma trees, more amenable to finegrained locking or
lockfree algorithms, would likely be useful there.


-- wli
