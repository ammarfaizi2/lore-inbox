Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264003AbTICRFZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 13:05:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263980AbTICRFY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 13:05:24 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:52659 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S264003AbTICRDt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 13:03:49 -0400
Date: Wed, 3 Sep 2003 19:03:48 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: (Simple) Basic Design Flaw in make menuconfig GUI
Message-ID: <20030903170348.GJ14376@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <001f01c37229$4bbd0410$1400a8c0@gaussian> <20030903083334.6a98a4f5.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="y5yQnZmVlpWlTeDv"
Content-Disposition: inline
In-Reply-To: <20030903083334.6a98a4f5.rddunlap@osdl.org>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--y5yQnZmVlpWlTeDv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 2003-09-03 08:33:34 -0700, Randy.Dunlap <rddunlap@osdl.org>
wrote in message <20030903083334.6a98a4f5.rddunlap@osdl.org>:
> On Wed, 3 Sep 2003 10:40:17 -0400 "Stevo" <stevo@cool3dz.com> wrote:
>=20
> | PROBLEM: (ocassionally) While I am speeding through the kernel
> | configuration, I will accidentally hit the "Esc" key one too many times=
 (I'm
> | sure we've all done this) and it will leave me at the "exit" screen:

> | can someone please add one more simple choice to the "exit" menu?
>=20
> Yes, I've needed that choice at times also.

Like this?


--- linux-2.6.0-test4-bk5/scripts/kconfig/mconf.c.jbglaw	2003-09-03 18:28:0=
6.000000000 +0200
+++ linux-2.6.0-test4-bk5/scripts/kconfig/mconf.c	2003-09-03 19:00:31.00000=
0000 +0200
@@ -773,27 +773,56 @@
 	tcgetattr(1, &ios_org);
 	atexit(conf_cleanup);
 	init_wsize();
-	conf(&rootmenu);
=20
-	do {
-		cprint_init();
-		cprint("--yesno");
-		cprint("Do you wish to save your new kernel configuration?");
-		cprint("5");
-		cprint("60");
-		stat =3D exec_conf();
-	} while (stat < 0);
-
-	if (stat =3D=3D 0) {
-		conf_write(NULL);
-		printf("\n\n"
-			"*** End of Linux kernel configuration.\n"
-			"*** Execute 'make' to build the kernel or try 'make help'."
-			"\n\n");
-	} else
-		printf("\n\n"
-			"Your kernel configuration changes were NOT saved."
-			"\n\n");
+	while (1) {
+		/*
+		 * Config dialog
+		 */
+		conf(&rootmenu);
+
+		/*
+		 * Really quit?
+		 */
+		do {
+			cprint_init();
+			cprint("--title");
+			cprint("Save configuration");
+			cprint("--radiolist");
+			cprint(radiolist_instructions);
+			cprint("15");
+			cprint("70");
+			cprint("6");
+
+			cprint("continue");
+			cprint("Continue with configuation");
+			cprint("ON");
+
+			cprint("save");
+			cprint("Save .config and exit");
+			cprint("OFF");
+
+			cprint("exit");
+			cprint("Don't save .config and exit");
+			cprint("OFF");
+
+			stat =3D exec_conf();
+		} while (stat < 0);
+
+		if(!strcmp(input_buf, "save")) {
+			conf_write(NULL);
+			printf("\n\n"
+				"*** End of Linux kernel configuration.\n"
+				"*** Execute 'make' to build the kernel or try 'make help'."
+				"\n\n");
+			return 0;
+		}
+		if(!strcmp(input_buf, "exit")) {
+			printf("\n\n"
+				"Your kernel configuration changes were NOT saved."
+				"\n\n");
+			return 0;
+		}
+	}
=20
 	return 0;
 }



MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
      ret =3D do_actions((curr | FREE_SPEECH) & ~(IRAQ_WAR_2 | DRM | TCPA));

--y5yQnZmVlpWlTeDv
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/Vh7zHb1edYOZ4bsRAgfxAJ0XPFuV+vMvkflzPloudwDYxiTJ/gCeNGny
BqRDjDp3JFTU2OxRGiFwVpY=
=ce9s
-----END PGP SIGNATURE-----

--y5yQnZmVlpWlTeDv--
