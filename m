Return-Path: <linux-kernel-owner+w=401wt.eu-S932729AbXAJLnc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932729AbXAJLnc (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 06:43:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932738AbXAJLnc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 06:43:32 -0500
Received: from wavehammer.waldi.eu.org ([82.139.201.20]:35253 "EHLO
	wavehammer.waldi.eu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932729AbXAJLnb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 06:43:31 -0500
X-Greylist: delayed 1163 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Jan 2007 06:43:30 EST
Date: Wed, 10 Jan 2007 12:24:03 +0100
From: Bastian Blank <bastian@waldi.eu.org>
To: kai@germaschewski.name, sam@ravnborg.org
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] kbuild: Don't ignore localversion files if the path includes a ~
Message-ID: <20070110112403.GA30765@wavehammer.waldi.eu.org>
Mail-Followup-To: Bastian Blank <bastian@waldi.eu.org>,
	kai@germaschewski.name, sam@ravnborg.org,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cNdxnHkX5QqsyA0e"
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Kai, Sam

The following patch fixes the problem that localversion files where
ignored if the tree lives in a path which contains a ~. It changes the
test to apply to the filename only.

Debian allows versions which contains ~ in it. The upstream part of the
version is in the directory name of the build tree and we got weird
results because the localversion files was just got ignored in this
case.

--- a/Makefile
+++ b/Makefile
@@ -807,7 +807,7 @@ space      :=3D $(nullstring) # end of line
 ___localver =3D $(objtree)/localversion* $(srctree)/localversion*
 __localver  =3D $(sort $(wildcard $(___localver)))
 # skip backup files (containing '~')
-_localver =3D $(foreach f, $(__localver), $(if $(findstring ~, $(f)),,$(f)=
))
+_localver =3D $(foreach f, $(__localver), $(if $(findstring ~, $(notdir $(=
f))),,$(f)))
=20
 localver =3D $(subst $(space),, \
           $(shell cat /dev/null $(_localver)) \

--=20
Totally illogical, there was no chance.
		-- Spock, "The Galileo Seven", stardate 2822.3

--cNdxnHkX5QqsyA0e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iEYEARECAAYFAkWkzNMACgkQnw66O/MvCNHleQCfdKv7eBxqXpPsLPDid3LYH3Hf
//IAn2UpfZImDoycjY1ody8pmI1od0pb
=XYvP
-----END PGP SIGNATURE-----

--cNdxnHkX5QqsyA0e--
