Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270998AbTHBFzd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 01:55:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271006AbTHBFzb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 01:55:31 -0400
Received: from pool-141-155-151-209.ny5030.east.verizon.net ([141.155.151.209]:16363
	"EHLO mail.blazebox.homeip.net") by vger.kernel.org with ESMTP
	id S270998AbTHBFz2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 01:55:28 -0400
Date: Sat, 2 Aug 2003 01:57:16 -0400
From: Diffie <diffie@blazebox.homeip.net>
To: Mike Anderson <andmike@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Badness in device_release at drivers/base/core.c:84
Message-ID: <20030802055716.GC3613@blazebox.homeip.net>
References: <20030801182207.GA3759@blazebox.homeip.net> <20030801144455.450d8e52.akpm@osdl.org> <20030801232721.GA5249@beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eHhjakXzOLJAF9wJ"
Content-Disposition: inline
In-Reply-To: <20030801232721.GA5249@beaverton.ibm.com>
User-Agent: Mutt/1.4.1i
X-Operating-System: Slackware Linux 9.0
X-Kernel-Version: Linux 2.6.0-test2-mm2
X-Mailer: Mutt 1.4.1i http://www.mutt.org
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.1.14; AVE: 6.20.0.1; VDF: 6.20.0.55; host: blazebox.homeip.net)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--eHhjakXzOLJAF9wJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 01, 2003 at 04:27:22PM -0700, Mike Anderson wrote:
> Andrew Morton [akpm@osdl.org] wrote:
> > This patch should fix the oops.
> >=20
> > As for why the proc reading code was unable to locate the HBA: dunno, b=
ut
> > this is a first step.
> >=20
> > Or maybe you don't have any adaptec controllers in the machine?
> >=20
> > (jejb, please apply..)
> >=20
> >=20
> >  25-akpm/drivers/scsi/aic7xxx_old/aic7xxx_proc.c |    2 +-
> >  1 files changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff -puN drivers/scsi/aic7xxx_old/aic7xxx_proc.c~aic7xxx_old-oops-fix =
drivers/scsi/aic7xxx_old/aic7xxx_proc.c
> > --- 25/drivers/scsi/aic7xxx_old/aic7xxx_proc.c~aic7xxx_old-oops-fix	Fri=
 Aug  1 14:41:14 2003
> > +++ 25-akpm/drivers/scsi/aic7xxx_old/aic7xxx_proc.c	Fri Aug  1 14:41:20=
 2003
> > @@ -92,7 +92,7 @@ aic7xxx_proc_info ( struct Scsi_Host *HB
> > =20
> >    HBAptr =3D NULL;
> > =20
> > -  for(p=3Dfirst_aic7xxx; p->host !=3D HBAptr; p=3Dp->next)
> > +  for(p=3Dfirst_aic7xxx; p && p->host !=3D HBAptr; p=3Dp->next)
> >      ;
> > =20
> >    if (!p)
>=20
> Is this really the right thing to add. The only purpose of these few lines
> is a poor sanity check as down further in the code a pointer to the
> structure is already present in hostdata.=20
>=20
> Adding the "p" is an indication that this drivers list got corrupted some
> where.
>=20
> I agree it may be better than an oops, but what else is invalid?
>=20
> You need to have adaptec controllers in the system to get a procfs node
> to read / write, but this error could be related to the node not getting
> cleaned up correctly on a remove which a patch has previously been
> posted.
>=20
> -andmike
> --
> Michael Anderson
> andmike@us.ibm.com
>=20
>=20

Mike,

I do indeed have an AHA-2940U2W controller in the box...could you be
kind and point me at the said patch? Thank you.

Regards,

Paul


--eHhjakXzOLJAF9wJ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/K1K8IymMQsXoRDARAiAvAJ9C1g+J3mBPvDaEEcGbk+qZpLDI9ACfcmca
hGtTfEbyWqF0FRSQkPIFpe4=
=1R+8
-----END PGP SIGNATURE-----

--eHhjakXzOLJAF9wJ--
