Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751433AbWICRLA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751433AbWICRLA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Sep 2006 13:11:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751435AbWICRLA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Sep 2006 13:11:00 -0400
Received: from smtp19.orange.fr ([80.12.242.19]:28230 "EHLO
	smtp-msa-out19.orange.fr") by vger.kernel.org with ESMTP
	id S1751433AbWICRK7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Sep 2006 13:10:59 -0400
X-ME-UUID: 20060903171057540.83EC51C00091@mwinf1924.orange.fr
From: Vincent Pelletier <vincent.plr@wanadoo.fr>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched.c: Be a bit more conservative in SMP
Date: Sun, 3 Sep 2006 19:10:56 +0200
User-Agent: KMail/1.9.4
Cc: mingo@elte.hu
References: <200609031541.39984.subdino2004@yahoo.fr>
In-Reply-To: <200609031541.39984.subdino2004@yahoo.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609031910.57259.vincent.plr@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Forgot the signed-off-by line in previous mail. Reposting same patch just in 
case. CC to maintainer as advised in the FAQ.

Signed-off-by: Vincent Pelletier <vincent.plr@wanadoo.fr>

--- linux-2.6-2.6.17/kernel/sched.c     2006-06-18 03:49:35.000000000 +0200
+++ linux-2.6-2.6.17-conservative/kernel/sched.c        2006-09-03
13:18:11.000000000 +0200
@@ -952,7 +952,7 @@ void kick_process(task_t *p)
 static inline unsigned long source_load(int cpu, int type)
 {
        runqueue_t *rq = cpu_rq(cpu);
-       unsigned long load_now = rq->nr_running * SCHED_LOAD_SCALE;
+       unsigned long load_now = (max(rq->nr_running - 1, 0)) *
SCHED_LOAD_SCALE;
        if (type == 0)
                return load_now;

-- 
VGER BF report: U 0.500348
