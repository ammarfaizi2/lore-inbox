Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263595AbVBCQcG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263595AbVBCQcG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 11:32:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262278AbVBCQcF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 11:32:05 -0500
Received: from svana.org ([203.20.62.76]:57356 "EHLO svana.org")
	by vger.kernel.org with ESMTP id S263351AbVBCQbd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 11:31:33 -0500
Date: Thu, 3 Feb 2005 17:31:15 +0100
From: Martijn van Oosterhout <kleptog@svana.org>
To: Pankaj Agarwal <pankaj@toughguy.net>
Cc: S Iremonger <exxsi@bath.ac.uk>, linux-os@analogic.com,
       linux-kernel@vger.kernel.org, Linux Net <linux-net@vger.kernel.org>
Subject: Re: Query - Regarding strange behaviour.
Message-ID: <20050203163110.GE16100@svana.org>
Reply-To: Martijn van Oosterhout <kleptog@svana.org>
References: <001501c509ff$d4be02e0$8d00150a@dreammac> <Pine.LNX.4.61.0502031017430.9404@chaos.analogic.com> <015901c50a07$721f2620$8d00150a@dreammac> <Pine.GSO.4.53.0502031602400.21155@amos.bath.ac.uk> <019501c50a0b$fcf8a9c0$8d00150a@dreammac>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="a2FkP9tdjPU2nyhF"
Content-Disposition: inline
In-Reply-To: <019501c50a0b$fcf8a9c0$8d00150a@dreammac>
User-Agent: Mutt/1.3.28i
X-PGP-Key-ID: Length=1024; ID=0x0DC67BE6
X-PGP-Key-Fingerprint: 295F A899 A81A 156D B522  48A7 6394 F08A 0DC6 7BE6
X-PGP-Key-URL: <http://svana.org/kleptog/0DC67BE6.pgp.asc>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--a2FkP9tdjPU2nyhF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 03, 2005 at 09:48:12PM +0530, Pankaj Agarwal wrote:
> [root@test usr]# lsattr -d /usr/bin
> su--ia------- /usr/bin

Well, there's your problem. These mean:

s: when deleted, its blocks are zeroed and written back to the disk
u: when deleted, its contents are saved.=20
i: cannot be modified: it cannot be deleted or renamed,
a: can only be open in append mode for writing

Remove those flags with chattr...

Hope this helps,

>=20
> ----- Original Message -----=20
> From: "S Iremonger" <exxsi@bath.ac.uk>
> To: "Pankaj Agarwal" <pankaj@toughguy.net>
> Cc: <linux-os@analogic.com>; <linux-kernel@vger.kernel.org>; "Linux Net"=
=20
> <linux-net@vger.kernel.org>
> Sent: Thursday, February 03, 2005 9:37 PM
> Subject: Re: Query - Regarding strange behaviour.
>=20
>=20
> >>its not even allowing me to copy it ...then surely it wont allow me mv =
as
> >>well... what else can i try...
> >>[root@test root]# mount
> >>/dev/hda2 on / type ext3 (rw)
> >>[root@test /]# cd /usr
> >>[root@test usr]# cp bin testbin
> >>cp: omitting directory `bin'
> >
> >"cp" does not normally copy direcrories as such by DEFAULT.
> >
> >Use the "-R" flag on "cp" to make it 'recurse' and copy the whole
> > directory and directory/files under it.
> >
> >e.g. "cp -R bin bincopy"
> >
> >
> >And, show us all the results of the following 2 commands, please.
> >
> >ls -ld /usr/bin
> >lsattr -d /usr/bin
> >
> >--S Iremonger <exxsi@bath.ac.uk>
> >
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-net" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Martijn van Oosterhout   <kleptog@svana.org>   http://svana.org/kleptog/
> Patent. n. Genius is 5% inspiration and 95% perspiration. A patent is a
> tool for doing 5% of the work and then sitting around waiting for someone
> else to do the other 95% so you can sue them.

--a2FkP9tdjPU2nyhF
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQFCAlHOY5Twig3Ge+YRAgBbAKCH95rEWSv9Q+fN6cqaGS7b9HnjewCg0gUK
GOh5FFQVAYCJihl3Vnp3aWg=
=L7rA
-----END PGP SIGNATURE-----

--a2FkP9tdjPU2nyhF--
