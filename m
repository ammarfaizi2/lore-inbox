Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262814AbRE0Qlv>; Sun, 27 May 2001 12:41:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262816AbRE0Qlm>; Sun, 27 May 2001 12:41:42 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:36892 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S262814AbRE0Qlf>; Sun, 27 May 2001 12:41:35 -0400
Date: Sun, 27 May 2001 18:41:23 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: "Ingo T. Storm" <it@lapavoni.de>, linux-kernel@vger.kernel.org,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: 2.4.5 does not link on Ruffian (alpha)
Message-ID: <20010527184123.E676@athlon.random>
In-Reply-To: <3B0BFE90.CE148B7@kjist.ac.kr> <20010523210923.A730@athlon.random> <022e01c0e5fc$39ac0cf0$2e2ca8c0@buxtown.de> <20010526193649.B1834@athlon.random> <20010526201442.D1834@athlon.random> <3B10521D.346E5886@mandrakesoft.com> <20010527044924.H1834@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010527044924.H1834@athlon.random>; from andrea@suse.de on Sun, May 27, 2001 at 04:49:24AM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 27, 2001 at 04:49:24AM +0200, Andrea Arcangeli wrote:
> caused me to write the posted patch to get all compilations right.

The reason I needed that patch is that I was not using 2.4.5aa1 but a
corrupted tree (I'm been fooled by an hardlink during developement), it
was just two lines away from the real one.

So this is the fix for all 2.4.5 based trees (ac1 and aa1 included) to
get generic and dp264 compililations right:

diff -urN 2.4.5/arch/alpha/kernel/sys_dp264.c fix/arch/alpha/kernel/sys_dp264.c
--- 2.4.5/arch/alpha/kernel/sys_dp264.c	Sat May 26 04:03:35 2001
+++ fix/arch/alpha/kernel/sys_dp264.c	Sun May 27 18:12:53 2001
@@ -16,18 +16,15 @@
 #include <linux/pci.h>
 #include <linux/init.h>
 
-#define __EXTERN_INLINE inline
-#include <asm/io.h>
-#include <asm/core_tsunami.h>
-#undef  __EXTERN_INLINE
-
 #include <asm/ptrace.h>
 #include <asm/system.h>
 #include <asm/dma.h>
 #include <asm/irq.h>
 #include <asm/bitops.h>
 #include <asm/mmu_context.h>
+#include <asm/io.h>
 #include <asm/pgtable.h>
+#include <asm/core_tsunami.h>
 #include <asm/hwrpb.h>
 
 #include "proto.h"


Sorry about that.

Andrea
