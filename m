Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267248AbUIAQuH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267248AbUIAQuH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 12:50:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267235AbUIAP43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 11:56:29 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:1971 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S267350AbUIAPvp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 11:51:45 -0400
Date: Wed, 1 Sep 2004 16:51:22 +0100
Message-Id: <200409011551.i81FpMbW000685@delerium.codemonkey.org.uk>
From: Dave Jones <davej@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix NULL derefence in OSS MAUI driver.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Spotted with the source checker from Coverity.com.

Signed-off-by: Dave Jones <davej@redhat.com>


diff -urpN --exclude-from=/home/davej/.exclude bk-linus/sound/oss/maui.c linux-2.6/sound/oss/maui.c
--- bk-linus/sound/oss/maui.c	2004-08-28 21:57:25.000000000 +0100
+++ linux-2.6/sound/oss/maui.c	2004-09-01 13:31:21.000000000 +0100
@@ -383,9 +383,8 @@ static int __init probe_maui(struct addr
 		 */
 
 		synth = midi_devs[this_dev]->converter;
-		synth->id = "MAUI";
-
 		if (synth != NULL) {
+			synth->id = "MAUI";
 			orig_load_patch = synth->load_patch;
 			synth->load_patch = &maui_load_patch;
 		} else
