Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261498AbVBNR3J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261498AbVBNR3J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 12:29:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261499AbVBNR3J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 12:29:09 -0500
Received: from irulan.endorphin.org ([80.68.90.107]:30469 "EHLO
	irulan.endorphin.org") by vger.kernel.org with ESMTP
	id S261498AbVBNR26 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 12:28:58 -0500
Subject: Re: [PATCH 01/04] Adding cipher mode context information to
	crypto_tfm
From: Fruhwirth Clemens <clemens@endorphin.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: James Morris <jmorris@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, michal@logix.cz, adam@yggdrasil.com
In-Reply-To: <20050214090726.2d099d96.davem@davemloft.net>
References: <Xine.LNX.4.44.0502101247390.9159-100000@thoron.boston.redhat.com>
	 <1108387234.8086.37.camel@ghanima>
	 <20050214075655.6dec60cb.davem@davemloft.net>
	 <1108400799.23133.34.camel@ghanima>
	 <20050214090726.2d099d96.davem@davemloft.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-7nK3NhocAA8lCOth/lZv"
Date: Mon, 14 Feb 2005 18:28:55 +0100
Message-Id: <1108402135.23133.48.camel@ghanima>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-7nK3NhocAA8lCOth/lZv
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2005-02-14 at 09:07 -0800, David S. Miller wrote:
> On Mon, 14 Feb 2005 18:06:39 +0100
> Fruhwirth Clemens <clemens@endorphin.org> wrote:
>=20
> > There is nothing wrong with having special methods, that lack generalit=
y
> > but are superior in performance. There is something wrong, when there
> > are no other. And there are no other for holding three kmappings or mor=
e
> > concurrently.
>=20
> You want more resources in a context where no such thing exists,
> in interrupt processing context.  There the stack is limited, allocatable
> memory is limited, etc. etc. etc.  And all of this is because you cannot
> sleep in interrupt context.

I have said nothing about sleeping in interrupt or softirq context.

First, one has to make kmap fallible. Second, ensure that it does not
fail often. This can be done by creating a page table pool, where kmap
can allocate page tables from, when all of the remaining page tables are
full. The mempool is of course refilled at the next occasion.

For stuff, that cannot be allowed to fail, kmap_atomic is still there.
--=20
Fruhwirth Clemens <clemens@endorphin.org>  http://clemens.endorphin.org

--=-7nK3NhocAA8lCOth/lZv
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCEN/XbjN8iSMYtrsRAlFcAJ95zvM/FaRHrdZy4KHVmnOCeE54wwCeJBqs
6vY+6Mp05gopBfEPM0xffJE=
=b4Xd
-----END PGP SIGNATURE-----

--=-7nK3NhocAA8lCOth/lZv--
