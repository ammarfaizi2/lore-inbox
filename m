Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262773AbRE0GWA>; Sun, 27 May 2001 02:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262777AbRE0GVv>; Sun, 27 May 2001 02:21:51 -0400
Received: from www.wen-online.de ([212.223.88.39]:45066 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S262773AbRE0GVm>;
	Sun, 27 May 2001 02:21:42 -0400
Date: Sun, 27 May 2001 08:21:15 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Jaswinder Singh <jaswinder.singh@3disystems.com>
cc: Alan Cox <laughing@shared-source.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.4-ac17
In-Reply-To: <006e01c0e616$e849e600$44a6b3d0@Toshiba>
Message-ID: <Pine.LNX.4.33.0105270656480.603-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 May 2001, Jaswinder Singh wrote:

> > The OS resides on disk, yes.  I suppose I could plunk a minimal
> > system into ramfs, pivot_root and umount disk, but I don't see
> > any way that could matter for a memory leak.
> >
>
> It is very difficult to see memory leak , with hard disks .

It is very easy for me to see any leak which I can trigger.  I'm using
a tool which tracks each any every allocation in the kernel. (a 1/32
scale model of physical memory with 'who allocated it, and when' tags)

> As i told you , in my case i am using no harddisks , only thing i have is
> RAM , so i am using only Ramdisk and ramfs, so in my case my Ram will full
> within few minutes and My machine hangs .

Exactly.  Nothing but ram and it's mostly unfreeable.  That makes
life pretty tough for the vm.

Does it hang if you are doing other things than creating/destroying
tiny files (with unique names) as rapidly as possible?.. ie did you
start doing that to troubleshoot because it was hanging over a long
period of time?

You snipped my suggestion.. did you try it?  If not, please do.  In
fact, go a bit further.  Make unconditional calls to kmem_cache_reap()
and shrink_icache_memory() as well.. prior to calling page_launder().
It's a long shot, but it might help.  If it does help, that will
tell developers what they need to know.  It costs you five minutes.

Another option is to build 2.4.5-pre6 and add the patch Rik posted.
If my thinker is working right, that _will_ help (if not cure).

Another option which virtually guarantees successful identification
of the problem (but costs more than five minutes) is for you to grab
a copy of IKD from your favorite kernel mirror and give memleak a try
locally.  It can be found in /pub/linux/kernel/people/andrea/ikd. If
you choose this option and have any trouble, drop me a note offline.

	-Mike

