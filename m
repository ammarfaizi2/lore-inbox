Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272012AbTHMXkJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 19:40:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272043AbTHMXkJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 19:40:09 -0400
Received: from waste.org ([209.173.204.2]:22475 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S272012AbTHMXkG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 19:40:06 -0400
Date: Wed, 13 Aug 2003 18:39:57 -0500
From: Matt Mackall <mpm@selenic.com>
To: James Morris <jmorris@intercode.com.au>,
       "David S. Miller" <davem@redhat.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] cryptoapi: Fix sleeping
Message-ID: <20030813233957.GE325@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We need in_atomic() so that we can call from regions where preempt is
disabled, for instance when using per_cpu crypto tfms.

diff -urN -X dontdiff orig/crypto/internal.h work/crypto/internal.h
--- orig/crypto/internal.h	2003-07-13 22:29:11.000000000 -0500
+++ work/crypto/internal.h	2003-08-12 14:38:54.000000000 -0500
@@ -37,7 +37,7 @@
 
 static inline void crypto_yield(struct crypto_tfm *tfm)
 {
-	if (!in_softirq())
+	if (!in_atomic())
 		cond_resched();
 }
 


-- 
Matt Mackall : http://www.selenic.com : of or relating to the moon
