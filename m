Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278088AbRJPEm5>; Tue, 16 Oct 2001 00:42:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278089AbRJPEms>; Tue, 16 Oct 2001 00:42:48 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:48340 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S278088AbRJPEmc>;
	Tue, 16 Oct 2001 00:42:32 -0400
Date: Tue, 16 Oct 2001 00:43:03 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [CFT][PATCH] large /proc/mounts and friends
In-Reply-To: <Pine.LNX.4.33.0110152110310.8688-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0110160032070.11608-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 15 Oct 2001, Linus Torvalds wrote:

> So you'd have the start be something like
> 
> 	p = m->op->start(m);
> 	if (m->did_lseek) {
> 		m->did_lseek = 0;
> 		p = m->op->seek(m, pos);
> 	}
> 	p = m->op->next(m, p);
> 
> instead of that for-loop..

Umm... That assumes that we actually can keep state.  Neither /proc/mounts
nor /proc/ksyms can do that (well, /proc/mounts can - at the price of really
dirty trick; we can insert a dummy element into vfsmntlist and use it as a
cursor, but I'd rather Not Go There(tm)).

However, having ->seek() (with default being a loop) makes sense.  I'll
play with that area and try to get a decent API - I understand what you
want, but there are several other issues I'd like to deal with.  I suspect
that ->start() semantics needs to be changed a bit...

