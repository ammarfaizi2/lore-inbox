Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129614AbQK3Ixm>; Thu, 30 Nov 2000 03:53:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129977AbQK3Ixc>; Thu, 30 Nov 2000 03:53:32 -0500
Received: from wiiusc.wii.ericsson.net ([192.36.108.17]:21681 "EHLO
        hell.wii.ericsson.net") by vger.kernel.org with ESMTP
        id <S129614AbQK3IxR>; Thu, 30 Nov 2000 03:53:17 -0500
Message-Id: <200011300822.JAA11351@hell.wii.ericsson.net>
X-Mailer: exmh version 2.2_20001129 06/23/2000 with nmh-1.0.3
To: linux-kernel@vger.kernel.org
From: Anders Eriksson <aer-list@mailandnews.com>
Subject: romfs as initrd
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1249086358P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 30 Nov 2000 09:22:45 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1249086358P
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable


Running 2.4.0-test10 I try to get an romfs image to work as an initrd =

image. It does work when mount `normally` using `mount -o loop`. =

However, when used as initrd image it fails. Here's the relevant part =

of dmesg:

  =

RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize  =


loop: enabling 64 loop devices                                          =

                RAMDISK: romfs filesystem found at block 0              =

                                RAMDISK: Loading 3183 blocks [1 disk] =

into ram disk... done.                            Freeing initrd =

memory: 3184k freed

=2E..

devfs: v0.102 (20000622) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
Trying fs: ext2
Trying fs: cramfs
wrong magic
Trying fs: romfs
ROMFS DEBUG: rsb_word0 0 rsb_word1 0 sz 0
Kernel panic: VFS: Unable to mount root fs on 01:00


Where the ROMFS DEBUG message comes for this section of romfs/inode.c:
----------------

        if (rsb->word0 !=3D ROMSB_WORD0 || rsb->word1 !=3D ROMSB_WORD1
           || sz < ROMFH_SIZE) {
                if (!silent)
                        printk ("VFS: Can't find a romfs filesystem on =

dev "
                                "%s.\n", kdevname(dev));
                printk ("ROMFS DEBUG: rsb_word0 %i rsb_word1 %i sz =

%i\n",rsb->word0,rsb->word1,sz);
                goto out;
----------------


Not knowing that much about fs (and VFS) internals it seems that the =

image is identified by the initrd code, but  currupted/misplaced so it =

cannot be used by the VFS when trying to mount it. I have no ideas what =

steps are supposed to happen in between these two.


Help and insights appreciated.

/Anders





--==_Exmh_1249086358P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.2 (GNU/Linux)
Comment: Exmh version 2.2_20000822 06/23/2000

iD8DBQE6Jg5V/X4RQObd8qERAmM/AJ4xlUjCJbX/+ZsedspmKAyKHTXgcgCfQt5X
qaTa/K9vk5TbLIJO15WmK34=
=33qn
-----END PGP SIGNATURE-----

--==_Exmh_1249086358P--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
