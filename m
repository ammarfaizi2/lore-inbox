Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272912AbTG3Ooe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 10:44:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272914AbTG3Ooe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 10:44:34 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:47793 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S272912AbTG3Oob (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 10:44:31 -0400
Date: Wed, 30 Jul 2003 16:44:29 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: TSCs are a no-no on i386
Message-ID: <20030730144429.GC1873@lug-owl.de>
Mail-Followup-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	lkml <linux-kernel@vger.kernel.org>
References: <20030730135623.GA1873@lug-owl.de> <Pine.GSO.3.96.1030730161309.911E-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pS0IeWLqOQV1qy0L"
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1030730161309.911E-100000@delta.ds2.pg.gda.pl>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--pS0IeWLqOQV1qy0L
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 2003-07-30 16:18:11 +0200, Maciej W. Rozycki <macro@ds2.pg.gda.pl>
wrote in message <Pine.GSO.3.96.1030730161309.911E-100000@delta.ds2.pg.gda.=
pl>:
> On Wed, 30 Jul 2003, Jan-Benedict Glaw wrote:
> > This small patch fixes a long-standing problem for bare i386 CPUs. These
> > don't have TSCs and so, a recent 2.4.x kernel will simply halt the
>=20
>  Actually i486 processors and some Pentium-like clones have none, too.

Ah, I didn't know that. Here's the updated patch:


--- linux-2.4.22-pre9/arch/i386/config.in.orig	2003-07-30 16:38:03.00000000=
0 +0200
+++ linux-2.4.22-pre9/arch/i386/config.in	2003-07-30 16:39:20.000000000 +02=
00
@@ -56,6 +56,7 @@
    define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM n
    define_bool CONFIG_X86_PPRO_FENCE y
    define_bool CONFIG_X86_F00F_WORKS_OK n
+   define_bool CONFIG_X86_HAS_TSC n
 else
    define_bool CONFIG_X86_WP_WORKS_OK y
    define_bool CONFIG_X86_INVLPG y
@@ -72,6 +73,7 @@
    define_bool CONFIG_X86_ALIGNMENT_16 y
    define_bool CONFIG_X86_PPRO_FENCE y
    define_bool CONFIG_X86_F00F_WORKS_OK n
+   define_bool CONFIG_X86_HAS_TSC n
 fi
 if [ "$CONFIG_M586" =3D "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 5
@@ -79,6 +81,7 @@
    define_bool CONFIG_X86_ALIGNMENT_16 y
    define_bool CONFIG_X86_PPRO_FENCE y
    define_bool CONFIG_X86_F00F_WORKS_OK n
+   define_bool CONFIG_X86_HAS_TSC n
 fi
 if [ "$CONFIG_M586TSC" =3D "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 5



MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
      ret =3D do_actions((curr | FREE_SPEECH) & ~(IRAQ_WAR_2 | DRM | TCPA));

--pS0IeWLqOQV1qy0L
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/J9nNHb1edYOZ4bsRAln8AJ0cSybzDBYZbZ++xcRhia5poBWcAACff3zs
BpbWRIc5ORwagUZVii7fUVM=
=xW8P
-----END PGP SIGNATURE-----

--pS0IeWLqOQV1qy0L--
