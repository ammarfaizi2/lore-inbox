Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264168AbUDBVbY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 16:31:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264188AbUDBVbY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 16:31:24 -0500
Received: from gprs214-45.eurotel.cz ([160.218.214.45]:2944 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S264168AbUDBVbW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 16:31:22 -0500
Date: Fri, 2 Apr 2004 22:13:43 +0200
From: Pavel Machek <pavel@suse.cz>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, hugh@veritas.com, vrajesh@umich.edu,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC][PATCH 1/3] radix priority search tree - objrmap complexity fix
Message-ID: <20040402201343.GA195@elf.ucw.cz>
References: <20040331150718.GC2143@dualathlon.random> <Pine.LNX.4.44.0403311735560.27163-100000@localhost.localdomain> <20040331172851.GJ2143@dualathlon.random> <20040401004528.GU2143@dualathlon.random> <20040331172216.4df40fb3.akpm@osdl.org> <20040401012625.GV2143@dualathlon.random> <20040331175113.27fd1d0e.akpm@osdl.org> <20040401020126.GW2143@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040401020126.GW2143@dualathlon.random>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > An anonymous user page meets these requirements.  A did say "anal", but
> > rw_swap_page_sync() is a general-purpose library function and we shouldn't
> > be making assumptions about the type of page which the caller happens to be
> > feeding us.
> 
> that is a specialized backdoor to do I/O on _private_ pages, it's not a
> general-purpose library function for doing anonymous pages
> swapin/swapout, infact the only user is swap susped and we'd better
> forbid swap suspend to pass anonymous pages through that interface and
> be sure that nobody will ever attempt anything like that.
> 
> that interface is useful only to reach the swap device, for doing I/O on
> private pages outside the VM, in the old days that was used to
> read/write the swap header (again on a private page), swap suspend is
> using it for similar reasons on _private_ pages.

Ahha, so *here* is that discussion happening. I was only seeing it at
bugzilla, and could not make sense of it.

If swsusp/pmdisk are only user of rw_swap_page_sync, perhaps it should
be moved to power/ directory?
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
