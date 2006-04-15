Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030223AbWDODLo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030223AbWDODLo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 23:11:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030220AbWDODLM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 23:11:12 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:12015 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1030221AbWDODKz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 23:10:55 -0400
Subject: [PATCH 05/08] percpu -v2 vmlinux.lds.h percpu_offset macro
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Fri, 14 Apr 2006 23:10:53 -0400
Message-Id: <1145070653.27407.32.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Added macro PERCPU_OFFSET to be inserted in the architectures.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux-2.6.17-rc1/include/asm-generic/vmlinux.lds.h
===================================================================
--- linux-2.6.17-rc1.orig/include/asm-generic/vmlinux.lds.h	2006-04-13 20:41:54.000000000 -0400
+++ linux-2.6.17-rc1/include/asm-generic/vmlinux.lds.h	2006-04-14 18:50:07.000000000 -0400
@@ -166,3 +166,11 @@
 		.stab.index 0 : { *(.stab.index) }			\
 		.stab.indexstr 0 : { *(.stab.indexstr) }		\
 		.comment 0 : { *(.comment) }
+
+		/* Per CPU offsets */
+#define PERCPU_OFFSET							\
+		__per_cpu_offset_start = .;				\
+		.data.percpu_offset : AT(ADDR(.data.percpu_offset) - LOAD_OFFSET) { \
+			*(.data.percpu_offset)				\
+		}							\
+		__per_cpu_offset_end = .;


