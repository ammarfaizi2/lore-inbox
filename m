Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261518AbUJ0AeG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261518AbUJ0AeG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 20:34:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261581AbUJ0AeF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 20:34:05 -0400
Received: from mx1.redhat.com ([66.187.233.31]:10155 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261518AbUJ0Abm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 20:31:42 -0400
Date: Tue, 26 Oct 2004 20:31:32 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Andrea Arcangeli <andrea@novell.com>, Andrew Morton <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: lowmem_reserve (replaces protection)
In-Reply-To: <417DCFDD.50606@yahoo.com.au>
Message-ID: <Pine.LNX.4.44.0410262029210.21548-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Oct 2004, Nick Piggin wrote:

> OK that makes sense... it isn't the length of the name, but the fact
> that that naming convention hasn't proliferated thoughout the 2.6 tree;

Speaking about not proliferating...

One thing we need to make sure of is that the lower zone
protection stuff doesn't put the allocation threshold
higher than kswapd's freeing threshold.

Otherwise on a 1GB system, we'll end up cycling most of
userspace allocations through the 128MB highmem zone,
instead of falling back to the other zones.

Note that simply having a small lower zone protection isn't
enough, if we still cross the kswapd threshold.  I suspect
the lower zone protection should just be off by default, 
except if highmem is at least 5x (or 8x?) bigger than lowmem...

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

