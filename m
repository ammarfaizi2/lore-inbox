Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318717AbSHLFVA>; Mon, 12 Aug 2002 01:21:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318718AbSHLFVA>; Mon, 12 Aug 2002 01:21:00 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:6158 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S318717AbSHLFU7>; Mon, 12 Aug 2002 01:20:59 -0400
Date: Mon, 12 Aug 2002 02:24:37 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Andrew Morton <akpm@zip.com.au>
cc: Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 9/21] batched addition of pages to the LRU
In-Reply-To: <3D57449E.4FADF44@zip.com.au>
Message-ID: <Pine.LNX.4.44L.0208120222420.23404-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Aug 2002, Andrew Morton wrote:

> And it only takes one dirty block!  Any LRU page which is dirty
> against a blocked queue is like a hand grenade floating
> down a stream [1].  If some innocent task tries to write that
> page it gets DoSed via the request queue.

This is exactly why we shouldn't wait on dirty pages in
the pageout path.

Of course we need to wait and we should stall before
the system gets overloaded so we don't "run into a wall",
but waiting on any random _single_ dirty page just doesn't
make sense.


Then again, that will probably still not fix the problem
that we're not keeping the disk busy so we won't get full
writeout speed and end up stalling...

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

