Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270085AbTGRPCq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 11:02:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271589AbTGROyM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 10:54:12 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:34693
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S270085AbTGROOx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 10:14:53 -0400
Date: Fri, 18 Jul 2003 15:29:12 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307181429.h6IETCJh017850@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: PATCH: btaudio uses memset so should be strlcpy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(I've got a patch pending from someone to redo the lot using memset so
its safe from padding suprises)

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test1/sound/oss/btaudio.c linux-2.6.0-test1-ac2/sound/oss/btaudio.c
--- linux-2.6.0-test1/sound/oss/btaudio.c	2003-07-14 14:11:57.000000000 +0100
+++ linux-2.6.0-test1-ac2/sound/oss/btaudio.c	2003-07-14 14:27:14.000000000 +0100
@@ -328,8 +328,8 @@
 	if (cmd == SOUND_MIXER_INFO) {
 		mixer_info info;
 		memset(&info,0,sizeof(info));
-                strncpy(info.id,"bt878",sizeof(info.id));
-                strncpy(info.name,"Brooktree Bt878 audio",sizeof(info.name));
+                strlcpy(info.id,"bt878",sizeof(info.id));
+                strlcpy(info.name,"Brooktree Bt878 audio",sizeof(info.name));
                 info.modify_counter = bta->mixcount;
                 if (copy_to_user((void *)arg, &info, sizeof(info)))
                         return -EFAULT;
@@ -338,8 +338,8 @@
 	if (cmd == SOUND_OLD_MIXER_INFO) {
 		_old_mixer_info info;
 		memset(&info,0,sizeof(info));
-                strncpy(info.id,"bt878",sizeof(info.id)-1);
-                strncpy(info.name,"Brooktree Bt878 audio",sizeof(info.name));
+                strlcpy(info.id,"bt878",sizeof(info.id)-1);
+                strlcpy(info.name,"Brooktree Bt878 audio",sizeof(info.name));
                 if (copy_to_user((void *)arg, &info, sizeof(info)))
                         return -EFAULT;
 		return 0;

