Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268248AbUG2Prh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268248AbUG2Prh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 11:47:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268263AbUG2PpA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 11:45:00 -0400
Received: from postimies.kymp.net ([80.248.96.135]:26117 "EHLO vesta.kymp.net")
	by vger.kernel.org with ESMTP id S268233AbUG2Pn6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 11:43:58 -0400
Date: Thu, 29 Jul 2004 18:42:24 +0300
To: Nathan Scott <nathans@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] let 4KSTACKS depend on EXPERIMENTAL and XFS on 4KSTACKS=n
Message-ID: <20040729154224.GA3030@bostik.iki.fi>
Reply-To: Mika Bostrom <bostik+lkml@bostik.iki.fi>
References: <20040720114418.GH21918@email.archlab.tuwien.ac.at> <40FD0A61.1040503@xfs.org> <40FD2E99.20707@mnsu.edu> <20040720195012.GN14733@fs.tum.de> <20040729060900.GA1946@frodo>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="M9NhX3UHpAaciwkO"
Content-Disposition: inline
In-Reply-To: <20040729060900.GA1946@frodo>
User-Agent: Mutt/1.5.6+20040523i
From: bostik@bostik.iki.fi (Mika Bostrom)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 29, 2004 at 04:09:00PM +1000, Nathan Scott wrote:
> On Tue, Jul 20, 2004 at 09:50:12PM +0200, Adrian Bunk wrote:
> > Mark this combination as BROKEN until XFS is fixed.
> This part is not useful.  We want to hear about problems
> that people hit with 4K stacks so we can try to address
> them, and it mostly works as is.

  I can mention one. This is not a bugreport (yet).

  I can reproduce a complete hard-lock on 2.6.7 vanilla with the
following setup:

  * VMWare 4.5.2 (taints kernel, I know)
    * NIC is bridged
  * XFS filesystem
  * 4k stacks

  Inside vmware, I am running an instance of modified OpenBSD. With 4k
stacks, at least once a day the system locks hard. The shortest time
between two forced boots was about 20 minutes.

  The hang is triggered everytime by a single instance: guest OS sends a
DHCP-request, and this causes the linux kernel to hang. This does not
happen every time, but perhaps every fourth or fifth time. On one
occasion, it was the first time immediately after boot.

  Compiling 2.6.7 with 8k stacks has so far solved this issue. No random
hangs.

  Now, the reason this can't be any kind of bugreport is clear:
  1) kernel is tainted
  2) VMWare's modules are not yet updated to cope with 2.6.7 kernel

  So until VMWare updates their product, I consider this a bug in their
modules. When they do, I intend to test 4k stacks again. If the hangs
continue, then I shall see with their support whether it can be tracked
to their code or not.

  But at least at the moment if you wish to use VMWare and XFS, using 4k
stacks is, in my experience, asking for trouble.=20

--=20
 Mika Bostr=F6m      +358-40-525-7347  \-/  "World peace will be achieved
 Bostik@iki.fi    www.iki.fi/bostik   X    when the last man has killed
 Security freak, and proud of it.    /-\   the second-to-last." -anon?

--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBCRrgv829VwOfGI4RApo+AKCm7w2BN6J8/2x3jGDxn5vsOPBaJgCfW96H
rk11kjWvqJfy5azR6zodJAQ=
=+y/D
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--
