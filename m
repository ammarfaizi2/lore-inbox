Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261533AbULNQee@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261533AbULNQee (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 11:34:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261544AbULNQee
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 11:34:34 -0500
Received: from mx1.redhat.com ([66.187.233.31]:31953 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261533AbULNQe2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 11:34:28 -0500
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] FRV update the trap tables comment
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.3
Date: Tue, 14 Dec 2004 16:34:19 +0000
Message-ID: <9801.1103042059@redhat.com>
From: David Howells <dhowells@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The attached patch updates the FRV trap tables comment to make it more
appropriate.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat frv-trap-comment-2610rc3.diff 
 entry-table.S |   40 +++++++++++++++++++++++++++++-----------
 1 files changed, 29 insertions(+), 11 deletions(-)

diff -uNr linux-2.6.10-rc3-mm1-mmcleanup/arch/frv/kernel/entry-table.S linux-2.6.10-rc3-mm1-misc/arch/frv/kernel/entry-table.S
--- linux-2.6.10-rc3-mm1-mmcleanup/arch/frv/kernel/entry-table.S	2004-12-13 17:33:50.000000000 +0000
+++ linux-2.6.10-rc3-mm1-misc/arch/frv/kernel/entry-table.S	2004-12-13 19:28:04.000000000 +0000
@@ -17,19 +17,37 @@
 
 ###############################################################################
 #
-# declare the main trap and vector tables
+# Declare the main trap and vector tables
 #
-# - the first instruction in each slot is a branch to the appropriate
-#   kernel-mode handler routine
+# There are six tables:
 #
-# - the second instruction in each slot is a branch to the debug-mode hardware
-#   single-step bypass handler - this is called from break.S to deal with the
-#   CPU stepping in to exception handlers (particular where external interrupts
-#   are concerned)
-#
-# - the linker script places the user mode and kernel mode trap tables on to
-#   the same 8Kb page, so that break.S can be more efficient when performing
-#   single-step bypass management
+# (1) The trap table for debug mode
+# (2) The trap table for kernel mode
+# (3) The trap table for user mode
+#
+#     The CPU jumps to an appropriate slot in the appropriate table to perform
+#     exception processing. We have three different tables for the three
+#     different CPU modes because there is no hardware differentiation between
+#     stack pointers for these three modes, and so we have to invent one when
+#     crossing mode boundaries.
+#
+# (4) The exception handler vector table
+#
+#     The user and kernel trap tables use the same prologue for normal
+#     exception processing. The prologue then jumps to the handler in this
+#     table, as indexed by the exception ID from the TBR.
+#
+# (5) The fixup table for kernel-trap single-step
+# (6) The fixup table for user-trap single-step
+#
+#     Due to the way single-stepping works on this CPU (single-step is not
+#     disabled when crossing exception boundaries, only when in debug mode),
+#     we have to catch the single-step event in break.S and jump to the fixup
+#     routine pointed to by this table.
+#
+# The linker script places the user mode and kernel mode trap tables on to
+# the same 8Kb page, so that break.S can be more efficient when performing
+# single-step bypass management
 #
 ###############################################################################
 
