Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266987AbTBTUqH>; Thu, 20 Feb 2003 15:46:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266994AbTBTUqH>; Thu, 20 Feb 2003 15:46:07 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:65033 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266987AbTBTUqG>; Thu, 20 Feb 2003 15:46:06 -0500
Date: Thu, 20 Feb 2003 12:51:13 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: William Lee Irwin III <wli@holomorphy.com>
cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Ingo Molnar <mingo@elte.hu>,
       Dave Hansen <haveblue@us.ibm.com>,
       Zwane Mwaikambo <zwane@holomorphy.com>, Chris Wedgwood <cw@f00f.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: doublefault debugging (was Re: Linux v2.5.62 --- spontaneous
 reboots)
In-Reply-To: <20030220204250.GC29983@holomorphy.com>
Message-ID: <Pine.LNX.4.44.0302201244001.12336-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 20 Feb 2003, William Lee Irwin III wrote:
> 
> You might want to grab aeb's fully non-recursive pathwalking if
> you really want to cut back the stack to 4KB, as well as fixing
> whatever stackblasting drivers are about.

The path walking should really not be an issue. Each level of a symlink
takes something like 64 bytes of stack on x86 (I checked it some time ago,
maybe it's changed a bit), since the actual recursive part is very shallow
indeed.

And since we don't recurse deeper than 5 levels anyway, the symlink 
recursion ends up not being a real problem compared to a lot of other 
code (never mind the single functions with hundreds of bytes of stack 
space: just regular function calls 5 levels deep is quite normal).

That fs recursion was not the problem even back in the days when the max
stack depth was <3kB (4kB allocation, 1kB task_struct). It used to be 8
levels deep or something, it was changed to 5 not because we ran out on
x86, but because of those stupid sparc register windows (causing much
bigger minimum function stack requirements than on x86).

			Linus

