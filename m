Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317688AbSFSALE>; Tue, 18 Jun 2002 20:11:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317689AbSFSALD>; Tue, 18 Jun 2002 20:11:03 -0400
Received: from mx2.elte.hu ([157.181.151.9]:1753 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S317688AbSFSALC>;
	Tue, 18 Jun 2002 20:11:02 -0400
Date: Wed, 19 Jun 2002 02:08:59 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Michael Hohnbaum <hohnbaum@us.ibm.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Robert Love <rml@tech9.net>,
       <linux-kernel@vger.kernel.org>, <colpatch@us.ibm.com>
Subject: Re: latest linus-2.5 BK broken
In-Reply-To: <Pine.LNX.4.44.0206190145580.28144-100000@e2>
Message-ID: <Pine.LNX.4.44.0206190201220.28144-100000@e2>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


another thought would be that the 'default' memory affinity can be derived
from the CPU affinity. A default process, one which is affine to all CPUs,
can have memory allocated from all memory nodes. A process which is bound
to a given set of CPUs, should get its memory allocated from the nodes
that 'belong' to those CPUs.

the topology might not be as simple as this, but generally it's the CPU
that drives the topology, so a given CPU affinity mask leads to a specific
'preferred memory nodes' bitmask - there isnt much choice needed on the
user's part, in fact it might be contraproductive to bind a process to
some CPU and bind its memory allocations to a very distant memory node.  
While mathematically there is not necesserily any 1:1 relationship between
CPU affinity and 'best memory affinity', technologically there is.

per-object affinity might still be possible under these scheme, it would
override whatever 'default' memory affinity is derived from the CPU
affinity mask. [that would enable for example for an important database
file to be locked to a given memory node, and helper processes executing
on distant CPUs will not cause a distant pagecache page to be allocated.]

another advantage is that this removes the burden from the application
writer, of having to figure out the actual memory topology and fitting the
CPU affinity to the memory affinity (and vice versa). The kernel can
figure out a good default memory affinity based on the CPU affinity mask.

(so everything so far points in the direction of having a simple CPU
affinity syscall, which we have now.)

	Ingo

