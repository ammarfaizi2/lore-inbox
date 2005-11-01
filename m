Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750769AbVKANme@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750769AbVKANme (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 08:42:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750785AbVKANme
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 08:42:34 -0500
Received: from mail.gondor.com ([212.117.64.182]:31493 "EHLO moria.gondor.com")
	by vger.kernel.org with ESMTP id S1750769AbVKANmd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 08:42:33 -0500
Date: Tue, 1 Nov 2005 14:42:33 +0100
From: Jan Niehusmann <jan@gondor.com>
To: linux-kernel@vger.kernel.org
Subject: ext3 corruption: "JBD: no valid journal superblock found"
Message-ID: <20051101134232.GA9234@knautsch.gondor.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Currently, I'm experiencing a strange problem with one of my ext3
filesystems: There seems to be some journal corruption, but up to now I
didn't see any sign of hardware problems, so I wonder if there could be
some filesystem bug involved.

The symptoms are the kernel not mounting the filesystem but giving the
following error message:

Oct 31 19:48:18 knautsch kernel: [17179601.724000] JBD: no valid journal superblock found
Oct 31 19:48:18 knautsch kernel: [17179601.724000] EXT3-fs: error loading journal.


e2fsck -n tells me

e2fsck 1.38 (30-Jun-2005)
Superblock has an invalid ext3 journal (inode 8).
Clear? no

e2fsck: Illegal inode number while checking ext3 journal for /dev/vgnb/compile


There are two things I did with the filesystem which may be related to
this: First, on Oct. 27 I did resize the filesystem (umount, lvextend,
e2fsck -f, resize2fs, mount). But after that I did several reboots
without any problems - this is my notebook and I turn it on and off
several times a day.

The second is an unclean shutdown and reboot at Oct 31 19:19:56. At this
boot, the filesystem was still mountable:

Oct 31 19:19:56 knautsch kernel: [17179602.428000] kjournald starting.  Commit interval 5 seconds
Oct 31 19:19:56 knautsch kernel: [17179602.432000] EXT3 FS on dm-4, internal journal
Oct 31 19:19:56 knautsch kernel: [17179602.432000] EXT3-fs: recovery complete.
Oct 31 19:19:56 knautsch kernel: [17179602.440000] EXT3-fs: mounted filesystem with ordered data mode.

(here, I'm assuming the "dm-4" number is stable between reboots,
correct? - Anyways, there were no error messages on that reboot)

The next reboot was the one at 19:48, with the error message quoted
above. So, to me it looks like the recovery at 19:19 did something wrong
and corrupted the journal.

I am just copying the whole filesystem over to another hard disk, so I
can do further analysis on that, later. If you think this could
really indicate some kind of bug, I hope that I can provide additional
information.

Jan


--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iQCVAwUBQ2dww4FL8fYptN/eAQJweAQAk5aQUajg9Vo6FqRhKc9/GHqR9DXaifVa
vkyAljgvzgSpw6bSwenIBZ/bWULZ59Ir/q689vVgOSbWsZqXentokbBXt9/T9qoa
feQIjfS65YD+FaHIePXnHomTt4yiPfGUhfbkRtC5eMs3EXj10+GGJwOj7fmTDuLX
XHTCgE6XmxY=
=1+ST
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--
