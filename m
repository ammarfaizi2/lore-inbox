Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316238AbSEKRcL>; Sat, 11 May 2002 13:32:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316239AbSEKRcK>; Sat, 11 May 2002 13:32:10 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:41469 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S316238AbSEKRcJ>;
	Sat, 11 May 2002 13:32:09 -0400
Message-ID: <3CDD5570.E7E97205@mvista.com>
Date: Sat, 11 May 2002 10:31:28 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: Linus Torvalds <torvalds@transmeta.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 64-bit jiffies, a better solution take 2
In-Reply-To: <Pine.LNX.4.33.0205101538400.25826-100000@penguin.transmeta.com> <3CDC6906.B0288387@mvista.com> <20020511092935.A16828@flint.arm.linux.org.uk> <3CDD324E.4E1C4FB6@mvista.com> <20020511171024.D1574@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> 
> On Sat, May 11, 2002 at 08:01:34AM -0700, george anzinger wrote:
> > #ifdef __ARMEB__
> > #include <linux/byteorder/big_endian.h>
> > #else
> > #include <linux/byteorder/little_endian.h>
> > #endif
> >
> > So, yes, given no hints on who or what configures __ARMEB__.
> > Is it always little endian?
> 
> Most sane people use ARM in little endian mode.  However, there are a few
> insane people (mostly from the Telecoms sector) who like to put the chips
> into the (broken) big endian mode.
> 
> We don't fully support big endian in the -rmk kernel (and therefore Linus'
> kernel) yet.

So, what to do?  For ARM and MIPS we could go back to solution 1:

+#if defined(__LITTLE_ENDIAN) || (BITS_PER_LONG > 32)
+char jiffies_at_jiffies_64[0];
+#elif ! defined(__BIG_ENDIAN)
+#ERROR "Neither __LITTLE_ENDIAN nor __BIG_ENDIAN defined "
+#endif

With this in the ld script file: 
jiffies = DEFINED(jiffies_at_jiffies_64) ? jiffies_64 : jiffies_64+4;

This would work no matter what endian was used.  If this is to be the ARM/ MIPS 
answer, what file should the #if... go in?
-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Real time sched:  http://sourceforge.net/projects/rtsched/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml
