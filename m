Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261721AbVGYG7P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261721AbVGYG7P (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 02:59:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261635AbVGYFyg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 01:54:36 -0400
Received: from smtp108.sbc.mail.re2.yahoo.com ([68.142.229.97]:61821 "HELO
	smtp108.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S261636AbVGYFxU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 01:53:20 -0400
Message-Id: <20050725054533.053885000.dtor_core@ameritech.net>
References: <20050725053449.483098000.dtor_core@ameritech.net>
Date: Mon, 25 Jul 2005 00:35:07 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: [patch 18/24] joydev - remove MSECS macro
Content-Disposition: inline; filename=joydev-msecs.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tobias Klauser <tklauser@nuerscht.ch>

Input: joydev - remove custom conversion from jiffies to msecs

Replace the MSECS() macro with the jiffies_to_msecs() function provided
in jiffies.h

Signed-off-by: Tobias Klauser <tklauser@nuerscht.ch>
Signed-off-by: Domen Puncer <domen@coderock.org>
Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/joydev.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

Index: work/drivers/input/joydev.c
===================================================================
--- work.orig/drivers/input/joydev.c
+++ work/drivers/input/joydev.c
@@ -37,8 +37,6 @@ MODULE_LICENSE("GPL");
 #define JOYDEV_MINORS		16
 #define JOYDEV_BUFFER_SIZE	64
 
-#define MSECS(t)	(1000 * ((t) / HZ) + 1000 * ((t) % HZ) / HZ)
-
 struct joydev {
 	int exist;
 	int open;
@@ -117,7 +115,7 @@ static void joydev_event(struct input_ha
 			return;
 	}
 
-	event.time = MSECS(jiffies);
+	event.time = jiffies_to_msecs(jiffies);
 
 	list_for_each_entry(list, &joydev->list, node) {
 
@@ -245,7 +243,7 @@ static ssize_t joydev_read(struct file *
 
 		struct js_event event;
 
-		event.time = MSECS(jiffies);
+		event.time = jiffies_to_msecs(jiffies);
 
 		if (list->startup < joydev->nkey) {
 			event.type = JS_EVENT_BUTTON | JS_EVENT_INIT;

