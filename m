Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313150AbSDHTyz>; Mon, 8 Apr 2002 15:54:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313626AbSDHTyy>; Mon, 8 Apr 2002 15:54:54 -0400
Received: from mnh-1-21.mv.com ([207.22.10.53]:22024 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S313150AbSDHTyy>;
	Mon, 8 Apr 2002 15:54:54 -0400
Message-Id: <200204082056.PAA03749@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: linux-kernel@vger.kernel.org, user-mode-linux-user@lists.sourceforge.net
Subject: user-mode port 0.56-2.4.18-15
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 08 Apr 2002 15:56:59 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm breaking with my usual practice of tying full UML releases to major
kernel releases.  The intervals between successive 2.4.x kernels are getting
too long for my taste.

So, here's a second 2.4.18 UML.  As usual, there are a ton of bug fixes in
this release.  Some of the more important ones are:

The console flow control bug is now fixed.  Flow control works properly
both with and without Sapan Bhatia's tty output SIGIO fix.

Fixed a crash caused by using a tty_struct after it had been freed when there
was no getty on the main console.

Daniel Phillips' pgtable fixes are in.

Fixed a crash caused by installing cmucl.

On older processors which don't implement the cmov instructions, UML likely
would hang on starting init.  Strictly speaking, this is not a UML bug.  The 
bug was booting a filesystem that executes cmov.  However, UML now detects
cmov support in the host processor and panics with a useful message when it
sees init get a SIGILL on a cmov.  The real fix is to get a filesystem that's
built for earlier processors than P6.

Added SA_SAMPLE_RANDOM to the irq registration flags of some drivers.  This
makes apps which read /dev/random work a lot better.  Randomness in UML is
more problematic than on the host, but I chose a set of drivers whose
interrupts shouldn't be too predictable.

The signal mask is now initialized so that odd environments can't screw
UML up by passing in bogus masks.  

The consoles and serial lines now support SIGWINCH.

The ubd driver's COW bitmaps are now properly byte-swapped. 

UML is now robust in the face of tmpfs running out of space.

HZ is now 52.

The project's home page is http://user-mode-linux.sourceforge.net

Downloads are available at 
	http://user-mode-linux.sourceforge.net/dl-sf.html

				Jeff

