Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264503AbUEaCFq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264503AbUEaCFq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 22:05:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264505AbUEaCFq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 22:05:46 -0400
Received: from mailout.despammed.com ([65.112.71.29]:46583 "EHLO
	mailout.despammed.com") by vger.kernel.org with ESMTP
	id S264503AbUEaCFi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 22:05:38 -0400
Date: Sun, 30 May 2004 20:52:23 -0500 (CDT)
Message-Id: <200405310152.i4V1qNk03732@mailout.despammed.com>
From: ndiamond@despammed.com
To: linux-kernel@vger.kernel.org
Subject: How to use floating point in a module?
X-Mailer: despammed.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A driver, implemented as a module, must do some floating-point computations including trig functions.  Fortunately the architecture is x86.  A few hundred kilograms of searching (almost a ton of searching :-) seems to reveal the following possibilities.

Recompile GNU's libc with option "--without-fp".  If I understand correctly, the resulting libc will completely avoid using floating-point hardware while providing floating-point computations to its client.  Do I understand correctly?

Compile the module's .c files with gcc's "-msoft-float" option and "-D__NO_MATH_INLINES".  (Actually I think "-D__NO_MATH_INLINES" is probably unnecessary here.)

Link the module's .o files with the version of libc produced above, and try to get a loadable .ko from this... or a loadable .o since the target is still kernel 2.4.something.

But I'm sure there must be a ton of pitfalls that I'm not seeing here.  I'm not the first poor slob who got tasked with shoving some floating-point into a module.  My searches found a few tricks that people used for a few floating-point operations, but they used the real floating-point hardware and they didn't really reveal all the trickery they used.  (Not that I can blame them, since the hackery they did must be virtually unteachable.)  I didn't find anyone saying that they found a safe method of doing it, whether or not a safe method might somewhat resemble the ideas I've just presented.  I didn't find anyone saying they got trig functions into it either.  If my ideas could possibly work, surely they would have been done already.  So, what am I missing?

And does anyone know a really safe method?
