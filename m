Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266246AbSKLGpX>; Tue, 12 Nov 2002 01:45:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266250AbSKLGpX>; Tue, 12 Nov 2002 01:45:23 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:13819 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id <S266246AbSKLGpW>; Tue, 12 Nov 2002 01:45:22 -0500
Date: Tue, 12 Nov 2002 06:53:04 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: "David S. Miller" <davem@redhat.com>
cc: akpm@digeo.com, <dmccr@us.ibm.com>, <riel@conectiva.com.br>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] flush_cache_page while pte valid 
In-Reply-To: <20021111.151929.31543489.davem@redhat.com>
Message-ID: <Pine.LNX.4.44.0211120648170.1427-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Nov 2002, David S. Miller wrote:
>    From: Hugh Dickins <hugh@veritas.com>
>    Date: Mon, 11 Nov 2002 18:25:25 +0000 (GMT)
> 
>    On some architectures (cachetlb.txt gives HyperSparc as an example)
>    it is essential to flush_cache_page while pte is still valid: the
>    rmap VM diverged from the base 2.4 VM before that fix was made,
>    so this error has crept back into 2.5.
> ...   
>    (I wonder, what happens if userspace now modifies the page
>    after the flush_cache_page, before the pte is invalidated?)
> 
> Thanks for catching this.
> 
> On architectures that are affected (such as the mentioned HyperSPARC
> chips), the cpu will take a trap and OOPS the kernel if the PTE is
> invalidated before the cache flush is made.

Thanks for shedding light on that; but I'm still wondering if there
might be data loss if userspace modifies the page in the tiny window
between correctly positioned flush_cache_page and pte invalidation?

Hugh

