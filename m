Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965093AbVHZQgn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965093AbVHZQgn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 12:36:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965102AbVHZQgn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 12:36:43 -0400
Received: from silver.veritas.com ([143.127.12.111]:21390 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S965093AbVHZQgm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 12:36:42 -0400
Date: Fri, 26 Aug 2005 17:38:37 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Ross Biro <ross.biro@gmail.com>
cc: Linus Torvalds <torvalds@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Rik van Riel <riel@redhat.com>, Ray Fucillo <fucillo@intersystems.com>,
       linux-kernel@vger.kernel.org
Subject: Re: process creation time increases linearly with shmem
In-Reply-To: <8783be660508260915524e2b1e@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0508261735360.7589@goblin.wat.veritas.com>
References: <430CBFD1.7020101@intersystems.com> <430D0D6B.100@yahoo.com.au>
  <Pine.LNX.4.63.0508251331040.25774@cuia.boston.redhat.com> 
 <430E6FD4.9060102@yahoo.com.au>  <Pine.LNX.4.58.0508252055370.3317@g5.osdl.org>
  <Pine.LNX.4.61.0508261220230.4697@goblin.wat.veritas.com>
 <8783be660508260915524e2b1e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 26 Aug 2005 16:36:38.0105 (UTC) FILETIME=[547BF490:01C5AA5C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Aug 2005, Ross Biro wrote:
> On 8/26/05, Hugh Dickins <hugh@veritas.com> wrote:
> > 
> > The refaulting will hurt the performance of something: let's
> > just hope that something doesn't turn out to be a show-stopper.
> 
> Why not just fault in all the pages on the first fault. Then the performance 
> loss is a single page fault (the page table copy that would have happened a 
> fork time now happens at fault time) and you get the big win for processes 
> that do fork/exec.

"all" might be very many more pages than were ever mapped in the parent,
and not be a win.  Some faultahead might work better.  Might, might, ...

Hugh
