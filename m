Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143836AbRAHOUY>; Mon, 8 Jan 2001 09:20:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143979AbRAHOUO>; Mon, 8 Jan 2001 09:20:14 -0500
Received: from ns.caldera.de ([212.34.180.1]:32263 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S143836AbRAHOUG>;
	Mon, 8 Jan 2001 09:20:06 -0500
Date: Mon, 8 Jan 2001 15:19:25 +0100
Message-Id: <200101081419.PAA26150@ns.caldera.de>
From: Christoph Hellwig <hch@caldera.de>
To: cr@sap.com (Christoph Rohland)
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: Patch (repost): cramfs memory corruption fix
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <qwwwvc6tbau.fsf@sap.com>
User-Agent: tin/1.4.1-19991201 ("Polish") (UNIX) (Linux/2.2.14 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <qwwwvc6tbau.fsf@sap.com> you wrote:
> Hi Linus,
>
> On Sun, 7 Jan 2001, Linus Torvalds wrote:
>> I wonder what to do about this - the limits are obviously useful, as
>> would the "use swap-space as a backing store" thing be. At the same
>> time I'd really hate to lose the lean-mean-clean ramfs.
>
> Let me repeat on this issue: shmem.c has everything needed for this
> despite read and write and they should be really easy to add. 
>
> I did not plan to write them in the near future because I did not
> think that this is a really wanted feature. But I can look into it.
>

I had a prototype tmpfs in -test10 (ro so) times.  It based on ramfs
for all the metadata stuff and used the (old) shmfs code for swap-backed
data.  The only real problem the code had, was that it needed a ->allocpage
address_space method in place of page_cache_alloc() to directly swap-in
pages in ->read.  IF anyone is interested I could forward port it to 2.4.0
and the new shmfs.

	Christoph

-- 
Whip me.  Beat me.  Make me maintain AIX.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
