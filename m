Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265592AbSJSMF0>; Sat, 19 Oct 2002 08:05:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265596AbSJSMF0>; Sat, 19 Oct 2002 08:05:26 -0400
Received: from [211.167.76.68] ([211.167.76.68]:26505 "HELO soulinfo")
	by vger.kernel.org with SMTP id <S265592AbSJSMFZ>;
	Sat, 19 Oct 2002 08:05:25 -0400
Date: Sat, 19 Oct 2002 20:05:00 +0800
From: Hu Gang <hugang@soulinfo.com>
To: Jaroslav Kysela <perex@suse.cz>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@ucw.cz>, mochel@osdl.org
Subject: [PATCH]1/2: fix intel8x0.c suspend problem.
Message-Id: <20021019200500.18d8f6df.hugang@soulinfo.com>
Organization: Beijing Soul
X-Mailer: Sylpheed version 0.8.2claws28 (GTK+ 1.2.10; i386-linux-debian-i386-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.t5HRkYAvpkN0(l"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.t5HRkYAvpkN0(l
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hello Patrick Mochel, Pavel Machek, Jaroslav Kysela :

When I use the 1/2 patch, the core suspend have works, but when the sound driver loaded the system still hang. This patch can fix it. Please apply.
---------------------------------------------------
--- linux-2.5.44-clean/sound/pci/intel8x0.c	Sat Oct 19 15:55:30 2002
+++ linux-2.5.44-suspend/sound/pci/intel8x0.c	Sat Oct 19 19:51:35 2002
@@ -1909,6 +1909,7 @@
 	snd_card_t *card = chip->card;
 	int i;
 
+	chip->in_suspend = 0;
 	snd_power_lock(card);
 	if (card->power_state == SNDRV_CTL_POWER_D0)
 		goto __skip;
@@ -1919,7 +1920,6 @@
 		if (chip->ac97[i])
 			snd_ac97_resume(chip->ac97[i]);
 
-	chip->in_suspend = 0;
 	snd_power_change_state(card, SNDRV_CTL_POWER_D0);
       __skip:
       	snd_power_unlock(card);

-- 
		- Hu Gang

--=.t5HRkYAvpkN0(l
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE9sUpsPM4uCy7bAJgRAs8NAJ4xsrJgfLMNYi8yBMw6UiJDI0eppgCeMGvU
lqwAmJ83j8IK9o/ES8n9OuE=
=uEaE
-----END PGP SIGNATURE-----

--=.t5HRkYAvpkN0(l--
