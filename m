Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261827AbUCKXna (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 18:43:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261844AbUCKXn3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 18:43:29 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:7901 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261827AbUCKXn1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 18:43:27 -0500
Date: Thu, 11 Mar 2004 23:43:31 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Rik van Riel <riel@redhat.com>
cc: Andrea Arcangeli <andrea@suse.de>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: anon_vma RFC2
In-Reply-To: <Pine.LNX.4.44.0403111551050.29254-100000@chimarrao.boston.redhat.com>
Message-ID: <Pine.LNX.4.44.0403112315220.2671-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Mar 2004, Rik van Riel wrote:
> On Thu, 11 Mar 2004, Hugh Dickins wrote:
> 
> > length of your essay on vma merging, it strikes me that you've taken
> > a wrong direction in switching from my anon mm to your anon vma.
> > 
> > Go by vmas and you have tiresome problems as they are split and merged,
> > very commonly.  Plus you have the overhead of new data structure per vma.
> 
> There's of course a blindingly simple alternative.  
> 
> Add every anonymous page to an "anon_memory" inode.  Then
> everything is in effect file backed.  Using the same page
> refcounting we already do, holes get shot into that "file".

Okay, Rik, the two extremes belong to you: one anon memory
object in total (above), and one per page (your original rmap);
whereas Andrea is betting on one per vma, and I go for one per mm.
Each way has its merits, I'm sure - and you've placed two bets!

> The swap cache code provides a filesystem like mapping
> from the anon_memory "files" to the on-disk stuff, or the
> anon_memory file pages are resident in memory.

For 2.7 something like that may well be reasonable.
But let's beware the fancy bloat of extra levels.

> As a side effect, it also makes it possible to get rid
> of the swapoff code, simply move the anon_memory file
> pages from disk into memory...

Wonderful if that code could disappear: but I somehow doubt
it'll fall out quite so easily - swapoff is inevitably
backwards from sanity, isn't it?

Hugh

