Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292232AbSBBG3W>; Sat, 2 Feb 2002 01:29:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292239AbSBBG3N>; Sat, 2 Feb 2002 01:29:13 -0500
Received: from dsl-213-023-043-146.arcor-ip.net ([213.23.43.146]:10419 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S292232AbSBBG27>;
	Sat, 2 Feb 2002 01:28:59 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Dave Jones <davej@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5 include file shakeup.
Date: Sat, 2 Feb 2002 07:33:51 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <20020202002532.A7782@suse.de>
In-Reply-To: <20020202002532.A7782@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16WtkG-0000ZR-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On February 2, 2002 01:25 am, Dave Jones wrote:
> after yesterdays cleanup removing sched.h inclusion from fs/,
> I looked at the dependancy graph for sched.h[1], and noticed that
> even with the removal of the explicit #include <linux/fs.h>, it
> was still being sucked in via <linux/capability.h>
> 
> Ripping this out meant breakage in various parts of the tree, who
> until now were relying on xxx including sched.h including fs.h
> these things are now including fs.h.
> 
> The next step is to split up fs.h some more, as some things are
> including it for trivial bits, but sucking in things like the superblock
> includes for every fs.  I've already started this by moving ERR_PTR and
> friends into <linux/err.h>

Just checking - you realize that getting the super_block includes out of fs.h 
is easy, right?  In fact I already did it in my Unbork fs.h (1..4) set of 
patches last month, at least I set a pattern using ext2 as an example, which 
is trivially extended for al filesystems.  Now, I'm just waiting for one of 
two things to happen: Al to decide he's finished mucking around in there and 
I can submit the patch to Linus, or Al will feel threatened again and submit 
a similar patch to Linus.  Either way we win, because the kernel gets better 
right?  (Except that the second scenerio creates considerably more friction 
that necessary, as we saw last week.)

> [...]
>
> Is all this worth it ?

You bet it is, you are preaching to the choir.

> Take a look at the updated dependancy graph after the cleanups[2],

Oh I know all about it, because I first did a version of this for myself
almost a year ago, and the complilation speedup was *remarkable*.  That's not 
even the biggest thing, I just find it much easier to work with and feel 
better about it when the kernel doesn't doesn't have its thumb tied to its 
nose.

;-)

-- 
Daniel
