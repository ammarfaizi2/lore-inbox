Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263897AbTGAVcZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 17:32:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263875AbTGAVcY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 17:32:24 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:30357 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S263897AbTGAVcK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 17:32:10 -0400
Date: Tue, 1 Jul 2003 22:46:31 +0100 (IST)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: Andrea Arcangeli <andrea@suse.de>
Cc: Linux Memory Management List <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: What to expect with the 2.6 VM
In-Reply-To: <20030701022516.GL3040@dualathlon.random>
Message-ID: <Pine.LNX.4.53.0307012236310.16265@skynet>
References: <Pine.LNX.4.53.0307010238210.22576@skynet>
 <20030701022516.GL3040@dualathlon.random>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Jul 2003, Andrea Arcangeli wrote:

> On Tue, Jul 01, 2003 at 02:39:47AM +0100, Mel Gorman wrote:
> >    Reverse Page Table Mapping
> >    ==========================
> >
> > <rmap stuff snipped>
>
> you mention only the positive things, and never the fact that's the most
> hurting piece of kernel code in terms of performance and smp scalability
> until you actually have to swapout or pageout.
>

You're right, I was commenting only on the positive side of things. I
didn't pay close enough attention to the development of the 2.5 series so
right now I can only comment on whats there and only to a small extent on
what it means or why it might be a bad thing. Here goes a more balanced
view...

Based on what I can decipher from this thread and other rmap related
threads, I've added this to the end of the rmap section. I'm still working
on the non-linear issues. It'll probably take me another day or two to get
that together.

--Begin Extract--
   There are two main benefits, both page-out related, with the introduction
   of reverse mapping. The first is with the management of page tables. In
   2.4, anonymous shared pages had to be placed in a swap cache until all
   references has been found. This could result in a large number of minor
   faults as page adjacent in virtual space were moved to the swap cache
   resulting in unnecessary page table updates. The second benefit is with
   the actual paging out mechanism. 2.6 is much better at selecting the
   correct page and atomically swapping it out from each virtual address
   space.

   Reverse mapping is not free though. The first obvious penalty is the space
   requirements for PTE chains. The space requirements will obviously depend
   on the number of shared pages, especially anonymous pages, in the system.
   There was patches submitted for the sharing of page tables but it was not
   merged into the mainline kernel. The second penalty is the CPU time
   required to maintain the mappings but no figures are available to measure
   how severe this is. The last point to note is that reverse mapping is only
   of benefit when page-outs are frequent which is mainly the case with
   lower-end machines. With large memory machines or with workloads that do
   not cause much swapping, there is only costs to reverse mapping but no
   benefits.
--End Extract--

-- 
Mel Gorman
