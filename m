Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030472AbWFVXRz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030472AbWFVXRz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 19:17:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030470AbWFVXRz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 19:17:55 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:9664 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1030466AbWFVXRm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 19:17:42 -0400
Date: Fri, 23 Jun 2006 07:17:45 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] uninline task_rq_lock()
Message-ID: <20060623031745.GA2917@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Saves 543 bytes from sched.o (gcc 3.3.3).

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.17-rc6/kernel/sched.c~LOCK	2006-06-23 06:46:57.000000000 +0400
+++ 2.6.17-rc6/kernel/sched.c	2006-06-23 07:03:06.000000000 +0400
@@ -355,7 +355,7 @@ static inline void finish_lock_switch(ru
  * interrupts.  Note the ordering: we can safely lookup the task_rq without
  * explicitly disabling preemption.
  */
-static inline runqueue_t *task_rq_lock(task_t *p, unsigned long *flags)
+static runqueue_t *task_rq_lock(task_t *p, unsigned long *flags)
 	__acquires(rq->lock)
 {
 	struct runqueue *rq;

