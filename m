Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267939AbTBMA0b>; Wed, 12 Feb 2003 19:26:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267940AbTBMA0b>; Wed, 12 Feb 2003 19:26:31 -0500
Received: from aramis.rutgers.edu ([128.6.4.2]:48292 "EHLO aramis.rutgers.edu")
	by vger.kernel.org with ESMTP id <S267939AbTBMA0a>;
	Wed, 12 Feb 2003 19:26:30 -0500
Subject: Re: O_DIRECT foolish question
From: Bruno Diniz de Paula <diniz@cs.rutgers.edu>
To: Chris Wedgwood <cw@f00f.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030213001302.GA13833@f00f.org>
References: <20030212140338.6027fd94.akpm@digeo.com>
	 <1045088991.4767.85.camel@urca.rutgers.edu>
	 <20030212224226.GA13129@f00f.org>
	 <1045090977.21195.87.camel@urca.rutgers.edu>
	 <20030212232443.GA13339@f00f.org>
	 <1045092802.4766.96.camel@urca.rutgers.edu>
	 <20030212233846.GA13540@f00f.org>
	 <1045093775.21195.99.camel@urca.rutgers.edu>
	 <20030212235130.GA13629@f00f.org>
	 <1045094589.4767.106.camel@urca.rutgers.edu>
	 <20030213001302.GA13833@f00f.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Vj25H8Ch5OdbywqelHBW"
Organization: Rutgers University
Message-Id: <1045096579.21195.121.camel@urca.rutgers.edu>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 12 Feb 2003 19:36:19 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Vj25H8Ch5OdbywqelHBW
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2003-02-12 at 19:13, Chris Wedgwood wrote:
> If I had to guess, write should work more or less the same as reads
> (ie. I should be able to write aligned-but-smaller-than-page-sized
> blocks to the end of files).
>=20
> Testing this however shows this is *not* the case.

This is not the case, I have also tested here and the file written has
n*block_size always. The problem with writing is that we can't sign to
the kernel that the actual data has finished and from that point on it
should zero-fill the bytes. And what is worse, the information about the
actual size is lost, since the write syscall will store what is passed
on the 3rd argument in the inode (field st_size of stat). This means
that after writing using O_DIRECT we can't read data correctly anymore.
The exception is when we write together with the data information about
the actual size and process disregarding information from stat, for
instance.

Well, I am sure I am completely wrong because this doesn't make any
sense for me. Someone that has already dealt with this and can bring a
light to the discussion?

Thanks,

Bruno.

>=20
> Now, this *might* actually be the right thing to do ... if we allow
> 'small writes' how do we deal with larger writes once the file-write
> position is messed up?
>=20
> Heh... tricky stuff.  Though required.
>=20
>=20
>=20
>   --cw
--=20
Bruno Diniz de Paula <diniz@cs.rutgers.edu>
Rutgers University

--=-Vj25H8Ch5OdbywqelHBW
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+SuiDZGORSF4wrt8RAtQcAJ9PsNe6KNX1hN1YnztR09m4DmUFDQCdEvf+
Ye7eR23JIJTjapBy0EZbwsY=
=RGGQ
-----END PGP SIGNATURE-----

--=-Vj25H8Ch5OdbywqelHBW--

