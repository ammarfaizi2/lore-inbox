Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262671AbTDHJD0 (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 05:03:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262701AbTDHJD0 (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 05:03:26 -0400
Received: from hera.cwi.nl ([192.16.191.8]:32419 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S262671AbTDHJDZ (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 05:03:25 -0400
From: Andries.Brouwer@cwi.nl
Date: Tue, 8 Apr 2003 11:15:00 +0200 (MEST)
Message-Id: <UTC200304080915.h389F0c02423.aeb@smtp.cwi.nl>
To: torvalds@transmeta.com
Subject: [PATCH] kafstimod.c fix: make timeouts unsigned long
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --recursive --new-file -X /linux/dontdiff a/fs/afs/kafstimod.c b/fs/afs/kafstimod.c
--- a/fs/afs/kafstimod.c	Sat Feb 15 20:42:01 2003
+++ b/fs/afs/kafstimod.c	Tue Mar 18 15:05:28 2003
@@ -99,18 +99,18 @@
 		spin_lock(&kafstimod_lock);
 		if (list_empty(&kafstimod_list)) {
 			timeout = MAX_SCHEDULE_TIMEOUT;
-		}
-		else {
-			timer = list_entry(kafstimod_list.next,afs_timer_t,link);
-			timeout = timer->timo_jif;
+		} else {
+			unsigned long tmo;
+
+			timer = list_entry(kafstimod_list.next,
+					   afs_timer_t, link);
+			tmo = timer->timo_jif;
 			jif = jiffies;
 
-			if (time_before_eq(timeout,jif))
+			if (time_before_eq(tmo,jif))
 				goto immediate;
 
-			else {
-				timeout = (long)timeout - (long)jiffies;
-			}
+			timeout = (long)tmo - (long)jiffies;
 		}
 		spin_unlock(&kafstimod_lock);
 
