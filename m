Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261846AbTE2CKL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 22:10:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261847AbTE2CKL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 22:10:11 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:146 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S261846AbTE2CKK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 22:10:10 -0400
Date: Wed, 28 May 2003 19:23:30 -0700
From: Andrew Morton <akpm@digeo.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: kiran@in.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] Inline vm_acct_memory
Message-Id: <20030528192330.77d3d9e9.akpm@digeo.com>
In-Reply-To: <Pine.LNX.4.44.0305281631030.1240-100000@localhost.localdomain>
References: <20030528110552.GF5604@in.ibm.com>
	<Pine.LNX.4.44.0305281631030.1240-100000@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 May 2003 02:23:27.0399 (UTC) FILETIME=[49B71B70:01C32589]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins <hugh@veritas.com> wrote:
>
> On Wed, 28 May 2003, Ravikiran G Thirumalai wrote:
> > I found that inlining vm_acct_memory speeds up vm_enough_memory.  
> > Since vm_acct_memory is only called by vm_enough_memory,
> 
> No, linux/mman.h declares
> 
> static inline void vm_unacct_memory(long pages)
> {
> 	vm_acct_memory(-pages);
> }
> 
> and I count 18 callsites for vm_unacct_memory.
> 
> I'm no judge of what's worth inlining, but Andrew is widely known
> and feared as The Scourge of Inliners, so I'd advise you to hide...

Maybe I'm wrong.  kernbench is not some silly tight-loop microbenchmark. 
It is a "real" workload: gcc.

The thing about pagetable setup and teardown is that it tends to be called
in big lumps: for a while the process is establishing thousands of pages
and then later it is tearing down thousands.  So the cache-thrashing impact
of having those eighteen instances sprinkled around the place is less
than it would be if they were all being called randomly.  If you can believe
such waffle.

Kiran, do you still have the raw data available?  profiles and runtimes?
