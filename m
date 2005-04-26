Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261466AbVDZKiN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261466AbVDZKiN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 06:38:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261478AbVDZKiM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 06:38:12 -0400
Received: from darwin.snarc.org ([81.56.210.228]:13189 "EHLO darwin.snarc.org")
	by vger.kernel.org with ESMTP id S261466AbVDZKiF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 06:38:05 -0400
To: "1/6][XEN]"@snarc.org, "[x86]"@snarc.org, <akpm@osdl.org>,
       ", <ian.pratt@cl.cam.ac.uk>,, <vincent.hanquez@cl.cam.ac.uk>"@snarc.org,
       add@snarc.org, Andrew@snarc.org, debugreg@snarc.org,
       ", for, Hanquez, linux-kernel@vger.kernel.org, macro, Morton, Pratt, Vincent"@snarc.org
Subject: "[PATCH
Cc: Ian@snarc.org
"From: 
Message-Id: <20050426103802.E7DC94BE12@darwin.snarc.org>
Date: Tue, 26 Apr 2005 12:38:02 +0200 (CEST)
From: tab@snarc.org (Vincent Hanquez)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following patch add 2 macros to set and get debugreg on x86.
This is useful for Xen because it will need only to redefine each macro
to a hypervisor call.

I can regenerate a patch keeping loaddebug if you folks seems that is
necessary or better.

Please apply, or comments.

	Signed-off-by: Vincent Hanquez <vincent.hanquez@cl.cam.ac.uk>

diff -Naur linux-2.6.12-rc3/include/asm-i386/processor.h linux-2.6.12-rc3.1/include/asm-i386/processor.h
--- linux-2.6.12-rc3/include/asm-i386/processor.h	2005-04-21 11:46:10.000000000 +0100
+++ linux-2.6.12-rc3.1/include/asm-i386/processor.h	2005-04-22 12:09:43.000000000 +0100
@@ -501,12 +501,16 @@
 } while (0)
 
 /*
- * This special macro can be used to load a debugging register
+ * These special macros can be used to get or set a debugging register
  */
-#define loaddebug(thread,register) \
-               __asm__("movl %0,%%db" #register  \
-                       : /* no output */ \
-                       :"r" ((thread)->debugreg[register]))
+#define cpu_get_debugreg(var, register)				\
+		__asm__("movl %%db" #register ", %0"		\
+			:"=r" (var))
+#define cpu_set_debugreg(value, register)			\
+		__asm__("movl %0,%%db" #register		\
+			: /* no output */			\
+			:"r" (value))
+
 
 /* Forward declaration, a strange C thing */
 struct task_struct;
