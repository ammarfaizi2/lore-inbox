Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263320AbTECORC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 May 2003 10:17:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263322AbTECORC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 May 2003 10:17:02 -0400
Received: from [203.145.184.221] ([203.145.184.221]:6418 "EHLO naturesoft.net")
	by vger.kernel.org with ESMTP id S263320AbTECORB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 May 2003 10:17:01 -0400
Subject: [PATCH 2.5.68] trivial mod_timer fixes for af_wanpipe.c
From: Vinay K Nallamothu <vinay-rc@naturesoft.net>
To: dm@sangoma.com
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 03 May 2003 20:04:12 +0530
Message-Id: <1051972452.2018.148.camel@lima.royalchallenge.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

af_wanpipe.c: trivial {del,add}_timer to mod_timer conversion.

--- linux-2.5.68/net/wanrouter/af_wanpipe.c	2003-04-15 18:16:12.000000000 +0530
+++ linux-2.5.68-nvk/net/wanrouter/af_wanpipe.c	2003-05-03 17:29:36.000000000 +0530
@@ -634,11 +634,8 @@
 	skb_queue_tail(&sk->write_queue,skb);
 	atomic_inc(&wp->packet_sent);
 
-	if (!(test_and_set_bit(0, &wp->timer))){
-		del_timer(&wp->tx_timer);
-		wp->tx_timer.expires = jiffies + 1;
-		add_timer(&wp->tx_timer);
-	}	
+	if (!(test_and_set_bit(0, &wp->timer)))
+		mod_timer(&wp->tx_timer, jiffies + 1);
 	
 	return(len);
 



