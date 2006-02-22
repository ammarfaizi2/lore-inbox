Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751391AbWBVShZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751391AbWBVShZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 13:37:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751390AbWBVShZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 13:37:25 -0500
Received: from mail.gmx.net ([213.165.64.20]:43440 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751286AbWBVShX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 13:37:23 -0500
X-Authenticated: #2308221
Date: Wed, 22 Feb 2006 19:37:18 +0100
From: Christian Trefzer <ctrefzer@gmx.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Gabor Gombas <gombasg@sztaki.hu>, "Theodore Ts'o" <tytso@mit.edu>,
       Andrew Morton <akpm@osdl.org>, Kay Sievers <kay.sievers@suse.de>,
       penberg@cs.helsinki.fi, gregkh@suse.de, bunk@stusta.de, rml@novell.com,
       linux-kernel@vger.kernel.org, johnstul@us.ibm.com
Subject: Re: 2.6.16-rc4: known regressions
Message-ID: <20060222183718.GA13193@zeus.uziel.local>
References: <20060221153305.5d0b123f.akpm@osdl.org> <20060222000429.GB12480@vrfy.org> <20060221162104.6b8c35b1.akpm@osdl.org> <Pine.LNX.4.64.0602211631310.30245@g5.osdl.org> <Pine.LNX.4.64.0602211700580.30245@g5.osdl.org> <20060222112158.GB26268@thunk.org> <20060222154820.GJ16648@ca-server1.us.oracle.com> <20060222162533.GA30316@thunk.org> <20060222173354.GJ14447@boogie.lpds.sztaki.hu> <Pine.LNX.4.64.0602220942040.30245@g5.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0602220942040.30245@g5.osdl.org>
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi everyone,


On Wed, Feb 22, 2006 at 09:57:38AM -0800, Linus Torvalds wrote:
>=20
>=20
> I _think_ that in this particular case, the best particular choice might=
=20
> be for the "mount" binary to be taught to re-try after a few seconds:=20
> either with a command line argument, or with just the early bootup initrd=
=20
> code being encouraged to have a loop like
>=20
> 	if (mounting root failed)
> 		echo "Please press F1 to continue"
> 		do
> 			read-keyboard-with-5-second-timeout
> 		while (mounting root failed)
> 	endif
>=20
> so that the user would have to press a key (or we'd just re-try every fiv=
e=20
> seconds).
>=20
> That way, the boot wouldn't just fail immediately over something that can=
=20
> be fixed (sometimes the root partition might just be hot-pluggable too:=
=20
> "insert disk and continue" can be a valid way to handle issues).
>=20

Is there a way to tell the kernel about which is the root device other
than through the kernel command line? If not, /init or /linuxrc could
parse /proc/cmdline for that and wait for the device node to appear.

Having the same trouble with my crude bloated glibc initramfs, I
resorted to waiting for /dev/hdX to appear after ide module insertion in
a loop with one second delay. AFAICS the loop is taken three times at
most on my slowest box, so five seconds seems a bit much, IMHO.

Trivial shell code goes like

echo -n "Waiting for root device to appear"
while [ ! -e $rootdevice ]
do
	sleep 1s
	echo -n "."
done
echo " OK."

The only downside here would be devices specified as hex numbers, and we
have an endless loop in case something went wrong. The latter can be
addressed with a counter checked against some sane limit.

Worked fine for me every time, except once when I build an image without
the IDE controller's module : /


Chris


--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (GNU/Linux)

iQIVAwUBQ/yvXl2m8MprmeOlAQKF0w/+KCcpm5rWhbbC/16JmDljJlI02pq4dF8t
eQ6JWJZXmS+Pv5G6NVIR2qXdU9DlNFFotADbS1UpXfW9TKwlIvuGO1o+S983L2rR
rBFi2r5aWzajjQp6IadxXqoWVR0h+vuXoGWy+PO0pE6B+44GOCl90baH6FYfOSA6
kbBP/R6Uj87xDLLHnW9SpdwYJS/LkCrImaqleFiszEXqZmGBbCSoP9ghZexz2Ejk
HVnQz0dtDa+gdwntyVfEflLJcRJ+FB5vaHm/QXoDfnNo8VbbjZAlZX214codTcjy
d/+o4VqNDSs4QKtk0JK/XVJrm5HED/MHFRjf3jqDxNnoZAAblRUHI/FqVfCW0BoG
DmmegvsXOuNikTehK80EDpCE1LTrTTEBCf9NKKmB3kbSXKsvUCaWQIy4Yk1al5Ie
Lw0xT8l9MHejjWk+6JcOnFhLnZgcyhIKpS2uLMT2ezW84CZOfe2XJXe+ebQItco+
knnNfPFXnS64D5z0IjWx8C1po/jIifQIzJKRCRPFgTgptkLD0xe2KVrlq31A9Wy1
yvIA3xsxXqE0FGDnsY7MmbgUS8FiU5Yp3mLq8Syy2Kt7xrEShPAVCLkgxjP3jz88
8MuQoaZjJWy0H34gJkbtbrmfanP+lQRp5ANovnhh9L5Is8JU8lSdj0T0c43AXq1S
71oSqmnUUX8=
=sF05
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--

