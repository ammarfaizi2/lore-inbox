Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272557AbTHPCIb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 22:08:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272559AbTHPCIb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 22:08:31 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:9162
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S272557AbTHPCI3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 22:08:29 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: [PATCH]O16.1int was Re: [PATCH] O16int for interactivity
Date: Sat, 16 Aug 2003 12:14:43 +1000
User-Agent: KMail/1.5.3
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       gaxt <gaxt@rogers.com>, Mike Galbraith <efault@gmx.de>
References: <200308160149.29834.kernel@kolivas.org> <1060974000.692.5.camel@teapot.felipe-alfaro.com>
In-Reply-To: <1060974000.692.5.camel@teapot.felipe-alfaro.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_TOZP/nRk9nQt4oq"
Message-Id: <200308161214.43966.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_TOZP/nRk9nQt4oq
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sat, 16 Aug 2003 05:00, Felipe Alfaro Solana wrote:
> Well, I'm sorry to say there's something really wrong here with O16int.
> 2.6.0-test3-mm2 plus O16int takes exactly twice the time to boot than

Easy fix. Sorry about that. Here is an O16.1int patch. Backs out the selective 
preemption by only interactive tasks.

Con

--Boundary-00=_TOZP/nRk9nQt4oq
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="patch-O16-O16.1int"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="patch-O16-O16.1int"

--- linux-2.6.0-test3-mm2/kernel/sched.c	2003-08-16 12:01:38.000000000 +1000
+++ linux-2.6.0-test3-mm2-O16/kernel/sched.c	2003-08-16 12:11:03.000000000 +1000
@@ -566,8 +566,7 @@ repeat:
 
 static inline int task_preempts_curr(task_t *p, runqueue_t *rq)
 {
-	if (p->prio < rq->curr->prio &&
-		((TASK_INTERACTIVE(p) && p->mm) || !p->mm)) {
+	if (p->prio < rq->curr->prio) {
 			/*
 			 * Prevent a task preempting it's own waker
 			 * to avoid starvation

--Boundary-00=_TOZP/nRk9nQt4oq--

