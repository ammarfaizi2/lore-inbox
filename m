Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261889AbVBLBTH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261889AbVBLBTH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 20:19:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261807AbVBLBTH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 20:19:07 -0500
Received: from smtp08.auna.com ([62.81.186.18]:23225 "EHLO smtp08.retemail.es")
	by vger.kernel.org with ESMTP id S261961AbVBLBSC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 20:18:02 -0500
Date: Sat, 12 Feb 2005 01:18:01 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: udev::cdsymlinks does not consider a 'cdrw' as a 'cdrom'
To: linux-kernel@vger.kernel.org
Cc: Greg KH <gregkh@suse.de>
References: <1108170212l.5587l.0l@werewolf.able.es>
	<1108170796l.5587l.1l@werewolf.able.es>
In-Reply-To: <1108170796l.5587l.1l@werewolf.able.es> (from
	jamagallon@able.es on Sat Feb 12 02:13:16 2005)
X-Mailer: Balsa 2.3.0
Message-Id: <1108171081l.5587l.2l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
	protocol="application/pgp-signature"; boundary="=-gJmL/Q4h183RiRzGPXTQ"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-gJmL/Q4h183RiRzGPXTQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


On 2005.02.12, J.A. Magallon wrote:
>=20
> On 2005.02.12, J.A. Magallon wrote:
> > Hi...
> >=20
> > I have a little problem with udev. I have udev-051, but have tried
> > cdsymlinks.c from 053 and is the same.
> >=20
> > It does not give 'cdrom' or 'dvd' for DVD writers.
> > In one box, hdb is a DVD, and hdc is a DVDRW:
> >=20
>=20
> Opps, and cdsymlinks.c and .sh behave different:
>=20
> werewolf:~# /sbin/cdsymlinks hdc -d
> Devices: hdb hdc
> DVDRAM : 0 1 hdc
> DVDRW  : 0 1 hdc
> DVD    : 1 1 hdb hdc
> CDRW   : 0 1 hdc
> CDR    : 0 1 hdc
> CDWMRW :
> CDMRW  :
> CDROM  : (all) hdb hdc
>  cdrw dvdrw dvdram
>=20
> werewolf:~# /etc/udev/scripts/cdsymlinks.sh hdc -d
> Devices: hdb hdc
> DVDRAM : 0 1 hdc
> DVDRW  : 0 1 hdc
> DVD    : 1 1 hdb hdc
> CDRW   : 0 1 hdc
> CD-R   : 0 1 hdc
> CDMRW  : 1 1 hdb hdc
> CDM    : 1 1 hdb hdc
> CDROM  : (all) hdb hdc
>  cdrom1 cdrw dvd1 dvdrw dvdram
>=20


Caught it:

--- cdsymlinks.c.orig	2005-02-12 02:17:19.000000000 +0100
+++ cdsymlinks.c	2005-02-12 02:17:26.000000000 +0100
@@ -267,8 +267,8 @@
             list_delete (&allowed_output);
             list_assign_split (&allowed_output, p.we_wordv[0] + 7);
           }
-          else if (!strncmp (p.we_wordv[0], "NUMBERED_LINKS=3D", 14))
-            numbered_links =3D atoi (p.we_wordv[0] + 14);
+          else if (!strncmp (p.we_wordv[0], "NUMBERED_LINKS=3D", 15))
+            numbered_links =3D atoi (p.we_wordv[0] + 15);
           break;
 	}
 	/* fall through */


--
J.A. Magallon <jamagallon()able!es>     \               Software is like se=
x:
werewolf!able!es                         \         It's better when it's fr=
ee
Mandrakelinux release 10.2 (Cooker) for i586
Linux 2.6.10-jam9 (gcc 3.4.3 (Mandrakelinux 10.2 3.4.3-3mdk)) #1


--=-gJmL/Q4h183RiRzGPXTQ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCDVlJRlIHNEGnKMMRAiMOAKCYGteuFiHwh1rrBJ++fufqmKDWhQCdED4x
ooJfT2cYfLpMk1D+cdXFZzs=
=6YC1
-----END PGP SIGNATURE-----

--=-gJmL/Q4h183RiRzGPXTQ--

