Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314612AbSEKG6x>; Sat, 11 May 2002 02:58:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314645AbSEKG6w>; Sat, 11 May 2002 02:58:52 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:21742 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S314612AbSEKG6u>;
	Sat, 11 May 2002 02:58:50 -0400
Message-ID: <3CDCC118.5A659170@mvista.com>
Date: Fri, 10 May 2002 23:58:32 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: jim.houston@attbi.com
CC: linux-kernel@vger.kernel.org
Subject: Re: 64-bit jiffies, a better solution
In-Reply-To: <3CDC9BDC.F96F7C36@attbi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Houston wrote:
> 
> Hi!
> 
> First what problem are you trying to solve?
> Why not have both variables and if they happen
> to endup in the same cache line you probably
> need years worth of jiffies to notice how
> long one more add takes.  E.g.
> 
>         jiffies_64++;
>         jiffies++;
> 
> To round out the list of options, how about a few lines of
> inline asm?  Maybe something like:
> 
>    extern unsigned long long jiffie_64;
>    extern unsigned int jiffie;
>    __asm__ (" \
>         .data
>         .align  8
>         .global jiffie
>         .global jiffie_64
>         .type   jiffie,@object
>         .size   jiffie,4
>         .type   jiffie_64,@object
>         .size   jiffie_64,8
>    jiffie_64:
>    jiffie:
>         .long   0, 0
>    ");
> 
> Adding the obvious ifdef of course.  Aside for broken
> binutils this might be portable code :-)

Until you move to a big endian 32-bit machine.  I would much rather hear
IS portable.
-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Real time sched:  http://sourceforge.net/projects/rtsched/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml
