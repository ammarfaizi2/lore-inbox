Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750775AbWHVSw2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750775AbWHVSw2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 14:52:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750785AbWHVSw2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 14:52:28 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:4745 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750775AbWHVSw2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 14:52:28 -0400
Subject: [PATCH] SRCU: add lock annotations to srcu_read_lock and
	srcu_read_unlock
From: Josh Triplett <josht@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Paul McKenney <paulmck@us.ibm.com>,
       Dipkanar Sarma <dipankar@in.ibm.com>
Content-Type: text/plain
Date: Tue, 22 Aug 2006 11:52:25 -0700
Message-Id: <1156272745.4360.61.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add an __acquires annotation to srcu_read_lock, and add a __releases
annotation to srcu_read_unlock.  This allows static analysis tools to
detect improperly paired calls to these functions.

Signed-off-by: Josh Triplett <josh@freedesktop.org>
---
 include/linux/srcu.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index a950d26..aca0eee 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -45,8 +45,8 @@ #endif /* #else #ifndef CONFIG_PREEMPT *
 
 int init_srcu_struct(struct srcu_struct *sp);
 void cleanup_srcu_struct(struct srcu_struct *sp);
-int srcu_read_lock(struct srcu_struct *sp);
-void srcu_read_unlock(struct srcu_struct *sp, int idx);
+int srcu_read_lock(struct srcu_struct *sp) __acquires(sp);
+void srcu_read_unlock(struct srcu_struct *sp, int idx) __releases(sp);
 void synchronize_srcu(struct srcu_struct *sp);
 long srcu_batches_completed(struct srcu_struct *sp);
 


