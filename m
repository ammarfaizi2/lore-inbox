Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261489AbVAANSi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261489AbVAANSi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jan 2005 08:18:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261870AbVAANSi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jan 2005 08:18:38 -0500
Received: from admingilde.org ([213.95.21.5]:7876 "EHLO mail.admingilde.org")
	by vger.kernel.org with ESMTP id S261489AbVAANSd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jan 2005 08:18:33 -0500
Date: Sat, 1 Jan 2005 14:18:04 +0100
From: Martin Waitz <tali@admingilde.org>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: make mandocs fails in 2.6.10-bk2
Message-ID: <20050101131804.GA4693@admingilde.org>
Mail-Followup-To: Jesper Juhl <juhl-lkml@dif.dk>,
	linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
References: <Pine.LNX.4.61.0412310135290.4725@dragon.hygekrogen.localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0412310135290.4725@dragon.hygekrogen.localhost>
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.6+20040907i
X-Hashcash: 0:050101:juhl-lkml@dif.dk:0bfc2bf279a0fb48
X-Hashcash: 0:050101:torvalds@osdl.org:1bed4cb574b7aab4
X-Hashcash: 0:050101:linux-kernel@vger.kernel.org:80752be8ceac8b8a
X-Spam-Score: -12.3 (------------)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Fri, Dec 31, 2004 at 01:40:54AM +0100, Jesper Juhl wrote:
> juhl@dragon:~/download/kernel/linux-2.6.10-bk2$ make mandocs
>   DOCPROC Documentation/DocBook/kernel-api.sgml
> docproc: /home/juhl/download/kernel/linux-2.6.10-bk2/drivers/net/net_init=
=2Ec: No such file or directory
> /bin/sh: line 1:  4845 Segmentation fault     =20
> SRCTREE=3D/home/juhl/download/kernel/linux-2.6.10-bk2/ scripts/basic/docp=
roc doc Documentation/DocBook/kernel-api.tmpl >Documentation/DocBook/kernel=
-api.sgml
> make[1]: *** [Documentation/DocBook/kernel-api.sgml] Error 139
> make: *** [mandocs] Error 2
>=20
> removing the reference to net_init.c makes it continue a bit further but=
=20
> it still ends up failing with these errors :=20

that's right.
net_init.c was removed but the reference in the documentation was
overseen.

The other blocker in building documentation is an #ifdef between
the comment and the function prototype in include/linux/skbuff.h:942.

Building documentation works again with the patch below:

Index: Documentation/DocBook/kernel-api.tmpl
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /home/martin/src/linux/linux-cvs/linux-2.5/Documentation/DocBook/=
kernel-api.tmpl,v
retrieving revision 1.33
diff -u -p -r1.33 kernel-api.tmpl
--- Documentation/DocBook/kernel-api.tmpl	1 Dec 2004 07:11:50 -0000	1.33
+++ Documentation/DocBook/kernel-api.tmpl	30 Dec 2004 20:28:16 -0000
@@ -143,7 +143,6 @@ KAO -->
   <chapter id=3D"netdev">
      <title>Network device support</title>
      <sect1><title>Driver Support</title>
-!Edrivers/net/net_init.c
 !Enet/core/dev.c
      </sect1>
      <sect1><title>8390 Based Network Cards</title>
Index: scripts/kernel-doc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /home/martin/src/linux/linux-cvs/linux-2.5/scripts/kernel-doc,v
retrieving revision 1.21
diff -u -p -r1.21 kernel-doc
--- scripts/kernel-doc	8 Nov 2004 22:45:49 -0000	1.21
+++ scripts/kernel-doc	30 Dec 2004 21:55:55 -0000
@@ -1578,13 +1578,13 @@ sub process_state3_function($$) {=20
     my $x =3D shift;
     my $file =3D shift;
=20
-    if ($x =3D~ m#\s*/\*\s+MACDOC\s*#io) {
+    if ($x =3D~ m#\s*/\*\s+MACDOC\s*#io || ($x =3D~ /^#/ && $x !~ /^#defin=
e/)) {
 	# do nothing
     }
     elsif ($x =3D~ /([^\{]*)/) {
         $prototype .=3D $1;
     }
-    if (($x =3D~ /\{/) || ($x =3D~ /\#/) || ($x =3D~ /;/)) {
+    if (($x =3D~ /\{/) || ($x =3D~ /\#define/) || ($x =3D~ /;/)) {
         $prototype =3D~ s@/\*.*?\*/@@gos;	# strip comments.
 	$prototype =3D~ s@[\r\n]+@ @gos; # strip newlines/cr's.
 	$prototype =3D~ s@^\s+@@gos; # strip leading spaces

--=20
Martin Waitz

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFB1qMMj/Eaxd/oD7IRArEpAJ9RStxTQMpjLAhVRNVewz07G1bstACdGNjN
bAhx6oBSt20Cx8P4/JL0I90=
=EGsM
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--

