Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261160AbUDBVtZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 16:49:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261162AbUDBVtZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 16:49:25 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:25758
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261160AbUDBVtN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 16:49:13 -0500
Date: Fri, 2 Apr 2004 23:49:14 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Pavel Machek <pavel@suse.cz>
Cc: Andrew Morton <akpm@osdl.org>, hugh@veritas.com, vrajesh@umich.edu,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC][PATCH 1/3] radix priority search tree - objrmap complexity fix
Message-ID: <20040402214914.GW21341@dualathlon.random>
References: <Pine.LNX.4.44.0403311735560.27163-100000@localhost.localdomain> <20040331172851.GJ2143@dualathlon.random> <20040401004528.GU2143@dualathlon.random> <20040331172216.4df40fb3.akpm@osdl.org> <20040401012625.GV2143@dualathlon.random> <20040331175113.27fd1d0e.akpm@osdl.org> <20040401020126.GW2143@dualathlon.random> <20040402201343.GA195@elf.ucw.cz> <20040402214258.GU21341@dualathlon.random> <20040402214548.GD246@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040402214548.GD246@elf.ucw.cz>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 02, 2004 at 11:45:48PM +0200, Pavel Machek wrote:
> Hi!
> 
> > > > > An anonymous user page meets these requirements.  A did say "anal", but
> > > > > rw_swap_page_sync() is a general-purpose library function and we shouldn't
> > > > > be making assumptions about the type of page which the caller happens to be
> > > > > feeding us.
> > > > 
> > > > that is a specialized backdoor to do I/O on _private_ pages, it's not a
> > > > general-purpose library function for doing anonymous pages
> > > > swapin/swapout, infact the only user is swap susped and we'd better
> > > > forbid swap suspend to pass anonymous pages through that interface and
> > > > be sure that nobody will ever attempt anything like that.
> > > > 
> > > > that interface is useful only to reach the swap device, for doing I/O on
> > > > private pages outside the VM, in the old days that was used to
> > > > read/write the swap header (again on a private page), swap suspend is
> > > > using it for similar reasons on _private_ pages.
> > > 
> > > Ahha, so *here* is that discussion happening. I was only seeing it at
> > > bugzilla, and could not make sense of it.
> > 
> > ;)
> > 
> > btw, as far as I can tell I cannot see anymore VM issues with current CVS
> > kernel, what I get now is:
> 
> What does "current CVS kernel" mean? Current one at bkcvs?

of course not, it means the kernel-source-26 that we used to reproduce
the suspend problem so far (mainline has no -mm writeback and no
anon-vma so it cannot have problems with rw_swap_page_sync).
