Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271806AbRH1Q0e>; Tue, 28 Aug 2001 12:26:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271808AbRH1Q0X>; Tue, 28 Aug 2001 12:26:23 -0400
Received: from bacchus.veritas.com ([204.177.156.37]:47300 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S271806AbRH1Q0L>; Tue, 28 Aug 2001 12:26:11 -0400
Date: Tue, 28 Aug 2001 17:27:52 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>, Ingo Molnar <mingo@elte.hu>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: find_get_swapcache_page() question
In-Reply-To: <Pine.LNX.4.33L.0108281244550.26170-100000@imladris.rielhome.conectiva>
Message-ID: <Pine.LNX.4.21.0108281721320.1165-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Aug 2001, Rik van Riel wrote:
> On Tue, 28 Aug 2001, Hugh Dickins wrote:
> 
> > 		if (!PageSwapCache(found))
> > 			BUG();
> > 		if (found->mapping != &swapper_space)
> > 			BUG();
> > are not safe, since there may a concurrent remove_from_swap_cache(),
> > either from try_to_unuse() or from Rik's new vm_swap_full() deletion.
> > Those tests would be safe if the page were locked, but it's not.
> 
> vm_swap_full() is called with the page locked,
> remove_from_swap_cache() also seems to want the
> page locked...

Certainly (I seem to recall composing a comment to that effect
recently :-)!  Sorry for being unclear, I meant that those tests
in lookup_swap_cache() are made without the page being locked
by lookup_swap_cache() or its caller (and I'm not proposing
that the page should be locked, but the unsafe tests removed).

Hugh

