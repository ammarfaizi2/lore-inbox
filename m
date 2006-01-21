Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932121AbWAULGH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932121AbWAULGH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 06:06:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932123AbWAULGG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 06:06:06 -0500
Received: from ganesha.gnumonks.org ([213.95.27.120]:57830 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S932121AbWAULGF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 06:06:05 -0500
Date: Sat, 21 Jan 2006 12:05:53 +0100
From: Harald Welte <laforge@netfilter.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: torvalds@osdl.org, bboissin@gmail.com, xslaby@fi.muni.cz, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: Iptables error
Message-ID: <20060121110553.GS4603@sunbeam.de.gnumonks.org>
References: <40f323d00601200843m32e8f5cbv5733209ce82b8a13@mail.gmail.com> <Pine.LNX.4.64.0601201148220.3672@evo.osdl.org> <20060120193201.GP4603@sunbeam.de.gnumonks.org> <20060120.114613.54096131.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="b1CVx77D595wdcW8"
Content-Disposition: inline
In-Reply-To: <20060120.114613.54096131.davem@davemloft.net>
User-Agent: mutt-ng devel-20050619 (Debian)
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--b1CVx77D595wdcW8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 20, 2006 at 11:46:13AM -0800, David S. Miller wrote:

> Your struct won't be 8-byte aligned either as far as I can tell on
> x86_64.

According to my tests, the struct is 8-byte-aligned on x86_64, and
that's how I'd like it to be.=20

Please don't ask me why it happens, I know that the alignment constraint
of a u64 on x86_64 is only 4.  But at least gcc-3.3.6 and gcc-4.0.3
(debian) result in __alignof__ of that test structure (and a 'u_int64_t
alone') to 8 bytes. =20

When it comes to these things, I can only do trial+error.

Maybe it's because __alignof__ returns the recommended alignment, not
the required alignment.

> We need to use the aligned_u64 thing if you want that.

That should make sure that we always get what we want, yes. =20

--=20
- Harald Welte <laforge@netfilter.org>                 http://netfilter.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
  "Fragmentation is like classful addressing -- an interesting early
   architectural error that shows how much experimentation was going
   on while IP was being designed."                    -- Paul Vixie

--b1CVx77D595wdcW8
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFD0hWRXaXGVTD0i/8RAsODAJ43oFRZxLfQ2ejgWxAvmajU9jWmBQCfQNFP
XWqJGy4ukEfWAbDQn6lezbU=
=EJNo
-----END PGP SIGNATURE-----

--b1CVx77D595wdcW8--
