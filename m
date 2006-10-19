Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946254AbWJSRIw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946254AbWJSRIw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 13:08:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946259AbWJSRIv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 13:08:51 -0400
Received: from saraswathi.solana.com ([198.99.130.12]:51111 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1946256AbWJSRIi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 13:08:38 -0400
Message-Id: <200610191707.k9JH7H3P005584@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: torvalds@osdl.org, akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] sysrq-t broke and no one noticed
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 19 Oct 2006 13:07:17 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The meaning of state_filter == 0 got messed up somehow.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.17/kernel/sched.c
===================================================================
--- linux-2.6.17.orig/kernel/sched.c
+++ linux-2.6.17/kernel/sched.c
@@ -4825,7 +4825,7 @@ void show_state_filter(unsigned long sta
 		 * console might take alot of time:
 		 */
 		touch_nmi_watchdog();
-		if (state_filter && (p->state & state_filter))
+		if (!state_filter || (p->state & state_filter))
 			show_task(p);
 	} while_each_thread(g, p);
 

