Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265699AbTIFBxH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 21:53:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265266AbTIFBss
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 21:48:48 -0400
Received: from DSL022.LABridge.com ([206.117.136.22]:14096 "EHLO Perches.com")
	by vger.kernel.org with ESMTP id S263620AbTIFBrh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 21:47:37 -0400
Subject: [PATCH] 2.6.0-test4 SEQ_START_TOKEN drivers/md (4/6)
From: Joe Perches <joe@perches.com>
To: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Content-Type: text/plain
Message-Id: <1062812862.16851.169.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Fri, 05 Sep 2003 18:47:42 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urN linux-2.6.0-test4/drivers/md/md.c SEQ_START_TOKEN/drivers/md/md.c
-- linux-2.6.0-test4/drivers/md/md.c	2003-09-02 12:52:39.000000000 -0700
+++ SEQ_START_TOKEN/drivers/md/md.c	2003-09-04 19:50:46.000000000 -0700
@@ -2858,7 +2858,7 @@
 		return NULL;
 	if (!l--)
 		/* header */
-		return (void*)1;
+		return SEQ_START_TOKEN;
 
 	spin_lock(&all_mddevs_lock);
 	list_for_each(tmp,&all_mddevs)
@@ -2884,7 +2884,7 @@
 		return NULL;
 
 	spin_lock(&all_mddevs_lock);
-	if (v == (void*)1)
+	if (v == SEQ_START_TOKEN)
 		tmp = all_mddevs.next;
 	else
 		tmp = mddev->all_mddevs.next;
@@ -2896,7 +2896,7 @@
 	}		
 	spin_unlock(&all_mddevs_lock);
 
-	if (v != (void*)1)
+	if (v != SEQ_START_TOKEN)
 		mddev_put(mddev);
 	return next_mddev;
 
@@ -2906,7 +2906,7 @@
 {
 	mddev_t *mddev = v;
 
-	if (mddev && v != (void*)1 && v != (void*)2)
+	if (mddev && v != SEQ_START_TOKEN && v != (void*)2)
 		mddev_put(mddev);
 }
 
@@ -2918,7 +2918,7 @@
 	mdk_rdev_t *rdev;
 	int i;
 
-	if (v == (void*)1) {
+	if (v == SEQ_START_TOKEN) {
 		seq_printf(seq, "Personalities : ");
 		spin_lock(&pers_lock);
 		for (i = 0; i < MAX_PERSONALITY; i++)


