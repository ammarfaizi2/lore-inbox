Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264464AbUANIhM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 03:37:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264919AbUANIhM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 03:37:12 -0500
Received: from pD9E5637F.dip.t-dialin.net ([217.229.99.127]:15744 "EHLO
	averell.firstfloor.org") by vger.kernel.org with ESMTP
	id S264464AbUANIhL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 03:37:11 -0500
Date: Wed, 14 Jan 2004 09:37:00 +0100
From: Andi Kleen <ak@muc.de>
To: akpm@osdl.org
Cc: jh@suse.cz, linux-kernel@vger.kernel.org
Subject: [PATCH] Fix compilation on gcc 3.4
Message-ID: <20040114083700.GA1820@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The upcomming gcc 3.4 has a new inlining algorithm which sometimes
fails to inline some "dumb" inlines in the kernel. This sometimes leads
to undefined symbols while linking.

To make the kernel compile again this patch drops the always inline
for gcc 3.4.  The new algorithm should be good enough to do the right
thing on its own. 

-Andi

diff -u linux-34/include/linux/compiler-gcc3.h-o linux-34/include/linux/compiler-gcc3.h
--- linux-34/include/linux/compiler-gcc3.h-o	2003-09-28 10:53:23.000000000 +0200
+++ linux-34/include/linux/compiler-gcc3.h	2004-01-13 22:36:22.000000000 +0100
@@ -3,7 +3,9 @@
 /* These definitions are for GCC v3.x.  */
 #include <linux/compiler-gcc.h>
 
-#if __GNUC_MINOR__ >= 1
+/* gcc 3.4 has a new inlining algorithm and always_inline seems to 
+   do more harm than good now. */
+#if __GNUC_MINOR__ >= 1 && __GNUC_MINOR__ < 4
 # define inline		__inline__ __attribute__((always_inline))
 # define __inline__	__inline__ __attribute__((always_inline))
 # define __inline	__inline__ __attribute__((always_inline))



