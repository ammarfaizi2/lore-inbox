Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316513AbSE0DiK>; Sun, 26 May 2002 23:38:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316514AbSE0DiJ>; Sun, 26 May 2002 23:38:09 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:28433 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316513AbSE0DiJ>; Sun, 26 May 2002 23:38:09 -0400
Date: Sun, 26 May 2002 20:38:26 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrew Morton <akpm@zip.com.au>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 5/18] mark swapout pages PageWriteback()
In-Reply-To: <3CF197A8.A5DB850B@zip.com.au>
Message-ID: <Pine.LNX.4.44.0205262035200.1746-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 26 May 2002, Andrew Morton wrote:
>
> But I recall you saying that there was advantage in keeping swapout pages
> locked so that aggressive memory users would throttle against their
> own swapout.  What's the story there?

The advantage is not the lock itself, as much as having people who page in
swap pages be delayed on them - which ends up slowing down processes that
swap a lot.

BUT: that could equally well be done by doing a "wait_on_writeback()" or
similar, and it could also be a tunable thing (ie wait on writeback only
when we actually need to slow them down). In particular, _not_ slowing
them down does improve throughput, it just makes it really really nasty
from an interactive standpoint under some loads.

I don't know. I have this feeling that it would be good to try to share
all the semantics between swap pages and shared file mappings, but at the
same time I also have to admit to believing that swap _is_ special in some
ways, so if we don't ever really unify them I won't be shedding any huge
tears.

		Linus

