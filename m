Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261468AbUK1NjO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261468AbUK1NjO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 08:39:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261469AbUK1NjO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 08:39:14 -0500
Received: from natsmtp00.rzone.de ([81.169.145.165]:11504 "EHLO
	natsmtp00.rzone.de") by vger.kernel.org with ESMTP id S261468AbUK1NjI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 08:39:08 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: ak@muc.de
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
Date: Sun, 28 Nov 2004 14:32:41 +0100
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
       David Howells <dhowells@redhat.com>, torvalds@osdl.org,
       hch@infradead.org, matthew@wil.cx, dwmw2@infradead.org,
       aoliva@redhat.com, Andreas Steinmetz <ast@domdv.de>
References: <34Xo6-2P0-19@gated-at.bofh.it> <35kb6-46Q-25@gated-at.bofh.it> <20041128005506.96454.qmail@colin2.muc.de>
In-Reply-To: <20041128005506.96454.qmail@colin2.muc.de>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_5NdqBEYtQyKtRPb";
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200411281432.41342.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_5NdqBEYtQyKtRPb
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On S=FCnndag 28 November 2004 01:55, ak@muc.de wrote:
> Please don't do that. x86_64 are not really synchronized in development
> (unlike s390/s390x) and I don't really want too coordinate too much
> with the i386 people when I change something in asm. There are also
> significant differences in some places already.
> Keep it separate is imho far better.
>=20
The ABI is actually a very small part of the asm/ files [1] and typically
one that does not see many changes. I found 5 files (fcntl.h ioctl.h
siginfo.h statfs.h types.h) that have trivial differences between i386
and x86_64 and can be merged, as well as 6 files (posix_types.h ptrace.h
sigcontext.h signal.h stat.h unistd.h) that are so different that it
makes sense to keep them completely separate files with an extra file
to choose between them.

The rest is either not part of the ABI or already identical.

	Arnd <><

[1] A quick browse over the files suggests we need only:
  errno.h fcntl.h ioctl.h ioctls.h ipc.h ipcbuf.h msgbuf.h
  param.h poll.h posix_types.h ptrace.h resource.h sembuf.h
  shmbuf.h shmparam.h sigcontext.h siginfo.h signal.h
  socket.h sockios.h stat.h statfs.h termbits.h termios.h
  types.h unistd.h

  If anyone has a better list, please post it.

--Boundary-02=_5NdqBEYtQyKtRPb
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBqdN55t5GS2LDRf4RAlzZAKCibCSSlewsz6+/i5cemSwcFg4MMACffpcS
weP0AoMW/sTpkCf1NFyC3Oo=
=E4+Q
-----END PGP SIGNATURE-----

--Boundary-02=_5NdqBEYtQyKtRPb--
