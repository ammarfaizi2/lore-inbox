Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267612AbSLFGsZ>; Fri, 6 Dec 2002 01:48:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267613AbSLFGsZ>; Fri, 6 Dec 2002 01:48:25 -0500
Received: from packet.digeo.com ([12.110.80.53]:16556 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267612AbSLFGsY>;
	Fri, 6 Dec 2002 01:48:24 -0500
Message-ID: <3DF049F9.6F83D13@digeo.com>
Date: Thu, 05 Dec 2002 22:55:53 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: William Lee Irwin III <wli@holomorphy.com>,
       Norman Gaywood <norm@turing.une.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: Maybe a VM bug in 2.4.18-18 from RH 8.0?
References: <20021206111326.B7232@turing.une.edu.au> <3DEFF69F.481AB823@digeo.com> <20021206011733.GF1567@dualathlon.random> <3DEFFEAA.6B386051@digeo.com> <20021206014429.GI1567@dualathlon.random> <20021206021559.GK9882@holomorphy.com> <20021206022853.GJ1567@dualathlon.random> <20021206024140.GL9882@holomorphy.com> <3DF034BB.D5F863B5@digeo.com> <20021206054804.GK1567@dualathlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Dec 2002 06:55:54.0210 (UTC) FILETIME=[854C0420:01C29CF4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> the
> algorithm is autotuned at boot and depends on the zone sizes, and it
> applies to the dma zone too with respect to the normal zone, the highmem
> case is just one of the cases that the fix for the general problem
> resolves,

Linus's incremental min will protect ZONE_DMA in the same manner.

> and you're totally wrong saying that mlocking 700m on a 4G box
> could kill it.

It is possible to mlock 700M of the normal zone on a 4G -aa kernel.
I can't immediately think of anything apart from vma's which will
make it fall over, but it will run like crap.

> 2.5 misses this important fix too btw.

It does not appear to be an important fix at all.  There have been
zero reports of it on any mailing list which I read since the google
days.

Yes, it needs to be addressed.  But it is not worth taking 100 megabytes
of pagecache away from everyone.  That is just a matter of choosing
the default value.

2.5 has much bigger problems than this - radix_tree nodes and pte_chains
in particular.
