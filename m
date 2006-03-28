Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932085AbWC1CBb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932085AbWC1CBb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 21:01:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932110AbWC1CBa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 21:01:30 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:17097 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S932085AbWC1CBa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 21:01:30 -0500
From: "Peter T. Breuer" <ptb@inv.it.uc3m.es>
Message-Id: <200603280201.k2S21RM02208@inv.it.uc3m.es>
Subject: Re: uptime increases during suspend
To: linux-kernel@vger.kernel.org
Date: Tue, 28 Mar 2006 04:01:27 +0200 (MET DST)
X-Anonymously-To: 
Reply-To: ptb@inv.it.uc3m.es
X-message-flag: Had your Outlook virus, today?  http://www.counterpane.com/crypto-gram-0103.html#4
X-WebTV-Stationery: Standard\; BGColor=black\; TextColor=black
Reply-By: Sat, 1 Apr 2006 14:21:08 -0700
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Also sprach Eric Piel:"
> It seems that what you are really looking for in your application is a 
> monotonic clock. Linux has such thing since few releases. Using 
> CLOCK_MONOTONIC (cf "man 3 clock_gettime") may look much less hacky than 
> using the uptime ;-)

Likely. But I and others have to support all kernels and all operating
systems, and the code would look less hacky if it could use just one
thing, and continue using it. Uptime has been used this way for years
by many many applications. Read proc/sysinfo.c from procps...

/***********************************************************************
 * Some values in /proc are expressed in units of 1/HZ seconds, where HZ
 * is the kernel clock tick rate. One of these units is called a jiffy.
 * The HZ value used in the kernel may vary according to hacker desire.
 * According to Linus Torvalds, this is not true. He considers the values
 * in /proc as being in architecture-dependant units that have no relation
 * to the kernel clock tick rate. Examination of the kernel source code
 * reveals that opinion as wishful thinking.
 *
 * In any case, we need the HZ constant as used in /proc. (the real HZ value
 * may differ, but we don't care) There are several ways we could get HZ:
 *
 * 1. Include the kernel header file. If it changes, recompile this library.
 * 2. Use the sysconf() function. When HZ changes, recompile the C library!
 * 3. Ask the kernel. This is obviously correct...
 *
 * Linus Torvalds won't let us ask the kernel, because he thinks we should
 * not know the HZ value. Oh well, we don't have to listen to him.
 * Someone smuggled out the HZ value. :-)
 *
 * This code should work fine, even if Linus fixes the kernel to match his
 * stated behavior. The code only fails in case of a partial conversion.
 *
 * Recent update: on some architectures, the 2.4 kernel provides an
 * ELF note to indicate HZ. This may be for ARM or user-mode Linux
 * support. This ought to be investigated. Note that sysconf() is still
 * unreliable, because it doesn't return an error code when it is
 * used with a kernel that doesn't support the ELF note. On some other
 * architectures there may be a system call or sysctl() that will work.
 */

Etc.

How am I supposed to know on which installation what will work and what
will not? What do you propose? Try CLOCK_MONOTONIC and see if it returns
EINVAL, then fall back to uptime?

(and it'll be some years before my manpage documents the flag you give!
- I don't even have a man page for clock_gettime! Aahh ... I see it on a 
more recent debian system ... yes, that looks good).

Sigh, more configure.in-ery.

   On  POSIX  systems  on  which these functions are available, the symbol
       _POSIX_TIMERS is defined in <unistd.h> to a value greater than 0.   The
       symbols  _POSIX_MONOTONIC_CLOCK,  _POSIX_CPUTIME, _POSIX_THREAD_CPUTIME
       indicate      that      CLOCK_MONOTONIC,      CLOCK_PROCESS_CPUTIME_ID,
       CLOCK_THREAD_CPUTIME_ID are available. 

This is getting as bad as bdflush.

> Now... concerning the suspend effect on this clock, I don't know. It's 
> probably the same problem as uptime: no official semantic has ever been 
> stated yet... Does anyone know?

Peter

