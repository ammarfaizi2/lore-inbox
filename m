Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266876AbSKKSBr>; Mon, 11 Nov 2002 13:01:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266874AbSKKSBq>; Mon, 11 Nov 2002 13:01:46 -0500
Received: from zeus.kernel.org ([204.152.189.113]:11229 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S266876AbSKKSAb>;
	Mon, 11 Nov 2002 13:00:31 -0500
Subject: Re: [PATCH] NCR53C9x ESP: C99 designated initializers
From: Arjan van de Ven <arjanv@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "David S. Miller" <davem@redhat.com>,
       geert@linux-m68k.org, Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       dledford@redhat.com, Jens Axboe <axboe@suse.de>
In-Reply-To: <Pine.LNX.4.44.0211110915470.1805-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0211110915470.1805-100000@home.transmeta.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-uLeu0/b3ArapwEqVeLaS"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 11 Nov 2002 18:43:15 +0100
Message-Id: <1037036596.2441.3.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-uLeu0/b3ArapwEqVeLaS
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2002-11-11 at 18:24, Linus Torvalds wrote:
>=20
> On 11 Nov 2002, Alan Cox wrote:
> >=20
> > The stupid thing is we take the lock then call the eh function then dro=
p
> > it. You can drop the lock, wait and retake it. I need to fix a couple o=
f
> > other drivers to do a proper wait and in much the same way.
>=20
> Hmm.. I wonder if the thing should disable the queue (plug it) and releas=
e=20
> the lock before calling reset. I assume we don't want any new requests at=
=20
> this point anyway, and having the low-level drivers know about stopping=20
> the queue etc sounds like a bad idea..

something similar is needed in the scsi layer for other reasons too; I
can imagine something that behaves similar as the network layer's=20
netif_stop_queue() and allows drivers to inform the upper layer to stop
trying to submit requests to the lower level driver. Fiber channel
drivers can do this for example on LIP down (and enable again on LIP
up). LIP is not the only reason this is useful; overall I estimate that
over half of the code in the (out of tree) qlogic 2x00 driver can be
removed if this functionality was available.

Greetings,
   Arjan van de Ven


--=-uLeu0/b3ArapwEqVeLaS
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9z+wyxULwo51rQBIRAtUOAJwO07AEb/55GQeaD8qw2oRwvbBsbQCgkhKN
jbU+AtgUuf70jin7Fur9xG0=
=v/lt
-----END PGP SIGNATURE-----

--=-uLeu0/b3ArapwEqVeLaS--

