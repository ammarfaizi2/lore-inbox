Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261552AbVBNUN4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261552AbVBNUN4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 15:13:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261557AbVBNUNz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 15:13:55 -0500
Received: from mail.murom.net ([213.177.124.17]:65200 "EHLO ns1.murom.ru")
	by vger.kernel.org with ESMTP id S261552AbVBNUKN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 15:10:13 -0500
Date: Mon, 14 Feb 2005 23:10:10 +0300
From: Sergey Vlasov <vsu@altlinux.ru>
To: linux-kernel@vger.kernel.org
Cc: linux-fbdev-devel@lists.sourceforge.net
Subject: [PATCH 2.6 2/2] Fix documentation build failure
Message-ID: <20050214201009.GB29201@sirius.home>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	linux-fbdev-devel@lists.sourceforge.net
References: <20050214200017.GA29201@sirius.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZoaI/ZTpAVc4A5k6"
Content-Disposition: inline
In-Reply-To: <20050214200017.GA29201@sirius.home>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ZoaI/ZTpAVc4A5k6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello!

In linux-2.6.11-rc4-bk2 building of the documentation (make htmldocs)
fails on "DOCPROC Documentation/DocBook/kernel-api.sgml" because of
these errors:

Error(/home/vsu/src/linux-2.6.11-rc4-bk2/include/linux/skbuff.h:936): canno=
t understand prototype: '#ifndef CONFIG_HAVE_ARCH_DEV_ALLOC_SKB '
Error(/home/vsu/src/linux-2.6.11-rc4-bk2/drivers/video/fbmem.c:1265): canno=
t understand prototype: 'const char *global_mode_option; '

This patch fixes htmldocs build failure on drivers/video/fbmem.c.
I think this patch (or an equivalent one) should be merged before the
2.6.11 release.

Signed-off-by: Sergey Vlasov <vsu@altlinux.ru>


--- linux-2.6.11-rc4-bk2/drivers/video/fbmem.c.doc-build	2005-02-14 20:12:3=
3 +0300
+++ linux-2.6.11-rc4-bk2/drivers/video/fbmem.c	2005-02-14 23:02:45 +0300
@@ -1261,9 +1261,6 @@ int fb_get_options(char *name, char **op
  *	Returns zero.
  *
  */
-
-extern const char *global_mode_option;
-
 int __init video_setup(char *options)
 {
 	int i, global =3D 0;
@@ -1277,6 +1274,8 @@ int __init video_setup(char *options)
  	}
=20
  	if (!global && !strstr(options, "fb:")) {
+		extern const char *global_mode_option;
+
  		global_mode_option =3D options;
  		global =3D 1;
  	}


--=20
Sergey Vlasov

--ZoaI/ZTpAVc4A5k6
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCEQWgW82GfkQfsqIRAmlqAJ0ahaEYp3aK96NpqV2ZvVjrXaTgHwCfewCo
uvD76GxbGvoyAZNFjX4a7Vo=
=vqEa
-----END PGP SIGNATURE-----

--ZoaI/ZTpAVc4A5k6--
