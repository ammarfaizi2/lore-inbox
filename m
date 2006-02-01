Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161031AbWBAMAJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161031AbWBAMAJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 07:00:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161032AbWBAMAJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 07:00:09 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:57483 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1161031AbWBAMAH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 07:00:07 -0500
Date: Wed, 1 Feb 2006 12:59:58 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Jan Glauber <jan.glauber@de.ibm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] s390: timer interface visibility.
Message-ID: <20060201115958.GC9361@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Glauber <jan.glauber@de.ibm.com>

Avoid visibility of kernel internal interface to user space.

Signed-off-by: Jan Glauber <jan.glauber@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 include/asm-s390/timer.h |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff -urpN linux-2.6/include/asm-s390/timer.h linux-2.6-patched/include/asm-s390/timer.h
--- linux-2.6/include/asm-s390/timer.h	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6-patched/include/asm-s390/timer.h	2006-02-01 11:04:08.000000000 +0100
@@ -1,7 +1,7 @@
 /*
  *  include/asm-s390/timer.h
  *
- *  (C) Copyright IBM Corp. 2003
+ *  (C) Copyright IBM Corp. 2003,2006
  *  Virtual CPU timer
  *
  *  Author: Jan Glauber (jang@de.ibm.com)
@@ -10,6 +10,8 @@
 #ifndef _ASM_S390_TIMER_H
 #define _ASM_S390_TIMER_H
 
+#ifdef __KERNEL__
+
 #include <linux/timer.h>
 
 #define VTIMER_MAX_SLICE (0x7ffffffffffff000LL)
@@ -43,4 +45,6 @@ extern void add_virt_timer_periodic(void
 extern int mod_virt_timer(struct vtimer_list *timer, __u64 expires);
 extern int del_virt_timer(struct vtimer_list *timer);
 
-#endif
+#endif /* __KERNEL__ */
+
+#endif /* _ASM_S390_TIMER_H */
