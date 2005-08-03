Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262412AbVHCS7L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262412AbVHCS7L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 14:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262402AbVHCS7K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 14:59:10 -0400
Received: from pilet.ens-lyon.fr ([140.77.167.16]:12518 "EHLO
	relaissmtp.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S262412AbVHCS6Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 14:58:24 -0400
Date: Wed, 3 Aug 2005 21:00:47 +0200
From: Benoit Boissinot <benoit.boissinot@ens-lyon.org>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: [Patch 2.6.13-rc4-mm1] mips: build fix for spinlock consolidation
Message-ID: <20050803190047.GC13680@ens-lyon.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch is needed for mips to compile with
the spinlock consolidation patch (the include of asm-mips/atomic.h
is moved down to avoid circular dependencies).

Signed-off-by: Benoit Boissinot <benoit.boissinot@ens-lyon.org>


--- linux/include/linux/spinlock.h.orig	2005-08-03 20:49:26.000000000 +0200
+++ linux/include/linux/spinlock.h	2005-08-03 20:54:40.000000000 +0200
@@ -55,7 +55,6 @@
 #include <linux/stringify.h>
 
 #include <asm/system.h>
-#include <asm/atomic.h>
 
 /*
  * Must define these before including other files, inline functions need them
@@ -207,6 +206,11 @@ extern int __lockfunc generic__raw_read_
 	1 : ({ local_irq_restore(flags); 0; }); \
 })
 
+/*
+ * Pull the atomic_t declaration:
+ * (asm-mips/atomic.h needs above definitions)
+ */  
+#include <asm/atomic.h>
 /**
  * atomic_dec_and_lock - lock on reaching reference count zero
  * @atomic: the atomic counter
