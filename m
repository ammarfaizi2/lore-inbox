Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315188AbSD3T6u>; Tue, 30 Apr 2002 15:58:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315191AbSD3T6t>; Tue, 30 Apr 2002 15:58:49 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:3246 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id <S315188AbSD3T6s>;
	Tue, 30 Apr 2002 15:58:48 -0400
Date: Tue, 30 Apr 2002 21:58:44 +0200
From: Martin Schewe <m@xsms.de>
To: Jens Axboe <axboe@suse.de>
Cc: Aaron Tiensivu <mojomofo@mojomofo.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IDE TCQ #4
Message-ID: <20020430195844.GA18504@linux01.gwdg.de>
In-Reply-To: <20020415125606.GR12608@suse.de> <02db01c1e498$7180c170$58dc703f@bnscorp.com> <20020416102510.GI17043@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DBIVS5p969aUjpLe"
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--DBIVS5p969aUjpLe
Content-Type: multipart/mixed; boundary="uAKRQypu60I7Lcqm"
Content-Disposition: inline


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Apr 16, 2002 at 12:25:10PM +0200, Jens Axboe wrote:

> Mark Hahn wrote this little script to detect support for TCQ, modified
> by me to not use the hdX symlinks.
>=20
> [...]
>=20
> #!/usr/bin/perl
>=20
> # bit 1 (TCQ) and 14 (word is valid) must be set to indicate tcq support
> $mask =3D (1 << 1) | (1 << 14);
>=20
> # bit 15 must be cleared too
> $bits =3D $mask | (1 << 15);
>=20
> # mail me the results!
> $addr =3D "linux-tcq\@kernel.dk";
>=20
> foreach $i (</proc/ide/ide*>) {
> 	foreach $d (<$i/hd*>) {
> 		@words =3D split(/\s/,`cat $d/identify`);
> 		$w83 =3D hex($words[83]);
> 		if (!(($w83 & $bits) ^ $mask)) {
> 			$model =3D `cat $d/model`;
> 			push(@goodies, $model);
> 			chomp($model);
> 			print "$d ($model) supports TCQ\n";
> 		}
> 	}
> }
>=20
> if ($addr && $#goodies) {

$#goodies refers to the last index of the array and scalar @goodies to
the actual number of elements.  So you probably got only mails from
people having more than two drives supporting TCQ...  :)

> 	open(M, "| mail -s TCQ-report $addr");
> 	print M @goodies;
> 	close(M);
> }

Fixed version attached.

		Martin

--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=tcq_support

#!/usr/bin/perl

# bit 1 (TCQ) and 14 (word is valid) must be set to indicate tcq support
$mask = (1 << 1) | (1 << 14);

# bit 15 must be cleared too
$bits = $mask | (1 << 15);

# mail me the results!
$addr = "linux-tcq\@kernel.dk";

foreach $i (</proc/ide/ide*>) {
	foreach $d (<$i/hd*>) {
		@words = split(/\s/,`cat $d/identify`);
		$w83 = hex($words[83]);
		if (!(($w83 & $bits) ^ $mask)) {
			$model = `cat $d/model`;
			push(@goodies, $model);
			chomp($model);
			print "$d ($model) supports TCQ\n";
		}
	}
}

if ($addr && @goodies) {
	open(M, "| mail -s TCQ-report $addr");
	print M @goodies;
	close(M);
}

--uAKRQypu60I7Lcqm--

--DBIVS5p969aUjpLe
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Weitere Infos: siehe http://www.gnupg.org

iD8DBQE8zvdzvFdT+uCkj6sRAsVzAJ4pf9iCW5P3mQduCeOxXP92z1ca7ACgqCAj
3WhceQ0Vqgrao/HdlR0klTc=
=XiIg
-----END PGP SIGNATURE-----

--DBIVS5p969aUjpLe--
