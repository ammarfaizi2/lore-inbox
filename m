Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265252AbUENLQr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265252AbUENLQr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 07:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265248AbUENLQq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 07:16:46 -0400
Received: from ozlabs.org ([203.10.76.45]:8365 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S265253AbUENLQI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 07:16:08 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16548.43651.116750.399000@cargo.ozlabs.ibm.com>
Date: Fri, 14 May 2004 21:16:19 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: mporter@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: [PATCH][PPC32] Fix pmac compile after OCP changes
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Porter's recent changes broke the compile for non-4xx ppc32
systems, unfortunately.  I get an error that mfdcr is not defined in
include/asm-ppc/ocp.h when compiling for powermac (reasonable, since
the mfdcr instruction only exists on 4xx processors).  The patch below
fixes it.

Please apply.

Thanks,
Paul.

diff -urN mporter-2.5/include/asm-ppc/ocp.h ppc-2.5/include/asm-ppc/ocp.h
--- mporter-2.5/include/asm-ppc/ocp.h	2004-05-14 19:09:48.517981840 +1000
+++ ppc-2.5/include/asm-ppc/ocp.h	2004-05-14 16:45:28.000000000 +1000
@@ -35,6 +35,8 @@
 #include <asm/rwsem.h>
 #include <asm/semaphore.h>
 
+#ifdef CONFIG_PPC_OCP
+
 #define OCP_MAX_IRQS	7
 #define MAX_EMACS	4
 #define OCP_IRQ_NA	-1	/* used when ocp device does not have an irq */
@@ -200,5 +202,6 @@
 #include <asm/ibm_ocp.h>
 #endif
 
+#endif				/* CONFIG_PPC_OCP */
 #endif				/* __OCP_H__ */
 #endif				/* __KERNEL__ */
