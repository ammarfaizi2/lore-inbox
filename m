Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289910AbSAWQ46>; Wed, 23 Jan 2002 11:56:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289908AbSAWQ4t>; Wed, 23 Jan 2002 11:56:49 -0500
Received: from [216.223.235.2] ([216.223.235.2]:53896 "HELO
	inventor.gentoo.org") by vger.kernel.org with SMTP
	id <S289910AbSAWQ4h>; Wed, 23 Jan 2002 11:56:37 -0500
Subject: Re: Athlon/AGP issue update
From: Daniel Robbins <drobbins@gentoo.org>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: "David S. Miller" <davem@redhat.com>, benh@kernel.crashing.org,
        linux-kernel@vger.kernel.org, andrea@suse.de, alan@redhat.com,
        Andrew Morton <akpm@zip.com.au>, vherva@niksula.hut.fi,
        Linux Weekly News <lwn@lwn.net>, paulus@samba.org
In-Reply-To: <200201231631.g0NGVcS426406@saturn.cs.uml.edu>
In-Reply-To: <200201231631.g0NGVcS426406@saturn.cs.uml.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 23 Jan 2002 09:57:52 -0700
Message-Id: <1011805072.10952.64.camel@inventor.gentoo.org>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-01-23 at 09:31, Albert D. Cahalan wrote:

> AGP might be non-coherent. If so, then the CPU should use a
> non-coherent mapping to avoid useless memory bus traffic.
> User code has access to some cache control instructions,
> so one may mark the memory cacheable for better performance
> even when it is non-coherent. ("flush when you're done")
> 
> BTW, I'd say the Athlon is pretty broken to set the dirty bit
> before a store is certain. The CPU has to be able to set this
> bit on a clean cache line anyway, so I don't see how this
> brokenness could help performance. Indeed, it hurts performance
> by causing erroneous memory bus traffic. (It's a bug.)

The answer I got from AMD on this is that because the page is marked as
cacheable, they are _allowed_ to do this.  Cacheable means that you are
allowed to cache, and also means that you are allowed to write back into
main memory if a cache line is marked dirty.  At least that's how they
explained it to me.  I believe the way they explained it to me is that
due to the page being cacheable, the CPU "owns" the page.

I don't know if I'd describe the writing out to main memory as a bug as
much as it is an area where, for whatever reason, AMD decided not to add
some additional processor resources to handle this particular case. 
Maybe the current behavior allowed them to implement speculative writes
much more efficiently (from a # of transistors on the chip perspective)
than if they added special logic so that these speculative writes were
*not* written out to main memory.  To me, this particular bug seems more
like an unfortunate coincidence of having a non-cache-coherent GART
working alongside a cache-coherent CPU.

Well, at least you guys see how someone at NVIDIA could mistake this for
a CPU bug.  If the kernel is affected, I hope we can find a nice
workable solution to this problem that doesn't involve disabling 4Mb
pages.

Also, everyone -- I can forward any additional questions you may have to
the people at AMD and get answers for you.  All I ask is that these
questions come from actual people who will be looking into a solution,
since that is of course my main concern.  I can then post answers from
AMD to this list for all to read.

Best Regards, 
 
-- 
Daniel Robbins                                  <drobbins@gentoo.org>
Chief Architect/President                       http://www.gentoo.org 
Gentoo Technologies, Inc.

