Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262268AbUCLQNK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 11:13:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262267AbUCLQNI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 11:13:08 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:11733 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S262278AbUCLQMK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 11:12:10 -0500
Date: Fri, 12 Mar 2004 16:12:10 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrea Arcangeli <andrea@suse.de>
cc: Rik van Riel <riel@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, <torvalds@osdl.org>,
       <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: anon_vma RFC2
In-Reply-To: <20040312155652.GW30940@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0403121602520.5118-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Mar 2004, Andrea Arcangeli wrote:
> On Fri, Mar 12, 2004 at 01:43:23PM +0000, Hugh Dickins wrote:
> 
> Don't forget you can't re-use the vma->shared for doing the tmpfs-style
> thing, that's already in a true inode.

Good point, I was overlooking that.  I'll see if I can come up with
something, but that may well prove a killer.

> you're right about vma_split, the way I implemented it is wrong,
> basically the as.vma/PageDirect idea is falling apart with vma_split.
> I should simply allocate the anon_vma without passing through the direct

Yes, that'll take a lot of the branching out, all much simpler.

> mode, that will fix it though it'll be a bit less efficient for the
> first page fault in an anonymous vma (only the first one, for all the
> other page faults it'll be as fast as the direct mode).

Simpler still to allocate it earlier?  Perhaps too wasteful.

Hugh

