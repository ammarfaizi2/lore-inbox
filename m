Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964771AbWDUU5i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964771AbWDUU5i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 16:57:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932476AbWDUU5i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 16:57:38 -0400
Received: from silver.veritas.com ([143.127.12.111]:54282 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S932474AbWDUU5g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 16:57:36 -0400
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
X-IronPort-AV: i="4.04,146,1144047600"; 
   d="scan'208"; a="37456409:sNHT1166006928"
Date: Fri, 21 Apr 2006 21:57:26 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: David Woodhouse <dwmw2@infradead.org>
cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Mikael Starvik <mikael.starvik@axis.com>, akpm@osdl.org, andrea@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Shrink rbtree
In-Reply-To: <1145646503.11909.222.camel@pmac.infradead.org>
Message-ID: <Pine.LNX.4.64.0604212150270.9101@blonde.wat.veritas.com>
References: <1145623663.11909.139.camel@pmac.infradead.org> 
 <4448D8BF.9040601@yahoo.com.au> <1145646503.11909.222.camel@pmac.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 21 Apr 2006 20:57:34.0516 (UTC) FILETIME=[36BF2F40:01C66586]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Apr 2006, David Woodhouse wrote:
> On Fri, 2006-04-21 at 23:06 +1000, Nick Piggin wrote:
> > How do we know the pointers are always going to be aligned? IIRC
> > struct address_space needed to be explicitly aligned when doing
> > this trick in page->mapping because some platform byte aligned it.
> 
> Really? I've been doing this kind of trick with the jffs2_raw_node_ref
> for years. We always allocate sufficiently aligned objects.

} __attribute__((aligned(sizeof(long))));
	/*
	 * On most architectures that alignment is already the case; but
	 * must be enforced here for CRIS, to let the least signficant bit
	 * of struct page's "mapping" pointer be used for PAGE_MAPPING_ANON.
	 */

You can often get away with it - I notice we never added the same
alignment to struct anon_vma, which in theory needed it just as much.
Some accident of how structures are packed into slabs on CRIS, I suppose.

Hugh
