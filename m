Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278633AbRKNXhv>; Wed, 14 Nov 2001 18:37:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278660AbRKNXhc>; Wed, 14 Nov 2001 18:37:32 -0500
Received: from fmfdns01.fm.intel.com ([132.233.247.10]:36576 "EHLO
	calliope1.fm.intel.com") by vger.kernel.org with ESMTP
	id <S278633AbRKNXh0>; Wed, 14 Nov 2001 18:37:26 -0500
Message-ID: <794826DE8867D411BAB8009027AE9EB913D03C95@FMSMSX38>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: linux-kernel@vger.kernel.org
Subject: constants for goodness calculation
Date: Wed, 14 Nov 2001 15:37:18 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wonder if we can make the following change in the goodness code for the
following 2 reasons.

(1) It would be more consistent with PROC_CHANGE_PENALTY in regarding to
goodness calculation.

(2) It would be easier to tweak these two constants in architecture
dependent code instead of generic code. The constants varies a lot from
platform to platform and instead of one constant for all platform, it is
easier for each platform to tailor optimal number in architecture code.

Any comments or objection?  If no, then I will generate a patch set to
include changes for all platforms.  One other question, what is the standard
procedure to send patch to Linus or Alan for consideration?  Thanks.


diff -Nur linux.orig/include/asm-i386/smp.h linux/include/asm-i386/smp.h
--- linux.orig/include/asm-i386/smp.h   Mon Nov  5 12:42:14 2001
+++ linux/include/asm-i386/smp.h        Wed Nov 14 15:22:32 2001
@@ -130,6 +130,7 @@
  */

 #define PROC_CHANGE_PENALTY    15              /* Schedule penalty */
+#define MM_CHANGE_PENALTY      1

 #endif
 #endif
diff -Nur linux.orig/kernel/sched.c linux/kernel/sched.c
--- linux.orig/kernel/sched.c   Wed Oct 17 14:14:37 2001
+++ linux/kernel/sched.c        Wed Nov 14 15:21:27 2001
@@ -177,7 +177,7 @@

                /* .. and a slight advantage to the current MM */
                if (p->mm == this_mm || !p->mm)
-                       weight += 1;
+                       weight += MM_CHANGE_PENALTY;
                weight += 20 - p->nice;
                goto out;
        }
