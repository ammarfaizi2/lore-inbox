Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932707AbVITG0M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932707AbVITG0M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 02:26:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932734AbVITG0M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 02:26:12 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:10713
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S932707AbVITG0L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 02:26:11 -0400
Subject: Re: 2.6.13-rt14 fails to build (smp)
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1127178337.5868.15.camel@cmn3.stanford.edu>
References: <1127178337.5868.15.camel@cmn3.stanford.edu>
Content-Type: text/plain
Organization: linutronix
Date: Tue, 20 Sep 2005 08:26:14 +0200
Message-Id: <1127197575.24044.310.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-09-19 at 18:05 -0700, Fernando Lopez-Lezcano wrote:
> Hi Ingo, just hit this problem trying to build rt14, this is on the SMP
> build, with 
> # CONFIG_HIGH_RES_TIMERS is not set
> Find the .config I used attached...
> 
> kernel/ktimers.c: In function 'migrate_ktimer_list':

Uuurg. HOTPLUG_CPU

tglx

Index: linux-2.6.13-rt12/kernel/ktimers.c
===================================================================
--- linux-2.6.13-rt12.orig/kernel/ktimers.c
+++ linux-2.6.13-rt12/kernel/ktimers.c
@@ -865,11 +865,11 @@ static void migrate_ktimer_list(struct k
 	struct ktimer *timer;
 	struct rb_node *node;
 
-	while ((node = rb_first(&old_base->root))) {
-		timer = rb_entry(node, struct ktimer, tnode);
+	while ((node = rb_first(&old_base->active))) {
+		timer = rb_entry(node, struct ktimer, node);
 		remove_ktimer(timer, old_base);
 		timer->base = new_base;
-		enqueue_ktimer(timer, new_base, NULL);
+		enqueue_ktimer(timer, new_base, NULL, KTIMER_RESTART);
 	}
 }
 


