Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030183AbWDNVTj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030183AbWDNVTj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 17:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965178AbWDNVTi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 17:19:38 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:43727 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S965176AbWDNVTf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 17:19:35 -0400
Subject: [PATCH 05/05] percpu i386 linker script update
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Fri, 14 Apr 2006 17:19:33 -0400
Message-Id: <1145049573.1336.137.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add .data.percpu_offset section into arch/i386

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux-2.6.17-rc1/arch/i386/kernel/vmlinux.lds.S
===================================================================
--- linux-2.6.17-rc1.orig/arch/i386/kernel/vmlinux.lds.S	2006-04-14 15:43:49.000000000 -0400
+++ linux-2.6.17-rc1/arch/i386/kernel/vmlinux.lds.S	2006-04-14 15:58:08.000000000 -0400
@@ -62,6 +62,9 @@ SECTIONS
   /* rarely changed data like cpu maps */
   . = ALIGN(32);
   .data.read_mostly : AT(ADDR(.data.read_mostly) - LOAD_OFFSET) { *(.data.read_mostly) }
+  __per_cpu_offset_start = .;
+  .data.percpu_offset  : AT(ADDR(.data.percpu_offset) - LOAD_OFFSET) { *(.data.percpu_offset) }
+  __per_cpu_offset_end = .;
   _edata = .;			/* End of data section */
 
   . = ALIGN(THREAD_SIZE);	/* init_task */


