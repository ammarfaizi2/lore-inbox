Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264985AbTGKSMj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 14:12:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264948AbTGKSMM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 14:12:12 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:12164
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S264632AbTGKR6a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 13:58:30 -0400
Date: Fri, 11 Jul 2003 19:12:18 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307111812.h6BICI5Y017314@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: fix the security leak in dmasound
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

'ra1
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.75/sound/oss/dmasound/dmasound_core.c linux-2.5.75-ac1/sound/oss/dmasound/dmasound_core.c
--- linux-2.5.75/sound/oss/dmasound/dmasound_core.c	2003-07-10 21:05:30.000000000 +0100
+++ linux-2.5.75-ac1/sound/oss/dmasound/dmasound_core.c	2003-07-11 16:30:15.000000000 +0100
@@ -351,8 +351,8 @@
 	    case SOUND_MIXER_INFO:
 		{
 		    mixer_info info;
-		    strlcpy(info.id, dmasound.mach.name2, sizeof(info.id));
-		    strlcpy(info.name, dmasound.mach.name2, sizeof(info.name));
+		    strncpy(info.id, dmasound.mach.name2, sizeof(info.id));
+		    strncpy(info.name, dmasound.mach.name2, sizeof(info.name));
 		    info.modify_counter = mixer.modify_counter;
 		    if (copy_to_user((int *)arg, &info, sizeof(info)))
 			    return -EFAULT;
