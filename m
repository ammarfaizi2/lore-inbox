Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261479AbVDZKzy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261479AbVDZKzy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 06:55:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261461AbVDZKzy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 06:55:54 -0400
Received: from hades.snarc.org ([212.85.152.11]:62215 "EHLO hades.snarc.org")
	by vger.kernel.org with ESMTP id S261482AbVDZKzd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 06:55:33 -0400
Date: Tue, 26 Apr 2005 12:55:26 +0200
From: Vincent Hanquez <vincent.hanquez@cl.cam.ac.uk>
To: linux-kernel@vger.kernel.org
Cc: ian.pratt@cl.cam.ac.uk, akpm@osdl.org
Subject: [PATCH 1/6][XEN][x86] add macro for debugreg
Message-ID: <20050426105526.GA26614@snarc.org>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	ian.pratt@cl.cam.ac.uk, akpm@osdl.org
References: <20050426103802.E7DC94BE12@darwin.snarc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050426103802.E7DC94BE12@darwin.snarc.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following patch add 2 macros to set and get debugreg on x86.
This is useful for Xen because it will need only to redefine each macro
to a hypervisor call.

I can regenerate a patch keeping loaddebug if you folks seems that is
necessary or better.

ignore my previous mail, really sorry for the noise.

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
