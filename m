Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261515AbSJUQok>; Mon, 21 Oct 2002 12:44:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261518AbSJUQok>; Mon, 21 Oct 2002 12:44:40 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:2810 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S261515AbSJUQoi>;
	Mon, 21 Oct 2002 12:44:38 -0400
Message-ID: <3DB43037.B27910EB@mvista.com>
Date: Mon, 21 Oct 2002 09:49:59 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Andi Kleen <ak@muc.de>, Jeff Dike <jdike@karaya.com>,
       john stultz <johnstul@us.ibm.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>,
       Stephen Hemminger <shemminger@osdl.org>, discuss@x86-64.org, aj@suse.de
Subject: Re: [PATCH] linux-2.5.43_vsyscall_A0
References: <20021019031002.GA16404@averell> <200210190450.XAA06161@ccure.karaya.com> <20021019040238.GA21914@averell> <20021019041659.GK23930@dualathlon.random> <20021020025914.GB15342@averell> <20021020145149.GT23930@dualathlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This may be way out there, but has any consideration been
given to high speed system calls.  I have worked on systems
where this was done for selected calls.  Only selected state
was saved.  Only fast calls such as getpid, gettimeofday,
etc. were allowed.  The calls were still executed in system
pages so there was still the context switch (i.e. the trap
overhead) but very little state save/ restore.  It used a
different trap number so it did not impact the standard
calls.

You would need to defeat the standard way of checking if in
the system so the standard system calls and interrupt code
would think user space was executing.  As I recall there was
some mapping tricks played so that while not actually in the
system map, it was still available.

I had only a brief encounter with these calls so I may not
have all the details right :(
-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
