Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272536AbTHKNLM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 09:11:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272540AbTHKNLM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 09:11:12 -0400
Received: from chello080108023209.34.11.vie.surfer.at ([80.108.23.209]:36993
	"HELO ghanima.endorphin.org") by vger.kernel.org with SMTP
	id S272536AbTHKNLF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 09:11:05 -0400
Date: Mon, 11 Aug 2003 15:11:05 +0200
To: Christophe Saout <christophe@saout.de>
Cc: Pascal Brisset <pascal.brisset-ml@wanadoo.fr>,
       linux-kernel@vger.kernel.org, mbligh@aracnet.com, kernel@gozer.org,
       axboe@suse.de
Subject: Re: [PATCH] loop: fixing cryptoloop troubles.
Message-ID: <20030811131105.GA2040@ghanima.endorphin.org>
References: <20030810023606.GA15356@ghanima.endorphin.org> <20030810140912.6F7224007E9@mwinf0301.wanadoo.fr> <1060525667.14835.4.camel@chtephan.cs.pocnet.net> <20030810210306.GA2235@ghanima.endorphin.org> <1060553236.25524.49.camel@chtephan.cs.pocnet.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
Content-Disposition: inline
In-Reply-To: <1060553236.25524.49.camel@chtephan.cs.pocnet.net>
User-Agent: Mutt/1.3.28i
From: Fruhwirth Clemens <clemens@endorphin.org>
X-Delivery-Agent: TMDA/0.51 (Python 2.1.3 on Linux/i686)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2003 at 12:07:16AM +0200, Christophe Saout wrote:

> The main problem with CBC is that you can't really do it. It only works
> when you have a constant stream of data because you always need the
> result from the previous encryption which you don't have when doing
> something in the middle of the block device.

That's partially correct. As most block cipher operate on blocks of 16 bytes
size it perfectly makes sence to use CBC on a 512 byte block.=20

> Warning: A long analysis of obvious things is following. I think most of
> you know everything I'm writing here, I'm just looking through the code
> myself and trying to explain what's happening. On the end I'll find the
> bug you fixed. I think that was the only bug regarding IV handling.

*knockonwood* :)

> The cryptoloop code is doing things correctly. In ecb mode, every bio
> could get converted at once, or every bvec.=20

ECB mode is broken in 2.6.0-test[12]. See=20

http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D106043148921893&w=3D2

It's a quite conservative patch. ECB processing can be optimized.

> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D analysis end =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D ;)

Thanks :)

> Yes, I think putting this into loop.c adds unnecessary complexity.
> Especially the IV handling is ugly. Sometimes the IV is calculated in
> loop.c (three times) and sometimes it gets incremented in cryptoloop.c.
> Wow. Error prone and ugly.

Definitly. loop.c is anyway ugly :). It would be nice to rip out the
block-backend stuff of loop.c and recommend to use device mapper instead.
loop.c will benefit from that for sure since it doesn't have to handle two
different case in such a schizophrenic manner.

> And you can still use dm over loop device if you want to encrypt a file.

I like that idea.=20

> > If you can't get attention for your patch, try to convince someone "more
> > important". DM maintainer is a good place to start :)
>=20
> Yes, the DM maintainer helped me write the patch and would like to see
> it merged. Convincing some more important persons would be easier if I
> would get any reaction from them. ;)

I'll give it a try, promised :)

Regards, Clemens

--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE/N5XoW7sr9DEJLk4RAqMPAJ9otz9AfGz4K5Nah2xTvUYEaHAA+QCeMf0N
W4rUNIzcMaMFwLmYxkYbOiM=
=syHE
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--
