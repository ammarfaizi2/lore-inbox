Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317472AbSGONIP>; Mon, 15 Jul 2002 09:08:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317480AbSGONIO>; Mon, 15 Jul 2002 09:08:14 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:30471 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S317472AbSGONIN>; Mon, 15 Jul 2002 09:08:13 -0400
Date: Mon, 15 Jul 2002 14:10:59 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] make spin_is_locked use an explicit signed char case
Message-ID: <20020715141059.A13659@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a trivial patch from the XFS tree and allows to use spinlock
debugging with code that is compiled with -funsigned-char.  XFS itself
shouldn't need -funsigned-char anymore, but doing the right thing in
spinlock.h doesn't cost anything.


--- linux/include/asm-i386/spinlock.h~	Sun Jun 23 21:38:01 2002
+++ linux/include/asm-i386/spinlock.h	Tue Jun 18 15:10:28 2002
@@ -39,7 +39,7 @@
  * We make no fairness assumptions. They have a cost.
  */
 
-#define spin_is_locked(x)	(*(volatile char *)(&(x)->lock) <= 0)
+#define spin_is_locked(x)	(*(volatile signed char *)(&(x)->lock) <= 0)
 #define spin_unlock_wait(x)	do { barrier(); } while(spin_is_locked(x))
 
 #define spin_lock_string \
