Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261613AbTJHPrl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 11:47:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261685AbTJHPrl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 11:47:41 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:2726 "EHLO
	mtvmime01.veritas.com") by vger.kernel.org with ESMTP
	id S261613AbTJHPrj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 11:47:39 -0400
Date: Wed, 8 Oct 2003 16:47:36 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Rik van Riel <riel@redhat.com>
cc: "David S. Miller" <davem@redhat.com>, <marcelo.tosatti@cyclades.com>,
       <Matt_Domsch@Dell.com>, <linux-kernel@vger.kernel.org>,
       <benh@kernel.crashing.org>
Subject: Re: [PATCH] page->flags corruption fix
In-Reply-To: <Pine.LNX.4.44.0310081106380.5568-100000@chimarrao.boston.redhat.com>
Message-ID: <Pine.LNX.4.44.0310081632080.3127-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Oct 2003, Rik van Riel wrote:
> 
> Though I suspect it's gotten worse since 2.4.14 or so, where
> we moved the final lru_cache_del() into __free_pages_ok() and
> the fact that anonymous pages are on the lru lists.

I agree both of those make it all more fragile;
but I still don't quite see where it's broken.

The existing shortcuts are normally dealing with either a freed
page or a just allocated, not yet published, page.  And you're
right that the anon->swap case is an exception, less obvious.

> It's quite possible that one CPU adds the page to the swap
> cache, while another CPU moves the page around on the inactive
> list. At that point both CPUs could be fiddling around with
> the page->flags simultaneously.

Don't both of those TryLockPage (in one case holding page_table_lock,
in the other case holding pagemap_lru_lock, to hold the page while
doing so)?

> In fact, this has been observed in heavy stress testing by
> Matt Domsch and Robert Hentosh...

Perhaps Matt could add description of what they observed, in support
of the patch.  I'm not yet convinced that it's necessarily the fix.

Hugh

