Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262648AbUDPH5X (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 03:57:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262719AbUDPH5X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 03:57:23 -0400
Received: from deliver.uni-koblenz.de ([141.26.64.15]:36779 "EHLO
	deliver.uni-koblenz.de") by vger.kernel.org with ESMTP
	id S262648AbUDPH5T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 03:57:19 -0400
From: Rainer Krienke <krienke@uni-koblenz.de>
Organization: Uni Koblenz
To: linux-kernel@vger.kernel.org
Subject: Strange "filesystem busy" problem
Date: Fri, 16 Apr 2004 09:57:15 +0200
User-Agent: KMail/1.6.1
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_bH5fAlEb2aRjTUI";
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200404160957.15401.krienke@uni-koblenz.de>
X-AntiVirus: checked by AntiVir Milter 1.0.6; AVE 6.25.0.2; VDF 6.25.0.15
X-AntiVirus: checked by AntiVir Milter 1.0.6; AVE 6.25.0.2; VDF 6.25.0.15
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_bH5fAlEb2aRjTUI
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello,

I am running several NFS and SMB server using SuSE Linux 8.2 with a SuSE=20
patched kernel k_smp4G-2.4.21-202 (the one from suse9.0).
Basically the system is running very stable and without problems. Before I =
can=20
describe the problem I have to describe the architecture in a few words:

The data that are served by NFS and SMB are on LVM2 logical volumes (lvm2=20
tools version 2.2.00.05, device-mapper 4.0.1, about 10 LVs)  using the xfs=
=20
filesystem( version 1.3.1). The LVM2 physical volume is  a software raid 1.=
  =20
The size of the software mirror is about 1TB. This mirror again is using tw=
o=20
hardware raid5 devices equipped with IDE disks that are connected by=20
fibrechannel to the host. There are two seperate paths to each hardware rai=
d,=20
so its a multipath setup. In short:

xfs_fs: LVM2: md_soft_raid1: md_multipath: Fibrechannel_hardware_raid_5

We are making heavy use of the automounter (Version 4.4.0) in that every us=
er=20
mount is a bind mount on the parent directory holding all the users data of=
=20
this server. Usually the are about 200 user mounts (in 5000) at one time on=
=20
one server.

The problem is that when rebooting the machine the xfs filesystems that lie=
 on=20
the LVM2 logical volumes cannot be umounted because the kernel claims they=
=20
are busy. This causes a resync of the software mirror after the reboot whic=
h=20
due to the size of 1TB takes quite a long time and increases the risk of da=
ta=20
loss, if during the resync more than one IDE disk should die on the source=
=20
part of the mirror. =20

The same busy-problem happens when I change to single user mode and then tr=
y=20
to umount  the xfs filesystems manually. Most of them will umount but there=
=20
is always one or two of them that won't. I tried to run fuser and lsof on t=
he=20
filesystem to see whats making it busy, but both tools do not report=20
anything. OK fuser -v says "kernel mount" but does not report any processes=
=20
accessing the filesystem.  You can take a look at the list of all processes=
=20
still running in single user mode here:

http://www.uni-koblenz.de/~krienke/tmp/processes.txt

At the moment I am simply out of ideas what to try. So what I am looking fo=
r=20
is a way to find out more about why the filesystems seem to be busy althoug=
h=20
there is nothing making them busy any longer. Since the system is in=20
production I have only little time to reboot it and analyse the problem and=
 I=20
cannot install a debug kernel, but perhaps there are other ways to find out=
=20
more? =20

Thanks for any hint
Rainer
=2D-=20
=2D------------------------------------------------------------------------=
=2D-
Rainer Krienke, Universitaet Koblenz, Rechenzentrum, Raum A022
Universitaetsstrasse 1, 56070 Koblenz, Tel: +49 261287 -1312, Fax: -1001312
Mail: krienke@uni-koblenz.de, Web: http://www.uni-koblenz.de/~krienke
Get my public PGP key: http://www.uni-koblenz.de/~krienke/mypgp.html
=2D------------------------------------------------------------------------=
=2D-

--Boundary-02=_bH5fAlEb2aRjTUI
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQBAf5Hbaldtjc/KDEoRAkf0AJ9TCK4/Wse0X9pimiOfHtnYIwavigCeM9vU
NM2Zgv+OuLj/s+F9Uwp17us=
=6b2i
-----END PGP SIGNATURE-----

--Boundary-02=_bH5fAlEb2aRjTUI--
