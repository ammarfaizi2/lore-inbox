Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316567AbSFPUgQ>; Sun, 16 Jun 2002 16:36:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316548AbSFPUgP>; Sun, 16 Jun 2002 16:36:15 -0400
Received: from etpmod.phys.tue.nl ([131.155.111.35]:37994 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S316544AbSFPUgN>; Sun, 16 Jun 2002 16:36:13 -0400
Date: Sun, 16 Jun 2002 22:36:06 +0200
From: Kurt Garloff <kurt@garloff.de>
To: Sancho Dauskardt <sancho@dauskardt.de>
Cc: Douglas Gilbert <dougg@torque.net>, Andries.Brouwer@cwi.nl,
       Linux kernel list <linux-kernel@vger.kernel.org>,
       Linux SCSI list <linux-scsi@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net,
       linux1394-devel@lists.sourceforge.net
Subject: Re: /proc/scsi/map
Message-ID: <20020616203606.GB21461@gum01m.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <kurt@garloff.de>,
	Sancho Dauskardt <sancho@dauskardt.de>,
	Douglas Gilbert <dougg@torque.net>, Andries.Brouwer@cwi.nl,
	Linux kernel list <linux-kernel@vger.kernel.org>,
	Linux SCSI list <linux-scsi@vger.kernel.org>,
	linux-usb-devel@lists.sourceforge.net,
	linux1394-devel@lists.sourceforge.net
References: <UTC200206152154.g5FLsCI23053.aeb@smtp.cwi.nl> <5.0.2.1.2.20020616003031.02a06330@pop.puretec.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZfOjI3PrQbgiZnxM"
Content-Disposition: inline
In-Reply-To: <5.0.2.1.2.20020616003031.02a06330@pop.puretec.de>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.4.16-schedJ2 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TU/e(NL), SuSE(DE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ZfOjI3PrQbgiZnxM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Sancho,

On Sun, Jun 16, 2002 at 12:40:50AM +0200, Sancho Dauskardt wrote:
> >In lk 2.5 we are hoping that driverfs will give us an
> >"information bridge" between scsi pseudo devices
> >and other driver subsystems such as ide, usb and iee1394.
> >Mike Sullivan's persistent naming patch (that I mentioned
> >in my previous post on this thread) adds driverfs capability
> >into the scsi subsystem. Driverfs capability is already
> >in the ide and usb subsystems.
> Driverfs will hopefully solve the problem, of "oh there's a SCSI device.=
=20
> how is it connected ?".
>=20
> But to date, SCSI doesn't know about the GUID's, right ?
> And without this, we won't get a uniform way of creating stable names for=
=20
> hot-plugable devices...

For the SCSI code, a device is uniquely identified by the CBTU tuple.
Every device has one and it's known to the SCSI code.
If you don't change your SCSI IDs (which rarely happens in practice) and
make sure the SCSI host adpters are loaded in the same order always (by
using scsihosts=3D or by just doing the modprobe in a certain order) you=20
even a stable way to address devices.

The SCSI code does not know about GUIDs or such things. It's up to the
lowlevel code to report such things. Or change the SCSI code to collect
such information.

Low-level drivers that are supposed to have a lot of SCSI devices attached,
such as FC drivers, should provide a way of making a stable mapping from the
identifiers in FC Land (Unique IDs) to the identifiers in SCSI land (CBTU).
If not, they should at least report the mapping in some proc file.

A more general approach could be to build a unique identifier from a host
adapter identifier and the BTU and use this unique identifier (which would
be the UID of FC devices for FC devices) inside the SCSI code instead of
CBTU. Then the first column of /proc/scsi/map would report this identifier
instead ...

But that would be a more invasive change than the simple code that I added
to report the SCSI CBTU to SCSI high-level devices mapping.

Regards,
--=20
Kurt Garloff                   <kurt@garloff.de>         [Eindhoven, NL]
Physics: Plasma simulations    <K.Garloff@TUE.NL>     [TU Eindhoven, NL]
Linux: SCSI, Security          <garloff@suse.de>    [SuSE Nuernberg, DE]
 (See mail header or public key servers for PGP2 and GPG public keys.)

--ZfOjI3PrQbgiZnxM
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9DPa2xmLh6hyYd04RAjitAJ9y8KPXlXmYINUevhumE8ukK5nC+QCfbObB
ATuf5vzakWB8GWMSC09h1Rw=
=A3z0
-----END PGP SIGNATURE-----

--ZfOjI3PrQbgiZnxM--
