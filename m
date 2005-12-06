Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932625AbVLFUJo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932625AbVLFUJo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 15:09:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932629AbVLFUJo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 15:09:44 -0500
Received: from perninha.conectiva.com.br ([200.140.247.100]:65200 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S932625AbVLFUJn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 15:09:43 -0500
Date: Tue, 6 Dec 2005 18:13:40 -0200
From: Eduardo Pereira Habkost <ehabkost@mandriva.com>
To: Greg KH <gregkh@suse.de>
Cc: Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: [PATCH 00/10] usb-serial: Switches from spin lock to atomic_t.
Message-ID: <20051206201340.GB20451@duckman.conectiva>
References: <20051206095610.29def5e7.lcapitulino@mandriva.com.br> <20051206194041.GA22890@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="f2QGlHpHGjS2mn6Y"
Content-Disposition: inline
In-Reply-To: <20051206194041.GA22890@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--f2QGlHpHGjS2mn6Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 06, 2005 at 11:40:41AM -0800, Greg KH wrote:
> On Tue, Dec 06, 2005 at 09:56:10AM -0200, Luiz Fernando Capitulino wrote:
> >  Greg,
> >=20
> >  Don't get scared. :-)
> >=20
> >  As showed by Eduardo Habkost some days ago, the spin lock 'lock' in the
> > struct 'usb_serial_port' is being used by some USB serial drivers to pr=
otect
> > the access to the 'write_urb_busy' member of the same struct.
> >=20
> >  The spin lock however, is needless: we can change 'write_urb_busy' type
> > to be atomic_t and remove all the spin lock usage.
>=20
> But if you do that, you make things slower on non-smp machines, which
> isn't very nice.  Why does the spinlock bother you?
>=20

We thought that an atomic_t was better when you suggested that we could
drop the spinlock after we added a semaphore to struct usb_serial_port
recently. Won't we drop the spinlock as suggested?

Anyway, I don't see yet why the atomic_t would make the code slower on
non-smp. Is atomic_add_unless(v, 1, 1) supposed to be slower than
'if (!v) v =3D 1;' ?

If it is really slower, is atomic_cmpxchg() supposed to be slower, too?

("Check it yourself" is a valid answer, too  :)   But maybe someone
could elighten me and I could save some time testing and checking the
generated code)

--=20
Eduardo

--f2QGlHpHGjS2mn6Y
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDlfD0caRJ66w1lWgRAmSjAKCis70EP3/OXjxXBMEc952utgthSQCfe61x
pIK5xiGTZhwruV4wBaoe6Hw=
=fL5Y
-----END PGP SIGNATURE-----

--f2QGlHpHGjS2mn6Y--
