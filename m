Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317308AbSIEIgz>; Thu, 5 Sep 2002 04:36:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317326AbSIEIgy>; Thu, 5 Sep 2002 04:36:54 -0400
Received: from holomorphy.com ([66.224.33.161]:63913 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S317308AbSIEIgx>;
	Thu, 5 Sep 2002 04:36:53 -0400
Date: Thu, 5 Sep 2002 01:32:40 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] __write_lock_failed() oops
Message-ID: <20020905083240.GC888@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
References: <20020905080310.GF18800@holomorphy.com> <3D77190C.F4562547@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <3D77190C.F4562547@zip.com.au>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
>> After running 64 simultaneous tiobench 256's a few times,
>> I get the following oops, which I've been seeing intermittently
>> for a number of 2.5.x releases (since 2.5.x booted on NUMA-Q):
>> Program received signal SIGSEGV, Segmentation fault.
>> 0xc0106693 in __write_lock_failed () at semaphore.c:176
>> 176     semaphore.c: No such file or directory.
>>         in semaphore.c

On Thu, Sep 05, 2002 at 01:42:52AM -0700, Andrew Morton wrote:
> That's all the assembly hacks in the rwlock code not having proper
> stack frames.  You may have to ksymoops it.
> At a guess: use-after-free bug against an address_space.  You may
> be able to catch it with slab poisoning.

(gdb) p/x $eax
$25 = 0xc0331ca0
(gdb) p &tasklist_lock
$27 = (rwlock_t *) 0xc0331ca0


Cheers,
Bill
