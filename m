Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264610AbSJNKaM>; Mon, 14 Oct 2002 06:30:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263491AbSJNKaM>; Mon, 14 Oct 2002 06:30:12 -0400
Received: from mailout09.sul.t-online.com ([194.25.134.84]:4299 "EHLO
	mailout09.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S264610AbSJNKaL>; Mon, 14 Oct 2002 06:30:11 -0400
Date: Mon, 14 Oct 2002 12:35:53 +0200
From: Martin Waitz <tali@admingilde.org>
To: linux-kernel@vger.kernel.org
Subject: [TRIVIAL PATCH] modular nfs broken
Message-ID: <20021014103553.GA1460@admingilde.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hi :)

from make modules_install:

if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.5.42; fi
depmod: *** Unresolved symbols in /lib/modules/2.5.42/kernel/fs/nfs/nfs.o
depmod:         generic_file_aio_read
depmod:         generic_file_aio_write


the following patch fixes that:

--- kernel/ksyms.c.orig 2002-10-14 12:27:25.000000000 +0200
+++ kernel/ksyms.c      2002-10-14 12:28:19.000000000 +0200
@@ -228,9 +228,11 @@ EXPORT_SYMBOL(generic_commit_write);
 EXPORT_SYMBOL(block_truncate_page);
 EXPORT_SYMBOL(generic_block_bmap);
 EXPORT_SYMBOL(generic_file_read);
+EXPORT_SYMBOL(generic_file_aio_read);
 EXPORT_SYMBOL(generic_file_sendfile);
 EXPORT_SYMBOL(do_generic_file_read);
 EXPORT_SYMBOL(generic_file_write);
+EXPORT_SYMBOL(generic_file_aio_write);
 EXPORT_SYMBOL(generic_file_write_nolock);
 EXPORT_SYMBOL(generic_file_mmap);
 EXPORT_SYMBOL(generic_ro_fops);


--=20
CU,		  / Friedrich-Alexander University Erlangen, Germany
Martin Waitz	//  [Tali on IRCnet]  [tali.home.pages.de] _________
______________/// - - - - - - - - - - - - - - - - - - - - ///
dies ist eine manuell generierte mail, sie beinhaltet    //
tippfehler und ist auch ohne grossbuchstaben gueltig.   /
			    -
Wer bereit ist, grundlegende Freiheiten aufzugeben, um sich=20
kurzfristige Sicherheit zu verschaffen, der hat weder Freiheit=20
noch Sicherheit verdient.
			Benjamin Franklin  (1706 - 1790)

--CE+1k2dSO48ffgeK
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE9qp4Jj/Eaxd/oD7IRAqbyAJwP+RQ14oydCBG9XPnXYk9CODxLIwCfUhRH
2hnXT/17Wh6naPhZMfC21Bg=
=7sVI
-----END PGP SIGNATURE-----

--CE+1k2dSO48ffgeK--
