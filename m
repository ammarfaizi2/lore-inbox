Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262561AbREZXYf>; Sat, 26 May 2001 19:24:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262573AbREZXY0>; Sat, 26 May 2001 19:24:26 -0400
Received: from zeus.kernel.org ([209.10.41.242]:20647 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S262561AbREZW6v>;
	Sat, 26 May 2001 18:58:51 -0400
Date: Sat, 26 May 2001 20:14:42 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "Ingo T. Storm" <it@lapavoni.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.5 does not link on Ruffian (alpha)
Message-ID: <20010526201442.D1834@athlon.random>
In-Reply-To: <3B0BFE90.CE148B7@kjist.ac.kr> <20010523210923.A730@athlon.random> <022e01c0e5fc$39ac0cf0$2e2ca8c0@buxtown.de> <20010526193649.B1834@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010526193649.B1834@athlon.random>; from andrea@suse.de on Sat, May 26, 2001 at 07:36:49PM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 26, 2001 at 07:36:49PM +0200, Andrea Arcangeli wrote:
> I got exactly the above when compiling for dp264 so I sent to Linus a
> patch to fix those compile problems, now I suspect my fix broke the
> generic compile :(, I will check that.

2.4.5aa1 compiles fine, but 2.4.5 doesn't, don't know why yet. Please
backout this patch from 2.4.5 for now, this should be the right thing to
do in the long run:

diff -urN alpha/arch/alpha/kernel/sys_dp264.c alpha-1/arch/alpha/kernel/sys_dp264.c
--- alpha/arch/alpha/kernel/sys_dp264.c	Sun Apr  1 01:17:07 2001
+++ alpha-1/arch/alpha/kernel/sys_dp264.c	Wed May 23 02:43:49 2001
@@ -16,15 +16,18 @@
 #include <linux/pci.h>
 #include <linux/init.h>
 
+#define __EXTERN_INLINE inline
+#include <asm/io.h>
+#include <asm/core_tsunami.h>
+#undef  __EXTERN_INLINE
+
 #include <asm/ptrace.h>
 #include <asm/system.h>
 #include <asm/dma.h>
 #include <asm/irq.h>
 #include <asm/bitops.h>
 #include <asm/mmu_context.h>
-#include <asm/io.h>
 #include <asm/pgtable.h>
-#include <asm/core_tsunami.h>
 #include <asm/hwrpb.h>
 
 #include "proto.h"


Now I will start a robot that will tell me in some hour of computations
which of the patches in my tree actually makes me to need the above
patch to compile both generic and dp264 correctly. After I localized the
offender patch it should be very easy to found why I need the above and
2.4.5 doesn't.

Andrea
