Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265961AbUAUE24 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 23:28:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265964AbUAUE24
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 23:28:56 -0500
Received: from dp.samba.org ([66.70.73.150]:52704 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S265961AbUAUE2y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 23:28:54 -0500
Date: Wed, 21 Jan 2004 15:27:04 +1100
From: Anton Blanchard <anton@samba.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] initialise cpu_vm_mask in init_mm
Message-ID: <20040121042704.GB4372@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Some architectures use cpu_vm_mask to optimise TLB flushes. On ppc64 we
are now using a common flush infrastructure that handles both userspace
and kernelspace (vmalloc) pages. In order to avoid triggering this
optimisation we need to mark the init mm as having scheduled on all
cpus.

Things currently work by luck (we check for the cpu only having run on
the local cpu, and the field is initialised to 0), but it would be safer
to initialise it CPU_MASK_ALL.

Anton

===== include/linux/init_task.h 1.27 vs edited =====
--- 1.27/include/linux/init_task.h	Tue Aug 19 12:46:23 2003
+++ edited/include/linux/init_task.h	Wed Jan 21 15:04:09 2004
@@ -40,6 +40,7 @@
 	.mmap_sem	= __RWSEM_INITIALIZER(name.mmap_sem),	\
 	.page_table_lock =  SPIN_LOCK_UNLOCKED, 		\
 	.mmlist		= LIST_HEAD_INIT(name.mmlist),		\
+	.cpu_vm_mask	= CPU_MASK_ALL,				\
 	.default_kioctx = INIT_KIOCTX(name.default_kioctx, name),	\
 }
 
