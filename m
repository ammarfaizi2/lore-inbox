Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751199AbWDCIZg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751199AbWDCIZg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 04:25:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbWDCIZg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 04:25:36 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:30342 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751199AbWDCIZg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 04:25:36 -0400
X-Mailer: exmh version 2.7.0 06/18/2004 with nmh-1.1-RC1
From: Keith Owens <kaos@sgi.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
cc: Eric Biederman <ebiederm@xmission.com>, linux-kernel@vger.kernel.org
Subject: [patch 2.6.17-rc1] Reinstate const in next_thread()
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 03 Apr 2006 18:25:21 +1000
Message-ID: <25335.1144052721@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Before commit 47e65328a7b1cdfc4e3102e50d60faf94ebba7d3, next_thread()
took a const task_t.  Reinstate the const qualifier, getting the next
thread never changes the current thread.

Signed-off-by: Keith Owens <kaos@sgi.com>

Index: linux/include/linux/sched.h
===================================================================
--- linux.orig/include/linux/sched.h	2006-04-03 18:20:22.000000000 +1000
+++ linux/include/linux/sched.h	2006-04-03 18:20:36.309150547 +1000
@@ -1205,7 +1205,7 @@ extern void wait_task_inactive(task_t * 
 
 #define thread_group_leader(p)	(p->pid == p->tgid)
 
-static inline task_t *next_thread(task_t *p)
+static inline task_t *next_thread(const task_t *p)
 {
 	return list_entry(rcu_dereference(p->thread_group.next),
 				task_t, thread_group);

