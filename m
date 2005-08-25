Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964875AbVHYVud@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964875AbVHYVud (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 17:50:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964894AbVHYVud
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 17:50:33 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:57337 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S964879AbVHYVub
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 17:50:31 -0400
Subject: Re: 2.6.13-rc7-rt1
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050825062651.GA26781@elte.hu>
References: <20050825062651.GA26781@elte.hu>
Content-Type: text/plain
Organization: MontaVista
Date: Thu, 25 Aug 2005 14:46:13 -0700
Message-Id: <1125006373.10901.11.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Wakeup race checking shouldn't trigger when interrupts are off. Here's a
fix.

Daniel

Index: linux-2.6.12/kernel/rt.c
===================================================================
--- linux-2.6.12.orig/kernel/rt.c	2005-08-25 21:33:43.000000000 +0000
+++ linux-2.6.12/kernel/rt.c	2005-08-25 21:44:20.000000000 +0000
@@ -257,6 +257,7 @@ void check_preempt_wakeup(struct task_st
 	 * hangs and race conditions.
 	 */
 	if (!preempt_count() &&
+		!__raw_irqs_disabled() &&
 		p->prio < current->prio &&
 		rt_task(p) &&
 		(current->rcu_read_lock_nesting != 0 ||


