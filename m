Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263298AbTJLOfB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Oct 2003 10:35:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263310AbTJLOfB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Oct 2003 10:35:01 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:20712
	"EHLO velociraptor.random") by vger.kernel.org with ESMTP
	id S263298AbTJLOe7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Oct 2003 10:34:59 -0400
Date: Sun, 12 Oct 2003 16:36:17 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@redhat.com>
Cc: Hugh Dickins <hugh@veritas.com>, Matt_Domsch@Dell.com,
       marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org,
       benh@kernel.crashing.org
Subject: Re: [PATCH] page->flags corruption fix
Message-ID: <20031012143617.GS16013@velociraptor.random>
References: <Pine.LNX.4.44.0310121213080.4598-100000@localhost.localdomain> <Pine.LNX.4.44.0310121009560.30191-100000@cluless.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0310121009560.30191-100000@cluless.boston.redhat.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 12, 2003 at 10:11:43AM -0400, Rik van Riel wrote:
> On Sun, 12 Oct 2003, Hugh Dickins wrote:
> 
> > I agree on that too: I think Rik did it for atomicity throughout,
> > to make the safety obvious; but in practice it was already safe.
> 
> Also to keep this fix future proof.  Who knows whether
> a super-optimised patch that masks just this particular
> race condition will still be safe when XFS is merged ?
> 
> I really don't like keeping the code fragile and making
> it easy to reintroduce bugs.

free_pages as said if it's buggy, then it can still trigger no matter
whatever you do there, at that deep point of free_pages a alloc_page
user will be able to get the page and corrupt it anyways, so it can't
help and it will never be able to help no matter what xfs or whatever
else gets merged. If that makes a difference alloc_page users will still
break it.

we can argue about the filemap.c part, but I'm sure the page_alloc.c part
can't make any sense ever.

Andrea - If you prefer relying on open source software, check these links:
	    rsync.kernel.org::pub/scm/linux/kernel/bkcvs/linux-2.[45]/
	    http://www.cobite.com/cvsps/
