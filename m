Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289194AbSANK7e>; Mon, 14 Jan 2002 05:59:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289196AbSANK7S>; Mon, 14 Jan 2002 05:59:18 -0500
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:43453 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S289194AbSANK7C>; Mon, 14 Jan 2002 05:59:02 -0500
Message-Id: <200201141058.g0EAwPR16578@jupiter.cs.uni-dortmund.de>
To: Andrew Morton <akpm@zip.com.au>
cc: Kyle <kyle@actarg.com>, linux-kernel@vger.kernel.org,
        chaffee@cs.berkeley.edu
Subject: Re: Hard lock when mounting loopback file 
In-Reply-To: Message from Andrew Morton <akpm@zip.com.au> 
   of "Sat, 12 Jan 2002 23:49:04 PST." <3C413BF0.24576AEC@zip.com.au> 
Date: Mon, 14 Jan 2002 11:58:25 +0100
From: "Prof. Brand " <brand@jupiter.cs.uni-dortmund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@zip.com.au> said:

[...]

> I don't know a thing about fat layout, but it appears that it uses a
> linked list of blocks, and if that list ends up pointing back onto
> itself, the kernel goes into an infinite loop in several places chasing
> its way to the end of the list.

Right.

> The below patch fixed it for me, and I was able to mount and read
> your filesystem image.

AFAIKS, this just cures the case where the wild pointer points to the first
block of the offending file. You should perhaps count the blocks you go
through, so a file something like:

 -------+-----+
        ^     |
        |     |
        +-----+

or other strange pointer messups don't get you.

BTW, is fsck (the Linux or the Win32 variety) able to fix this?
-- 
Horst von Brand			     http://counter.li.org # 22616
