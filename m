Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129166AbQKPVOG>; Thu, 16 Nov 2000 16:14:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129707AbQKPVN5>; Thu, 16 Nov 2000 16:13:57 -0500
Received: from mailc.telia.com ([194.22.190.4]:27659 "EHLO mailc.telia.com")
	by vger.kernel.org with ESMTP id <S129166AbQKPVNt>;
	Thu, 16 Nov 2000 16:13:49 -0500
From: Roger Larsson <roger@norran.net>
Date: Wed, 15 Nov 2000 23:18:42 +0100
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Confusing comment in reschedule_idle - unlock of runqueue.
MIME-Version: 1.0
Message-Id: <00111523184200.04121@dox>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This comment is written in head of reschedule_idle, is it really
correct?

--------------------------
/*
 * This is ugly, but reschedule_idle() is very timing-critical.
 * We enter with the runqueue spinlock held, but we might end
 * up unlocking it early, so the caller must not unlock the
 * runqueue, it's always done by reschedule_idle().
 *
 * This function must be inline as anything that saves and restores
 * flags has to do so within the same register window on sparc (Anton)
 */
static FASTCALL(void reschedule_idle(struct task_struct * p));

static void reschedule_idle(struct task_struct * p)
--------------------------


If it is then, wake_up_process and schedule_tail are wrong.
But I think not...

--------------------------
	reschedule_idle(p);
out:
	spin_unlock_irqrestore(&runqueue_lock, flags);
--------------------------

/RogerL

-- 
Home page:
  http://www.norran.net/nra02596/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
