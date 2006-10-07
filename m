Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423109AbWJGDLk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423109AbWJGDLk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 23:11:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423111AbWJGDLk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 23:11:40 -0400
Received: from smtp.osdl.org ([65.172.181.4]:60871 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1423109AbWJGDLj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 23:11:39 -0400
Date: Fri, 6 Oct 2006 20:11:24 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jesper Juhl <jesper.juhl@gmail.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Simple script that locks up my box with recent kernels
In-Reply-To: <9a8748490610061636r555f1be4x3c53813ceadc9fb2@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0610062000281.3952@g5.osdl.org>
References: <9a8748490610061636r555f1be4x3c53813ceadc9fb2@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 7 Oct 2006, Jesper Juhl wrote:
> 
> Which has worked great in the past, but with recent kernels it has
> been a sure way to cause a complete lockup within 1 hour :-(

Reliable lock-ups (and "within 1 hour" is quite quick too) are actually 
great.

> 2.6.17.13 .
> The first kernel where I know for sure it caused lockups is
> 2.6.18-git15 .   I've also tested 2.6.18-git16, 2.6.18-git21 and
> 2.6.19-rc1-git2 and those 3 also lock up solid.

Can I bother you to just bisect it?

Even if you decide that it's too painful to bisect to the very end, "git 
bisect" will give great results after just as few reboots as four or five, 
and hopefully narrow down the thing a _lot_.

So, for example, while my git tree doesn't contain the stable release 
numbers, you can trivially just get my tree, and then point "git fetch" at 
the stable git tree and get v2.6.17.13 that way.

Then you can do just

	git bisect start
	git bisect good v2.6.17.13
	git bisect bad $(cat patch-2.6.18-git15.id)

and off you go - it will pick a half-way point for you to test, and then 
if that one was good, you just say "git bisect good", and it will pick the 
next one..

(that "patch-2.6.18-git15.id" thing is from kernel.org - it's how you can 
get the exact git state of any particular snapshot, even if it's not 
tagged in any real tree - that particular one seems to have SHA1 ID 
1bdfd554be94def718323659173517c5d4a69d25..)

"git bisect" really does kick ass. Don't worry if it says "10374 commits 
to test after this" - because it does a binary search, it basically 
cuts the commits to test in half each time, and so if you do just five 
bisections, you'll have cut down the 10,000 commits to just a few hundred. 
At that point, maybe we even have a clue, or we might ask you to test a 
few more times to narrow things down even more.

		Linus
