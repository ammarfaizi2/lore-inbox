Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261896AbUCDNkJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 08:40:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261898AbUCDNkJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 08:40:09 -0500
Received: from kamikaze.scarlet-internet.nl ([213.204.195.165]:1167 "EHLO
	kamikaze.scarlet-internet.nl") by vger.kernel.org with ESMTP
	id S261896AbUCDNkD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 08:40:03 -0500
Message-ID: <1078407599.404731af80bfc@webmail.dds.nl>
Date: Thu,  4 Mar 2004 14:39:59 +0100
From: wdebruij@dds.nl
To: wdebruij@dds.nl
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [UPDATE] Re: [PATCH] 2.6.3 very small patch: libc compatibility for skbuff.h (userspace access to sk_buffs)
References: <1078404558.404725ceb404c@webmail.dds.nl>
In-Reply-To: <1078404558.404725ceb404c@webmail.dds.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

new version. Now uses sys/time.h in userspace to resolve timevals. Also, the
patch mimetype is no longer (erroneously) reported as application/-octet-stream
(since I just pasted it in below).

----begin---

--- linux-2.6.3-orig/include/linux/skbuff.h	2004-02-18 04:58:26.000000000 +0100
+++ linux-2.6.3/include/linux/skbuff.h	2004-03-04 11:10:49.716489408 +0100
@@ -14,19 +14,26 @@
 #ifndef _LINUX_SKBUFF_H
 #define _LINUX_SKBUFF_H

+#ifdef __KERNEL__
 #include <linux/config.h>
 #include <linux/kernel.h>
 #include <linux/compiler.h>
 #include <linux/time.h>
 #include <linux/cache.h>
-
 #include <asm/atomic.h>
+#else
+#include <sys/time.h>
+#endif
+
 #include <asm/types.h>
 #include <linux/spinlock.h>
+
+#ifdef __KERNEL__
 #include <linux/mm.h>
 #include <linux/highmem.h>
 #include <linux/poll.h>
 #include <linux/net.h>
+#endif

 #define HAVE_ALLOC_SKB		/* For the drivers to know */
 #define HAVE_ALIGNABLE_SKB	/* Ditto 8)		   */

