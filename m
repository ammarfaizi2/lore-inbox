Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263566AbTEIWwz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 18:52:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263568AbTEIWwy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 18:52:54 -0400
Received: from air-2.osdl.org ([65.172.181.6]:44424 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263566AbTEIWwa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 18:52:30 -0400
Date: Fri, 9 May 2003 16:05:05 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Linus Torvalds <torvalds@transmeta.com>, Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.5.69] suspend storing signed jiffies
Message-Id: <20030509160505.31cae893.shemminger@osdl.org>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gets rid of warning because of using jiffies in int.

diff -Nru a/kernel/suspend.c b/kernel/suspend.c
--- a/kernel/suspend.c	Fri May  9 15:54:51 2003
+++ b/kernel/suspend.c	Fri May  9 15:54:51 2003
@@ -201,7 +201,8 @@
 /* 0 = success, else # of processes that we failed to stop */
 int freeze_processes(void)
 {
-	int todo, start_time;
+	int todo;
+	unsigned long start_time;
 	struct task_struct *g, *p;
 	
 	printk( "Stopping tasks: " );
