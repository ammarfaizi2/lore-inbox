Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261656AbTJHPKq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 11:10:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261660AbTJHPKq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 11:10:46 -0400
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:12077 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S261656AbTJHPKp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 11:10:45 -0400
Date: Wed, 8 Oct 2003 11:10:24 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: "David S. Miller" <davem@redhat.com>
cc: Hugh Dickins <hugh@veritas.com>, <marcelo.tosatti@cyclades.com>,
       <Matt_Domsch@Dell.com>, <linux-kernel@vger.kernel.org>,
       <benh@kernel.crashing.org>
Subject: Re: [PATCH] page->flags corruption fix
In-Reply-To: <20031008075700.553e89f9.davem@redhat.com>
Message-ID: <Pine.LNX.4.44.0310081106380.5568-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Oct 2003, David S. Miller wrote:
> On Wed, 8 Oct 2003 15:49:34 +0100 (BST)
> Hugh Dickins <hugh@veritas.com> wrote:
> 
> > Seven atomic ops in a row, isn't that rather inefficient?

Absolutely.

> > Is there an actual test case for why 2.4 now needs this change?
> 
> It's not a new bug, we've always had this bug in 2.4.x

Though I suspect it's gotten worse since 2.4.14 or so, where
we moved the final lru_cache_del() into __free_pages_ok() and
the fact that anonymous pages are on the lru lists.

It's quite possible that one CPU adds the page to the swap
cache, while another CPU moves the page around on the inactive
list. At that point both CPUs could be fiddling around with
the page->flags simultaneously.

In fact, this has been observed in heavy stress testing by
Matt Domsch and Robert Hentosh...

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

