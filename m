Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262410AbUKXHRD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262410AbUKXHRD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 02:17:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262264AbUKXHPF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 02:15:05 -0500
Received: from smtp810.mail.sc5.yahoo.com ([66.163.170.80]:57189 "HELO
	smtp810.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262316AbUKXHOw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 02:14:52 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 1/11] Atkbd keycodesize fix
Date: Wed, 24 Nov 2004 02:06:03 -0500
User-Agent: KMail/1.6.2
Cc: LKML <linux-kernel@vger.kernel.org>
References: <200411240205.10502.dtor_core@ameritech.net>
In-Reply-To: <200411240205.10502.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200411240206.05955.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1957, 2004-11-20 02:05:34-05:00, dtor_core@ameritech.net
  Input: atkbd - fix keycode table size initialization that got broken
         by my changes that exported 'set' and other settings via sysfs.
         setkeycodes should work again now.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 atkbd.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)


===================================================================



diff -Nru a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
--- a/drivers/input/keyboard/atkbd.c	2004-11-24 01:40:49 -05:00
+++ b/drivers/input/keyboard/atkbd.c	2004-11-24 01:40:49 -05:00
@@ -757,6 +757,10 @@
 		set_bit(BTN_MIDDLE, atkbd->dev.keybit);
 	}
 
+	atkbd->dev.keycode = atkbd->keycode;
+	atkbd->dev.keycodesize = sizeof(unsigned char);
+	atkbd->dev.keycodemax = ARRAY_SIZE(atkbd_set2_keycode);
+
 	for (i = 0; i < 512; i++)
 		if (atkbd->keycode[i] && atkbd->keycode[i] < ATKBD_SPECIAL)
 			set_bit(atkbd->keycode[i], atkbd->dev.keybit);
@@ -798,10 +802,6 @@
 
 	if (atkbd->softrepeat)
 		atkbd->softraw = 1;
-
-	atkbd->dev.keycode = atkbd->keycode;
-	atkbd->dev.keycodesize = sizeof(unsigned char);
-	atkbd->dev.keycodemax = ARRAY_SIZE(atkbd_set2_keycode);
 
 	serio_set_drvdata(serio, atkbd);
 
