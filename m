Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281797AbRKQSaA>; Sat, 17 Nov 2001 13:30:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281801AbRKQS3u>; Sat, 17 Nov 2001 13:29:50 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:39850 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S281799AbRKQS3l>;
	Sat, 17 Nov 2001 13:29:41 -0500
Date: Sat, 17 Nov 2001 13:29:39 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linus Torvalds <torvalds@transmeta.com>, wwcopt@optonline.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] Re: 2.4.15-pre5: /proc/cpuinfo broken
In-Reply-To: <E1659pZ-0007sI-00@the-village.bc.nu>
Message-ID: <Pine.GSO.4.21.0111171322090.11475-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 17 Nov 2001, Alan Cox wrote:

> > 	c) hunt down and fix the userland that relies on arithmetics
> > on file position in case of regular files (POSIX prohibits it, SuS allows).
> 
> You forgot d.
> 
> (d) - when someone seeks in the file do the seek, and document that they
> lose their guarantees. So they fall back to existing 1.0->2.4 behaviour.
> You just run the iterator either on or back from scratch to the seek point.

Umm...  In principle doable, but then we are losing anything resembling
sane behaviour on seek to remembered position.  OTOH, it's weak anyway
and saying that it's FIFO and trying to squeeze something from lseek()
is not too attractive.

I'll do that variant - it will be local to file/seq_file.c.  I'll give it
some beating and send it - hopefully in an hour or two.

