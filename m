Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751332AbWE2Vox@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751332AbWE2Vox (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 17:44:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbWE2VXn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 17:23:43 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:5816 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751321AbWE2VXj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 17:23:39 -0400
Date: Mon, 29 May 2006 23:23:59 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>
Subject: [patch 11/61] lock validator: lockdep: small xfs init_rwsem() cleanup
Message-ID: <20060529212359.GK3155@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060529212109.GA2058@elte.hu>
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

From: Ingo Molnar <mingo@elte.hu>

init_rwsem() has no return value. This is not a problem if init_rwsem()
is a function, but it's a problem if it's a do { ... } while (0) macro.
(which lockdep introduces)

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
---
 fs/xfs/linux-2.6/mrlock.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux/fs/xfs/linux-2.6/mrlock.h
===================================================================
--- linux.orig/fs/xfs/linux-2.6/mrlock.h
+++ linux/fs/xfs/linux-2.6/mrlock.h
@@ -28,7 +28,7 @@ typedef struct {
 } mrlock_t;
 
 #define mrinit(mrp, name)	\
-	( (mrp)->mr_writer = 0, init_rwsem(&(mrp)->mr_lock) )
+	do { (mrp)->mr_writer = 0; init_rwsem(&(mrp)->mr_lock); } while (0)
 #define mrlock_init(mrp, t,n,s)	mrinit(mrp, n)
 #define mrfree(mrp)		do { } while (0)
 #define mraccess(mrp)		mraccessf(mrp, 0)
