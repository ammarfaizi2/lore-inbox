Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129308AbQKTABA>; Sun, 19 Nov 2000 19:01:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129183AbQKTAAu>; Sun, 19 Nov 2000 19:00:50 -0500
Received: from ns1.metabyte.com ([216.218.208.34]:7 "EHLO ns1.metabyte.com")
	by vger.kernel.org with ESMTP id <S129807AbQKTAAl>;
	Sun, 19 Nov 2000 19:00:41 -0500
From: Pete Zaitcev <zaitcev@metabyte.com>
Message-Id: <200011192330.PAA05251@ns1.metabyte.com>
Subject: Loud screech after reboot of 2.2.18-pre22
To: jgarzik@mandrakesoft.com
Date: Sun, 19 Nov 2000 15:30:39 -0800 (PST)
Cc: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a Sony VAIO Z505JE with ymfpci sound and built-in microphone
and speaker. Everything worked fine with 2.2.17 plus ymfpci patch,
but the 2.2.18-pre22 produces a loud screech starting as sound
initializes and ending when startup scrips load mixer settings.
This happens because of audio loop between microphone and speakers.

I found that the culprit is the change to values of array
mixer_defaults[] in ac97_codec.c, that happened in 2.2.18-pre.

Currently I run the following patch:

--- linux-2.2.18-pre22/drivers/sound/ac97_codec.c	Sat Nov 18 19:04:34 2000
+++ linux-2.2.18-pre22-p3/drivers/sound/ac97_codec.c	Sun Nov 19 15:37:44 2000
@@ -131,7 +131,7 @@
 	{SOUND_MIXER_PCM,	0x4343},
 	{SOUND_MIXER_SPEAKER,	0x4343},
 	{SOUND_MIXER_LINE,	0x4343},
-	{SOUND_MIXER_MIC,	0x4343},
+	{SOUND_MIXER_MIC,	0x1111},	/* P3 - audio loop */
 	{SOUND_MIXER_CD,	0x4343},
 	{SOUND_MIXER_ALTPCM,	0x4343},
 	{SOUND_MIXER_IGAIN,	0x4343},

I wonder if there is a better way?

In the interests of full disclosure let me mention that YMFxxx do have
internal loopbacks that may produce the same effect and that I checked
to the best of my ability that those loopbacks are muted. Therefore
I conclude that the loopback happens inside the AC97 (if such a thing
is possible).

--Pete
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
