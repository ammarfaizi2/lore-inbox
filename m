Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273096AbRIIXn4>; Sun, 9 Sep 2001 19:43:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273098AbRIIXnq>; Sun, 9 Sep 2001 19:43:46 -0400
Received: from ns.snowman.net ([63.80.4.34]:20486 "EHLO ns.snowman.net")
	by vger.kernel.org with ESMTP id <S273096AbRIIXn2>;
	Sun, 9 Sep 2001 19:43:28 -0400
Date: Sun, 9 Sep 2001 19:43:13 -0400
From: Stephen Frost <sfrost@snowman.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.10-pre6
Message-ID: <20010909194313.G11136@ns>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0109081949510.1097-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cupjvedY0UaoiHsO"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0109081949510.1097-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Sat, Sep 08, 2001 at 07:52:04PM -0700
X-Editor: Vim http://www.vim.org/
X-Info: http://www.snowman.net
X-Operating-System: Linux/2.2.16 (i686)
X-Uptime: 7:37pm  up 388 days, 21:55, 12 users,  load average: 2.00, 2.00, 2.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--cupjvedY0UaoiHsO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Linus Torvalds (torvalds@transmeta.com) wrote:
>=20
> Most noticeable (except perhaps for the NTFS update if you're a NTFS user)
> is that the broken bootdata patch that could cause some spurious MM
> corruption due to a double page free of the bootdata got reverted. This is
> the one that caused BUG reports from mm/page_alloc.c..

	The changes to rd.c cause it to fail in compiling.  Following
	is a patch which I believe to be correct.  It fixes the
	compilation problem and the module appears to load, work and
	unload correctly.

		Stephen


--- linux-2.4.10-pre6-orig/drivers/block/rd.c	Sun Sep  9 16:19:07 2001
+++ linux/drivers/block/rd.c	Sun Sep  9 16:06:59 2001
@@ -259,7 +259,7 @@
 			/* special: we want to release the ramdisk memory,
 			   it's not like with the other blockdevices where
 			   this ioctl only flushes away the buffer cache. */
-			if ((atomic_read(rd_bdev[minor]->bd_openers) > 2))
+			if ((atomic_read(&rd_bdev[minor]->bd_openers) > 2))
 				return -EBUSY;
 			destroy_buffers(inode->i_rdev);
 			rd_blocksizes[minor] =3D 0;
@@ -372,7 +372,7 @@
 		struct block_device *bdev =3D rd_bdev[i];
 		rd_bdev[i] =3D NULL;
 		if (bdev) {
-			blkdev_put(bdev);
+			blkdev_put(bdev, BDEV_FILE);
 			bdput(bdev);
 		}
 		destroy_buffers(MKDEV(MAJOR_NR, i));

--cupjvedY0UaoiHsO
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7m/6QrzgMPqB3kigRAlXWAKCCOnGhJitx2bLRAZG8PiV9TTxwXACfV0nD
6cYtQoP3atW46Hn+/TXtJ1M=
=Ijq6
-----END PGP SIGNATURE-----

--cupjvedY0UaoiHsO--
