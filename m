Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264725AbUF1FnY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264725AbUF1FnY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 01:43:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264723AbUF1Fmq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 01:42:46 -0400
Received: from smtp810.mail.sc5.yahoo.com ([66.163.170.80]:9912 "HELO
	smtp810.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264725AbUF1F1S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 01:27:18 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 19/19] serio use driver_find
Date: Mon, 28 Jun 2004 00:27:15 -0500
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <200406280008.21465.dtor_core@ameritech.net> <200406280025.54154.dtor_core@ameritech.net> <200406280026.35503.dtor_core@ameritech.net>
In-Reply-To: <200406280026.35503.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200406280027.16696.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1793, 2004-06-27 21:09:35-05:00, dtor_core@ameritech.net
  Input: serio - make use of driver_find instead of re-implementing it
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 serio.c |    4 +---
 1 files changed, 1 insertion(+), 3 deletions(-)


===================================================================



diff -Nru a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
--- a/drivers/input/serio/serio.c	2004-06-27 21:24:26 -05:00
+++ b/drivers/input/serio/serio.c	2004-06-27 21:24:26 -05:00
@@ -261,7 +261,6 @@
 {
 	struct serio *serio = to_serio_port(dev);
 	struct device_driver *drv;
-	struct kobject *k;
 	int retval;
 
 	retval = down_interruptible(&serio_sem);
@@ -276,8 +275,7 @@
 	} else if (!strncmp(buf, "rescan", count)) {
 		serio_disconnect_port(serio);
 		serio_connect_port(serio, NULL);
-	} else if ((k = kset_find_obj(&serio_bus.drivers, buf)) != NULL) {
-		drv = container_of(k, struct device_driver, kobj);
+	} else if ((drv = driver_find(buf, &serio_bus)) != NULL) {
 		serio_disconnect_port(serio);
 		serio_connect_port(serio, to_serio_driver(drv));
 	} else {
