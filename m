Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318968AbSICXyt>; Tue, 3 Sep 2002 19:54:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318983AbSICXyt>; Tue, 3 Sep 2002 19:54:49 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:54446 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S318968AbSICXys>;
	Tue, 3 Sep 2002 19:54:48 -0400
Message-ID: <3D754BAE.4020402@us.ibm.com>
Date: Tue, 03 Sep 2002 16:54:22 -0700
From: Michael Hohnbaum <hohnbaum@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [patch] "fully HT-aware scheduler" support, 2.5.31-BK-curr
References: <Pine.LNX.4.44.0208270226190.12947-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> symmetric multithreading (hyperthreading) is an interesting new concept
> that IMO deserves full scheduler support. Physical CPUs can have multiple
> (typically 2) logical CPUs embedded, and can run multiple tasks 'in
> parallel' by utilizing fast hardware-based context-switching between the
> two register sets upon things like cache-misses or special instructions.
> To the OSs the logical CPUs are almost undistinguishable from physical
> CPUs. In fact the current scheduler treats each logical CPU as a separate
> physical CPU - which works but does not maximize multiprocessing
> performance on SMT/HT boxes.
> 
  ...
> 
> There's a single flexible interface for lowlevel boot code to set up
> physical CPUs: sched_map_runqueue(cpu1, cpu2) maps cpu2 into cpu1's
> runqueue. The patch also implements the lowlevel bits for P4 HT boxes for
> the 2/package case.
> 
> (NUMA systems which have tightly coupled CPUs with a smaller cache and
> protected by a large L3 cache might benefit from sharing the runqueue as
> well - but the target for this concept is SMT.)
>

Sharing a runqueue for all processors on a node of a NUMA system has the
drawback of not accounting for cache warmth for processes.  Ideally, for
a NUMA system there should continue to be individual runqueues per cpu
(or per set of HT processors), and then a grouping of runqueues at the
node level.  At load balancing, priority should be to redispatch on the
same processor, followed by on the same node.  The pain threshold for
crossing the node boundary will vary depending on the NUMA-ness of the
hardware, so it would be good to account for this in the scheduler.

Erich Focht has a large patch to the O(1) scheduler that implements
this type of scheduling hierarchy.  Have you had an opportunity to look
it over?  What do you think about getting portions of this into the
O(1) scheduler?
> 
> Testreports, comments, suggestions welcome,
> 
> 	Ingo
> 

           Michael Hohnbaum
           hohnbaum@us.ibm.com


