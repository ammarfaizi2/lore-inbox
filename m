Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265020AbTGKSXe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 14:23:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264948AbTGKSWE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 14:22:04 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:22148
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S264610AbTGKSDG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 14:03:06 -0400
Date: Fri, 11 Jul 2003 19:16:52 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307111816.h6BIGqnu017392@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: more wrong strlcpy's
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.75/sound/oss/sonicvibes.c linux-2.5.75-ac1/sound/oss/sonicvibes.c
--- linux-2.5.75/sound/oss/sonicvibes.c	2003-07-10 21:08:53.000000000 +0100
+++ linux-2.5.75-ac1/sound/oss/sonicvibes.c	2003-07-11 16:27:40.000000000 +0100
@@ -1046,8 +1046,8 @@
 	VALIDATE_STATE(s);
         if (cmd == SOUND_MIXER_INFO) {
 		mixer_info info;
-		strlcpy(info.id, "SonicVibes", sizeof(info.id));
-		strlcpy(info.name, "S3 SonicVibes", sizeof(info.name));
+		strncpy(info.id, "SonicVibes", sizeof(info.id));
+		strncpy(info.name, "S3 SonicVibes", sizeof(info.name));
 		info.modify_counter = s->mix.modcnt;
 		if (copy_to_user((void *)arg, &info, sizeof(info)))
 			return -EFAULT;
@@ -1055,8 +1055,8 @@
 	}
 	if (cmd == SOUND_OLD_MIXER_INFO) {
 		_old_mixer_info info;
-		strlcpy(info.id, "SonicVibes", sizeof(info.id));
-		strlcpy(info.name, "S3 SonicVibes", sizeof(info.name));
+		strncpy(info.id, "SonicVibes", sizeof(info.id));
+		strncpy(info.name, "S3 SonicVibes", sizeof(info.name));
 		if (copy_to_user((void *)arg, &info, sizeof(info)))
 			return -EFAULT;
 		return 0;
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.75/sound/oss/soundcard.c linux-2.5.75-ac1/sound/oss/soundcard.c
--- linux-2.5.75/sound/oss/soundcard.c	2003-07-10 21:09:33.000000000 +0100
+++ linux-2.5.75-ac1/sound/oss/soundcard.c	2003-07-11 16:27:26.000000000 +0100
@@ -289,8 +289,8 @@
 {
 	mixer_info info;
 
-	strlcpy(info.id, mixer_devs[dev]->id, sizeof(info.id));
-	strlcpy(info.name, mixer_devs[dev]->name, sizeof(info.name));
+	strncpy(info.id, mixer_devs[dev]->id, sizeof(info.id));
+	strncpy(info.name, mixer_devs[dev]->name, sizeof(info.name));
 	info.modify_counter = mixer_devs[dev]->modify_counter;
 	if (__copy_to_user(arg, &info,  sizeof(info)))
 		return -EFAULT;
@@ -301,8 +301,8 @@
 {
 	_old_mixer_info info;
 
- 	strlcpy(info.id, mixer_devs[dev]->id, sizeof(info.id));
- 	strlcpy(info.name, mixer_devs[dev]->name, sizeof(info.name));
+ 	strncpy(info.id, mixer_devs[dev]->id, sizeof(info.id));
+ 	strncpy(info.name, mixer_devs[dev]->name, sizeof(info.name));
  	if (copy_to_user(arg, &info,  sizeof(info)))
 		return -EFAULT;
 	return 0;
