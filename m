Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268658AbRGZTjR>; Thu, 26 Jul 2001 15:39:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268659AbRGZTjH>; Thu, 26 Jul 2001 15:39:07 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:5643 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S268657AbRGZTi4>; Thu, 26 Jul 2001 15:38:56 -0400
Date: Thu, 26 Jul 2001 12:37:00 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Richard A Nelson <cowboy@vnet.ibm.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: ext3-2.4-0.9.4
In-Reply-To: <Pine.LNX.4.33.0107261429190.19887-100000@badlands.lexington.ibm.com>
Message-ID: <Pine.LNX.4.33.0107261233000.1062-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


On Thu, 26 Jul 2001, Richard A Nelson wrote:
>
> In looking at the synchronous directory options, I'm unsure as to
> the 'real' status wrt fsync() on a directory:
> 	1) Does fsync() of a directory work on most/all current FS?

Modulo bugs, yes.

Now, there's another issue, of course: if you have an important mail-spool
on some of the less tested filesystems, I would consider you crazy
regardless of fsync() working ;). I don't think anybody has ever verified
that fsync() (or much anything else wrt writing) does the right thing on
NTFS, for example.

> 	2) Does it work on 2.2.x as well as 2.4.x?

Yes. However, there may be performance issues. As with just about
anything, we didn't start optimizing things until it became a real issue,
and in some cases at least historically the filesystems fell back on just
doing a whole "fsync_dev()" if they had nothing better to do.

I think later 2.2.x kernels (ie the ones past the point where Alan took
over) probably have the fsync() optimizations at least for ext2.

		Linus

