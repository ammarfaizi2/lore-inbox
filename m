Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030504AbVIOPq6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030504AbVIOPq6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 11:46:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030487AbVIOPq5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 11:46:57 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:39239
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S1030504AbVIOPq5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 11:46:57 -0400
Date: Thu, 15 Sep 2005 17:47:02 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Hugh Dickins <hugh@veritas.com>, Nick Piggin <npiggin@novell.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Roland McGrath <roland@redhat.com>
Subject: Re: ptrace can't be transparent on readonly MAP_SHARED
Message-ID: <20050915154702.GA4122@opteron.random>
References: <20050914212405.GD4966@opteron.random> <Pine.LNX.4.61.0509151337260.16231@goblin.wat.veritas.com> <Pine.LNX.4.58.0509150805150.26803@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0509150805150.26803@g5.osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 15, 2005 at 08:12:59AM -0700, Linus Torvalds wrote:
> have a PROT_READONLY/PROT_NONE area that is visible from the debugger, but
> continues to cause SIGSEGV's if the user process itself tries to access
> it. To me, that's good.

Continue to cause sigsegv yes, but on the wrong page, when it will read
the page it can contain different data compared to what is on
disk/pagecache.

> There would have to be some real advantage to _not_ doing what we're doing 
> now. And I don't see an advantage.

The advantage is a faster fast path and less special cases to keep in
mind.

> The real complexity is not "maybe_mkwrite()", which is trivial. The real 

It is trivial yes, but for it to work without deadlocks, it requires
non-trivial changes to the page fault handler and get_user_pages.

I guess this is mostly a matter of taste, but my taste is about keeping
it simple and fast (though the difference is certainly not measurable).

Thanks.
