Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264610AbTGKSXb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 14:23:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265032AbTGKSWf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 14:22:35 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:19076
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S264958AbTGKSBx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 14:01:53 -0400
Date: Fri, 11 Jul 2003 19:15:41 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307111815.h6BIFfvU017368@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: fix security leak in maestro.c
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.75/sound/oss/maestro.c linux-2.5.75-ac1/sound/oss/maestro.c
--- linux-2.5.75/sound/oss/maestro.c	2003-07-10 21:14:10.000000000 +0100
+++ linux-2.5.75-ac1/sound/oss/maestro.c	2003-07-11 16:28:21.000000000 +0100
@@ -2024,8 +2024,8 @@
 	VALIDATE_CARD(card);
         if (cmd == SOUND_MIXER_INFO) {
 		mixer_info info;
-		strlcpy(info.id, card_names[card->card_type], sizeof(info.id));
-		strlcpy(info.name, card_names[card->card_type], sizeof(info.name));
+		strncpy(info.id, card_names[card->card_type], sizeof(info.id));
+		strncpy(info.name, card_names[card->card_type], sizeof(info.name));
 		info.modify_counter = card->mix.modcnt;
 		if (copy_to_user((void *)arg, &info, sizeof(info)))
 			return -EFAULT;
@@ -2033,8 +2033,8 @@
 	}
 	if (cmd == SOUND_OLD_MIXER_INFO) {
 		_old_mixer_info info;
-		strlcpy(info.id, card_names[card->card_type], sizeof(info.id));
-		strlcpy(info.name, card_names[card->card_type], sizeof(info.name));
+		strncpy(info.id, card_names[card->card_type], sizeof(info.id));
+		strncpy(info.name, card_names[card->card_type], sizeof(info.name));
 		if (copy_to_user((void *)arg, &info, sizeof(info)))
 			return -EFAULT;
 		return 0;
