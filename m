Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131839AbRBKC7m>; Sat, 10 Feb 2001 21:59:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129141AbRBKC7c>; Sat, 10 Feb 2001 21:59:32 -0500
Received: from tungsten.btinternet.com ([194.73.73.81]:19161 "EHLO
	tungsten.btinternet.com") by vger.kernel.org with ESMTP
	id <S131839AbRBKC7Z>; Sat, 10 Feb 2001 21:59:25 -0500
Date: Sun, 11 Feb 2001 02:58:51 +0000 (GMT)
From: <davej@suse.de>
X-X-Sender: <davej@athlon.local>
To: Alan Cox <alan@redhat.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] duplicate check in setup.c
Message-ID: <Pine.LNX.4.31.0102110256260.4383-100000@athlon.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Alan,

 We check for 'dl' twice in the cachesize checking in setup.c

'good eyes' to John Levon for spotting this before me,
this patch has been sitting around for a while.

regards,

Dave.

-- 
| Dave Jones.        http://www.suse.de/~davej
| SuSE Labs

diff -urN --exclude-from=/home/davej/.exclude linux/arch/i386/kernel/setup.c linux-dj/arch/i386/kernel/setup.c
--- linux/arch/i386/kernel/setup.c	Sat Feb 10 02:49:30 2001
+++ linux-dj/arch/i386/kernel/setup.c	Sat Feb 10 03:04:31 2001
@@ -1563,12 +1563,10 @@
 				case 4:
 					if ( c->x86 > 6 && dl ) {
 						/* P4 family */
-						if ( dl ) {
-							/* L3 cache */
-							cs = 128 << (dl-1);
-							l3 += cs;
-							break;
-						}
+						/* L3 cache */
+						cs = 128 << (dl-1);
+						l3 += cs;
+						break;
 					}
 					/* else same as 8 - fall through */
 				case 8:

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
