Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267542AbUIGIES@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267542AbUIGIES (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 04:04:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267523AbUIGIES
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 04:04:18 -0400
Received: from natnoddy.rzone.de ([81.169.145.166]:56749 "EHLO
	natnoddy.rzone.de") by vger.kernel.org with ESMTP id S267542AbUIGIDM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 04:03:12 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Hirokazu Takata <takata@linux-m32r.org>
Subject: Re: [PATCH 2.6.9-rc1-mm3] [m32r] Modify sys_ipc() to remove useless iBCS2 support code
Date: Tue, 7 Sep 2004 10:02:11 +0200
User-Agent: KMail/1.6.2
Cc: akpm@osdl.org, hch@infradead.org, linux-kernel@vger.kernel.org
References: <20040903014811.6247d47d.akpm@osdl.org> <20040903105423.A3179@infradead.org> <20040906.214051.336469534.takata.hirokazu@renesas.com>
In-Reply-To: <20040906.214051.336469534.takata.hirokazu@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_IsWPB+wnoSiArQR";
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200409071002.17155.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_IsWPB+wnoSiArQR
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Montag, 6. September 2004 14:40, Hirokazu Takata wrote:
> From: Christoph Hellwig <hch@infradead.org>
> >  - please don't implement ancient backward-compat syscalls in a new
> >    port (that's why we made those conditional on __ARCH_WANT_* in unist=
d.h,
> >    but see also old_ in your arch code and the totally useless iBCS2
> >    hack in the sysv ipc code)
> >  - your probably want to run all this code through sparse and fix warni=
ngs
>
> The useless iBCS2 supporting code is removed.
>=20
> However, according to old_ syscalls, I would like to keep backward-
> compatibility for a while, due to some old deb packages and=20
> executables for m32r. =20

Actually, you should consider the complete sys_ipc interface deprecated,
just like sys_socketcall and all old_ syscalls. Neither of these should
not be added to any new architecture, because you can simply call the
underlying syscall handlers like sys_socket or sys_semop directly, like
e.g. parisc does.

I guess it would be a good idea to have architecture independent versions
of sys_pipe, sys_mmap and sys_uname in the tree so new architectures
can start with an empty sys_arch.c.

	Arnd <><

--Boundary-02=_IsWPB+wnoSiArQR
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBPWsI5t5GS2LDRf4RAte0AJ0QnYXpZja23/TFh3ayaBINOt/oVwCeKA6R
QemE0MG9VMzm9dGZ20Sndqw=
=5AN7
-----END PGP SIGNATURE-----

--Boundary-02=_IsWPB+wnoSiArQR--
