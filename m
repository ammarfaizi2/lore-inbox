Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261509AbVAXNyH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261509AbVAXNyH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 08:54:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261510AbVAXNyG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 08:54:06 -0500
Received: from dea.vocord.ru ([217.67.177.50]:6551 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S261509AbVAXNxl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 08:53:41 -0500
Subject: Re: [-mm patch] fix SuperIO compilation
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: Christoph Hellwig <hch@infradead.org>
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       Greg Kroah-Hartman <greg@kroah.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1106571899.25992.21.camel@uganda>
References: <20050124021516.5d1ee686.akpm@osdl.org>
	 <20050124122541.GG3515@stusta.de>  <20050124123448.GA29631@infradead.org>
	 <1106571899.25992.21.camel@uganda>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Uou5Xs+uGryBjt/nHZ7n"
Organization: MIPT
Date: Mon, 24 Jan 2005 16:56:11 +0300
Message-Id: <1106574971.25992.27.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Mon, 24 Jan 2005 13:50:14 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Uou5Xs+uGryBjt/nHZ7n
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2005-01-24 at 16:04 +0300, Evgeniy Polyakov wrote:
> On Mon, 2005-01-24 at 12:34 +0000, Christoph Hellwig wrote:
> > On Mon, Jan 24, 2005 at 01:25:41PM +0100, Adrian Bunk wrote:
> > > On Mon, Jan 24, 2005 at 02:15:16AM -0800, Andrew Morton wrote:
> > > >...
> > > > Changes since 2.6.11-rc1-mm2:
> > > >...
> > > >  bk-i2c.patch
> > > >...
> > > >  Latest versions of various bk trees
> > > >...
> > >=20
> > > This causes the following compile error:
> >=20
> > Where's that code coming from anyone?  Greg seems to be adding tons of =
not fully
> > reviewed stuff lately..
>=20
> That code was written by me.
> Please provide full error output, since it is compiled successfully
> here.
>=20
> Thank you.

Ok, I found following in the archive:
******************************************
On Mon, Jan 24, 2005 at 02:15:16AM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.11-rc1-mm2:
>...
>  bk-i2c.patch
>...
>  Latest versions of various bk trees
>...

This causes the following compile error:

<--  snip  -->

...
  LD      drivers/superio/built-in.o
drivers/superio/sc_acb.o(.text+0x0): In function `sc_write_reg':
: multiple definition of `sc_write_reg'
drivers/superio/sc_gpio.o(.text+0x0): first defined here
drivers/superio/sc_acb.o(.text+0x30): In function `sc_read_reg':
: multiple definition of `sc_read_reg'
drivers/superio/sc_gpio.o(.text+0x30): first defined here
make[2]: *** [drivers/superio/built-in.o] Error 1

<--  snip  -->

The trivial fix for these needlessly global functions is below.

BTW1: pin_test.c is added but completely unused.
BTW2: bk-i2c adds a whole bunch of unused SuperIO EXPORT_SYMBOL's.
      Is usage for them expected very soon or shall I send a patch to=20
      remove them?


<--  snip  -->


This patch makes needlessly global functions static fixing a compile=20
error if both sc_acb.c and sc_gpio.c are compiled statically into the=20
kernel.

*********************************

It is not Greg, but completely my fault and I agree with your changes.
pin_test.c was added as example of how to use SuperIO subsystem,=20
it is not supposed to be compiled, it is an example, probably it should=20
live in Documentation/superio/example.c

Tahnk you for review.

--=20
        Evgeniy Polyakov

Crash is better than data corruption -- Arthur Grabowski

--=-Uou5Xs+uGryBjt/nHZ7n
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBB9P57IKTPhE+8wY0RAhppAJ41glZ++w7V1f30BDtmi7g1pVc96QCaA86t
xs0cTdGf7ApCO2U2DgdAN0A=
=bvxr
-----END PGP SIGNATURE-----

--=-Uou5Xs+uGryBjt/nHZ7n--

