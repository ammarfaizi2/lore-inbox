Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272922AbTG0XB2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 19:01:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272921AbTG0XB1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 19:01:27 -0400
Received: from zeus.kernel.org ([204.152.189.113]:31477 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S272874AbTG0XBA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 19:01:00 -0400
Date: Sun, 27 Jul 2003 21:27:43 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307272027.h6RKRhkk029840@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: PATCH: further OSS audio updates
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test2/sound/oss/ac97_codec.c linux-2.6.0-test2-ac1/sound/oss/ac97_codec.c
--- linux-2.6.0-test2/sound/oss/ac97_codec.c	2003-07-14 14:11:57.000000000 +0100
+++ linux-2.6.0-test2-ac1/sound/oss/ac97_codec.c	2003-07-23 16:32:08.000000000 +0100
@@ -513,8 +513,9 @@
 
 	if (cmd == SOUND_MIXER_INFO) {
 		mixer_info info;
-		strncpy(info.id, codec->name, sizeof(info.id));
-		strncpy(info.name, codec->name, sizeof(info.name));
+		memset(&info, 0, sizeof(info));
+		strlcpy(info.id, codec->name, sizeof(info.id));
+		strlcpy(info.name, codec->name, sizeof(info.name));
 		info.modify_counter = codec->modcnt;
 		if (copy_to_user((void *)arg, &info, sizeof(info)))
 			return -EFAULT;
@@ -522,8 +523,9 @@
 	}
 	if (cmd == SOUND_OLD_MIXER_INFO) {
 		_old_mixer_info info;
-		strncpy(info.id, codec->name, sizeof(info.id));
-		strncpy(info.name, codec->name, sizeof(info.name));
+		memset(&info, 0, sizeof(info));
+		strlcpy(info.id, codec->name, sizeof(info.id));
+		strlcpy(info.name, codec->name, sizeof(info.name));
 		if (copy_to_user((void *)arg, &info, sizeof(info)))
 			return -EFAULT;
 		return 0;
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test2/sound/oss/cmpci.c linux-2.6.0-test2-ac1/sound/oss/cmpci.c
--- linux-2.6.0-test2/sound/oss/cmpci.c	2003-07-14 14:11:57.000000000 +0100
+++ linux-2.6.0-test2-ac1/sound/oss/cmpci.c	2003-07-23 16:32:08.000000000 +0100
@@ -1272,8 +1272,9 @@
 	VALIDATE_STATE(s);
         if (cmd == SOUND_MIXER_INFO) {
 		mixer_info info;
-		strncpy(info.id, "cmpci", sizeof(info.id));
-		strncpy(info.name, "C-Media PCI", sizeof(info.name));
+		memset(&info, 0, sizeof(info));
+		strlcpy(info.id, "cmpci", sizeof(info.id));
+		strlcpy(info.name, "C-Media PCI", sizeof(info.name));
 		info.modify_counter = s->mix.modcnt;
 		if (copy_to_user((void *)arg, &info, sizeof(info)))
 			return -EFAULT;
@@ -1281,8 +1282,9 @@
 	}
 	if (cmd == SOUND_OLD_MIXER_INFO) {
 		_old_mixer_info info;
-		strncpy(info.id, "cmpci", sizeof(info.id));
-		strncpy(info.name, "C-Media cmpci", sizeof(info.name));
+		memset(&info, 0, sizeof(info));
+		strlcpy(info.id, "cmpci", sizeof(info.id));
+		strlcpy(info.name, "C-Media cmpci", sizeof(info.name));
 		if (copy_to_user((void *)arg, &info, sizeof(info)))
 			return -EFAULT;
 		return 0;
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test2/sound/oss/dmasound/dmasound_core.c linux-2.6.0-test2-ac1/sound/oss/dmasound/dmasound_core.c
--- linux-2.6.0-test2/sound/oss/dmasound/dmasound_core.c	2003-07-27 19:56:30.000000000 +0100
+++ linux-2.6.0-test2-ac1/sound/oss/dmasound/dmasound_core.c	2003-07-27 20:50:02.000000000 +0100
@@ -351,8 +351,9 @@
 	    case SOUND_MIXER_INFO:
 		{
 		    mixer_info info;
-		    strncpy(info.id, dmasound.mach.name2, sizeof(info.id));
-		    strncpy(info.name, dmasound.mach.name2, sizeof(info.name));
+		    memset(&info, 0, sizeof(info));
+		    strlcpy(info.id, dmasound.mach.name2, sizeof(info.id));
+		    strlcpy(info.name, dmasound.mach.name2, sizeof(info.name));
 		    info.modify_counter = mixer.modify_counter;
 		    if (copy_to_user((int *)arg, &info, sizeof(info)))
 			    return -EFAULT;
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test2/sound/oss/hal2.c linux-2.6.0-test2-ac1/sound/oss/hal2.c
--- linux-2.6.0-test2/sound/oss/hal2.c	2003-07-27 19:56:30.000000000 +0100
+++ linux-2.6.0-test2-ac1/sound/oss/hal2.c	2003-07-23 16:32:08.000000000 +0100
@@ -787,9 +787,9 @@
 
         if (cmd == SOUND_MIXER_INFO) {
 		mixer_info info;
-		
-		strncpy(info.id, hal2str, sizeof(info.id));
-		strncpy(info.name, hal2str, sizeof(info.name));
+		memset(&info, 0, sizeof(info));
+		strlcpy(info.id, hal2str, sizeof(info.id));
+		strlcpy(info.name, hal2str, sizeof(info.name));
 		info.modify_counter = hal2->mixer.modcnt;
 		if (copy_to_user((void *)arg, &info, sizeof(info)))
 			return -EFAULT;
@@ -797,9 +797,9 @@
 	}
 	if (cmd == SOUND_OLD_MIXER_INFO) {
 		_old_mixer_info info;
-		
-		strncpy(info.id, hal2str, sizeof(info.id));
-		strncpy(info.name, hal2str, sizeof(info.name));
+		memset(&info, 0, sizeof(info));
+		strlcpy(info.id, hal2str, sizeof(info.id));
+		strlcpy(info.name, hal2str, sizeof(info.name));
 		if (copy_to_user((void *)arg, &info, sizeof(info)))
 			return -EFAULT;
 		return 0;
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test2/sound/oss/harmony.c linux-2.6.0-test2-ac1/sound/oss/harmony.c
--- linux-2.6.0-test2/sound/oss/harmony.c	2003-07-27 19:56:30.000000000 +0100
+++ linux-2.6.0-test2-ac1/sound/oss/harmony.c	2003-07-23 15:56:03.000000000 +0100
@@ -1296,7 +1296,6 @@
 	unregister_parisc_driver(&harmony_driver);
 }
 
-EXPORT_NO_SYMBOLS;
 
 MODULE_AUTHOR("Alex DeVries <alex@linuxcare.com>");
 MODULE_DESCRIPTION("Harmony sound driver");
