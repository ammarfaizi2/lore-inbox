Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317011AbSFQU5x>; Mon, 17 Jun 2002 16:57:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317013AbSFQU5w>; Mon, 17 Jun 2002 16:57:52 -0400
Received: from etpmod.phys.tue.nl ([131.155.111.35]:8723 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S317011AbSFQU5t>; Mon, 17 Jun 2002 16:57:49 -0400
Date: Mon, 17 Jun 2002 22:57:50 +0200
From: Kurt Garloff <garloff@suse.de>
To: Patrick Mansfield <patmans@us.ibm.com>
Cc: Linux kernel list <linux-kernel@vger.kernel.org>,
       Linux SCSI list <linux-scsi@vger.kernel.org>
Subject: Re: /proc/scsi/map
Message-ID: <20020617205750.GC1313@gum01m.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Patrick Mansfield <patmans@us.ibm.com>,
	Linux kernel list <linux-kernel@vger.kernel.org>,
	Linux SCSI list <linux-scsi@vger.kernel.org>
References: <20020615133606.GC11016@gum01m.etpnet.phys.tue.nl> <20020617133534.A10174@eng2.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VywGB/WGlW4DM4P8"
Content-Disposition: inline
In-Reply-To: <20020617133534.A10174@eng2.beaverton.ibm.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.4.16-schedJ2 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TU/e(NL), SuSE(DE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--VywGB/WGlW4DM4P8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

On Mon, Jun 17, 2002 at 01:35:34PM -0700, Patrick Mansfield wrote:
> On Sat, Jun 15, 2002 at 03:36:06PM +0200, Kurt Garloff wrote:
> > Life would be easier if the scsi subsystem would just report which SCSI
> > device (uniquely identified by the controller,bus,target,unit tuple) be=
longs
> > to which high-level device. The information is available in the kernel.
>=20
> I prefer we refer to the tuple as host, channel, id, lun (H, C, I, L), so
> as to more closely match /proc/scsi/scsi, /proc/scsi/sg, and attached
> messages:

You are refering to the naming of this 4-tuple, right: HCIL vs. CBTU?
I chose for CBTU, because that on's used in devfs. Actually, as you can see
from scsidev, I like HCIL more. But that's a detail the kernel should not
care about. The header line should be removed anyway as Albert remarked.
And helping those people who think that 200 bytes is unacceptable bloat.

[...]
> > 3,0,12,00       0x00    1       sg12    c:15:0c sdf     b:08:50
>=20
> Why not treat each upper layer driver the same? Type is already
> in /proc/scsi/scsi, or implied by the upper level drivers attached.
> Online should really be part of /proc/scsi/scsi.

I'm not sure I know what you mean. The fact that I decided to put
the sg device name first independently of the (potentially) random
order in which high-level drivers are assigned?

> Then, each line is a path followed by a list of upper level devices.

It is.=20

> This would also simplify the code, although the ordering of the upper
> level devices becomes link or module load order dependent.

Just I decided to report shg first. This has a very pratical reason:
I you want to use userspace tools to collect more advanced (and maybe type
dependant information), you will always want to use the sg device, which=20
you can use to send SCSI commands and which you can open, even if there is
no medium or if the device is in use.

> And similiar to sg (someone commented on parsing '^#'), have a _hdr
> entry; something like:
>=20
> $ cat /proc/scsi/map_hdr /proc/scsi/map
>=20
> H:C:I:L      online  type:name:block/char:maj:min
> 00:00:00:00     1       sg:sg0:c:15:00      sr:sr0:b:0b:00
> 01:00:01:00     1       sg:sg1:c:15:01      sr:sr1:b:0b:01
> 01:00:02:00     1       sg:sg2:c:15:02      osst:osst0:c:ce:00
> 02:00:09:00     1       sg:sg3:c:15:03      sd:sdd:b:08:30

This looks find to me as well, by the way.
The reason why I chose to additionally report the device type reported by
inquiry is that you will only see the attached (and thus only the loaded)
high-level drivers of a device. With the device type, a userspace tool could
easily decide whether to trigger a modprobe and start again ...

> Or:
>=20
> H:C:I:L      online  type:enumeration:block/char:maj:min
> 00:00:00:00     1      sg:0:c:15:00      sr:0:b:0b:00
> 01:00:01:00     1      sg:1:c:15:01      sr:1:b:0b:01
> 01:00:02:00     1      sg:2:c:15:02      osst:0:c:ce:00
> 02:00:09:00     1      sg:3:c:15:03      sd:d:b:08:30
>=20
>=20
> > A patch for 2.5 should be done as well, if the design is OK, of course.
>=20
> IMO, we should use driverfs for this in 2.5. Mike Sullivan's scsi driverfs
> patch currently ends up with a driverfs layout (showing one Scsi_Device
> with two partitions, sg and sd attached) like this:

I still think the easy /proc/scsi/map format would be a nice basis to
inquire more information on the SCSI devices from userspace, even if you add
hierarchical attachment information via driverfs. And I think a solution
that works with both 2.4 and 2.5 would help most users, of course.

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE Linux AG, Nuernberg, DE                            SCSI, Security

--VywGB/WGlW4DM4P8
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9Dk1NxmLh6hyYd04RAk4nAJ9jzAbPOw+OGOOS80jDNCqH5hKqZgCgvq23
yZeaeadn4DM4GD64y/ez6ls=
=OR7T
-----END PGP SIGNATURE-----

--VywGB/WGlW4DM4P8--
