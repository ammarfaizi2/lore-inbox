Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263097AbTH0K4V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 06:56:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263276AbTH0K4V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 06:56:21 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:41506 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id S263097AbTH0K4U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 06:56:20 -0400
Date: Wed, 27 Aug 2003 11:57:54 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: rusty@rustcorp.com.au, <mingo@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] Futex non-page-pinning fix
In-Reply-To: <20030827033836.17310dbc.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44.0308271154060.2974-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Aug 2003, Andrew Morton wrote:
> Hugh Dickins <hugh@veritas.com> wrote:
> >
> > But I disagree over move_to/from_swap_cache: nothing should
> >  be done there at all.  Once you have mapping,index in struct
> >  futex_q, it's irrelevant what tmpfs might be doing to the
> >  page->mapping,page->index of the unmapped page.
> 
> But move_to_swap_cache() alters a page's ->mapping and ->index when that
> page is potentially mapped into user pagetables.

It'd better not: BUG_ON(page_mapped(page)) at start of shmem_writepage,
sole caller of move_to_swap_cache.  Things fall apart if tmpfs pages
get reassigned to swap while they're mapped.

Hugh

