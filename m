Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264973AbTGKSXc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 14:23:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265027AbTGKSWc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 14:22:32 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:19844
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S264959AbTGKSCM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 14:02:12 -0400
Date: Fri, 11 Jul 2003 19:16:00 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307111816.h6BIG0gX017374@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: fix security leak in msnd_pinnacle.c
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.75/sound/oss/msnd_pinnacle.c linux-2.5.75-ac1/sound/oss/msnd_pinnacle.c
--- linux-2.5.75/sound/oss/msnd_pinnacle.c	2003-07-10 21:11:33.000000000 +0100
+++ linux-2.5.75-ac1/sound/oss/msnd_pinnacle.c	2003-07-11 16:28:08.000000000 +0100
@@ -555,8 +555,8 @@
 }
 
 #define set_mixer_info()							\
-		strlcpy(info.id, "MSNDMIXER", sizeof(info.id));			\
-		strlcpy(info.name, "MultiSound Mixer", sizeof(info.name));
+		strncpy(info.id, "MSNDMIXER", sizeof(info.id));			\
+		strncpy(info.name, "MultiSound Mixer", sizeof(info.name));
 
 static int mixer_ioctl(unsigned int cmd, unsigned long arg)
 {
