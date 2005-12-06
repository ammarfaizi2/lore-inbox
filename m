Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030220AbVLFUYN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030220AbVLFUYN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 15:24:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030219AbVLFUYM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 15:24:12 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:62638 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1030218AbVLFUYL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 15:24:11 -0500
Subject: [PATCH] um: fix compile error for tt
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, jdike@karaya.com,
       user-mode-linux-devel@lists.sourceforge.net
Date: Tue, 06 Dec 2005 22:24:09 +0200
Message-Id: <1133900650.3279.9.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.4.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Without the included patch, I get the following compile error for um:

arch/um/kernel/tt/uaccess.c: In function `copy_from_user_tt':
arch/um/kernel/tt/uaccess.c:11: error: `FIXADDR_USER_START' undeclared (first use in this function)
arch/um/kernel/tt/uaccess.c:11: error: (Each undeclared identifier is reported only once
arch/um/kernel/tt/uaccess.c:11: error: for each function it appears in.)

The error only happens when I disable CONFIG_MODE_SKAS.

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 uaccess-tt.h |    1 +
 1 file changed, 1 insertion(+)

Index: 2.6/arch/um/kernel/tt/include/uaccess-tt.h
===================================================================
--- 2.6.orig/arch/um/kernel/tt/include/uaccess-tt.h
+++ 2.6/arch/um/kernel/tt/include/uaccess-tt.h
@@ -8,6 +8,7 @@
 
 #include "linux/string.h"
 #include "linux/sched.h"
+#include "asm/fixmap.h"
 #include "asm/processor.h"
 #include "asm/errno.h"
 #include "asm/current.h"


