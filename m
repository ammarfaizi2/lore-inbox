Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267014AbSKLWwK>; Tue, 12 Nov 2002 17:52:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267018AbSKLWwK>; Tue, 12 Nov 2002 17:52:10 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:7477 "EHLO
	mtvmime02.veritas.com") by vger.kernel.org with ESMTP
	id <S267014AbSKLWwJ>; Tue, 12 Nov 2002 17:52:09 -0500
Date: Tue, 12 Nov 2002 22:59:51 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: "David S. Miller" <davem@redhat.com>
cc: akpm@digeo.com, <dmccr@us.ibm.com>, <riel@conectiva.com.br>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] flush_cache_page while pte valid 
In-Reply-To: <20021112.135147.21135668.davem@redhat.com>
Message-ID: <Pine.LNX.4.44.0211122256340.1147-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Nov 2002, David S. Miller wrote:

>    From: Hugh Dickins <hugh@veritas.com>
>    Date: Tue, 12 Nov 2002 17:43:40 +0000 (GMT)
>    
>    Sorry, I still don't get it.  If the flush_cache_page is doing something
>    necessary, then won't a user access in between it and invalidating pte
>    undo what was necessary?  And if it's not necessary, why do we do it?
>    (For better performance would be a very good reason.)
>    
> If there are other writable mappings of the page, we can't swap
> it out legally.

But I'm worried about the case where this is the last writable mapping:
it seems userspace (on another CPU) can still write to it in between
the flush_cache_page and invalidation of the pte (on this CPU hoping
to swap out that page).

Hugh

