Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318275AbSHKHzC>; Sun, 11 Aug 2002 03:55:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318277AbSHKHzB>; Sun, 11 Aug 2002 03:55:01 -0400
Received: from dsl-213-023-020-163.arcor-ip.net ([213.23.20.163]:37786 "EHLO
	starship") by vger.kernel.org with ESMTP id <S318275AbSHKHzB>;
	Sun, 11 Aug 2002 03:55:01 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Linus Torvalds <torvalds@transmeta.com>,
       Jamie Lokier <lk@tantalophile.demon.co.uk>
Subject: Re: [patch 6/12] hold atomic kmaps across generic_file_read
Date: Sun, 11 Aug 2002 10:00:06 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Andrew Morton <akpm@zip.com.au>, lkml <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0208101529490.2401-100000@home.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0208101529490.2401-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17dndv-0001ei-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 11 August 2002 00:42, Linus Torvalds wrote:
> For example, what do you do when somebody has a COW-page mapped into it's
> VM space and you want to start paging stuff out?

Clearly it requires a CoW break and swapping out that page won't free any 
memory directly, but it will in turn allow the cache page to be dropped.  I 
suppose your point is that these ideas touch the system in a lot of places, 
and right now the code is a little too irregular to withstand lathering on a 
new layer of cruft.  That's true, but <plug>the reverse mapping work 
enables some fundamental VM simplifications that make a lot of things more 
local, and so a better base for these new, sophisticated features is on its 
way.</plug>

> There are "interesting"
> cases that just may mean that doing the COW thing is a really stupid thing
> to do, even if it is intriguing to _think_ about it.

It is good sport, but the real benefits are compelling and will only get more 
so.  For high end scientific uses (read supercomputing clusters) it's a cinch 
developers will prefer high speed file operations that turn in nearly the 
same raw performance on large transfers as O_DIRECT while not bypassing the 
file cache.

-- 
Daniel
