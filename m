Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265928AbTFSThu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 15:37:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265918AbTFSTht
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 15:37:49 -0400
Received: from palrel10.hp.com ([156.153.255.245]:11433 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S265928AbTFSThr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 15:37:47 -0400
Date: Thu, 19 Jun 2003 12:51:45 -0700
From: David Mosberger <davidm@napali.hpl.hp.com>
Message-Id: <200306191951.h5JJpj3A032683@napali.hpl.hp.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: init_thread_union really needed by modules?
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Reply-To: davidm@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is it really necessary for init_thread_union to be exported to
modules?  If not, would you mind applying the attached patch.  (We
haven't exported the symbol on ia64 for ages, with no apparent ill
effects.)

Furthermore, if this patch can be applied, we should be able to make
the init_thread_union local to arch/ARCH/kernel/init_task.c and
that in turn would let us remove its declaration from
include/linux/sched.h alltogether (i.e., no more ugly #ifdefs).

Thanks,

	--david

===== kernel/ksyms.c 1.203 vs edited =====
--- 1.203/kernel/ksyms.c	Wed Jun 11 19:53:38 2003
+++ edited/kernel/ksyms.c	Thu Jun 19 12:46:35 2003
@@ -592,7 +592,6 @@
 /* init task, for moving kthread roots - ought to export a function ?? */
 
 EXPORT_SYMBOL(init_task);
-EXPORT_SYMBOL(init_thread_union);
 
 EXPORT_SYMBOL(tasklist_lock);
 EXPORT_SYMBOL(find_task_by_pid);
