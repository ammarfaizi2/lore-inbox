Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272143AbTHNDts (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 23:49:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272148AbTHNDts
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 23:49:48 -0400
Received: from CPEdeadbeef0000-CM000039d4cc6a.cpe.net.cable.rogers.com ([24.192.190.108]:32386
	"HELO coredump.sh0n.net") by vger.kernel.org with SMTP
	id S272143AbTHNDtr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 23:49:47 -0400
Date: Wed, 13 Aug 2003 23:49:39 -0400 (EDT)
From: Shawn Starr <spstarr@sh0n.net>
To: linux-kernel@vger.kernel.org
cc: trivial@rustcorp.com.au, Jaroslav Kysela <perex@suse.cz>
Subject: [PATCH][TRIVIAL][2.6.0-test3][SOUND-OPL3] Don't free struct opl3 we
 need it for snd_printd
Message-ID: <Pine.LNX.4.44.0308132253280.3489-100000@coredump.sh0n.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This trivial patch fixes a panic when we try to display OPL3 debug info on
init.

Please apply, tested and works.

Shawn Starr.

diff -Nrup linux-2.6.0-test3-vanilla/sound/drivers/opl3/opl3_lib.c linux-2.6.0-test3-fixes/sound/drivers/opl3/opl3_lib.c
--- linux-2.6.0-test3-vanilla/sound/drivers/opl3/opl3_lib.c	2003-08-13 23:27:35.000000000 -0400
+++ linux-2.6.0-test3-fixes/sound/drivers/opl3/opl3_lib.c	2003-08-13 23:29:51.000000000 -0400
@@ -440,9 +440,9 @@ int snd_opl3_create(snd_card_t * card,
 	default:
 		opl3->command = &snd_opl2_command;
 		if ((err = snd_opl3_detect(opl3)) < 0) {
-			snd_opl3_free(opl3);
 			snd_printd("OPL2/3 chip not detected at 0x%lx/0x%lx\n",
 				   opl3->l_port, opl3->r_port);
+			snd_opl3_free(opl3);
 			return err;
 		}
 		/* detect routine returns correct hardware type */

