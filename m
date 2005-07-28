Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261281AbVG1Dpv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261281AbVG1Dpv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 23:45:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261283AbVG1Dpv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 23:45:51 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:1514 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261281AbVG1Dps (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 23:45:48 -0400
Subject: Re: [RFC][PATCH] Make MAX_RT_PRIO and MAX_USER_RT_PRIO configurable
From: Steven Rostedt <rostedt@goodmis.org>
To: Daniel Walker <dwalker@mvista.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1122521538.29823.177.camel@localhost.localdomain>
References: <1122473595.29823.60.camel@localhost.localdomain>
	 <1122512420.5014.6.camel@c-67-188-6-232.hsd1.ca.comcast.net>
	 <1122513928.29823.150.camel@localhost.localdomain>
	 <1122519999.29823.165.camel@localhost.localdomain>
	 <1122521538.29823.177.camel@localhost.localdomain>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Wed, 27 Jul 2005 23:45:28 -0400
Message-Id: <1122522328.29823.186.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-07-27 at 23:32 -0400, Steven Rostedt wrote:
> New benchmarks with my own formula.
> 

Take two: I ran this on my laptop (IBM ThinkPad G41 with an 3.3GHz
Pentium 4 HT processor, yeah yeah, no battery life :-).  But this has an
older compiler.

$ gcc -v
Reading specs from /usr/lib/gcc-lib/i486-linux-gnu/3.3.6/specs
Configured with: ../src/configure -v --enable-languages=c,c
++,java,f77,pascal,objc,ada,treelang --prefix=/usr
--mandir=/usr/share/man --infodir=/usr/share/info
--with-gxx-include-dir=/usr/include/c++/3.3 --enable-shared
--enable-__cxa_atexit --with-system-zlib --enable-nls
--without-included-gettext --enable-clocale=gnu --enable-debug
--enable-java-gc=boehm --enable-java-awt=xlib --enable-objc-gc
i486-linux-gnu
Thread model: posix
gcc version 3.3.6 (Debian 1:3.3.6-7)


Here's the results on it:

compiled again with "gcc -O2 -o ffb ffb.c"

/* comments embedded */


sched=128  ffb=160  my=160
/* this is a 3.3GHz so clocks look good */
clock speed = 00000000:c5e54f4c 3320139596 ticks per second
sched=159  ffb=159  my=159
last bit set
generic ffb: 00000000:0a25b1d0
/* Hmm, all generic ffb is even slower? do I blame gcc or Intel? */
time: 0.051275712us
sched ffb: 00000000:0023ae21
/* double Hmm, Ingo's is faster !? */
time: 0.000704289us
my ffb: 00000000:019c458d
/* look at this, mine is the same. Are the three bears coming around soon :-) */
time: 0.008137802us
sched=0  ffb=0  my=0

first bit set
generic ffb: 00000000:09766c3c
time: 0.047816034us
sched ffb: 00000000:0023c79f
time: 0.000706254us
my ffb: 00000000:005a8758
time: 0.001786939us

OK, still looks like the generic ffb can be changed.  Unless I'm missing
something, this shows that I probably should be sending in a patch now
to replace the find_first_bit.  Ingo's sched_find_first_bit is still the
winner, but that is customed to the scheduler, until we need a
configurable priority.

What do you think?

-- Steve


