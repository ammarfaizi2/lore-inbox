Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268815AbUHLVYI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268815AbUHLVYI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 17:24:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268804AbUHLVUu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 17:20:50 -0400
Received: from alhambra.mulix.org ([192.117.103.203]:21123 "EHLO
	granada.merseine.nu") by vger.kernel.org with ESMTP id S268576AbUHLVRt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 17:17:49 -0400
Date: Fri, 13 Aug 2004 00:18:41 +0300
From: Muli Ben-Yehuda <mulix@mulix.org>
To: Jeff Moyer <jmoyer@redhat.com>
Cc: Matt Mackall <mpm@selenic.com>, linux-kernel@vger.kernel.org,
       Stelian Pop <stelian@popies.net>, jgarzik@pobox.com
Subject: Re: [patch] fix netconsole hang with alt-sysrq-t
Message-ID: <20040812211841.GB17907@granada.merseine.nu>
References: <16659.56343.686372.724218@segfault.boston.redhat.com> <20040806195237.GC16310@waste.org> <16659.58271.979999.616045@segfault.boston.redhat.com> <20040806202649.GE16310@waste.org> <16667.55966.317888.504243@segfault.boston.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="61jdw2sOBCFtR2d/"
Content-Disposition: inline
In-Reply-To: <16667.55966.317888.504243@segfault.boston.redhat.com>
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--61jdw2sOBCFtR2d/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 12, 2004 at 05:01:18PM -0400, Jeff Moyer wrote:

> So how do you want to deal with this case?  We could do something like:
>=20
> 	int cpu =3D smp_processor_id();

That doesn't look right, unless I'm missing something, you could get
preempted here (between the smp_processor_id() and the
local_irq_save() and end up with 'cpu' pointing to the wrong CPU.

> 	local_irq_save(flags);
> 	if (!spin_trylock(&netpoll_poll_lock)) {
> 		/* allow recursive calls on this cpu */
> 		if (cpu !=3D poll_owner)
> 			spin_lock(&netpoll_poll_lock);
> 	}
> 	poll_owner =3D cpu;

Cheers,=20
Muli
--=20
Muli Ben-Yehuda
http://www.mulix.org | http://mulix.livejournal.com/


--61jdw2sOBCFtR2d/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBG96xKRs727/VN8sRAg26AKCALYDFbCvBvEGHJaaEODudyD+yGwCgjfpm
PDWkcKQ6mspxIdtE8JeKB6c=
=243J
-----END PGP SIGNATURE-----

--61jdw2sOBCFtR2d/--
