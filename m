Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318779AbSHGQqW>; Wed, 7 Aug 2002 12:46:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318782AbSHGQqW>; Wed, 7 Aug 2002 12:46:22 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:25984
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S318779AbSHGQqU>; Wed, 7 Aug 2002 12:46:20 -0400
Date: Wed, 7 Aug 2002 09:49:38 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Richard Zidlicky 
	<Richard.Zidlicky@stud.informatik.uni-erlangen.de>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Randolph Chung <randolph@tausq.org>
Subject: [PATCH][RESEND x 2] A generic RTC driver [0/3]
Message-ID: <20020807164938.GD744@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The is a slightly updated version of the patch that I've resent twice
split up into 3 chunks, and 3 times as a single patch.  The only changes
this time are support for a 64bit kernel and a 32bit userland, from the
parisc group, as well as include/asm-parisc/rtc.h, both from Randolph
Chung.

Patch 1 is the current version of the driver (switched to C99-style
initializers, done in the current m68k CVS tree) and needed changes to
select/compile it in general.  I had previously asked the m68k community
if anyone objected to this being submitted by me, and I got Richard
Zidlicky's (who's at the top of the file) approval, as well as Geert
Uytterhoeven's approval.

Patch 2 is the PPC portion of the patch, which creates
include/asm-ppc/rtc.h.  This has been in the PPC bitkeeper tree for over
a month now.  I can have Paul Mackerras send this to you instead, if you
prefer.

Patch 3 is my own slight bit of work, as well as some work by Randolph
Chung. This changes set_rtc_time(struct *rtc_time) to return an int
instead of void.  This was done so that the arch-specific code here
could do additional checks on the time and return an error if needed.
This then introduces include/asm-generic/rtc.h, include/asm-i386/rtc.h
and include/asm-alpha/rtc.h.  include/asm-generic/rtc.h contains the
get_rtc_time and set_rtc_time logic that is in drivers/char/rtc.c and
has been tested on SMP i386.  This also modifies include/asm-ppc/rtc.h
to return -ENODEV if no rtc hardware is present.

Additionally, Dave Jones pointed out to me a place where we might not be
safe when jiffies wraps, so this switches that to time_after().

>From Randolph Chung, is supprt for a 64bit kernel and a 32bit userland.

And now onto the history of this driver.

This has been in the m68k tree for a number of years now, so the general
code behind it is quite sound.  This has also been abstracted to the
point where it works on other archs (mainly due to m68k/PPC hybrid
machines).  This is quite useful since a number of archs cannot use
drivers/char/rtc.c because they have very different hardware, or other
issues.

This should also be useful on MIPS, who at one point in the past were
about to copy the PPC rtc driver (drivers/macintosh/rtc.c) and quite
probably useful on other archs as well.

This has been in use by the parisc-linux people as well for some time,
and a version similar to this has been tested by them in 2.5.

Based on some private feedback, I believe with some additional
enhancements, ia64 will make use of this as well.  And if the MIPS
community ever did make an rtc driver similar to
drivers/macintosh/rtc.c, they should be able to use this one rather
trivially.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
