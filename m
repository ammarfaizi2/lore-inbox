Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265249AbRG2AEU>; Sat, 28 Jul 2001 20:04:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265277AbRG2AEK>; Sat, 28 Jul 2001 20:04:10 -0400
Received: from schiele.swm.uni-mannheim.de ([134.155.20.124]:53384 "EHLO
	schiele.swm.uni-mannheim.de") by vger.kernel.org with ESMTP
	id <S265249AbRG2ADy>; Sat, 28 Jul 2001 20:03:54 -0400
Date: Sun, 29 Jul 2001 02:03:44 +0200
From: Robert Schiele <rschiele@uni-mannheim.de>
To: Philip Blundell <philb@gnu.org>
Cc: Steven Cole <elenstev@mesatop.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: 2.4.8-pre1 build error in drivers/parport/parport_pc.c
Message-ID: <20010729020344.A9303@schiele.swm.uni-mannheim.de>
In-Reply-To: <01072619531103.06728@localhost.localdomain> <20010727101241.A15014@schiele.swm.uni-mannheim.de> <rschiele@uni-mannheim.de> <E15QX7a-0000gl-00@kings-cross.london.uk.eu.org> <20010728222943.A24586@schiele.swm.uni-mannheim.de> <rschiele@uni-mannheim.de> <E15QbIJ-0001kG-00@kings-cross.london.uk.eu.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="wRRV7LY7NUeQGEoC"
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <E15QbIJ-0001kG-00@kings-cross.london.uk.eu.org>; from philb@gnu.org on Sat, Jul 28, 2001 at 10:06:43PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 28, 2001 at 10:06:43PM +0100, Philip Blundell wrote:
> >The "extern" was only an escape for the case that the compiler cannot
> >inline the function. Due to the fact, that current gcc has "static
> >inline" it is better to use this, because with "static inline" we do
> >not need to keep a global symbol just for the case the compiler is not
> >capable to inline the function in some place.
>=20
> The versions in the .c file are there so that the "ops" structure can poi=
nt to=20
> them.  The ones in the .h file are purely an optimisation to allow you to=
=20
> short-circuit the ops struct if you know only one driver is involved.

Because of that the compiler has to create a "real" function from the
code anyway. The way this is handled by gcc is stated in the gcc info
pages:

   "When a function is both inline and `static', if all calls to the
    function are integrated into the caller, and the function's
    address is never used, then the function's own assembler code is
    never referenced.  In this case, GNU CC does not actually output
    assembler code for the function, unless you specify the option
    `-fkeep-inline-functions'.  Some calls cannot be integrated for
    various reasons (in particular, calls that precede the function's
    definition cannot be integrated, and neither can recursive calls
    within the definition).  If there is a nonintegrated call, then
    the function is compiled to assembler code as usual.  The function
    must also be compiled as usual if the program refers to its
    address, because that can't be inlined."

>=20
> Changing this stuff to "static inline" still offends my sense of aestheti=
cs=20
> somewhat, but I guess it's okay if you have checked that it still does th=
e=20
> right thing in the CONFIG_PARPORT_OTHER case.

I didn't test this before your mail. But to be absolutely sure, I
tested it now. --- And it works perfectly.

Robert

--=20
Robert Schiele			mailto:rschiele@uni-mannheim.de
Tel./Fax: +49-621-10059		http://webrum.uni-mannheim.de/math/rschiele/

--wRRV7LY7NUeQGEoC
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iQEVAwUBO2NS38QAnns5HcHpAQEZqwf7BoLS24W1wfLUGR5LEnUvq1X7e0KTVzrD
bYZML/s5N6E9fVWYGV+6UaBo2XyfHlMXiRAvdvOwtxvj5qTs3IYjUZ9bKWW320ab
ctSS/snsvb9M2YB0oqCZyxc0SNOjeWXmxL/bF2D6yQZiWUQR41/8vBgSwKVEVqtb
sK+SpF8ojf2FC5Rdb+kMSJQ2wSG7SPRQ+EUZzTAldDLxM4d8vpnv9TiAiq5Ucn1+
5S3kb9GWHR/4qNFQOh862Tw5ORJMvloQLxe5TQN49UFKhhX1AKrNzlKUYn9WycSW
xLGdXl06GXmRvHe/tHRt88N1G1TrsTKMmXV5ighE8Kodpk2B6RIAWw==
=4kCf
-----END PGP SIGNATURE-----

--wRRV7LY7NUeQGEoC--
