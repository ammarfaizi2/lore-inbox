Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265383AbSJXKhF>; Thu, 24 Oct 2002 06:37:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265384AbSJXKhF>; Thu, 24 Oct 2002 06:37:05 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:52488 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S265383AbSJXKhE>; Thu, 24 Oct 2002 06:37:04 -0400
Date: Thu, 24 Oct 2002 06:42:44 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: Rik van Riel <riel@conectiva.com.br>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Dave McCracken <dmccr@us.ibm.com>, Andrew Morton <akpm@digeo.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [PATCH 2.5.43-mm2] New shared page table patch
In-Reply-To: <407130000.1035313347@flay>
Message-ID: <Pine.LNX.3.96.1021024063555.14473A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Oct 2002, Martin J. Bligh wrote:

> > I'm just trying to decide what this might do for a news server with
> > hundreds of readers mmap()ing a GB history file. Benchmarks show the 2.5
> > has more latency the 2.4, and this is likely to make that more obvious.
> > 
> > Is there any way to to have this only on processes which really need it?
> > define that any way you wish, including hanging a capability on the
> > executable to get spt.
> 
> Uh, what are you referring to here? Large pages or shared pagetables?
> You can't mmap filebacked stuff with larged pages (nixed by Linus).

Shared pagetables, it's a non-root application.

> And yes, large pages have to be specified explicitly by the app.
> On the other hand, I don't think shared pagetables have an mmap hook,

That could be interesting... so if the server has a mmap()ed file and
forks a child when a connection comes in, the tables would get duplicated
even with the patch? That's not going to help me.

> though that'd be easy enough to add. And if you're not reading the whole 
> history file, presumably the PTEs will only be sparsely instantiated anyway.

I have to go back and look at that code to be sure, you may be right.
There certainly are other things which are mmap()ed by all children (or
threads, depending on implementation) which might benefit since they're
moderately large and do have hundreds to thousands of copies.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

