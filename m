Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318109AbSHPDoX>; Thu, 15 Aug 2002 23:44:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318111AbSHPDoX>; Thu, 15 Aug 2002 23:44:23 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:53769 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318109AbSHPDoW>; Thu, 15 Aug 2002 23:44:22 -0400
Date: Thu, 15 Aug 2002 20:50:58 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Benjamin LaHaise <bcrl@redhat.com>
cc: Andrea Arcangeli <andrea@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       Pavel Machek <pavel@elf.ucw.cz>, <linux-kernel@vger.kernel.org>,
       <linux-aio@kvack.org>
Subject: Re: aio-core why not using SuS? [Re: [rfc] aio-core for 2.5.29 (Re:
 async-io API registration for 2.5.29)]
In-Reply-To: <Pine.LNX.4.44.0208152041120.1271-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0208152045330.1271-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 15 Aug 2002, Linus Torvalds wrote:
> 
> My bet is that we'll never do it due to performance issues. It's just 
> simpler to make the high pages end up being some special stuff (ie the old 
> "swap victim cache" etc that wouldn't show up to the VM proper).

Actually, the simplest schenario is to just make an arbitrary cut-off at
8G or 16G of RAM, and make anything above it default to the hugetlb zone,
and make that use a separate hugetlb map which does refcounts at 2MB
granularity). And create fake "struct page" entries for those things that
have to have it, along with a separate kmap area that holds a few of the 
big mappings.

There's an almost complete overlap between people who want hugetlb and 
64GB x86 machines anyway, so I doubt you'd find people to complain.

And the advantage of the hugetlb stuff is exactly the fact that the normal 
VM doesn't need to worry about it. It's nonswappable, and doesn't get IO 
done into it through any of the normal paths.

Minimal impact.

		Linus

