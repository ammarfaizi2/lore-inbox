Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030562AbVIOSJT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030562AbVIOSJT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 14:09:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030563AbVIOSJT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 14:09:19 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:28506
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S1030562AbVIOSJT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 14:09:19 -0400
Date: Thu, 15 Sep 2005 20:09:28 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Hugh Dickins <hugh@veritas.com>, Nick Piggin <npiggin@novell.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Roland McGrath <roland@redhat.com>
Subject: Re: ptrace can't be transparent on readonly MAP_SHARED
Message-ID: <20050915180928.GI4122@opteron.random>
References: <20050914212405.GD4966@opteron.random> <Pine.LNX.4.61.0509151337260.16231@goblin.wat.veritas.com> <Pine.LNX.4.58.0509150805150.26803@g5.osdl.org> <20050915154702.GA4122@opteron.random> <Pine.LNX.4.58.0509150911180.26803@g5.osdl.org> <20050915162347.GC4122@opteron.random> <Pine.LNX.4.58.0509150928030.26803@g5.osdl.org> <20050915165117.GE4122@opteron.random> <Pine.LNX.4.58.0509151043370.26803@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0509151043370.26803@g5.osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 15, 2005 at 10:52:14AM -0700, Linus Torvalds wrote:
> And the PTRACE_POKE is _exactly_ the same thing. There's _zero_ 
> difference. The fact that PTRACE_POKE _changes_ the data instead of just 
> reading it doesn't change anything at all - the fact that data got changed 
> in NO WAY invalidates the fact that processes might still depend on 
> getting a SIGSEGV.

And this process may as well depend to see the on-disk changes that
other threads are doing on the shared memory, and that will break
regardless of what Linus changes in the kernel.

You also didn't make up any useful example where _writing_ (not reading
like in your example) was involved. Your example is totally offtopic,
since it only involved reading as far as I can tell.

I can't imagine where writing to a PROT_NONE is actually useful.

> Now, if you have a technical reason why "maybe_mkwrite()" needs to go 
> away, then that's a different thing. BUT IT HAS NOTHING TO DO WITH THE 
> FACT THAT WE LOOKED AT OR CHANGED THE DATA!

It just looks unnecessary cruft, but I'll stick with kernel crashing
bugs for my own safety.
