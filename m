Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262336AbUKXHej@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262336AbUKXHej (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 02:34:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262365AbUKXHdb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 02:33:31 -0500
Received: from smtp810.mail.sc5.yahoo.com ([66.163.170.80]:19561 "HELO
	smtp810.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262333AbUKXHVk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 02:21:40 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 11/11] gameport: connect/disconnect mandatory
Date: Wed, 24 Nov 2004 02:13:18 -0500
User-Agent: KMail/1.6.2
Cc: LKML <linux-kernel@vger.kernel.org>
References: <200411240205.10502.dtor_core@ameritech.net> <200411240211.20241.dtor_core@ameritech.net> <200411240211.47746.dtor_core@ameritech.net>
In-Reply-To: <200411240211.47746.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200411240213.20225.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1966, 2004-11-24 01:28:49-05:00, dtor_core@ameritech.net
  Input: make connect and disconnect methods mandatory for gameport
         drivers since that's where gameport_{open|close} are called
         from to actually bind driver to a port.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 gameport.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)


===================================================================



diff -Nru a/drivers/input/gameport/gameport.c b/drivers/input/gameport/gameport.c
--- a/drivers/input/gameport/gameport.c	2004-11-24 01:58:30 -05:00
+++ b/drivers/input/gameport/gameport.c	2004-11-24 01:58:30 -05:00
@@ -107,8 +107,7 @@
         list_for_each_entry(drv, &gameport_driver_list, node) {
 		if (gameport->drv)
 			break;
-		if (drv->connect)
-                	drv->connect(gameport, drv);
+               	drv->connect(gameport, drv);
         }
 }
 
@@ -128,7 +127,7 @@
 void gameport_unregister_port(struct gameport *gameport)
 {
 	list_del_init(&gameport->node);
-	if (gameport->drv && gameport->drv->disconnect)
+	if (gameport->drv)
 		gameport->drv->disconnect(gameport);
 }
 
@@ -138,7 +137,7 @@
 
 	list_add_tail(&drv->node, &gameport_driver_list);
 	list_for_each_entry(gameport, &gameport_list, node)
-		if (!gameport->drv && drv->connect)
+		if (!gameport->drv)
 			drv->connect(gameport, drv);
 }
 
@@ -148,7 +147,7 @@
 
 	list_del_init(&drv->node);
 	list_for_each_entry(gameport, &gameport_list, node) {
-		if (gameport->drv == drv && drv->disconnect)
+		if (gameport->drv == drv)
 			drv->disconnect(gameport);
 		gameport_find_driver(gameport);
 	}
