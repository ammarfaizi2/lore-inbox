Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751033AbWIYUOt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751033AbWIYUOt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 16:14:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751092AbWIYUO1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 16:14:27 -0400
Received: from 17.sub-70-199-97.myvzw.com ([70.199.97.17]:46495 "EHLO
	mail.goop.org") by vger.kernel.org with ESMTP id S1751062AbWIYUOS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 16:14:18 -0400
Message-Id: <20060925184639.290985244@goop.org>
References: <20060925184540.601971833@goop.org>
User-Agent: quilt/0.45-1
Date: Mon, 25 Sep 2006 11:45:46 -0700
From: jeremy@goop.org
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, Chuck Ebbert <76306.1226@compuserve.com>,
       Zachary Amsden <zach@vmware.com>, Jan Beulich <jbeulich@novell.com>,
       Andi Kleen <ak@suse.de>
Subject: [PATCH 6/6] Implement "current" with the PDA.
Content-Disposition: inline; filename=pda/i386-pda-current.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use the pcurrent field in the PDA to implement the "current" macro.
This ends up compiling down to a single instruction to get the current
task.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Cc: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Zachary Amsden <zach@vmware.com>
Cc: Jan Beulich <jbeulich@novell.com>
Cc: Andi Kleen <ak@suse.de>

---
 include/asm-i386/current.h |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff -r 3752f3a5974a include/asm-i386/current.h
--- a/include/asm-i386/current.h	Mon Sep 25 01:48:09 2006 -0700
+++ b/include/asm-i386/current.h	Mon Sep 25 01:48:09 2006 -0700
@@ -1,13 +1,14 @@
 #ifndef _I386_CURRENT_H
 #define _I386_CURRENT_H
 
-#include <linux/thread_info.h>
+#include <asm/pda.h>
+#include <linux/compiler.h>
 
 struct task_struct;
 
-static __always_inline struct task_struct * get_current(void)
+static __always_inline struct task_struct *get_current(void)
 {
-	return current_thread_info()->task;
+	return read_pda(pcurrent);
 }
 
 #define current get_current()

--

