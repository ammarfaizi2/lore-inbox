Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266352AbUJAXnQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266352AbUJAXnQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 19:43:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266810AbUJAXnQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 19:43:16 -0400
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:47074 "EHLO
	ppsw-0.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S266352AbUJAXnL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 19:43:11 -0400
Date: Sat, 2 Oct 2004 00:43:08 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Marcin =?iso-8859-2?Q?Gibu=B3a?= <mg@iceni.pl>
cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Windows Logical Disk Manager error
In-Reply-To: <1096641835.17297.45.camel@imp.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0410020041030.14363@hermes-1.csi.cam.ac.uk>
References: <200409231254.12287@senat> <200410010149.19951@senat> 
 <1096619799.17297.22.camel@imp.csi.cam.ac.uk>  <200410011626.09995@senat>
 <1096641835.17297.45.camel@imp.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1870869256-1174902921-1096674188=:14363"
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1870869256-1174902921-1096674188=:14363
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 1 Oct 2004, Anton Altaparmakov wrote:
> On Fri, 2004-10-01 at 15:26, Marcin Gibu=FF=FFa wrote:
> > > I would not advise you to use volume6 without the md driver.  You are
> > > then missing the last 32kb off the end and you never know when they
> >=20
> > Well, I can't even build it... mdadm failes and driver complains with
> > md: Dev sda2 smaller than chunk_size: 0k < 32k
> > Different chunk size doesn't make any difference.
>=20
> That is a bug in the md driver then.
>=20
> > > direction.  Fortunately you can fix this case by using the "--roundin=
g=3D"
> > > parameter to mdadm.  So if you have a cluster size of 4k try
> > > --rounding=3D4.  (If you don't know your cluster size enable debuggin=
g in
> > > the ntfs driver and then do the mount and "dmesg | grep cluster_size"
> > > will tell you the answer.  To enable debugging in the driver it must =
be
> > > compiled with debugging enabled and you need to, as root, do: "echo 1=
 >
> > > /proc/sys/fs/ntfs-debug" after loading the module if modular and befo=
re
> > > doing the mount command.)
> >=20
> > According to ntfs driver output my cluster size is indeed 4kb, but it s=
till=20
> > failes to read mounted fs.
> >=20
> > Error is now:
> > NTFS-fs error (device md1): ntfs_readdir(): Actual VCN (0x2000650068005=
4) of=20
> > index buffer is different from expected VCN (0x4). Directory inode 0x5 =
is=20
> > corrupt or driver bug.
>=20
> So the number has changed.  Means it is aligning the two pieces
> differently.  But still not correctly.  Actually, having looked at the
> dump of your LDM database again, it is not rounding anything at all. It
> behaves exactly like the NT4 fault tolerant arrays, i.e. it uses all
> 512-byte sectors to store data.
>=20
> You can see it from:
>=20
> Volume2 Size: 0x05AB2EA2 (46437 MB)
>     Volume2-01
>       Disk2-01   VolumeOffset: 0x00000000 Offset: 0x00000000 Length:
> 0x033A186B
>       Disk2-02   VolumeOffset: 0x033A186B Offset: 0x033A18AA Length:
> 0x02711637
>=20
> Disk2-01 contains 0x033a186B sectors =3D=3D 5413987 in decimal an you can
> see the number is odd and hence the Linux md driver cannot work as it
> uses 1024 bytes minimum so it can never work.  )-:
>=20
> Disk2-02 starts at the offset Disk2-01 stops and hence the Linux md
> driver again cannot work.
>=20
> Sorry but with current Linux md driver and tools it is not possible to
> make your linear arrays work.

I should add an AFAIK here.  I am by no means familiar (enough) with EVMS,=
=20
LVM1/2, and the kernel Device Mapper itself, to be able to tell if there=20
isn't some clever way of making it work with existing drivers and tools...

Best regards,

=09Anton
--=20
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
--1870869256-1174902921-1096674188=:14363--
