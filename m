Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281222AbRKEQlJ>; Mon, 5 Nov 2001 11:41:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281223AbRKEQlB>; Mon, 5 Nov 2001 11:41:01 -0500
Received: from [194.51.220.145] ([194.51.220.145]:40916 "EHLO emeraude")
	by vger.kernel.org with ESMTP id <S281222AbRKEQkt>;
	Mon, 5 Nov 2001 11:40:49 -0500
Date: Mon, 5 Nov 2001 17:35:43 +0100
From: Stephane Jourdois <stephane@tuxfinder.org>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Massimo Dal Zotto <dz@debian.org>, LKLM <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] SMM BIOS on Dell i8100
Message-ID: <20011105173543.A17203@emeraude.kwisatz.net>
Reply-To: stephane@tuxfinder.org
In-Reply-To: <20011105100346.A1511@emeraude.kwisatz.net> <3BE6B869.D79E93B1@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
Content-Disposition: inline
In-Reply-To: <3BE6B869.D79E93B1@mandrakesoft.com>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux 2.4.14-pre8
X-Send-From: emeraude
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 05, 2001 at 11:03:53AM -0500, Jeff Garzik wrote:
> Stephane Jourdois wrote:
> > I've got a Dell Inspiron 8100, which seems to differ slightly from
> > i8000. Here is a patch that fixes that. Please do not hesitate to ask me
> > to test some new code or anything on my laptop.
> Has this been tested in I8000?  You are changing a lot of magic numbers
> in the code, and noone but you/Massimo know whether that is ok or not...

I presume it works.
Let me explain why while looking at parts of my patch :

-#define I8K_FN_NONE		0x08
-#define I8K_FN_UP		0x09
-#define I8K_FN_DOWN		0x0a
-#define I8K_FN_MUTE		0x0c
+#define I8K_FN_NONE		0x00
+#define I8K_FN_UP		0x01
+#define I8K_FN_DOWN		0x02
+#define I8K_FN_MUTE		0x04

In fact, i8100 returns respectively 1, 2 and 4.
i8100 returns 0x09, 0x0a, and 0x0c (see Massimo's code).

Then we can take the 4 lighter bits, and test them without testing
the 4 greater bits which value are 0x08 on i8000 and 0x00 on i8100.

hence :
-    switch ((regs.eax & 0xff00) >> 8) {
+    switch ((regs.eax & 0x0700) >> 8) {

a different version (which I didn't choose), would be to keep Massimo's
defines, and test (((regs.eax | 0x0800 ) & 0xff00) >> 8). But that's
more operations, then not the better solution :-)

As the drivers disks provided by Dell (windows drivers of course) are
the same which works on i8000 and i8100, I suppose that they test only
the 4 lighter bits here


Of course, as Massismo's told me a few hours ago, this is a beta version
of this code, and it supports at least Massimo's i8000 and now my i8100.
We should wait a few days for feed-back from lklm readers, then
Massimo's intents are to implement a more modular code. That's a good
intent, isn't it ? :-)


Anyway, you'll agree with me that 2 laptops is better than one :-)


Thanks for your answer.
St=E9phane.

--=20
 ///  Stephane Jourdois        	/"\  ASCII RIBBON CAMPAIGN \\\
(((    Ing=E9nieur d=E9veloppement 	\ /    AGAINST HTML MAIL    )))
 \\\   6, av. de la Belle Image	 X                         ///
  \\\  94440 Marolles en Brie  	/ \    +33 6 8643 3085    ///

--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjvmv98ACgkQk2dpMN4A2NMqHgCfafvIsNpUSrMWg7YfDJiwq7n2
u/0An1dZIfEz6Ds1TpIFaWN5/0R6TEE5
=z6Yr
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--
