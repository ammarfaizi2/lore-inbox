Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262206AbVBKHJw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262206AbVBKHJw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 02:09:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262217AbVBKHJY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 02:09:24 -0500
Received: from smtp817.mail.sc5.yahoo.com ([66.163.170.3]:43358 "HELO
	smtp817.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262207AbVBKHFg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 02:05:36 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: InputML <linux-input@atrey.karlin.mff.cuni.cz>
Subject: [PATCH 3/10] Gameport: connect() is mandatory
Date: Fri, 11 Feb 2005 02:00:59 -0500
User-Agent: KMail/1.7.2
Cc: alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>,
       Vojtech Pavlik <vojtech@suse.cz>
References: <200502110158.47872.dtor_core@ameritech.net> <200502110159.51020.dtor_core@ameritech.net> <200502110200.28299.dtor_core@ameritech.net>
In-Reply-To: <200502110200.28299.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502110201.00916.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.2151, 2005-02-11 01:18:29-05:00, dtor_core@ameritech.net
  Input: make connect and disconnect methods mandatory for gameport
         drivers since that's where gameport_{open|close} are called
         from to actually bind driver to a port.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 gameport.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)


===================================================================



diff -Nru a/drivers/input/gameport/gameport.c b/drivers/input/gameport/gameport.c
--- a/drivers/input/gameport/gameport.c	2005-02-11 01:35:40 -05:00
+++ b/drivers/input/gameport/gameport.c	2005-02-11 01:35:40 -05:00
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
