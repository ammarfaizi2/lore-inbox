Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263804AbUC3S2j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 13:28:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263805AbUC3S2j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 13:28:39 -0500
Received: from fw.osdl.org ([65.172.181.6]:7638 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263804AbUC3S2i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 13:28:38 -0500
Date: Tue, 30 Mar 2004 10:28:34 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org, hugh@veritas.com
Subject: Re: mapped pages being truncated [was Re: 2.6.5-rc2-aa5]
Message-Id: <20040330102834.7627cf54.akpm@osdl.org>
In-Reply-To: <20040330161056.GZ3808@dualathlon.random>
References: <20040329150646.GA3808@dualathlon.random>
	<20040329124803.072bb7c6.akpm@osdl.org>
	<20040329224526.GL3808@dualathlon.random>
	<20040330161056.GZ3808@dualathlon.random>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> here we go, my new debugging WARN_ON in in __remove_from_page_cache
>  triggered just before the other one in page_remove_rmap, as I expected
>  it was truncate removing pages from pagecache before all mappings were
>  dropped:

XFS is doing peculiar things - xfs_setattr calls truncate_inode_pages()
before running vmtruncate().

	xfs_setattr
	->xfs_itruncate_start
	  ->VOP_TOSS_PAGES
	    ->fs_tosspages
	      ->truncate_inode_pages


