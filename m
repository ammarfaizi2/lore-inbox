Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312619AbSG2PUv>; Mon, 29 Jul 2002 11:20:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317484AbSG2PUv>; Mon, 29 Jul 2002 11:20:51 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:64643
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S312619AbSG2PUu>; Mon, 29 Jul 2002 11:20:50 -0400
Date: Mon, 29 Jul 2002 08:24:07 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Richard Zidlicky 
	<Richard.Zidlicky@stud.informatik.uni-erlangen.de>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH][RESEND] A generic RTC driver [0/3]
Message-ID: <20020729152407.GG11206@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is essentially the same driver I've sent 3 time previously in a
single patch, and unchanged since the last time I sent it in 3 smaller
chunks.

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

Patch 3 is my own slight bit of work.  This changes set_rtc_time(struct
*rtc_time) to return an int instead of void.  This was done so that the
arch-specific code here could do additional checks on the time and
return an error if needed.  This then introduces
include/asm-generic/rtc.h, include/asm-i386/rtc.h and
include/asm-alpha/rtc.h.  include/asm-generic/rtc.h contains the
get_rtc_time and set_rtc_time logic that is in drivers/char/rtc.c and
has been tested on SMP i386.  This also modifies include/asm-ppc/rtc.h
to return -ENODEV if no rtc hardware is present.

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

Based on some private feedback, the parisc-linux people have been using
the 2.4 version of this driver for a while, so getting it to work on 2.5
for them should be a trivial matter (it's currently in their tree,
untested as other issues need to be resolved first).  I believe with
some additional enhancements, ia64 will make use of this as well.  And
if the MIPS community ever did make an rtc driver similar to
drivers/macintosh/rtc.c, they should be able to use this one rather
trivially.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
