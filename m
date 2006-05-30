Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932222AbWE3KLD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932222AbWE3KLD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 06:11:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932225AbWE3KLC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 06:11:02 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:59270 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932222AbWE3KLA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 06:11:00 -0400
Date: Tue, 30 May 2006 12:11:23 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [patch, -rc5-mm1] lock validator: rwsem build fix for non-x86 architectures
Message-ID: <20060530101123.GC31982@elte.hu>
References: <20060530022925.8a67b613.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060530022925.8a67b613.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: lock validator: rwsem build fix for non-x86 architectures
From: Ingo Molnar <mingo@elte.hu>

rwsem build fix for non-x86 architectures which use their own
asm/rwsem.h and have no __init_rwsem method yet.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
---
 include/linux/rwsem.h |    4 ++++
 1 file changed, 4 insertions(+)

Index: linux/include/linux/rwsem.h
===================================================================
--- linux.orig/include/linux/rwsem.h
+++ linux/include/linux/rwsem.h
@@ -30,8 +30,12 @@ struct rw_semaphore;
  * Lockdep: type splitting can also be done for dynamic locks, if for
  * example there are per-CPU dynamically allocated locks:
  */
+#ifdef CONFIG_PROVE_RWSEM_LOCKING
 #define init_rwsem_key(sem, key)				\
 	__init_rwsem((sem), #sem, key)
+#else
+# define init_rwsem_key(sem, key)	init_rwsem(sem)
+#endif
 
 #ifndef rwsemtrace
 #if RWSEM_DEBUG
