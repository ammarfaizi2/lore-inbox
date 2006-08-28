Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750760AbWH1UER@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbWH1UER (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 16:04:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbWH1UER
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 16:04:17 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:18073 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S1750760AbWH1UER (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 16:04:17 -0400
Date: Mon, 28 Aug 2006 22:04:16 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Andrew Morton <akpm@osdl.org>
Cc: dhowells@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH -mm] lib/rwsem.c: un-inline rwsem_down_failed_common()
Message-ID: <20060828200416.GA31315@rhlx01.fht-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Un-inlining rwsem_down_failed_common() (two callsites) reduced
lib/rwsem.o on my Athlon, gcc 4.1.2 from 5935 to 5480 Bytes (455 Bytes saved).

I thus guess that reduced icache footprint (and better function caching)
is worth more than any function call overhead.

Compile-tested and run-tested on 2.6.18-rc4-mm3.


Signed-off-by: Andreas Mohr <andi@lisas.de>

--- linux-2.6.18-rc4-mm3.orig/lib/rwsem.c	2006-08-22 21:09:55.000000000 +0200
+++ linux-2.6.18-rc4-mm3/lib/rwsem.c	2006-09-05 21:52:09.000000000 +0200
@@ -146,7 +146,7 @@
 /*
  * wait for a lock to be granted
  */
-static inline struct rw_semaphore *
+static struct rw_semaphore *
 rwsem_down_failed_common(struct rw_semaphore *sem,
 			struct rwsem_waiter *waiter, signed long adjustment)
 {
