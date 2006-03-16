Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751665AbWCPKaM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751665AbWCPKaM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 05:30:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752068AbWCPKaM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 05:30:12 -0500
Received: from 213-239-205-134.clients.your-server.de ([213.239.205.134]:56760
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1751665AbWCPKaL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 05:30:11 -0500
Subject: [PATCH] posix-timer fix requeue accounting when signal is ignored
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Andrew Morton <akpm@osdl.org>
Cc: Roman Zippel <zippel@linux-m68k.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Thu, 16 Mar 2006 11:30:11 +0100
Message-Id: <1142505012.29968.22.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roman Zippel <zippel@linux-m68k.org>

When the posix-timer signal is ignored then the timer is rearmed by the
callback function. The requeue pending accounting has to be fixed up 
else the state might be wrong.

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Index: linux-2.6.16-updates/kernel/posix-timers.c
===================================================================
--- linux-2.6.16-updates.orig/kernel/posix-timers.c
+++ linux-2.6.16-updates/kernel/posix-timers.c
@@ -358,6 +358,7 @@ static int posix_timer_fn(struct hrtimer
 						timer->base->softirq_time,
 						timr->it.real.interval);
 			ret = HRTIMER_RESTART;
+			++timr->it_requeue_pending;
 		}
 	}
 


