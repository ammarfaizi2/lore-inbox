Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264887AbTGKSRS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 14:17:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264632AbTGKSMx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 14:12:53 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:10628
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S264809AbTGKR5n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 13:57:43 -0400
Date: Fri, 11 Jul 2003 19:11:29 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307111811.h6BIBTvg017302@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: fix security leaks in cmpci
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.75/sound/oss/cmpci.c linux-2.5.75-ac1/sound/oss/cmpci.c
--- linux-2.5.75/sound/oss/cmpci.c	2003-07-10 21:10:16.000000000 +0100
+++ linux-2.5.75-ac1/sound/oss/cmpci.c	2003-07-11 16:27:53.000000000 +0100
@@ -1272,8 +1272,8 @@
 	VALIDATE_STATE(s);
         if (cmd == SOUND_MIXER_INFO) {
 		mixer_info info;
-		strlcpy(info.id, "cmpci", sizeof(info.id));
-		strlcpy(info.name, "C-Media PCI", sizeof(info.name));
+		strncpy(info.id, "cmpci", sizeof(info.id));
+		strncpy(info.name, "C-Media PCI", sizeof(info.name));
 		info.modify_counter = s->mix.modcnt;
 		if (copy_to_user((void *)arg, &info, sizeof(info)))
 			return -EFAULT;
@@ -1281,8 +1281,8 @@
 	}
 	if (cmd == SOUND_OLD_MIXER_INFO) {
 		_old_mixer_info info;
-		strlcpy(info.id, "cmpci", sizeof(info.id));
-		strlcpy(info.name, "C-Media cmpci", sizeof(info.name));
+		strncpy(info.id, "cmpci", sizeof(info.id));
+		strncpy(info.name, "C-Media cmpci", sizeof(info.name));
 		if (copy_to_user((void *)arg, &info, sizeof(info)))
 			return -EFAULT;
 		return 0;
