Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270596AbTGNMdp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 08:33:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270612AbTGNMbt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 08:31:49 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:44420
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S270573AbTGNMLR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 08:11:17 -0400
Date: Mon, 14 Jul 2003 13:25:14 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307141225.h6ECPERr030911@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, marcelo@conectiva.com
Subject: PATCH: fix a race in the plugin api for ac97
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.22-pre5/drivers/sound/ac97_codec.c linux.22-pre5-ac1/drivers/sound/ac97_codec.c
--- linux.22-pre5/drivers/sound/ac97_codec.c	2003-07-14 12:27:39.000000000 +0100
+++ linux.22-pre5-ac1/drivers/sound/ac97_codec.c	2003-07-07 16:20:20.000000000 +0100
@@ -740,7 +740,6 @@
 	memset(codec, 0, sizeof(*codec));
 	spin_lock_init(&codec->lock);
 	INIT_LIST_HEAD(&codec->list);
-	list_add(&codec->list, &codecs);
 	return codec;
 }
 
@@ -869,6 +868,7 @@
 	 */
 	 
 	down(&codec_sem);
+	list_add(&codec->list, &codecs);
 
 	list_for_each(l, &codec_drivers) {
 		d = list_entry(l, struct ac97_driver, list);
