Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261626AbTJHPxf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 11:53:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261664AbTJHPxf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 11:53:35 -0400
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:14158 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S261626AbTJHPxe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 11:53:34 -0400
Date: Wed, 8 Oct 2003 11:52:58 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Hugh Dickins <hugh@veritas.com>
cc: "David S. Miller" <davem@redhat.com>, <marcelo.tosatti@cyclades.com>,
       <Matt_Domsch@Dell.com>, <linux-kernel@vger.kernel.org>,
       <benh@kernel.crashing.org>
Subject: Re: [PATCH] page->flags corruption fix
In-Reply-To: <Pine.LNX.4.44.0310081632080.3127-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0310081151330.5568-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Oct 2003, Hugh Dickins wrote:

> > It's quite possible that one CPU adds the page to the swap
> > cache, while another CPU moves the page around on the inactive
> > list. At that point both CPUs could be fiddling around with
> > the page->flags simultaneously.
> 
> Don't both of those TryLockPage (in one case holding page_table_lock,
> in the other case holding pagemap_lru_lock, to hold the page while
> doing so)?

Nope. I'm afraid they don't. Think of eg. mark_page_accessed
moving the page to the active list ...

> > In fact, this has been observed in heavy stress testing by
> > Matt Domsch and Robert Hentosh...
> 
> Perhaps Matt could add description of what they observed, in support
> of the patch.  I'm not yet convinced that it's necessarily the fix.

I'm not convinced all of the operations need to be atomic
(especially the ones in __free_pages_ok()) but since I've
seen the bug happen I'd rather play safe...

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

