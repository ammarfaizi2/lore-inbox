Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265224AbUBAHC3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 02:02:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265225AbUBAHC3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 02:02:29 -0500
Received: from Kiwi.CS.UCLA.EDU ([131.179.128.19]:35284 "EHLO kiwi.cs.ucla.edu")
	by vger.kernel.org with ESMTP id S265224AbUBAHC1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 02:02:27 -0500
Message-Id: <200402010702.i1172QG05156@kiwi.cs.ucla.edu>
To: linux-kernel@vger.kernel.org
Subject: C++ kernel modules
Date: Sat, 31 Jan 2004 23:02:26 -0800
From: Eddie Kohler <kohler@CS.UCLA.EDU>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Someone forwarded me a link to the recent thread on C++ kernel modules,
which started off with the Click modular router, which I co-wrote.  Phew!
Some discussion!!!


About Click <www.pdos.lcs.mit.edu/click>:

* Click is a router and packet processor whose configurations are built out
of little reusable modules.  It can get very good performance, mostly due
to polling drivers, but also due to careful coding and high-level
optimizations.

* It really is a module, that works with Linux kernels in the 2.2 and 2.4
series.  (We'll support 2.6 soon.)  It has been available since 1999 and is
used in a bunch of research projects and a few commercial products.  The
same code also compiles at user-level for debugging, testing, trace
processing, and the like.

* C++ expressed our design clearly and simplified development.  For a
research project where elegance and fine-grained modularity were explicit
goals, this was important.  Our decision was controversial at first within
the team, but people came around pretty quickly.  Over time the C++ type
system has helped us a lot and hurt us a little.  I probably wouldn't
choose to do this differently.


Using C++ in the kernel is eminently doable.  We don't use exceptions,
RTTI, the standard library, or floating point.  We need to provide dummy
stubs for __cxa_pure_virtual(), __rtti_si(), and __rtti_user().  That's it
from the C++ side.

Our kernel patch has several parts: bug fixes to the kernel (very small),
some polling network device drivers (implemented as of 2.2), and header
tweaks for C++ compatibility (1157 lines).  The header tweaks include:
  - Changing "::" in asm statements to ": :"  (by far the most lines)
  - Declaring empty structures with a macro (because of g++ brain damage)
  - Occasional explicit casts from void*
  - Type tweaks (For instance, did you know that in the stock 2.4 kernels,
__skb_pull() returns char*, but skb_pull() returns unsigned char*?)
  - We also compile the C++ code with "#define namespace xxx_namespace"
preprocessor hacks to avoid C++ keywords.

I would love it if most of these fixes (except the ugly empty-structure
change) made it into the real kernel, as they have in the BSDs.  (I believe
FreeBSD kernel headers have been C++-clean for a while.)  There'd seem to
be little downside.  But I haven't been holding my breath.


In love and solidarity,
Eddie Kohler
UCLA

(Please cc: explicitly if you feel like flaaaming.)
