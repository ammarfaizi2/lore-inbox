Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313767AbSEJWgo>; Fri, 10 May 2002 18:36:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313789AbSEJWgn>; Fri, 10 May 2002 18:36:43 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:48375 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S313767AbSEJWgm>;
	Fri, 10 May 2002 18:36:42 -0400
Message-ID: <3CDC4B5C.C3DB2533@mvista.com>
Date: Fri, 10 May 2002 15:36:12 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 64-bit jiffies, a better solution
In-Reply-To: <Pine.LNX.4.33.0205101451120.22516-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Fri, 10 May 2002, george anzinger wrote:
> >
> > should work.  So here is a solution that does all the above and does
> > NOT invade new name spaces:
> 
> Ok, looks fine, but I'd really rather move the "jiffies" linker games
> into the per-architecture stuff, and get rid of the jiffies_at_jiffies_64
> games.
> 
> It's just one line per architecture, after all.
> 
>                 Linus
If that were only true.  The problem is that some architectures can be
built with either endian.  Mips, for example, seems to take the endian
stuff in as an environment variable.  The linker seems to know this
stuff, but does not provide the "built in" to allow it to be used.

The info is available from the header files at compile time, but I could
not find a clean way to export it to the Makefile, where we might choose
which linker script to use.  I suppose we could run the linker script
thru cpp if all else fails.  Any ideas?
-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Real time sched:  http://sourceforge.net/projects/rtsched/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml
