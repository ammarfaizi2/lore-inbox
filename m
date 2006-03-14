Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751074AbWCNPAW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751074AbWCNPAW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 10:00:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751147AbWCNPAV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 10:00:21 -0500
Received: from mivlgu.ru ([81.18.140.87]:23706 "EHLO master.mivlgu.local")
	by vger.kernel.org with ESMTP id S1751074AbWCNPAU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 10:00:20 -0500
Date: Tue, 14 Mar 2006 18:00:17 +0300
From: Sergey Vlasov <vsu@altlinux.ru>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: Bill Nottingham <notting@redhat.com>, Kay Sievers <kay.sievers@vrfy.org>,
       Andrew Morton <akpm@osdl.org>, ambx1@neo.rr.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [PNP] 'modalias' sysfs export
Message-ID: <20060314150017.GQ2873@master.mivlgu.local>
References: <44082E14.5010201@drzeus.cx> <4412F53B.5010309@drzeus.cx> <20060311173847.23838981.akpm@osdl.org> <4414033F.2000205@drzeus.cx> <20060312172332.GA10278@vrfy.org> <20060313165719.GB4147@devserv.devel.redhat.com> <20060313192411.GA23380@vrfy.org> <20060313222644.GD1311@devserv.devel.redhat.com> <20060314152944.797390cd.vsu@altlinux.ru> <4416BB73.5070801@drzeus.cx>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YPYi+6JBnn8IjLOH"
Content-Disposition: inline
In-Reply-To: <4416BB73.5070801@drzeus.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--YPYi+6JBnn8IjLOH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 14, 2006 at 01:47:47PM +0100, Pierre Ossman wrote:
> Sergey Vlasov wrote:
> > BTW, we can change the alias format for PNP device drivers to
> >
> > 	pnp:*dXXXYYYY*
> >
> > (note the additional "*" before the device ID).  This would allow us to
> > have a single-value "modalias" attribute for PNP logical devices too -
> > it would have the form
> >
> > 	pnp:dXXXYYYYdXXXYYYYdXXXYYYY
> >
> > (listing all IDs, in this case sorting is not required, because each
> > driver will match at most only a single dXXXYYYY entry).
> >  =20
>=20
> How do you guarantee that the modules are tried in the correct order? Is
> it well defined in modprobe that pnp:*dABC0001* would match before
> pnp:*dXYZ0001* if the modalias is pnp:dABC0001dXYZ0001 ?

No, the order is undefined.  However, defining it will not really help -
what if there is another similar device in the system, which is discovered
earlier and brings in the generic driver before the second device is
considered?  In this case defining the module load order buys you nothing.
Currently the only reliable solution to prevent a generic driver from
driving a device which has a more specific driver is to blacklist the
problematic device in the generic driver (e.g., usbhid has lots of
blacklist entries because vendors like to abuse the HID class).

--YPYi+6JBnn8IjLOH
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFEFtqBW82GfkQfsqIRAmqSAJwMkabIfer9j3RTTbgjx58RkpqILQCdG/aO
YMedHN/RADYU+X09/lEZ/Ac=
=etbb
-----END PGP SIGNATURE-----

--YPYi+6JBnn8IjLOH--
