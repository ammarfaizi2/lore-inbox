Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317182AbSFQXGz>; Mon, 17 Jun 2002 19:06:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317181AbSFQXGz>; Mon, 17 Jun 2002 19:06:55 -0400
Received: from etpmod.phys.tue.nl ([131.155.111.35]:14869 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S317176AbSFQXGw>; Mon, 17 Jun 2002 19:06:52 -0400
Date: Tue, 18 Jun 2002 01:06:48 +0200
From: Kurt Garloff <kurt@garloff.de>
To: Doug Ledford <dledford@redhat.com>
Cc: Linux SCSI list <linux-scsi@vger.kernel.org>,
       Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: /proc/scsi/map
Message-ID: <20020617230648.GA3448@gum01m.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <kurt@garloff.de>,
	Doug Ledford <dledford@redhat.com>,
	Linux SCSI list <linux-scsi@vger.kernel.org>,
	Linux kernel list <linux-kernel@vger.kernel.org>
References: <20020615133606.GC11016@gum01m.etpnet.phys.tue.nl> <20020617180818.C30391@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
Content-Disposition: inline
In-Reply-To: <20020617180818.C30391@redhat.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.4.16-schedJ2 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TU/e(NL), SuSE(DE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Doug,

On Mon, Jun 17, 2002 at 06:08:18PM -0400, Doug Ledford wrote:
> On Sat, Jun 15, 2002 at 03:36:06PM +0200, Kurt Garloff wrote:
> > Life would be easier if the scsi subsystem would just report which SCSI
> > device (uniquely identified by the controller,bus,target,unit tuple) be=
longs
> > to which high-level device. The information is available in the kernel.
>=20
> Umm, this patently fails to meet the criteria you posted of "stable devic=
e=20
> name".  Adding a controller to a system is just as likely to blow this=20
> naming scheme to hell as it is to blow the traditional linux /dev/sd?=20
> scheme.  IOW, even though the /proc/scsi/map file looks nice and usefull,=
=20
> it fails to solve the very problem you are trying to solve.

In case you just add controllers, you just need to make sure you get them t=
he
same numbers again. A solution for this exists already:
* For a kernel where SCSI low-level drivers are loaded as modules,
  you just need to keep the order constant
* For compiled in SCSI drivers, use scsihosts=3D


But actually, the patch is not meant to be the holy grail of persistent
device naming. But it enables userspace tools to collect information=20
* reliably=20
  (fails so far due to possible open() failures with unknown
   relation to the corresponding sg device (which could be opened))
* without too much trouble

Both things I consider important and useful.

The patch basically does provide two pieces of information:
* mapping between sg vs. other high level devices
* mapping CBTU to high-level devices
The latter one is enough for many setups, and the former can be used for
more elaborate solutions involving userspace tools more advanced than the
simple script I included in the patch.

If you want to go for the holy grail, you may either come up with a=20
unique address at hardware level (which does currently not exist for all
types dealt with by the SCSI subsystem) and make it available to SCSI mid
level or use signatures that allows you to find devices back. LVM, e.g.
does the latter.=20
But at this moment, I fear, neither of them are possible in all cases.

Regards,
--=20
Kurt Garloff                   <kurt@garloff.de>         [Eindhoven, NL]
Physics: Plasma simulations    <K.Garloff@TUE.NL>     [TU Eindhoven, NL]
Linux: SCSI, Security          <garloff@suse.de>    [SuSE Nuernberg, DE]
 (See mail header or public key servers for PGP2 and GPG public keys.)

--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9DmuIxmLh6hyYd04RAnGnAJ9lD6SOo6jIMxcCX6KjA0DW+aHxuwCfSbLO
cMFmTKVmmRVDaxbpyBiQ2bE=
=bLpC
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--
