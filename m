Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932142AbVLFMmZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932142AbVLFMmZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 07:42:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932150AbVLFMmZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 07:42:25 -0500
Received: from perninha.conectiva.com.br ([200.140.247.100]:16311 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S932142AbVLFMmZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 07:42:25 -0500
Date: Tue, 6 Dec 2005 10:46:22 -0200
From: Eduardo Pereira Habkost <ehabkost@mandriva.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>, gregkh@suse.de,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       Oliver Neukum <oliver@neukum.org>
Subject: Re: [PATCH 01/10] usb-serial: URB write locking macros.
Message-ID: <20051206124621.GK13801@duckman.conectiva>
References: <20051206095722.45cf4a32.lcapitulino@mandriva.com.br> <1133871843.4836.15.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1E1Oui4vdubnXi3o"
Content-Disposition: inline
In-Reply-To: <1133871843.4836.15.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1E1Oui4vdubnXi3o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 06, 2005 at 01:24:03PM +0100, Arjan van de Ven wrote:
> On Tue, 2005-12-06 at 09:57 -0200, Luiz Fernando Capitulino wrote:
> >  Introduces URB write locking macros.
>=20
> ugh.. WHY ?

Maybe we need a better description for the patch: the locking is already
there (the 'lock' field in struct sub_serial_port), and there is no
change of behaviour, just replacing a (spin_lock_t, int) by an atomic_t.

The purpose of the changes is removing the spinlock, because it is used
only to protect write_urb_busy, and if someday we need locking on other
parts, we already have a semaphore (introduced by Capitulino some time
ago, to fix a open()/close() race condition).

--=20
Eduardo

--1E1Oui4vdubnXi3o
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDlYgdcaRJ66w1lWgRAqWVAJ9cRq1ZuWFHUkv59oBfaujrxsDKmwCfcvdo
SUerW82mDkjlXS4fyOxHGsM=
=juOX
-----END PGP SIGNATURE-----

--1E1Oui4vdubnXi3o--
