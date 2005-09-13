Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932603AbVIMLU5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932603AbVIMLU5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 07:20:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932604AbVIMLU5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 07:20:57 -0400
Received: from gold.veritas.com ([143.127.12.110]:15472 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S932603AbVIMLU4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 07:20:56 -0400
Date: Tue, 13 Sep 2005 12:20:42 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: Kirill Korotaev <dev@sw.ru>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, xemul@sw.ru
Subject: Re: [PATCH] error path in setup_arg_pages() misses vm_unacct_memory()
In-Reply-To: <20050912132352.6d3a0e3a.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0509131217200.7040@goblin.wat.veritas.com>
References: <4325B188.10404@sw.ru> <20050912132352.6d3a0e3a.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 13 Sep 2005 11:20:56.0266 (UTC) FILETIME=[35B432A0:01C5B855]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Sep 2005, Andrew Morton wrote:
> Kirill Korotaev <dev@sw.ru> wrote:
> >
> >  This patch fixes error path in setup_arg_pages() functions, since it 
> >  misses vm_unacct_memory() after successful call of 
> >  security_vm_enough_memory(). Also it cleans up error path.
> 
> Ugh.  The identifier `security_vm_enough_memory()' sounds like some
> predicate which has no side-effects.  Except it performs accounting.  Hence
> bugs like this.
> 
> It's a shame that you mixed a largeish cleanup along with a bugfix - please
> don't do that in future.
> 
> Patch looks OK to me.  Hugh, could you please double-check sometime?

It's a good find, and the patch looks correct to me, so far as it goes.
But I think it's the wrong patch, and incomplete: it can be done more
appropriately, more simply and more completely in insert_vm_struct itself.
I'll post a replacement patch (or admit I'm wrong) in a little while.

Hugh
