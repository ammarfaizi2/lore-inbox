Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264426AbUFGL5u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264426AbUFGL5u (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 07:57:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264452AbUFGL5Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 07:57:16 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:1409 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S264502AbUFGLzg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 07:55:36 -0400
To: torvalds@osdl.org, akpm@osdl.org, vojtech@ucw.cz,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
Message-Id: <1086609353730@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <10866093532008@twilight.ucw.cz>
Mime-Version: 1.0
Date: Mon, 7 Jun 2004 13:55:53 +0200
Subject: [PATCH 10/39] input: Do not process scancodes in atkbd until fully initialized
X-Mailer: gregkh_patchbomb_levon_offspring
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input-for-linus

===================================================================

ChangeSet@1.1371.753.17, 2004-04-23 02:40:48-05:00, dtor_core@ameritech.net
  Input: Do not generate events from atkbd until keyboard is completely
         initialized. It should suppress messages about suprious NAKs
         when controller's timeout is longer than one in atkbd


 atkbd.c |    6 ++++++
 1 files changed, 6 insertions(+)

===================================================================

diff -Nru a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
--- a/drivers/input/keyboard/atkbd.c	2004-06-07 13:12:59 +02:00
+++ b/drivers/input/keyboard/atkbd.c	2004-06-07 13:12:59 +02:00
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

