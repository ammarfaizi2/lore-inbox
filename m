Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262700AbUBZGps (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 01:45:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262701AbUBZGps
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 01:45:48 -0500
Received: from dp.samba.org ([66.70.73.150]:40858 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262700AbUBZGpk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 01:45:40 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: akpm@osdl.org, torvalds@osdl.org
Cc: viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org
Subject: [PATCH] __cacheline_aligned always in own section
Date: Thu, 26 Feb 2004 17:44:47 +1100
Message-Id: <20040226064551.1E44B2C57E@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Name: Always Put Cache Aligned Code in Own Section: Even Modules
Status: Tested on 2.6.3-bk7

We put ____cacheline_aligned things in their own section, simply
because we waste less space that way.  Otherwise we end up padding
innocent variables to the next cacheline to get the required
alignment.

There's no reason not to do this in modules, too.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .16274-linux-2.6.3-bk7/include/linux/cache.h .16274-linux-2.6.3-bk7.updated/include/linux/cache.h
--- .16274-linux-2.6.3-bk7/include/linux/cache.h	2003-09-22 09:47:16.000000000 +1000
+++ .16274-linux-2.6.3-bk7.updated/include/linux/cache.h	2004-02-26 16:43:49.000000000 +1100
@@ -26,13 +26,9 @@
 #endif
 
 #ifndef __cacheline_aligned
-#ifdef MODULE
-#define __cacheline_aligned ____cacheline_aligned
-#else
 #define __cacheline_aligned					\
   __attribute__((__aligned__(SMP_CACHE_BYTES),			\
 		 __section__(".data.cacheline_aligned")))
-#endif
 #endif /* __cacheline_aligned */
 
 #ifndef __cacheline_aligned_in_smp

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
