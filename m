Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751206AbVIGRlE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751206AbVIGRlE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 13:41:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751232AbVIGRlD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 13:41:03 -0400
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:3788
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S1751206AbVIGRlB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 13:41:01 -0400
Subject: [patch] synclinkmp.c add statistics clear
From: Paul Fulghum <paulkf@microgate.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1126114853.4056.12.camel@deimos.microgate.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 07 Sep 2005 12:40:53 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch] synclinkmp.c add statistics clear

From: Paul Fulghum <paulkf@microgate.com>

Add ability to clear statistics.

Signed-off-by: Paul Fulghum <paulkf@microgate.com>

--- linux-2.6.13/drivers/char/synclinkmp.c	2005-08-28 18:41:01.000000000 -0500
+++ linux-2.6.13-mg/drivers/char/synclinkmp.c	2005-09-07 12:26:28.000000000 -0500
@@ -2750,6 +2750,8 @@ static int startup(SLMP_INFO * info)
 
 	info->pending_bh = 0;
 
+	memset(&info->icount, 0, sizeof(info->icount));
+
 	/* program hardware for current parameters */
 	reset_port(info);
 
@@ -2953,12 +2955,12 @@ static int get_stats(SLMP_INFO * info, s
 		printk("%s(%d):%s get_params()\n",
 			 __FILE__,__LINE__, info->device_name);
 
-	COPY_TO_USER(err,user_icount, &info->icount, sizeof(struct mgsl_icount));
-	if (err) {
-		if ( debug_level >= DEBUG_LEVEL_INFO )
-			printk( "%s(%d):%s get_stats() user buffer copy failed\n",
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


