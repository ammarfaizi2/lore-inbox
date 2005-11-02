Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964894AbVKBNUz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964894AbVKBNUz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 08:20:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964963AbVKBNUy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 08:20:54 -0500
Received: from chilli.pcug.org.au ([203.10.76.44]:4237 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S964894AbVKBNUx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 08:20:53 -0500
Date: Thu, 3 Nov 2005 00:20:12 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Christoph Hellwig <hch@lst.de>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] TIOC* compat ioctl handling
Message-Id: <20051103002012.5e422ae5.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Thu__3_Nov_2005_00_20_12_+1100_PTO1GKof1SSVe1r5"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Thu__3_Nov_2005_00_20_12_+1100_PTO1GKof1SSVe1r5
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Christoph,

This patch (commit 9c0cbd54ce0397017a823484f9a8054ab369b8a2) removed the
COMPATIBLE_IOCTL bits for TIOCSTART and TIOCSTOP because they are
unimplemented.  The result is that the first 50 times you type ^C at a
bash prompt (on ppc64 at least) you get a nice message in your syslog (and
on your console):

ioctl32(bash:3527): Unknown cmd fd(2) cmd(2000746e){' '} arg(00000000) on /=
dev/pts/0

Because bash (on ppc64 at least) does a TIOCSTART ioctl when ^C is
pressed.  The ioctl always returned EINVAL but now we also get the log
message.  Should we put the COMPATIBLE_IOCTL bits back?

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__3_Nov_2005_00_20_12_+1100_PTO1GKof1SSVe1r5
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDaL0MFdBgD/zoJvwRAmymAJ49sxE8IeWvGXfqQqsHqncIeODn4QCdF00q
FiyZ2EyyOYzG4cHlBgmvLr4=
=MSUy
-----END PGP SIGNATURE-----

--Signature=_Thu__3_Nov_2005_00_20_12_+1100_PTO1GKof1SSVe1r5--
