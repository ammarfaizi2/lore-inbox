Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263628AbTDDCeS (for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 21:34:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263630AbTDDCeS (for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 21:34:18 -0500
Received: from dp.samba.org ([66.70.73.150]:17582 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263628AbTDDCeL (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Apr 2003 21:34:11 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com, rth@twiddle.net, grundler@parisc-linux.org,
       matthew@wil.cx, prumpf@tux.org
Subject: [PATCH] HPUX/OSF4 personality issues in 2.5.
Date: Fri, 04 Apr 2003 12:22:47 +1000
Message-Id: <20030404024540.4F6F62C15F@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.20's personality.h:

	PER_UW7 =		0x000e | STICKY_TIMEOUTS | MMAP_PAGE_ZERO,
	PER_HPUX =		0x000f,
	PER_OSF4 =		0x0010,			 /* OSF/1 v4 */
	PER_MASK =		0x00ff,

2.5.66's personality.h:

	PER_UW7 =		0x000e | STICKY_TIMEOUTS | MMAP_PAGE_ZERO,
	PER_OSF4 =		0x000f,			 /* OSF/1 v4 */
	PER_HPUX =		0x0010,
	PER_MASK =		0x00ff,

So I assume 2.5 should be changed to match 2.4?

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.66-bk9/include/linux/personality.h working-2.5.66-bk9-sparcmodule/include/linux/personality.h
--- linux-2.5.66-bk9/include/linux/personality.h	2003-02-07 19:20:01.000000000 +1100
+++ working-2.5.66-bk9-sparcmodule/include/linux/personality.h	2003-04-04 12:17:58.000000000 +1000
@@ -62,8 +62,8 @@ enum {
 	PER_RISCOS =		0x000c,
 	PER_SOLARIS =		0x000d | STICKY_TIMEOUTS,
 	PER_UW7 =		0x000e | STICKY_TIMEOUTS | MMAP_PAGE_ZERO,
-	PER_OSF4 =		0x000f,			 /* OSF/1 v4 */
-	PER_HPUX =		0x0010,
+	PER_HPUX =		0x000f,
+	PER_OSF4 =		0x0010,			 /* OSF/1 v4 */
 	PER_MASK =		0x00ff,
 };
 
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
