Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318888AbSG1C44>; Sat, 27 Jul 2002 22:56:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318890AbSG1C44>; Sat, 27 Jul 2002 22:56:56 -0400
Received: from mail.linux-new-media.de ([62.245.157.204]:8452 "HELO
	mail.linux-new-media.de") by vger.kernel.org with SMTP
	id <S318888AbSG1C44>; Sat, 27 Jul 2002 22:56:56 -0400
Date: Sun, 28 Jul 2002 05:00:06 +0200 (CEST)
From: =?iso-8859-15?Q?Mirko_D=F6lle?= <mdoelle@linux-user.de>
X-X-Sender: mdoelle@troy.linux-magazin.de
To: alan@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4.19-rc3, i810_audio: ignoring ready status of ICH for
 i845G chipset / Epox mainboard
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Message-Id: <20020728030014.B250015C97@mail.linux-new-media.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

this patch for Kernel 2.4.19-rc3 removes the "break" that aborted the module
init of i810_audio.o in case of "not ready" status before probing (line
2656-2663).
On my Epox 4G4A+ mainboard with i845G chipset the ready status was always "0",
so the module could not be loaded. After removing the "break" in line 2663
the module works great: loading, playing serveral MP3s, removing and reloading
were no problem.

Perhaps someone can confirm this so the break could perhaps be removed in the
final Kernel 2.4.19.



diff -ru linux-2.4.19-rc3.orig/drivers/sound/i810_audio.c linux-2.4.19-rc3.patched/drivers/sound/i810_audio.c
--- linux-2.4.19-rc3.orig/drivers/sound/i810_audio.c	Sun Jul 28 05:54:54 2002
+++ linux-2.4.19-rc3.patched/drivers/sound/i810_audio.c	Sun Jul 28 06:06:06 2002
@@ -2660,7 +2660,10 @@
 		if (!i810_ac97_exists(card,num_ac97)) {
 			if(num_ac97 == 0)
 				printk(KERN_ERR "i810_audio: Primary codec not ready.\n");
-			break; /* I think this works, if not ready stop */
+			/* Hack by dg2fer: On my Epox 4G4A+ with i845G we should just    */
+			/* continue probing and *not* break. The status is always "not   */
+			/* ready" but afterwards it works great. So I removed the break. */
+			/* break; */ /* I think this works, if not ready stop */
 		}

 		if ((codec = kmalloc(sizeof(struct ac97_codec), GFP_KERNEL)) == NULL)



With best regards,
Sincerely,
  Mirko, dg2fer

