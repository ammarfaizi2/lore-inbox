Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282999AbRLGRGz>; Fri, 7 Dec 2001 12:06:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282998AbRLGRGu>; Fri, 7 Dec 2001 12:06:50 -0500
Received: from etpmod.phys.tue.nl ([131.155.111.35]:55130 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S282916AbRLGRG3>; Fri, 7 Dec 2001 12:06:29 -0500
Date: Fri, 7 Dec 2001 18:02:14 +0100
From: Kurt Garloff <garloff@suse.de>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Linux kernel list <linux-kernel@vger.kernel.org>,
        linux-alpha@vger.kernel.org, Jay Estabrook <Jay.Estabrook@compaq.com>
Subject: Re: IDE DMA on AXP & barriers
Message-ID: <20011207180214.D14011@garloff.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Linux kernel list <linux-kernel@vger.kernel.org>,
	linux-alpha@vger.kernel.org,
	Jay Estabrook <Jay.Estabrook@compaq.com>
In-Reply-To: <20011206061315.J13427@garloff.etpnet.phys.tue.nl> <20011206125935.A3930@jurassic.park.msu.ru> <20011207132505.B4229@garloff.etpnet.phys.tue.nl> <20011207170341.A9959@jurassic.park.msu.ru> <20011207154815.A14011@garloff.etpnet.phys.tue.nl> <20011207194347.A2718@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gdTfX7fkYsEEjebm"
Content-Disposition: inline
In-Reply-To: <20011207194347.A2718@jurassic.park.msu.ru>
User-Agent: Mutt/1.3.22.1i
X-Operating-System: Linux 2.4.16 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TU/e(NL), SuSE(DE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gdTfX7fkYsEEjebm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ivan, Jay,

[stripped the distributor's lists from Cc: again; I just wanted the patch to
 reach lots of people that can potentially test.]

On Fri, Dec 07, 2001 at 07:43:47PM +0300, Ivan Kokshaysky wrote:
> On Fri, Dec 07, 2001 at 03:48:15PM +0100, Kurt Garloff wrote:
> > Hey, where did you find that manual? I could not find one at Compaq's w=
eb
> > site.
>=20
> IIRC, few years ago someone posted a link on axp-list, and I picked it up.
> Anyway, I've placed it on
> ftp://ftp.park.msu.ru/ink/docs/21174_SI.pdf

Got it, thanks!

> > How do I recognize the broken PYXIS in software? (Except for waiting for
> > your hard disk to be corrupted?)
>=20
> Put the chip into PCI loopback mode, read some memory (crossing the
> page boundary) via direct PCI window and check for corruption -
> perhaps this will work.

I guess the manual will tell me how to do that ...

> > Or should I just put an #ifdef CONFIG_ALPHA_PYXIS in my patch?
> > What about the users of generic alpha kernels?
>=20
> #ifdef CONFIG_ALPHA_PYXIS won't work for them.

That's why I'm looking for something better ...
But on a generic kernel, we have to do a number of things, then:
* Detect PYXIS
* Set into PCI loopback
* Do the cross 8k DMA read
* Set flag if corruption

(And even this test is not completely perfect, as only devices on the
 primary PCI bus seem to be affected.)

> > Or a config option?
>=20
> Maybe...

Runtime detection is better of course. Think of distributors ...

On the other hand, the workaround does not hurt performance as far as I cou=
ld
measure. For reading data from disk (i.e. DMAing to memory), the patch does
not do anything. For writing to disk, I make 16 or 17 PDR segments from 4,
but bonnie would not tell me any difference in performance.
So doing it on every PYXIS would also be an option.=20

> Jay, your opinion? Perhaps you have the info which systems are affected?

=2E.. and how they can be identified.

Thanks,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE GmbH, Nuernberg, DE                                SCSI, Security

--gdTfX7fkYsEEjebm
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8EPYWxmLh6hyYd04RAtoVAJ461gZ9IoXaNAajv1MVnmX+UZ0N3gCgoAzR
0RBhL63uip2utHwmjoWTapk=
=Lx4T
-----END PGP SIGNATURE-----

--gdTfX7fkYsEEjebm--
