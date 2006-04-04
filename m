Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751821AbWDDG1o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751821AbWDDG1o (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 02:27:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751820AbWDDG1o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 02:27:44 -0400
Received: from ozlabs.org ([203.10.76.45]:43939 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751818AbWDDG1n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 02:27:43 -0400
Subject: Re: [Fastboot] Re: [PATCH] kexec on ia64
From: Michael Ellerman <michael@ellerman.id.au>
Reply-To: michael@ellerman.id.au
To: Andrew Morton <akpm@osdl.org>
Cc: Khalid Aziz <khalid_aziz@hp.com>, linux-ia64@vger.kernel.org,
       fastboot@lists.osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060403212049.480ad388.akpm@osdl.org>
References: <1144102818.8279.6.camel@localhost.localdomain>
	 <20060403212049.480ad388.akpm@osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-mUP8jHBGvwM4iAqIVSJ1"
Date: Tue, 04 Apr 2006 08:07:58 +0200
Message-Id: <1144130879.29756.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-mUP8jHBGvwM4iAqIVSJ1
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2006-04-03 at 21:20 -0700, Andrew Morton wrote:
> Khalid Aziz <khalid_aziz@hp.com> wrote:
> > +/*
> > + * Terminate any outstanding interrupts
> > + */
> > +void terminate_irqs(void)
> > +{
> > +	struct irqaction * action;
> > +	irq_desc_t *idesc;
> > +	int i;
> > +
> > +	for (i=3D0; i<NR_IRQS; i++) {
>=20
> 	for (i =3D 0; i < NR_IRQS; i++) {
>=20
> > +		idesc =3D irq_descp(i);
> > +		action =3D idesc->action;
> > +		if (!action)
> > +			continue;
> > +		if (idesc->handler->end)
> > +			idesc->handler->end(i);
> > +	}
> > +}
>=20
> Could we have a bit more description of what this function does, and why =
we
> need it?
>=20
> Should other kexec-using architectures be using this?  If not, why does
> ia64 need it?

We've been kicking around a patch to do something similar, we also eoi
anything that's outstanding. I can't find the patch just now, but it's
on linuxppc somewhere I think.

cheers

--=20
Michael Ellerman
IBM OzLabs

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-mUP8jHBGvwM4iAqIVSJ1
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBEMg0+dSjSd0sB4dIRAgIBAJ94wIIGbAjYSxFFw3lLB67gq/4BBgCfZHk6
6yDkgrajRYWfS5wbEXIy1rE=
=Ykix
-----END PGP SIGNATURE-----

--=-mUP8jHBGvwM4iAqIVSJ1--

