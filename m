Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261806AbUJYNwj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261806AbUJYNwj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 09:52:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261813AbUJYNuY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 09:50:24 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:40154 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261801AbUJYNsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 09:48:36 -0400
Date: Mon, 25 Oct 2004 14:48:14 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: David Howells <dhowells@redhat.com>, <reiserfs-dev@namesys.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] delete_from_page_cache
In-Reply-To: <Pine.LNX.4.44.0410241651540.12023-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0410251438001.14745-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Oct 2004, Hugh Dickins wrote:

> Both reiser4 and cachefs want remove_from_page_cache to be exported.
> Before that, could we please make it symmetric with add_to_page_cache,
> add_to_swap_cache and delete_from_swap_cache? by doing its own
> page_cache_release, instead of commenting that each time it's called.
> But safer if we change the name too: delete_from_page_cache.
> 
> This patch is against 2.6.10-rc1, which doesn't include reiser4 and
> cachefs.  The next patch is against 2.6.9-mm1 and patches those.
> But I can understand if you ignore both patches as a waste of time.

I apologize, yes, a waste of time.  A good idea a year or few ago,
but now too late.  Reiser4's drop_page has to unlock the page between
removing it from page cache and doing the page_cache_release - as it
correctly did before my patches interfered.  And it would be highly
inappropriate for me to be forcing reiser4 to do this some other way.
So, sorry, please just ignore/revert my delete_from_page_cache patches.

Hugh

