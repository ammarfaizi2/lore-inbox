Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317072AbSHJQ6J>; Sat, 10 Aug 2002 12:58:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317081AbSHJQ6J>; Sat, 10 Aug 2002 12:58:09 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:7440 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317072AbSHJQ6J>; Sat, 10 Aug 2002 12:58:09 -0400
Date: Sat, 10 Aug 2002 10:03:09 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: Andrew Morton <akpm@zip.com.au>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 6/12] hold atomic kmaps across generic_file_read
In-Reply-To: <Pine.LNX.4.44L.0208101114590.23404-100000@imladris.surriel.com>
Message-ID: <Pine.LNX.4.44.0208101002250.2134-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 10 Aug 2002, Rik van Riel wrote:
> On Sat, 10 Aug 2002, Linus Torvalds wrote:
> 
> > and having it magically populate the VM directly with the whole file
> > mapping, with _one_ failed page fault. And the above is actually a fairly
> > common thing. See how many people have tried to optimize using mmap vs
> > read, and what they _all_ really wanted was this "populate the pages in
> > one go" thing.
> 
> If this is worth it, chances are prefaulting at mmap() time
> could also be worth trying ... hmmm ;)

Maybe, maybe not.

The advantage of read() is that it contains an implicit "madvise()", since 
the read _tells_ us that it wants X pages. 

A page fault does not tell us, and prefaulting can hurt us.

		Linus

