Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289345AbSAJFr1>; Thu, 10 Jan 2002 00:47:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289346AbSAJFrR>; Thu, 10 Jan 2002 00:47:17 -0500
Received: from zero.tech9.net ([209.61.188.187]:32779 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S289345AbSAJFrE>;
	Thu, 10 Jan 2002 00:47:04 -0500
Subject: Re: lock order in O(1) scheduler
From: Robert Love <rml@tech9.net>
To: "David S. Miller" <davem@redhat.com>
Cc: kevin@koconnor.net, mingo@elte.hu, linux-kernel@vger.kernel.org
In-Reply-To: <20020109.212957.59465864.davem@redhat.com>
In-Reply-To: <20020110001002.A13456@arizona.localdomain>
	<1010640369.5335.289.camel@phantasy> 
	<20020109.212957.59465864.davem@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.0.99+cvs.2001.12.18.08.57 (Preview Release)
Date: 10 Jan 2002 00:49:24 -0500
Message-Id: <1010641765.5340.295.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-01-10 at 00:29, David S. Miller wrote:

> Unlocking order doesn't matter wrt. ABBA deadlock.

Indeed.  Thank you.

Anyhow, Ingo, here is a patch for the typo in set_cpus_allowed:

diff -urN linux-2.5.2-pre10/ linux/
--- linux-2.5.2-pre10/kernel/sched.c	Tue Jan  8 00:26:17 2002
+++ linux/kernel/sched.c	Thu Jan 10 00:41:38 2002
@@ -813,8 +813,8 @@
 		spin_lock_irq(&target_rq->lock);
 		spin_lock(&this_rq->lock);
 	} else {
-		spin_lock_irq(&target_rq->lock);
-		spin_lock(&this_rq->lock);
+		spin_lock_irq(&this_rq->lock);
+		spin_lock(&target_rq->lock);
 	}
 	dequeue_task(p, p->array);
 	this_rq->nr_running--;

	Robert Love

