Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261479AbUL2Hle@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261479AbUL2Hle (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 02:41:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261476AbUL2HlG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 02:41:06 -0500
Received: from smtp802.mail.sc5.yahoo.com ([66.163.168.181]:15535 "HELO
	smtp802.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261426AbUL2Hd1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 02:33:27 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 8/16] Allow setkeycodes work again
Date: Wed, 29 Dec 2004 02:25:15 -0500
User-Agent: KMail/1.6.2
Cc: linux-input@atrey.karlin.mff.cuni.cz, LKML <linux-kernel@vger.kernel.org>
References: <200412290217.36282.dtor_core@ameritech.net> <200412290223.24307.dtor_core@ameritech.net> <200412290224.14315.dtor_core@ameritech.net>
In-Reply-To: <200412290224.14315.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200412290225.17324.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1967, 2004-11-20 02:27:37-05:00, dtor_core@ameritech.net
  Input: atkbd - fix keycode table size initialization that got broken
         by my changes that exported 'set' and other settings via sysfs.
         setkeycodes should work again now.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 atkbd.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)


===================================================================



diff -Nru a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
--- a/drivers/input/keyboard/atkbd.c	2004-12-29 01:48:53 -05:00
+++ b/drivers/input/keyboard/atkbd.c	2004-12-29 01:48:53 -05:00
@@ -756,6 +756,10 @@
 		set_bit(BTN_MIDDLE, atkbd->dev.keybit);
 	}
 
+	atkbd->dev.keycode = atkbd->keycode;
+	atkbd->dev.keycodesize = sizeof(unsigned char);
+	atkbd->dev.keycodemax = ARRAY_SIZE(atkbd_set2_keycode);
+
 	for (i = 0; i < 512; i++)
 		if (atkbd->keycode[i] && atkbd->keycode[i] < ATKBD_SPECIAL)
 			set_bit(atkbd->keycode[i], atkbd->dev.keybit);
@@ -803,10 +807,6 @@
 
 	if (atkbd->softrepeat)
 		atkbd->softraw = 1;
-
-	atkbd->dev.keycode = atkbd->keycode;
-	atkbd->dev.keycodesize = sizeof(unsigned char);
-	atkbd->dev.keycodemax = ARRAY_SIZE(atkbd_set2_keycode);
 
 	serio->private = atkbd;
 
