Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266460AbSL2FAg>; Sun, 29 Dec 2002 00:00:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266464AbSL2FAf>; Sun, 29 Dec 2002 00:00:35 -0500
Received: from mnh-1-16.mv.com ([207.22.10.48]:58885 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S266460AbSL2FAe>;
	Sun, 29 Dec 2002 00:00:34 -0500
Message-Id: <200212290512.AAA05601@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel List <linux-kernel@vger.kernel.org>,
       Julian Seward <jseward@acm.org>
Subject: Re: [PATCH] Allow UML kernel to run in a separate host address space 
In-Reply-To: Your message of "28 Dec 2002 20:03:41 PST."
             <1041134621.17117.3.camel@ixodes.goop.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 29 Dec 2002 00:12:49 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jeremy@goop.org said:
> I suspect Valgrind could use this too at some point.  There hasn't
> been much discussion about it yet, but I think Valgrind may well move
> towards a more complete virtualization in a later round of
> development, and isolating the virtual virtual address space from the
> Valgrind's real virtual address space would be very useful.  (Jeff
> suggested the idea of merging Valgrind and UML at some level, which
> does raise some interesting possibilities.) 

Yes, valgrind already has a pseudo-scheduler, a psuedo-threads library, it
delivers signals by hand, and it wants to run its client in a separate
thread so it can get out of the business of being an LD_PRELOAD shared
library.

This is all stuff that UML has, that UML does right (/me crosses fingers),
and that is usable by Valgrind (and anything else that's interested) with 
some repackaging of UML as a library.

Replacing Valgrind's signal delivery with UML's is a no-brainer.  Replacing
its scheduler and threads library would involve it creating UML processes
by calling UML's do_fork().  Valgrind would need to provide the low-level
switch_to, I think.  There are probably other things that Valgrind would
need to provide, but I see no reason this wouldn't work.

				Jeff

