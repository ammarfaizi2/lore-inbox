Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263820AbUC3SxU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 13:53:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263827AbUC3SxU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 13:53:20 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:25020
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263820AbUC3Svb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 13:51:31 -0500
Date: Tue, 30 Mar 2004 20:51:29 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, hugh@veritas.com
Subject: Re: mapped pages being truncated [was Re: 2.6.5-rc2-aa5]
Message-ID: <20040330185129.GC3808@dualathlon.random>
References: <20040329150646.GA3808@dualathlon.random> <20040329124803.072bb7c6.akpm@osdl.org> <20040329224526.GL3808@dualathlon.random> <20040330161056.GZ3808@dualathlon.random> <20040330102834.7627cf54.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040330102834.7627cf54.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2004 at 10:28:34AM -0800, Andrew Morton wrote:
> Andrea Arcangeli <andrea@suse.de> wrote:
> >
> > here we go, my new debugging WARN_ON in in __remove_from_page_cache
> >  triggered just before the other one in page_remove_rmap, as I expected
> >  it was truncate removing pages from pagecache before all mappings were
> >  dropped:
> 
> XFS is doing peculiar things - xfs_setattr calls truncate_inode_pages()
> before running vmtruncate().
> 
> 	xfs_setattr
> 	->xfs_itruncate_start
> 	  ->VOP_TOSS_PAGES
> 	    ->fs_tosspages
> 	      ->truncate_inode_pages

Ok, so objrmap needs my WARN_ON changes to survive the above. I believe
I can close the bug as fixed now (however I will leave the WARN_ON in
the code).

Still xfs seems pretty broken doing the above.
