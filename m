Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030213AbWCQQRg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030213AbWCQQRg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 11:17:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030209AbWCQQRg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 11:17:36 -0500
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:50830 "EHLO
	laptopd505.fenrus.org") by vger.kernel.org with ESMTP
	id S1030207AbWCQQRd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 11:17:33 -0500
Subject: [Patch 5 of 8] Add the __stack_chk_fail() function
From: Arjan van de Ven <arjan@linux.intel.com>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1142611850.3033.100.camel@laptopd505.fenrus.org>
References: <1142611850.3033.100.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 17 Mar 2006 17:14:46 +0100
Message-Id: <1142612087.3033.110.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

GCC emits a call to a __stack_chk_fail() function when the cookie is not 
matching the expected value. Since this is a bad security issue; lets panic
the kernel

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>

---
 kernel/panic.c |    8 ++++++++
 1 file changed, 8 insertions(+)

Index: linux-2.6.16-rc6-stack-protector/kernel/panic.c
===================================================================
--- linux-2.6.16-rc6-stack-protector.orig/kernel/panic.c
+++ linux-2.6.16-rc6-stack-protector/kernel/panic.c
@@ -174,3 +174,11 @@ void add_taint(unsigned flag)
 	tainted |= flag;
 }
 EXPORT_SYMBOL(add_taint);
+
+#ifdef CONFIG_STACK_PROTECTOR
+void __stack_chk_fail(void)
+{
+	panic("stack-protector: Stack is corrupted\n");
+}
+EXPORT_SYMBOL(__stack_chk_fail);
+#endif

