Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261615AbRE0TXh>; Sun, 27 May 2001 15:23:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261791AbRE0TX1>; Sun, 27 May 2001 15:23:27 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:46634 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S261615AbRE0TXW>; Sun, 27 May 2001 15:23:22 -0400
Date: Sun, 27 May 2001 21:22:56 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: "Ingo T. Storm" <it@lapavoni.de>, linux-kernel@vger.kernel.org,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: 2.4.5 does not link on Ruffian (alpha)
Message-ID: <20010527212256.A5882@athlon.random>
In-Reply-To: <3B0BFE90.CE148B7@kjist.ac.kr> <20010523210923.A730@athlon.random> <022e01c0e5fc$39ac0cf0$2e2ca8c0@buxtown.de> <20010526193649.B1834@athlon.random> <20010526201442.D1834@athlon.random> <3B10521D.346E5886@mandrakesoft.com> <20010527044924.H1834@athlon.random> <20010527184123.E676@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010527184123.E676@athlon.random>; from andrea@suse.de on Sun, May 27, 2001 at 06:41:23PM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 27, 2001 at 06:41:23PM +0200, Andrea Arcangeli wrote:
> On Sun, May 27, 2001 at 04:49:24AM +0200, Andrea Arcangeli wrote:
> > caused me to write the posted patch to get all compilations right.
> 
> The reason I needed that patch is that I was not using 2.4.5aa1 but a
> corrupted tree (I'm been fooled by an hardlink during developement), it
> was just two lines away from the real one.
> 
> So this is the fix for all 2.4.5 based trees (ac1 and aa1 included) to
> get generic and dp264 compililations right:

woops, the dp264 compilation wasn't right yet, this additional patch is
needed too.

--- 2.4.5aa2/arch/alpha/kernel/core_tsunami.c.~1~	Sat May 26 04:03:35 2001
+++ 2.4.5aa2/arch/alpha/kernel/core_tsunami.c	Sun May 27 20:44:59 2001
@@ -11,7 +11,6 @@
 #include <linux/pci.h>
 #include <linux/sched.h>
 #include <linux/init.h>
-#include <linux/bootmem.h>
 
 #include <asm/ptrace.h>
 #include <asm/system.h>
@@ -21,6 +20,8 @@
 #include <asm/io.h>
 #include <asm/core_tsunami.h>
 #undef __EXTERN_INLINE
+
+#include <linux/bootmem.h>
 
 #include "proto.h"
 #include "pci_impl.h"


the bootmem include was the one that broke the __EXTERN_INLINE logic for
dp264.

Andrea
