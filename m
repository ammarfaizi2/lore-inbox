Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265922AbTFSTX3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 15:23:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265924AbTFSTX2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 15:23:28 -0400
Received: from palrel12.hp.com ([156.153.255.237]:55238 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S265922AbTFSTXY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 15:23:24 -0400
Date: Thu, 19 Jun 2003 12:37:22 -0700
From: David Mosberger <davidm@napali.hpl.hp.com>
Message-Id: <200306191937.h5JJbMff032515@napali.hpl.hp.com>
To: drepper@redhat.com, mingo@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: potential set_child_tid/clear_child_tid bug
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Reply-To: davidm@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At the moment, if you don't set CLONE_CHILD_SETTID/CLONE_CHILD_CLEARTID,
the {set,clear}_child_tid values get inherited from the parent task.
I may be missing something, but I suspect that's not the intended behavior.
The patch below instead clears the respective members.

	--david

diff -Nru a/kernel/fork.c b/kernel/fork.c
--- a/kernel/fork.c	Thu Jun 19 12:20:17 2003
+++ b/kernel/fork.c	Thu Jun 19 12:20:17 2003
@@ -889,11 +889,15 @@
 
 	if (clone_flags & CLONE_CHILD_SETTID)
 		p->set_child_tid = child_tidptr;
+	else
+		p->set_child_tid = NULL;
 	/*
 	 * Clear TID on mm_release()?
 	 */
 	if (clone_flags & CLONE_CHILD_CLEARTID)
 		p->clear_child_tid = child_tidptr;
+	else
+		p->clear_child_tid = NULL;
 
 	/*
 	 * Syscall tracing should be turned off in the child regardless
