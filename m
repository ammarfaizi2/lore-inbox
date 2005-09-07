Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751029AbVIGRFr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751029AbVIGRFr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 13:05:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751146AbVIGRFr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 13:05:47 -0400
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:39371
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S1751029AbVIGRFq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 13:05:46 -0400
Subject: [patch] synclink.c add clear stats
From: Paul Fulghum <paulkf@microgate.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1126112742.3984.21.camel@deimos.microgate.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 07 Sep 2005 12:05:42 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch] synclink.c add clear stats

From: Paul Fulghum <paulkf@microgate.com>

Add the ability to clear statistics.

Signed-off-by: Paul Fulghum <paulkf@microgate.com>

--- linux-2.6.13/drivers/char/synclink.c	2005-09-07 11:43:56.000000000 -0500
+++ linux-2.6.13-mg/drivers/char/synclink.c	2005-09-07 11:55:19.000000000 -0500
@@ -1814,6 +1814,8 @@ static int startup(struct mgsl_struct * 
 
 	info->pending_bh = 0;
 	
+	memset(&info->icount, 0, sizeof(info->icount));
+
 	init_timer(&info->tx_timer);
 	info->tx_timer.data = (unsigned long)info;
 	info->tx_timer.function = mgsl_tx_timeout;
@@ -2470,12 +2472,12 @@ static int mgsl_get_stats(struct mgsl_st
 		printk("%s(%d):mgsl_get_params(%s)\n",
 			 __FILE__,__LINE__, info->device_name);
 			
-	COPY_TO_USER(err,user_icount, &info->icount, sizeof(struct mgsl_icount));
-	if (err) {
-		if ( debug_level >= DEBUG_LEVEL_INFO )
-			printk( "%s(%d):mgsl_get_stats(%s) user buffer copy failed\n",
-				__FILE__,__LINE__,info->device_name);
-		return -EFAULT;
+	if (!user_icount) {
+		memset(&info->icount, 0, sizeof(info->icount));
+	} else {
+		COPY_TO_USER(err, user_icount, &info->icount, sizeof(struct mgsl_icount));
+		if (err)
+			return -EFAULT;
 	}
 	
 	return 0;



