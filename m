Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273016AbTG0XDH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 19:03:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273010AbTG0XC6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 19:02:58 -0400
Received: from zeus.kernel.org ([204.152.189.113]:31477 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S272892AbTG0XBN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 19:01:13 -0400
Date: Sun, 27 Jul 2003 21:28:18 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307272028.h6RKSI9r029847@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: PATCH: further sound updates
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Switching back to strlcpy/memset to avoid padding problems
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test2/sound/oss/maestro.c linux-2.6.0-test2-ac1/sound/oss/maestro.c
--- linux-2.6.0-test2/sound/oss/maestro.c	2003-07-14 14:11:57.000000000 +0100
+++ linux-2.6.0-test2-ac1/sound/oss/maestro.c	2003-07-23 16:32:08.000000000 +0100
@@ -2030,8 +2030,9 @@
 	VALIDATE_CARD(card);
         if (cmd == SOUND_MIXER_INFO) {
 		mixer_info info;
-		strncpy(info.id, card_names[card->card_type], sizeof(info.id));
-		strncpy(info.name, card_names[card->card_type], sizeof(info.name));
+		memset(&info, 0, sizeof(info));
+		strlcpy(info.id, card_names[card->card_type], sizeof(info.id));
+		strlcpy(info.name, card_names[card->card_type], sizeof(info.name));
 		info.modify_counter = card->mix.modcnt;
 		if (copy_to_user((void *)arg, &info, sizeof(info)))
 			return -EFAULT;
@@ -2039,8 +2040,9 @@
 	}
 	if (cmd == SOUND_OLD_MIXER_INFO) {
 		_old_mixer_info info;
-		strncpy(info.id, card_names[card->card_type], sizeof(info.id));
-		strncpy(info.name, card_names[card->card_type], sizeof(info.name));
+		memset(&info, 0, sizeof(info));
+		strlcpy(info.id, card_names[card->card_type], sizeof(info.id));
+		strlcpy(info.name, card_names[card->card_type], sizeof(info.name));
 		if (copy_to_user((void *)arg, &info, sizeof(info)))
 			return -EFAULT;
 		return 0;
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test2/sound/oss/msnd_pinnacle.c linux-2.6.0-test2-ac1/sound/oss/msnd_pinnacle.c
--- linux-2.6.0-test2/sound/oss/msnd_pinnacle.c	2003-07-14 14:11:57.000000000 +0100
+++ linux-2.6.0-test2-ac1/sound/oss/msnd_pinnacle.c	2003-07-23 16:32:08.000000000 +0100
@@ -555,8 +555,9 @@
 }
 
 #define set_mixer_info()							\
-		strncpy(info.id, "MSNDMIXER", sizeof(info.id));			\
-		strncpy(info.name, "MultiSound Mixer", sizeof(info.name));
+		memset(&info, 0, sizeof(info));					\
+		strlcpy(info.id, "MSNDMIXER", sizeof(info.id));			\
+		strlcpy(info.name, "MultiSound Mixer", sizeof(info.name));
 
 static int mixer_ioctl(unsigned int cmd, unsigned long arg)
 {
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test2/sound/oss/sonicvibes.c linux-2.6.0-test2-ac1/sound/oss/sonicvibes.c
--- linux-2.6.0-test2/sound/oss/sonicvibes.c	2003-07-14 14:11:57.000000000 +0100
+++ linux-2.6.0-test2-ac1/sound/oss/sonicvibes.c	2003-07-23 16:32:08.000000000 +0100
@@ -1046,8 +1046,9 @@
 	VALIDATE_STATE(s);
         if (cmd == SOUND_MIXER_INFO) {
 		mixer_info info;
-		strncpy(info.id, "SonicVibes", sizeof(info.id));
-		strncpy(info.name, "S3 SonicVibes", sizeof(info.name));
+		memset(&info, 0, sizeof(info));
+		strlcpy(info.id, "SonicVibes", sizeof(info.id));
+		strlcpy(info.name, "S3 SonicVibes", sizeof(info.name));
 		info.modify_counter = s->mix.modcnt;
 		if (copy_to_user((void *)arg, &info, sizeof(info)))
 			return -EFAULT;
@@ -1055,8 +1056,9 @@
 	}
 	if (cmd == SOUND_OLD_MIXER_INFO) {
 		_old_mixer_info info;
-		strncpy(info.id, "SonicVibes", sizeof(info.id));
-		strncpy(info.name, "S3 SonicVibes", sizeof(info.name));
+		memset(&info, 0, sizeof(info));
+		strlcpy(info.id, "SonicVibes", sizeof(info.id));
+		strlcpy(info.name, "S3 SonicVibes", sizeof(info.name));
 		if (copy_to_user((void *)arg, &info, sizeof(info)))
 			return -EFAULT;
 		return 0;
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test2/sound/oss/soundcard.c linux-2.6.0-test2-ac1/sound/oss/soundcard.c
--- linux-2.6.0-test2/sound/oss/soundcard.c	2003-07-14 14:11:57.000000000 +0100
+++ linux-2.6.0-test2-ac1/sound/oss/soundcard.c	2003-07-23 16:32:08.000000000 +0100
@@ -288,9 +288,9 @@
 static int get_mixer_info(int dev, caddr_t arg)
 {
 	mixer_info info;
-
-	strncpy(info.id, mixer_devs[dev]->id, sizeof(info.id));
-	strncpy(info.name, mixer_devs[dev]->name, sizeof(info.name));
+	memset(&info, 0, sizeof(info));
+	strlcpy(info.id, mixer_devs[dev]->id, sizeof(info.id));
+	strlcpy(info.name, mixer_devs[dev]->name, sizeof(info.name));
 	info.modify_counter = mixer_devs[dev]->modify_counter;
 	if (__copy_to_user(arg, &info,  sizeof(info)))
 		return -EFAULT;
@@ -300,9 +300,9 @@
 static int get_old_mixer_info(int dev, caddr_t arg)
 {
 	_old_mixer_info info;
-
- 	strncpy(info.id, mixer_devs[dev]->id, sizeof(info.id));
- 	strncpy(info.name, mixer_devs[dev]->name, sizeof(info.name));
+	memset(&info, 0, sizeof(info));
+ 	strlcpy(info.id, mixer_devs[dev]->id, sizeof(info.id));
+ 	strlcpy(info.name, mixer_devs[dev]->name, sizeof(info.name));
  	if (copy_to_user(arg, &info,  sizeof(info)))
 		return -EFAULT;
 	return 0;
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test2/sound/oss/swarm_cs4297a.c linux-2.6.0-test2-ac1/sound/oss/swarm_cs4297a.c
--- linux-2.6.0-test2/sound/oss/swarm_cs4297a.c	2003-07-14 14:11:57.000000000 +0100
+++ linux-2.6.0-test2-ac1/sound/oss/swarm_cs4297a.c	2003-07-23 16:32:08.000000000 +0100
@@ -90,7 +90,6 @@
 #include <asm/sibyte/64bit.h>
 
 struct cs4297a_state;
-EXPORT_NO_SYMBOLS;
 
 static void stop_dac(struct cs4297a_state *s);
 static void stop_adc(struct cs4297a_state *s);
@@ -1238,8 +1237,9 @@
 	}
 	if (cmd == SOUND_MIXER_INFO) {
 		mixer_info info;
-		strncpy(info.id, "CS4297a", sizeof(info.id));
-		strncpy(info.name, "Crystal CS4297a", sizeof(info.name));
+		memset(&info, 0, sizeof(info));
+		strlcpy(info.id, "CS4297a", sizeof(info.id));
+		strlcpy(info.name, "Crystal CS4297a", sizeof(info.name));
 		info.modify_counter = s->mix.modcnt;
 		if (copy_to_user((void *) arg, &info, sizeof(info)))
 			return -EFAULT;
@@ -1247,8 +1247,9 @@
 	}
 	if (cmd == SOUND_OLD_MIXER_INFO) {
 		_old_mixer_info info;
-		strncpy(info.id, "CS4297a", sizeof(info.id));
-		strncpy(info.name, "Crystal CS4297a", sizeof(info.name));
+		memset(&info, 0, sizeof(info));
+		strlcpy(info.id, "CS4297a", sizeof(info.id));
+		strlcpy(info.name, "Crystal CS4297a", sizeof(info.name));
 		if (copy_to_user((void *) arg, &info, sizeof(info)))
 			return -EFAULT;
 		return 0;
