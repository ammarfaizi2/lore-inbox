Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751007AbWDWNDV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751007AbWDWNDV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Apr 2006 09:03:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751396AbWDWNDV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Apr 2006 09:03:21 -0400
Received: from gold.veritas.com ([143.127.12.110]:5952 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1751007AbWDWNDV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Apr 2006 09:03:21 -0400
X-IronPort-AV: i="4.04,149,1144047600"; 
   d="scan'208"; a="58830191:sNHT29238964"
Date: Sun, 23 Apr 2006 14:03:15 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: David Woodhouse <dwmw2@infradead.org>
cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Mikael Starvik <mikael.starvik@axis.com>, akpm@osdl.org, andrea@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Shrink rbtree
In-Reply-To: <1145657573.11909.226.camel@pmac.infradead.org>
Message-ID: <Pine.LNX.4.64.0604231359350.3678@blonde.wat.veritas.com>
References: <1145623663.11909.139.camel@pmac.infradead.org> 
 <4448D8BF.9040601@yahoo.com.au>  <1145646503.11909.222.camel@pmac.infradead.org>
  <Pine.LNX.4.64.0604212150270.9101@blonde.wat.veritas.com>
 <1145657573.11909.226.camel@pmac.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 23 Apr 2006 13:03:20.0616 (UTC) FILETIME=[4BBA1A80:01C666D6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Apr 2006, David Woodhouse wrote:
> On Fri, 2006-04-21 at 21:57 +0100, Hugh Dickins wrote:
> > 
> > You can often get away with it - I notice we never added the same
> > alignment to struct anon_vma, which in theory needed it just as much.
> > Some accident of how structures are packed into slabs on CRIS, I suppose.
> 
> That sounds very strange to me, but it's harmless enough to add the
> explicit alignment.

It's occurred to me that the unusual thing about struct address_space
is that it does _not_ have a slab cache of its own: it's for years been
part of the struct inode itself; and I guess that exposes it to an
alignment issue which slab objects themselves avoid.  But still a
good idea to add the explicit alignment as doc.

Hugh
