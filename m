Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262884AbTEGGMS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 02:12:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262890AbTEGGMS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 02:12:18 -0400
Received: from franka.aracnet.com ([216.99.193.44]:6017 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S262884AbTEGGMR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 02:12:17 -0400
Date: Tue, 06 May 2003 21:10:24 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: William Lee Irwin III <wli@holomorphy.com>,
       Paul Mackerras <paulus@samba.org>
cc: Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@digeo.com>,
       dipankar@in.ibm.com, linux-kernel@vger.kernel.org,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: [PATCH] kmalloc_percpu
Message-ID: <4960000.1052280622@[10.10.2.4]>
In-Reply-To: <20030507051901.GY8978@holomorphy.com>
References: <20030506014745.02508f0d.akpm@digeo.com> <20030507023126.12F702C019@lists.samba.org> <20030507024135.GW8978@holomorphy.com> <16056.34210.319959.255815@argo.ozlabs.ibm.com> <20030507042250.GX8978@holomorphy.com> <16056.37397.694764.303333@argo.ozlabs.ibm.com> <20030507051901.GY8978@holomorphy.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Same address mapped differently on different cpus is what I thought
>>> you meant. It does make sense, and besides, it only really matters
>>> when the thing is being switched in, so I think it's not such a big
>>> deal. e.g. mark per-thread mm context with the cpu it was prepped for,
>>> if they don't match at load-time then reset the kernel pmd's pgd entry
>>> in the per-thread pgd at the top level. x86 blows away the TLB at the
> 
> On Wed, May 07, 2003 at 02:56:53PM +1000, Paul Mackerras wrote:
>> Having to have a pgdir per thread would be a bit sucky, wouldn't it?
> 
> Not as bad as it initially sounds; on non-PAE i386, it's 4KB and would
> hurt. On PAE i386, it's 32B and can be shoehorned, say, in thread_info.
> Then the rest is just a per-cpu kernel pmd and properly handling vmalloc
> faults (which are already handled properly for non-PAE vmallocspace).
> There might be other reasons to do it, like reducing the virtualspace
> overhead of the atomic kmap area, but it's not really time yet.

Even if the space isn't a problem, having a full TLB flush on thread 
context switch sounds sucky. Per-node is sufficient for most things,
and is much cheaper (update on cross-node migrate). 

M.

