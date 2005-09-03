Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751032AbVICMX0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751032AbVICMX0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 08:23:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751050AbVICMX0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 08:23:26 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:5823 "EHLO smtp2-g19.free.fr")
	by vger.kernel.org with ESMTP id S1751024AbVICMX0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 08:23:26 -0400
Message-ID: <1125750204.431995bc984c3@imp4-g19.free.fr>
Date: Sat, 03 Sep 2005 14:23:24 +0200
From: Renaud Lienhart <renaud.lienhart@free.fr>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, mingo@elte.hu
Subject: [PATCH 2.6.13-mm1] use cached variable in sys_sched_yield()
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.5
X-Originating-IP: 81.51.169.14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In sys_sched_yield(), we cache current->array in the "array" variable, thus
there's no need to dereference "current" again later.

Signed-Off-By: Renaud Lienhart <renaud.lienhart@free.fr>

--- a/kernel/sched.c	Sat Sep  3 14:01:38 2005
+++ b/kernel/sched.c	Sat Sep  3 14:02:47 2005
@@ -4058,7 +4058,7 @@
 	if (rt_task(current))
 		target = rq->active;

-	if (current->array->nr_active == 1) {
+	if (array->nr_active == 1) {
 		schedstat_inc(rq, yld_act_empty);
 		if (!rq->expired->nr_active)
 			schedstat_inc(rq, yld_both_empty);
