Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264982AbUDUGIs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264982AbUDUGIs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 02:08:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264987AbUDUGIc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 02:08:32 -0400
Received: from smtp804.mail.sc5.yahoo.com ([66.163.168.183]:39596 "HELO
	smtp804.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264982AbUDUGFp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 02:05:45 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 9/15] New set of input patches: atkbd timeout complaints
Date: Wed, 21 Apr 2004 00:58:42 -0500
User-Agent: KMail/1.6.1
Cc: Vojtech Pavlik <vojtech@suse.cz>
References: <200404210049.17139.dtor_core@ameritech.net>
In-Reply-To: <200404210049.17139.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200404210058.44629.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1910, 2004-04-20 22:32:46-05:00, dtor_core@ameritech.net
  Input: Do not generate events from atkbd until keyboard is completely
         initialized. It should suppress messages about suprious NAKs
         when controller's timeout is longer than one in atkbd


 atkbd.c |    6 ++++++
 1 files changed, 6 insertions(+)


===================================================================



diff -Nru a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
--- a/drivers/input/keyboard/atkbd.c	Tue Apr 20 23:09:40 2004
+++ b/drivers/input/keyboard/atkbd.c	Tue Apr 20 23:09:40 2004
@@ -188,6 +188,7 @@
 	unsigned int resend:1;
 	unsigned int release:1;
 	unsigned int bat_xl:1;
+	unsigned int enabled:1;
 
 	unsigned int last;
 	unsigned long time;
@@ -248,6 +249,9 @@
 		goto out;
 	}
 
+	if (!atkbd->enabled)
+		goto out;
+
 	if (atkbd->translated) {
 
 		if (atkbd->emul ||
@@ -749,6 +753,8 @@
 		atkbd->set = 2;
 		atkbd->id = 0xab00;
 	}
+
+	atkbd->enabled = 1;
 
 	if (atkbd->extra) {
 		atkbd->dev.ledbit[0] |= BIT(LED_COMPOSE) | BIT(LED_SUSPEND) | BIT(LED_SLEEP) | BIT(LED_MUTE) | BIT(LED_MISC);
