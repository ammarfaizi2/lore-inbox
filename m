Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264629AbUEXSwq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264629AbUEXSwq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 14:52:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264632AbUEXSwp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 14:52:45 -0400
Received: from mx1.elte.hu ([157.181.1.137]:386 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S264629AbUEXSwo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 14:52:44 -0400
Date: Mon, 24 May 2004 22:54:02 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Christian Meder <chris@onestepahead.de>
Subject: [patch] minor sched.c cleanup, BK-curr
Message-ID: <20040524205402.GA16710@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.26.8-itk2 (ELTE 1.1) SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9, BAYES_00 -4.90,
	UPPERCASE_25_50 0.00
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus, Andrew,

the following obviously correct patch from Christian Meder simplifies
the DELTA() define. It's against BK-curr.

Signed-off-by: Christian Meder <chris@onestepahead.de>
Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- linux/kernel/sched.c.orig	
+++ linux/kernel/sched.c	
@@ -141,8 +141,7 @@
 	(v1) * (v2_max) / (v1_max)
 
 #define DELTA(p) \
-	(SCALE(TASK_NICE(p), 40, MAX_USER_PRIO*PRIO_BONUS_RATIO/100) + \
-		INTERACTIVE_DELTA)
+	(SCALE(TASK_NICE(p), 40, MAX_BONUS) + INTERACTIVE_DELTA)
 
 #define TASK_INTERACTIVE(p) \
 	((p)->prio <= (p)->static_prio - DELTA(p))
