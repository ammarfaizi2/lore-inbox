Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292797AbSCDTRw>; Mon, 4 Mar 2002 14:17:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292792AbSCDTRl>; Mon, 4 Mar 2002 14:17:41 -0500
Received: from mailout6-1.nyroc.rr.com ([24.92.226.177]:38860 "EHLO
	mailout6.nyroc.rr.com") by vger.kernel.org with ESMTP
	id <S292783AbSCDTR2>; Mon, 4 Mar 2002 14:17:28 -0500
Subject: Re: ext3 and undeletion
From: James D Strandboge <jstrand1@rochester.rr.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <E16hu8q-00080A-00@the-village.bc.nu>
In-Reply-To: <E16hu8q-00080A-00@the-village.bc.nu>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-41a3W+kYbLAamlG3WB4w"
X-Mailer: Evolution/1.0.2 
Date: 04 Mar 2002 14:17:15 -0500
Message-Id: <1015269436.17583.25.camel@hedwig.strandboge.cxm>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-41a3W+kYbLAamlG3WB4w
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2002-03-04 at 10:12, Alan Cox wrote:
> > Modifying unlink will probably suffice.
I am working on a preliminary patch that does this.  My current
implementaion (which is not ready to submit-- but works) added a line to
sys_unlink in fs/namei.c that calls my vfs_undel_link().  The
vfs_undel_link() function is based on the logic of sys_link, and creates
a hard link from the deleted file to one in the "stuff we deleted"
directory.  Then vfs_undel_link returns to sys_unlink and original link
is deleted, leaving only the one in the "stuff we deleted" directory.

> You would need to hook the truncate/unlink paths in the file system. If=20
> you are doing it within the fs it becomes cheap (at least for ext2) - as
> you can simply reassign the data blocks to a new inode, stuff the new ino=
de
> into the magic "stuff we deleted" directory and continue.
After much consideration, my implementation does not deal with
truncate/overwrite because it would fill up the filesystem and be very
slow in VFS since there would have to be a full copy.  Also, staying
high level in VFS makes the patch work over any fs that uses VFS.

When I submit, I will make sure to add RFC to get more input on the
implementation, and possibly dealing with truncate.

Jamie Strandboge

--=20
Email:        jstrand1@rochester.rr.com
GPG/PGP ID:   26384A3A
Fingerprint:  D9FF DF4A 2D46 A353 A289  E8F5 AA75 DCBE 2638 4A3A

--=-41a3W+kYbLAamlG3WB4w
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEABECAAYFAjyDyDoACgkQqnXcviY4SjoBNgCdFwvcou1UcIkXksPPvc1nTmaU
NA0AnjU3feJAZFknV2I35vHz8ka6Kz4x
=t9LS
-----END PGP SIGNATURE-----

--=-41a3W+kYbLAamlG3WB4w--

