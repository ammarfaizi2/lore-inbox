Return-Path: <linux-kernel-owner+w=401wt.eu-S1755144AbWL3Pte@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755144AbWL3Pte (ORCPT <rfc822;w@1wt.eu>);
	Sat, 30 Dec 2006 10:49:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755146AbWL3Ptd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Dec 2006 10:49:33 -0500
Received: from gateway-1237.mvista.com ([63.81.120.158]:27040 "EHLO
	dwalker1.mvista.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755144AbWL3Ptd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Dec 2006 10:49:33 -0500
Message-Id: <20061230154804.862606000@mvista.com>
User-Agent: quilt/0.45-1
Date: Sat, 30 Dec 2006 07:48:04 -0800
From: Daniel Walker <dwalker@mvista.com>
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
CC: Mimi Zohar <zohar@us.ibm.com>
CC: Kylene Hall <kjhall@us.ibm.com>
Subject: [PATCH -rt] panic on SLIM + selinux
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If you have both SLIM and selinux compiled into your kernel selinux will panic
if it can't register itself. The code below, 

if (register_security (&selinux_ops))
	panic("SELinux: Unable to register with kernel.\n");

"security/selinux/hooks.c" 5014 lines --95%--                                                                           4811,35       96%

This could be a bug report cause I bet there's a better way to make these mutually 
exclusive.

Signed-Off-By: Daniel Walker <dwalker@mvista.com>

---
 security/slim/Kconfig |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.19/security/slim/Kconfig
===================================================================
--- linux-2.6.19.orig/security/slim/Kconfig
+++ linux-2.6.19/security/slim/Kconfig
@@ -1,6 +1,6 @@
 config SECURITY_SLIM
 	boolean "SLIM support"
-	depends on SECURITY && SECURITY_NETWORK && INTEGRITY
+	depends on SECURITY && SECURITY_NETWORK && INTEGRITY && !SECURITY_SELINUX
 	help
 	  The Simple Linux Integrity Module implements a modified low water-mark
 	  mandatory access control integrity model.
--
