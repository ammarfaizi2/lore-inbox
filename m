Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263863AbRFSGGS>; Tue, 19 Jun 2001 02:06:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263866AbRFSGF6>; Tue, 19 Jun 2001 02:05:58 -0400
Received: from con-64-133-52-190-ria.sprinthome.com ([64.133.52.190]:15117
	"EHLO ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id <S263863AbRFSGFt>; Tue, 19 Jun 2001 02:05:49 -0400
Date: Mon, 18 Jun 2001 23:05:37 -0700
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Andreas Dilger <adilger@turbolinux.com>
Cc: Kernel Developer List <linux-kernel@vger.kernel.org>
Subject: Re: Simple example of using slab allocator?
Message-ID: <20010618230537.B28162@one-eyed-alien.net>
Mail-Followup-To: Andreas Dilger <adilger@turbolinux.com>,
	Kernel Developer List <linux-kernel@vger.kernel.org>
In-Reply-To: <20010615151901.G28394@one-eyed-alien.net> <200106181656.f5IGuamN013348@webber.adilger.int>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="A6N2fC+uXW/VQSAv"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200106181656.f5IGuamN013348@webber.adilger.int>; from adilger@turbolinux.com on Mon, Jun 18, 2001 at 10:56:36AM -0600
Organization: One Eyed Alien Networks
X-Copyright: (C) 2001 Matthew Dharm, all rights reserved.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--A6N2fC+uXW/VQSAv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Well, if it's really that simple....

Another aspect of this, tho, is that I'd like to be able to profile my
memory usage.  Does the SA have any ability to report (easily) the number
of pages allocated and how full each one is?

Matt Dharm

On Mon, Jun 18, 2001 at 10:56:36AM -0600, Andreas Dilger wrote:
> Matthew Dharm writes:
> > For 2.5, I'm planning on switching my driver over to the slab allocator,
> > for a variety of reasons.  Does anyone have a _dead_ simple example of =
how
> > to use such a beast?  I've seen the various web pages and document
> > explaining the API, but I love to see working examples for reference (a=
nd
> > to fill in the blanks).
>=20
> The slab allocator IS dead simple to use, basically:
>=20
> - driver global variable:
>=20
> kmem_cache_t *usb_mass_cachep;
> =09
> - in the driver init function:
>=20
> 	usb_mass_cachep =3D kmem_cache_create("usb_mass_cache",
> 					    sizeof(struct whatever),
> 					    0, SLAB_HWCACHE_ALIGN,
> 					    NULL, NULL);
> 	(check for NULL usb_mass_slab)
>=20
> - in the driver cleanup function:
>=20
> 	if (usb_mass_cachep && kmem_cache_destroy(usb_mass_cachep))
> 		printk(KERN_ERR "usb_mass_cache: not all structures freed\n");
>=20
> - wherever you need an item from the slab cache:
>=20
> 	whateverp =3D kmem_cache_alloc(usb_mass_cachep, GFP_KERNEL);
> 	(check for NULL whateverp)
>=20
> - when you are done with it:
>=20
> 	kmem_cache_free(usb_mass_cachep, whateverp);
>=20
> Notes:
> - if you have a slab leak and you don't free all of the items (hence the =
slab
>   cache is not removed), you will probably get an oops when you reload the
>   driver.  You can only have one slab cache per name ("usb_mass_cache" he=
re).
> - You may need different alignment (SLAB_HWCACHE_ALIGN), or not
> - You may need different allocation policy (GFP_KERNEL), or not
>=20
> Cheers, Andreas
> --=20
> Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
>                  \  would they cancel out, leaving him still hungry?"
> http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

God, root, what is difference?
					-- Pitr
User Friendly, 11/11/1999

--A6N2fC+uXW/VQSAv
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7Luuxz64nssGU+ykRAnF7AKC3dC+dPgF475E5yZymVLBcvlHTzgCfc3jf
MOfFg+TEz0AHaKKVblbemAM=
=83IH
-----END PGP SIGNATURE-----

--A6N2fC+uXW/VQSAv--
