Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263964AbTFKCFv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 22:05:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263983AbTFKCFv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 22:05:51 -0400
Received: from [61.95.53.28] ([61.95.53.28]:7434 "EHLO dreamcraft.com.au")
	by vger.kernel.org with ESMTP id S263964AbTFKCFu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 22:05:50 -0400
Date: Wed, 11 Jun 2003 12:19:26 +1000
From: Simon Fowler <simon@himi.org>
To: Andrew Morton <akpm@digeo.com>
Cc: jsimmons@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: 2.5.70-bk radeonfb oops on boot.
Message-ID: <20030611021926.GA2241@himi.org>
Mail-Followup-To: Andrew Morton <akpm@digeo.com>,
	jsimmons@infradead.org, linux-kernel@vger.kernel.org
References: <20030610061654.GB25390@himi.org> <20030610130204.GC27768@himi.org> <20030610141440.26fad221.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="T4sUOijqQbZv57TR"
Content-Disposition: inline
In-Reply-To: <20030610141440.26fad221.akpm@digeo.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 10, 2003 at 02:14:40PM -0700, Andrew Morton wrote:
> Simon Fowler <simon@himi.org> wrote:
> >
> > On Tue, Jun 10, 2003 at 04:16:54PM +1000, Simon Fowler wrote:
> > > I've started seeing a hard lockup on boot with my Fujitsu Lifebook
> > > p2120 laptop, with a radeon mobility M6 LY, when using a Linus bk
> > > kernel as of 2003-06-09 (possibly earlier - the last kernel I've
> > > tested is bk as of 2003-06-04). lspci lists this hardware:
> > >=20
> > I've narrowed the start of the problem down: 2.5.70-bk13 works,
> > -bk14 oopses.=20
>=20
> That's funny.  bk13->bk14 was almost all arm stuff.  diffstat below.
>=20
> It might be worth reverting this chunk, see if that fixes it:
>=20
> --- b/drivers/char/mem.c        Thu Jun  5 23:36:40 2003
> +++ b/drivers/char/mem.c        Sun Jun  8 05:02:24 2003
> @@ -716 +716 @@
> -__initcall(chr_dev_init);
> +subsys_initcall(chr_dev_init);
>=20
And we have a winner . . . Reverting this hunk fixes the oops.

Simon

--=20
PGP public key Id 0x144A991C, or http://himi.org/stuff/himi.asc
(crappy) Homepage: http://himi.org
doe #237 (see http://www.lemuria.org/DeCSS)=20
My DeCSS mirror: ftp://himi.org/pub/mirrors/css/=20

--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+5pGuQPlfmRRKmRwRApK6AKCmVDRjViOREYLW4fW7LYL/4r2JnQCcCb47
RT3FIV2JaIPQZD2QCKhhxss=
=fCss
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--
