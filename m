Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263812AbTEODbe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 23:31:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263802AbTEODW3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 23:22:29 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:26092 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S263812AbTEODS1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 23:18:27 -0400
Date: Thu, 15 May 2003 04:31:15 +0100
Message-Id: <200305150331.h4F3VFTl000738@deviant.impure.org.uk>
To: torvalds@transmeta.com
From: davej@codemonkey.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: i810 no codec fix.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Syncs up with 2.4

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/sound/oss/i810_audio.c linux-2.5/sound/oss/i810_audio.c
--- bk-linus/sound/oss/i810_audio.c	2003-04-25 13:53:16.000000000 +0100
+++ linux-2.5/sound/oss/i810_audio.c	2003-04-26 15:08:06.000000000 +0100
@@ -66,16 +66,19 @@
  *
  *	This driver is cursed. (Ben LaHaise)
  *
+ *  ICH 3 caveats
+ *	Intel errata #7 for ICH3 IO. We need to disable SMI stuff
+ *	when codec probing. [Not Yet Done]
  *
  *  ICH 4 caveats
  *
- *      The ICH4 has the feature, that the codec ID doesn't have to be 
- *      congruent with the IO connection.
+ *	The ICH4 has the feature, that the codec ID doesn't have to be 
+ *	congruent with the IO connection.
  * 
- *      Therefore, from driver version 0.23 on, there is a "codec ID" <->
- *      "IO register base offset" mapping (card->ac97_id_map) field.
+ *	Therefore, from driver version 0.23 on, there is a "codec ID" <->
+ *	"IO register base offset" mapping (card->ac97_id_map) field.
  *   
- *      Juergen "George" Sawinski (jsaw) 
+ *	Juergen "George" Sawinski (jsaw) 
  */
  
 #include <linux/module.h>
@@ -640,6 +643,10 @@ static void i810_set_dac_channels(struct
 	int	aud_reg;
 	struct ac97_codec *codec = state->card->ac97_codec[0];
 
+	/* No codec, no setup */
+	if(codec == NULL)
+		return;
+
 	aud_reg = i810_ac97_get(codec, AC97_EXTENDED_STATUS);
 	aud_reg |= AC97_EA_PRI | AC97_EA_PRJ | AC97_EA_PRK;
 	state->card->ac97_status &= ~(SURR_ON | CENTER_LFE_ON);
