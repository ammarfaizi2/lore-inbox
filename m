Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265197AbSLWDrZ>; Sun, 22 Dec 2002 22:47:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265589AbSLWDrZ>; Sun, 22 Dec 2002 22:47:25 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:62447 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S265197AbSLWDrY>;
	Sun, 22 Dec 2002 22:47:24 -0500
Date: Mon, 23 Dec 2002 14:54:39 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus <torvalds@transmeta.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Trivial Kernel Patches <trivial@rustcorp.com.au>
Subject: [RESEND][PATCH] better compat_jiffies_to_clock_t
Message-Id: <20021223145439.368d4d05.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.7 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

[Resent because it hasn't truned up yet and I haven't had any
opposition.]

At David Mosberger's suggestion can we use this new version of
compat_jiffies_to_clock_t?  It does better rounding and will not fail
if COMPAT_USER_HZ > HZ.

Please apply.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.52-32bit.base/include/linux/compat.h 2.5.52-32bit.clock/include/linux/compat.h
--- 2.5.52-32bit.base/include/linux/compat.h	2002-12-16 14:49:54.000000000 +1100
+++ 2.5.52-32bit.clock/include/linux/compat.h	2002-12-17 15:20:18.000000000 +1100
@@ -9,9 +9,11 @@
 #ifdef CONFIG_COMPAT
 
 #include <linux/stat.h>
+#include <linux/param.h>	/* for HZ */
 #include <asm/compat.h>
 
-#define compat_jiffies_to_clock_t(x)	((x) / (HZ / COMPAT_USER_HZ))
+#define compat_jiffies_to_clock_t(x)	\
+		(((unsigned long long)(x) * COMPAT_USER_HZ) / HZ)
 
 struct compat_utimbuf {
 	compat_time_t		actime;


-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
