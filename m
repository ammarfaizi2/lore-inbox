Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030224AbWAXBRv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030224AbWAXBRv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 20:17:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030250AbWAXBRv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 20:17:51 -0500
Received: from liaag1ad.mx.compuserve.com ([149.174.40.30]:37833 "EHLO
	liaag1ad.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1030224AbWAXBRu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 20:17:50 -0500
Date: Mon, 23 Jan 2006 20:16:18 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [patch 5/9] ia32 syscalls: switch UML to shared table
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>,
       Jeff Dike <jdike@addtoit.com>
Message-ID: <200601232017_MC3-1-B683-9F3D@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

References: <200601231938_MC3-1-B687-7C42@compuserve.com>
In-Reply-To: <200601231938_MC3-1-B687-7C42@compuserve.com>

Shared ia32 syscall table 5/9:

Switch uml to the new shared syscall table.

Signed-Off-By: Chuck Ebbert <76306.1226@compuserve.com>

--- 2.6.16-rc1-mm2.orig/arch/um/sys-i386/sys_call_table.S
+++ 2.6.16-rc1-mm2/arch/um/sys-i386/sys_call_table.S
@@ -13,13 +13,18 @@
 #define sys_time um_time
 
 /*
- * old_mmap and old_select will be renamed
+ * old_mmap and old_select were renamed
  * to sys_old_mmap and sys_old_select.
- * Be compatible with both old and new names.
  */
-#define old_mmap old_mmap_i386
 #define sys_old_mmap old_mmap_i386
-
 #define sys_old_select old_select
 
-#include "../../i386/kernel/syscall_table.S"
+#define syscall_ptr_type	.long
+#define SYSCALL(func)		RAWSYSCALL(sys_ ## func)
+#define SYS32CALL		SYSCALL
+#define STUB32CALL		SYSCALL
+#define COMPATCALL		SYSCALL
+
+ENTRY(sys_call_table)
+
+#include "../../i386/kernel/syscall_tbl.S"
-- 
Chuck
