Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263041AbUKRWPJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263041AbUKRWPJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 17:15:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262986AbUKRWC1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 17:02:27 -0500
Received: from cimice4.lam.cz ([212.71.168.94]:3276 "EHLO vagabond.light.src")
	by vger.kernel.org with ESMTP id S262990AbUKRWAV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 17:00:21 -0500
Date: Thu, 18 Nov 2004 23:00:02 +0100
From: Jan Hudec <bulb@ucw.cz>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: hbryan@us.ibm.com, akpm@osdl.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, pavel@ucw.cz, torvalds@osdl.org
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
Message-ID: <20041118220002.GI2870@vagabond>
References: <OFFF27FA67.0439D04D-ON88256F50.006793AA-88256F50.00699D3A@us.ibm.com> <E1CUsJX-0004Q6-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="16qp2B0xu0fRvRD7"
Content-Disposition: inline
In-Reply-To: <E1CUsJX-0004Q6-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--16qp2B0xu0fRvRD7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 18, 2004 at 20:51:31 +0100, Miklos Szeredi wrote:
> > The "allocation" is a fetch or store instruction by the FUSE process,=
=20
> > which generates a page fault.  To satisfy that, the kernel has to alloc=
ate=20
> > some real memory.  A fetch or store instruction doesn't fail when there=
's=20
> > no real memory available.  It just waits for the kernel to make some=20
> > available.  The kernel does that by picking some less deserving page an=
d=20
> > evicting it.  That eviction may require a pageout.  If the guy who's do=
ing=20
> > the fetch or store is the guy who's supposed to do that pageout, you ha=
ve=20
> > a deadlock.
>=20
> OK.  I still maintaintain, that this is an impossible situation, but
> maybe I'm wrong.=20

No. It is a hard-to-see, but real situation.

> > Furthermore, it's not right for the write() to fail or for any process =
to=20
> > be killed by the OOM Killer.  The system has the resources to complete =
the=20
> > job.  It just hasn't scheduled them correctly and thus backed itself in=
to=20
> > a corner.
>=20
> Yes, but a kernel based filesystem would be in the same situation.
> It's not a problem unique to userspace filesystems.  And I think the
> kernel is careful enough not to get into the corner.  So there's no
> problem.

The kernel may also have that problem and solves it the
not-exactly-right way -- by unleashing the OOM killer. But FUSE won't
unleash the OOM killer -- it will deadlock the swapper, because the
swapper waits for the fuse process and the fuse process won't run until
the swapper cleans some pages. Because the swapper does not know, that
trying to writeout pages is futile since this request is from writeout
path. It does know in the in-kernel case.

---------------------------------------------------------------------------=
----
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--16qp2B0xu0fRvRD7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBnRthRel1vVwhjGURAgcfAJ9iz4mT3tJMvs72YokO1E/N/P3NVwCaA3VZ
Ndin2VeRiew6YJ1UG5JLM1E=
=qhJw
-----END PGP SIGNATURE-----

--16qp2B0xu0fRvRD7--
