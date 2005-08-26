Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965148AbVHZRyA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965148AbVHZRyA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 13:54:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965149AbVHZRx7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 13:53:59 -0400
Received: from mx1.redhat.com ([66.187.233.31]:59800 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965148AbVHZRx7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 13:53:59 -0400
Date: Fri, 26 Aug 2005 13:53:26 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@cuia.boston.redhat.com
To: Ray Fucillo <fucillo@intersystems.com>
cc: Nick Piggin <nickpiggin@yahoo.com.au>, Hugh Dickins <hugh@veritas.com>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: process creation time increases linearly with shmem
In-Reply-To: <430F4A9E.3060903@intersystems.com>
Message-ID: <Pine.LNX.4.63.0508261349550.25015@cuia.boston.redhat.com>
References: <430CBFD1.7020101@intersystems.com> <430D0D6B.100@yahoo.com.au>
 <Pine.LNX.4.63.0508251331040.25774@cuia.boston.redhat.com>
 <430E6FD4.9060102@yahoo.com.au> <Pine.LNX.4.58.0508252055370.3317@g5.osdl.org>
 <Pine.LNX.4.61.0508261220230.4697@goblin.wat.veritas.com> <430F26AA.80901@yahoo.com.au>
 <430F4A9E.3060903@intersystems.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Aug 2005, Ray Fucillo wrote:

> However, there is still a need that the child, once successfully forked, is
> operational reasonably quickly.  I suspect that Ross's idea of paging in
> everything after the first fault would not be optimal for us, because we'd
> still be talking about hundreds of ms of work done before the child does
> anything useful. 

Simply skipping the page table setup of MAP_SHARED regions
should be enough to fix this issue.

> It would still be far better than the behavior we have today because 
> that time would no longer be synchronous with the fork().

Filling in all the page table entries at the first fault to
a VMA doesn't make much sense, IMHO.

The reason I think this is that people have experimented
with prefaulting already resident pages at page fault time,
and those experiments have never shown a conclusive benefit.

Now, if doing such prefaulting for normal processes does not
show a benefit - why would it be beneficial to recently forked
processes with a huge SHM area ?

I suspect we would be better off without that extra complexity,
unless there is a demonstrated benefit to it.

-- 
All Rights Reversed
