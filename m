Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750875AbWAYJJE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750875AbWAYJJE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 04:09:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751064AbWAYJJE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 04:09:04 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:57996 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1750875AbWAYJJC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 04:09:02 -0500
Date: Wed, 25 Jan 2006 11:08:27 +0200 (EET)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Blaisorblade <blaisorblade@yahoo.it>
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       jdike@karaya.com
Subject: [PATCH] um: fix compliation error when CONFIG_SKAS is disabled
Message-ID: <Pine.LNX.4.58.0601251105120.23552@sbz-30.cs.Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pekka Enberg <penberg@cs.helsinki.fi>

This patch fixes the following compilation error when CONFIG_SKAS is disabled:

  CC      arch/um/sys-i386/ldt.o
arch/um/sys-i386/ldt.c:19:21: proc_mm.h: No such file or directory
make[1]: *** [arch/um/sys-i386/ldt.o] Error 1

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

Index: 2.6/arch/um/sys-i386/ldt.c
===================================================================
--- 2.6.orig/arch/um/sys-i386/ldt.c
+++ 2.6/arch/um/sys-i386/ldt.c
@@ -16,7 +16,6 @@
 #include "choose-mode.h"
 #include "kern.h"
 #include "mode_kern.h"
-#include "proc_mm.h"
 #include "os.h"
 
 extern int modify_ldt(int func, void *ptr, unsigned long bytecount);
@@ -90,6 +89,7 @@ out:
 #include "skas.h"
 #include "skas_ptrace.h"
 #include "asm/mmu_context.h"
+#include "proc_mm.h"
 
 long write_ldt_entry(struct mm_id * mm_idp, int func, struct user_desc * desc,
 		     void **addr, int done)
