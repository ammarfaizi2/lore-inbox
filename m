Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261205AbUC3UNl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 15:13:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261214AbUC3UNl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 15:13:41 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:25655 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261205AbUC3UNj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 15:13:39 -0500
Date: Wed, 31 Mar 2004 06:13:10 +1000
From: Nathan Scott <nathans@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org,
       hugh@veritas.com
Subject: Re: mapped pages being truncated [was Re: 2.6.5-rc2-aa5]
Message-ID: <20040331061310.A28752@wobbly.melbourne.sgi.com>
References: <20040329150646.GA3808@dualathlon.random> <20040329124803.072bb7c6.akpm@osdl.org> <20040329224526.GL3808@dualathlon.random> <20040330161056.GZ3808@dualathlon.random> <20040330102834.7627cf54.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040330102834.7627cf54.akpm@osdl.org>; from akpm@osdl.org on Tue, Mar 30, 2004 at 10:28:34AM -0800
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

Oh.  Fix in progress...

thanks.

-- 
Nathan
