Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265366AbUFHWfX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265366AbUFHWfX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 18:35:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265373AbUFHWfX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 18:35:23 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:16215 "EHLO
	MTVMIME02.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S265368AbUFHWfL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 18:35:11 -0400
Date: Tue, 8 Jun 2004 23:34:56 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: arjanv@redhat.com, <joern@wohnheim.fh-wedel.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] stop page_state stack waste
In-Reply-To: <20040608141106.3c7c3c10.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44.0406082331470.2556-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jun 2004, Andrew Morton wrote:
> Hugh Dickins <hugh@veritas.com> wrote:
> >
> > Replace get_page_state (which memset most of full page_state to 0) by
> > get_main_page_state, which just sets the small structure needed.  This
> > helps 4k stacks not to overflow: cuts 224 bytes off try_to_free_pages
> > and wakeup_bdflush (and sync_inodes_sb) stack usages: wakeup_bdflush
> > doesn't do much, but is called by try_to_free_pages and mempool_alloc.
> 
> Yeah, I was looking at that.  I simply did:
> -} ____cacheline_aligned;
> +};

Well, that is a smaller patch; but you're still wasting 124 bytes of
stack in wakeup_bdflush below 124 bytes wasted in try_to_free_pages.

Hugh

