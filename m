Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282381AbRKZTcb>; Mon, 26 Nov 2001 14:32:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282436AbRKZTcQ>; Mon, 26 Nov 2001 14:32:16 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:6675 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S282427AbRKZTaS>; Mon, 26 Nov 2001 14:30:18 -0500
Message-ID: <3C02980E.8EDED15D@zip.com.au>
Date: Mon, 26 Nov 2001 11:29:19 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: mingo@elte.hu, bcrl@redhat.com, velco@fadata.bg,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Scalable page cache
In-Reply-To: <Pine.LNX.4.33.0111262115261.17043-100000@localhost.localdomain>,
		<20011126131641.A13955@redhat.com>
		<Pine.LNX.4.33.0111262115261.17043-100000@localhost.localdomain> <20011126.103327.18298379.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> 
>    From: Ingo Molnar <mingo@elte.hu>
>    Date: Mon, 26 Nov 2001 21:29:39 +0100 (CET)
> 
>    so i'm not against removing (or improving) the hash [our patch in fact
>    just left the hash alone], but the patch presented is not a win IMO.
> 
> Maybe you should give it a test to find out for sure :)

umm..  I've never seen any numbers from you, David.

Correct me if I'm wrong, but the pagecache_hash cost is
significant in the following situations:

1: TUX, because its pagecache lookups are not associated with
   a page copy.  This copy makes the benefits of the patch
   unmeasurable with other workloads.

1a: Other sendfile-intensive applications. (Theoretical benefit.
    No benchmark results have been seen).

2: NUMA hardware, where the cost of cacheline transfer is much
   higher.

ergo, there is no point in futzing with the pagecache_lock *at all*
until either TUX is merged, or we decide to support large-scale
NUMA hardware well, which will require changes in other places.

Prove me wrong.  Please.

-
