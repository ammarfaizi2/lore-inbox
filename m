Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282431AbRKZTVN>; Mon, 26 Nov 2001 14:21:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282280AbRKZTTq>; Mon, 26 Nov 2001 14:19:46 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:43122 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S282419AbRKZTTS>; Mon, 26 Nov 2001 14:19:18 -0500
Date: Mon, 26 Nov 2001 14:19:14 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Momchil Velikov <velco@fadata.bg>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@redhat.com>
Subject: Re: [PATCH] Scalable page cache
Message-ID: <20011126141914.D13955@redhat.com>
In-Reply-To: <20011126131641.A13955@redhat.com> <Pine.LNX.4.33.0111262133140.17709-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0111262133140.17709-100000@localhost.localdomain>; from mingo@elte.hu on Mon, Nov 26, 2001 at 09:40:53PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2001 at 09:40:53PM +0100, Ingo Molnar wrote:
> this does not appear to be the case (see my other replies). Even if the
> hash table is big and assuming the worst-case (we miss on every hash table
> access), mem_map is *way* bigger in the cache because it has a much less
> compressed format. The compression ratio between mem_map[] and the hash
> table is 1:8 in the stock kernel, 1:4 with the page buckets patch.

Well, the only point you've made that has any impact on the data structure 
that I'm proposing is that the cachling bouncing caused by lock acquisition 
is the limiting factor.  The best solution to that is to make the per-bucket 
lock only used for insert and remove, and make lookups lockless.  In order 
to make that work, we need to break the current PageLock into a spinlock 
portion and an io-lock flag, and grab the spinlock before removing the page 
from the page cache.  Now, would you care to comment on the data structure?

		-ben
-- 
Fish.
