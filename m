Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267370AbSLERFN>; Thu, 5 Dec 2002 12:05:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267371AbSLERFN>; Thu, 5 Dec 2002 12:05:13 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:21252 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267370AbSLERFM>; Thu, 5 Dec 2002 12:05:12 -0500
Date: Thu, 5 Dec 2002 09:13:54 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: george anzinger <george@mvista.com>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: [PATCH ] POSIX clocks & timers take 15 (NOT HIGH RES)
In-Reply-To: <3DEEFE42.3F04BDBD@mvista.com>
Message-ID: <Pine.LNX.4.44.0212050904390.27298-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, finally starting to look at merging this, however:

This must go (we already have a timespec, there's no way it should be
here in <asm/signal.h>):

	+#ifndef _STRUCT_TIMESPEC
	+#define _STRUCT_TIMESPEC
	+struct timespec {
	+       time_t  tv_sec;         /* seconds */
	+       long    tv_nsec;        /* nanoseconds */
	+};
	+#endif /* _STRUCT_TIMESPEC */

and you have things like

	+       if ((flags & TIMER_ABSTIME) &&
	+           (clock->clock_get != do_posix_clock_monotonic_gettime)) {
	+       }else{
	+       }

and

	+if (!p) {
	+printk("in sub_remove for id=%d called with null pointer.\n", id);
	+return(0);
	+}

and obviously the "nanosleep()" thing and the CLOCK_NANOSLEEP_ENTRY()
stuff has been discussed in the unrelated thread (ie it doesn't work for
alpha or other architectures).

		Linus

