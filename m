Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275671AbRJNPs4>; Sun, 14 Oct 2001 11:48:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275680AbRJNPsr>; Sun, 14 Oct 2001 11:48:47 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:61709 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S275671AbRJNPsg>; Sun, 14 Oct 2001 11:48:36 -0400
Date: Sun, 14 Oct 2001 08:48:38 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Paul Gortmaker <p_gortmaker@yahoo.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Making diff(1) of linux kernels faster
In-Reply-To: <3BC953B5.18870B14@yahoo.com>
Message-ID: <Pine.LNX.4.33.0110140841540.15323-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 14 Oct 2001, Paul Gortmaker wrote:
>
> Well, I taught diff to read each tree sequentially 1st and the results
> were quite surprising (linux-2.2 kernel, two identical 8 MB trees, on
> some older hardware, average times reported, new diff option is "-z").

Not that surprising. The very same factor of 5 was talked about in the
read-ahed thread - "diff -ur" is nasty because the kernel usually cannot
effectively read-ahead much of anything (each file is small, and the
kernel doesn't do intra-file read-ahead), and because the trees are in
different locations on the disk you end up seeking a _lot_ between each
file diff.

> Now if I only had enough ram to personally test how much it helps
> against a couple of 2.4.x kernel trees...  other stats welcomed.

Could you maybe instead of pre-reading the whole tree, just pre-read one
directory at a time?

Quite frankly, the whole-tree approach only works well if you have _much_
more than 2*tree-size worth of memory (not counting other apps you have
open).  Not everybody has that, especially not these days when the full
tree is 50MB+ or something.

So the full pre-read is probably only worthwhile on machines with closer
to half a gig of memory, or with old kernels..

Even just doing it one directory at a time should improve speed
_noticeably_. I'd bet you'll get close to the same improvement, with much
less memory pressure..

		Linus

