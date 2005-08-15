Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964798AbVHOOtp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964798AbVHOOtp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 10:49:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964799AbVHOOtp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 10:49:45 -0400
Received: from mxfep01.bredband.com ([195.54.107.70]:29632 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S964798AbVHOOto (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 10:49:44 -0400
Subject: Re: [RFC] [PATCH] cache pollution aware __copy_from_user_ll()
From: Ian Kumlien <pomac@vapor.com>
Reply-To: pomac@vapor.com
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org, hch@infradead.org, lkml.hyoshiok@gmail.com
In-Reply-To: <1124090511.3228.12.camel@laptopd505.fenrus.org>
References: <1124054660.10376.15.camel@localhost>
	 <1124090511.3228.12.camel@laptopd505.fenrus.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-h1raD6snAuxXtccwqfVy"
Date: Mon, 15 Aug 2005 16:49:41 +0200
Message-Id: <1124117381.10376.33.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-h1raD6snAuxXtccwqfVy
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2005-08-15 at 09:21 +0200, Arjan van de Ven wrote:
> On Sun, 2005-08-14 at 23:24 +0200, Ian Kumlien wrote:
> > Hi, all
> >=20
> > I might be missunderstanding things but...
> >=20
> > First of all, machines with long pipelines will suffer from cache misse=
s
> > (p4 in this case).
> >=20
> > Depending on the size copied, (i don't know how large they are so..)
> > can't one run out of cachelines and/or evict more useful cache data?
>=20
> CPU caches are really big nowadays

Yes but (is copy to/from user size limited?) whats the cahes size
compared to the copy operation preformed compared to lost useful
cachelines =3D)

> > Ie, if it's cached from begining to end, we generally only need 'some
> > of' the begining, the cpu's prefetch should manage the rest.
>=20
> cpu prefetch isn't going to be fast enough. It helps some, but in the
> end the cpu prefetch also has to wait for the ram, it doesn't make the
> ram faster or free, it just takes a jumpstart on getting to it.

Yeah i know, but i was thinking more of a compromize, then it might be
better...

> > I might, as i said, not know all about things like this and i also
> > suffer from a fever but i still find Hiro's data interesting.
>=20
> It is. It's good proof that you can make a big gain already by
> converting a few key places to his excellent code. And neither me nor
> Christoph are suggesting to ditch his effort! Instead we suggest that
> what he is doing is useful for some cases and harmful for others, and
> that it is quite easy to identify those cases and separate them from
> eachother, and that thus as a result it is more optimal to have 2 apis,
> one for each of the cases.

Thats good to know, since i have wondered for a while why block io seems
so oddly slow...

I just thought that there might be some good compromize between the two
that would make it automatic.

Oh well, guess i'm back to coughing and waiting for patches to be
implemented =3D)
--=20
Ian Kumlien <pomac () vapor ! com> -- http://pomac.netswarm.net

--=-h1raD6snAuxXtccwqfVy
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1-ecc0.1.6 (GNU/Linux)

iD8DBQBDAKuF7F3Euyc51N8RAl7PAJ9aWjQDcuLo7IwgRlyw3+7SQBxyuQCeIQvn
JQdv7dUpmMSa+QzDwVExI3M=
=rgZn
-----END PGP SIGNATURE-----

--=-h1raD6snAuxXtccwqfVy--

