Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751407AbWFYGJ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751407AbWFYGJ3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 02:09:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751410AbWFYGJ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 02:09:29 -0400
Received: from liaag2ad.mx.compuserve.com ([149.174.40.155]:45528 "EHLO
	liaag2ad.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1751407AbWFYGJ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 02:09:28 -0400
Date: Sun, 25 Jun 2006 02:03:22 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: 2.6.17-mm1
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Martin Bligh <mbligh@google.com>
Message-ID: <200606250206_MC3-1-C35F-F5F7@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20060623143004.6af78d68.akpm@osdl.org>

On Fri, 23 Jun 2006 14:30:04 -0700, Andrew Morton wrote:

> On Fri, 23 Jun 2006 12:23:54 -0700
> Martin Bligh <mbligh@mbligh.org> wrote:
> 
> > On 16x NUMA-Q, got a panic running dbench across different fs's.

> > Got a very similar panic on a flat SMP box too:
> > 
> > BUG: unable to handle kernel paging request at virtual address 00100100

> And that's LIST_POISON1.
> 
> The only s_show()s I can see are in slab and in kallsyms.
> 
> It would help if you could gdb these guys, work out file-n-line.

It's definitely in slab, in one of the loops walking the full, partial
and free chains.

> 
> And it would be super-good if you could revert
> slab-stop-using-list_for_each.patch and retest.  

I don't think that's the problem.  It really looks like a corrupted list.

How does this keep showing up in slab all the time?  Broken locking?

And also, looking at the prefetching in the list macros, it can have the
same effect as list_for_each_safe -- _if_ the compiler decides to save
the pointer it passed to prefetch().  In this case it didn't...

-- 
Chuck
 "You can't read a newspaper if you can't read."  --George W. Bush
