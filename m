Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751296AbVKXO7l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296AbVKXO7l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 09:59:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751283AbVKXO7l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 09:59:41 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:61913
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1751266AbVKXO7k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 09:59:40 -0500
Subject: [PATCH -mm] timespec: normalize off by one errors
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: linutronix
Date: Thu, 24 Nov 2005 16:04:52 +0100
Message-Id: <1132844692.32542.203.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus tree has a fix for set_normalized_timespec (commit
3f39894d1b5c253b10fcb8fbbbcf65a330f6cdc7)

[PATCH] timespec: normalize off by one errors

It would appear that the timespec normalize code has an off by one error.
Found in three places.  Thanks to Ben for spotting.
Signed-off-by: George Anzinger<george@mvista.com>


It got lost in -mm due to the deinlining of set_normalized_timespec

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>


Index: linux-2.6.15-rc2-mm1/kernel/time.c
===================================================================
--- linux-2.6.15-rc2-mm1.orig/kernel/time.c
+++ linux-2.6.15-rc2-mm1/kernel/time.c
@@ -611,7 +611,7 @@ EXPORT_SYMBOL(mktime);
  */
 void set_normalized_timespec (struct timespec *ts, time_t sec, long nsec)
 {
-	while (nsec > NSEC_PER_SEC) {
+	while (nsec >= NSEC_PER_SEC) {
 		nsec -= NSEC_PER_SEC;
 		++sec;
 	}


