Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264965AbTGKSry (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 14:47:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265025AbTGKSq4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 14:46:56 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:9860
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S264862AbTGKR51 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 13:57:27 -0400
Date: Fri, 11 Jul 2003 19:11:14 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307111811.h6BIBERJ017296@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: Fix security leaks in btaudio
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.75/sound/oss/btaudio.c linux-2.5.75-ac1/sound/oss/btaudio.c
--- linux-2.5.75/sound/oss/btaudio.c	2003-07-10 21:06:05.000000000 +0100
+++ linux-2.5.75-ac1/sound/oss/btaudio.c	2003-07-11 16:28:57.000000000 +0100
@@ -328,8 +328,8 @@
 	if (cmd == SOUND_MIXER_INFO) {
 		mixer_info info;
 		memset(&info,0,sizeof(info));
-                strlcpy(info.id,"bt878",sizeof(info.id));
-                strlcpy(info.name,"Brooktree Bt878 audio",sizeof(info.name));
+                strncpy(info.id,"bt878",sizeof(info.id));
+                strncpy(info.name,"Brooktree Bt878 audio",sizeof(info.name));
                 info.modify_counter = bta->mixcount;
                 if (copy_to_user((void *)arg, &info, sizeof(info)))
                         return -EFAULT;
@@ -338,8 +338,8 @@
 	if (cmd == SOUND_OLD_MIXER_INFO) {
 		_old_mixer_info info;
 		memset(&info,0,sizeof(info));
-                strlcpy(info.id,"bt878",sizeof(info.id)-1);
-                strlcpy(info.name,"Brooktree Bt878 audio",sizeof(info.name));
+                strncpy(info.id,"bt878",sizeof(info.id)-1);
+                strncpy(info.name,"Brooktree Bt878 audio",sizeof(info.name));
                 if (copy_to_user((void *)arg, &info, sizeof(info)))
                         return -EFAULT;
 		return 0;
