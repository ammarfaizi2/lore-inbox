Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287432AbSA0A67>; Sat, 26 Jan 2002 19:58:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282978AbSA0A6x>; Sat, 26 Jan 2002 19:58:53 -0500
Received: from web20209.mail.yahoo.com ([216.136.226.64]:55819 "HELO
	web20209.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S287432AbSA0A6k>; Sat, 26 Jan 2002 19:58:40 -0500
Message-ID: <20020127005839.73575.qmail@web20209.mail.yahoo.com>
Date: Sat, 26 Jan 2002 16:58:39 -0800 (PST)
From: tluxt <tluxt@yahoo.com>
Subject: Athlon/AGP-Where is problem, what hw is affected, when will it be solved
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Regarding this issue, and DR & ADC's comments (below),
I'd like to find know exactly which hw is affected, and how one could
find
out if their hw is affected.  & I'd like to see this info become
avialable
on some well known relevant web site, for easy access to the public.
Such as:
http://www.kernel.org
http://lwn.net/daily/
or ???  some other likely source?

Specifically:

Does the current problem affect all Athlons running Linux, or only some
that have certain other hw in the system?  All Athlons with AGP hw? Some
other combination?

If it only affects some hw combinations, is there any sw available (or
will such be made available) for a person to run on an Athlon system to
determine if that system has this problem?

What are the definitions of the relevant terms:
  AGP
  BAT
  TLB
  DRM(dma_mmap)
  GART
  ...

What are the possible problems that will occur, and how often? (Ex: some
programs will Sig11, only when doing graphics, based on current estimates
about once per 5 minutes, ... etc.   Sometimes the display image will be
corrupted some way.)

What's a guess as to when a fix will be available?  (There will be a fix
for 2.4 kernels, yes?)  Is this a minor or major problem for kernel
developers to solve?

Does AMD's implemention seem to be a good or bad choice to have made,
given the realities of how peripheral hw & OS SW would have to accomodate
it?  (Ie, performance tradeoffs.)  Is it likely this processor hw
decision
will be used in future processors, or removed?

What is an AMD url for finding out more about this situation?
What is a Linux (Kernel?) URL for keeping up to date on what the kernel
folks are doing about this situation?

Who is the kernel developer(s) most involved in fixing this issue?

Thanks for all your great work!  :)

BTW, I use a 1G Athlon as my primary workstation (5-12 hrs/day), running
KDE 2.2.2 Debian Woody, and it is very stable overall.  In a very rough
apples to oranges comparison, about 5-10 times FEWER problems than with
the Windows ME that's also on the harddisk.  The only current repeatable
problem I have is with Kghostview Sig11 when it tries to open a document.
(And that's a perhaps graphics=AGP & AMD problem?)

Please cc me on this, as I'm not subscribed to the kernel list.

=======================================================================
AMD's comment:
Our conclusion is that the operating system is creating coherency
problems within the system by creating cacheable translation to AGP
GART-mapped physical memory.

=======================================================================
Subject:  Re: Athlon/AGP issue update
From:     Daniel Robbins <drobbins@gentoo.org>
Date:     2002-01-23 16:57:52

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
...
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


__________________________________________________
Do You Yahoo!?
Great stuff seeking new owners in Yahoo! Auctions! 
http://auctions.yahoo.com
