Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751453AbWCYRfF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751453AbWCYRfF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 12:35:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751454AbWCYRfF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 12:35:05 -0500
Received: from mail.gmx.net ([213.165.64.20]:29594 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751453AbWCYRfD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 12:35:03 -0500
X-Authenticated: #2308221
Date: Sat, 25 Mar 2006 18:35:11 +0100
From: Christian Trefzer <ctrefzer@gmx.de>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ccache complains in latest git about -p
Message-ID: <20060325173511.GB10293@zeus.uziel.local>
References: <200603251521.32217.ak@suse.de> <200603251528.20299.ak@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QKdGvSO+nmPlgiQ/"
Content-Disposition: inline
In-Reply-To: <200603251528.20299.ak@suse.de>
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--QKdGvSO+nmPlgiQ/
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 25, 2006 at 03:28:20PM +0100, Andi Kleen wrote:
> With CC=3D"ccache cc" it works as expected.

And here I was, thinking that CC should be a variable containing no
whitespace, ie. just a single path to a binary, be it relative or
absolute, and that there were ways of teaching ccache to be completely
transparent (using gentoo, it was set up for me that way):

 $ ls -l /usr/lib/ccache/bin/
insgesamt 0
lrwxrwxrwx 1 root root 15  6. M=E4r 01:13 c++ -> /usr/bin/ccache
lrwxrwxrwx 1 root root 15  6. M=E4r 01:13 cc -> /usr/bin/ccache
lrwxrwxrwx 1 root root 15  6. M=E4r 01:13 g++ -> /usr/bin/ccache
lrwxrwxrwx 1 root root 15  6. M=E4r 01:13 gcc -> /usr/bin/ccache
lrwxrwxrwx 1 root root 15  6. M=E4r 01:13 i686-pc-linux-gnu-c++ ->
/usr/bin/ccache
lrwxrwxrwx 1 root root 15  6. M=E4r 01:13 i686-pc-linux-gnu-g++ ->
/usr/bin/ccache
lrwxrwxrwx 1 root root 15  6. M=E4r 01:13 i686-pc-linux-gnu-gcc ->
/usr/bin/ccache
 $=20

So all I need to do in order to enable ccache is add this stub dir to
the front of my PATH:

 $ echo $PATH
/usr/lib/ccache/bin:/usr/lib/distcc/bin:/usr/local/bin:/usr/i686-pc-linux-g=
nu/gcc-bin/4.1.0:[...]
(Note: the order of distcc after ccache is important, if not obvious)

So what the thing does is call the next instance of the name it was
called by from your path, ie. subtracts dirname($0) from the beginning
of $PATH, and supply each and every argument to that. In my past setup,
stuff is taken from the cache, and if not found, distributed across
machines. Works extremely well for kernel builds on slow machines, with
a faster one right beside it. And no dirty CC=3D stuff to begin with : )

AFAICT this is not a religious or purist issues, as there have been real
problems with CC not following the recommendation and some projects
relying on that, but as this thread goes to show there occur problems
even without real problems existing ; ) Maybe setting obscure CC
variables works reliably for kernel builds, I never tried...


Kind regards,

Chris


--QKdGvSO+nmPlgiQ/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iQIVAwUBRCV/T12m8MprmeOlAQJGJRAApz+xIRKJerRdSrSxMuJSFEvhrfeyX4Hk
LbogvndQYLeTSoY1X4Yr+Xfa/dzWg/dOXjZte3IU9IIjdDJyH5hGQtbDKhsRBcVq
10VFsUjY8QIVp112u+TcKfGkHbO9eE3z1vJ5zQ2v8h5QeFng0mBuVeHO6gUj1nsv
plB2yzth69qSBUVL3SE8NWIOZEF+EEyq3j+KOX+pJcUtXzxGnJjSaUGdGfn+FH9b
p1Mr/a9ekFPtc4/AClMn1lnYNX8h/yoxj/Ttt+K3Tbqe4euBZdveHntdREegO/IK
Iu5Z6p/QZwCHs/wua8EhUdqYn9RrED7xxm0bOF3nF6EockDH6aRb8TG5ly6ob6lB
RDlhwsfnxHMGodZ5XzovgMMNH4vrJkCHjaOvBx8jsXNggGVTpgP9ujI/j68j/t/l
QwRe1JWroTbnyMtUA7RftZQqN/MMVsypgf1B3UyifW/J965uD4xoiXNGicnlg5zR
im1cR7WwHlDbqV6DiiyNM3v7DGMqiQDAQ7YX1w+8YIsbD3pFUA724fSwqZFOssoD
nQX3sY+FbabmP35GbweqhGJoVUhQGZislJEz/2vcwpbwLXfkSX0uEI9jVVoZWPK2
sRYeBtIKmz9s9MesmuBnVR8U4b9oG0JkWn7K3GbLaoSGaQD0hJvoJ85yzVBtis8v
YkbGNkHNB1A=
=KuHn
-----END PGP SIGNATURE-----

--QKdGvSO+nmPlgiQ/--

