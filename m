Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268032AbUIFN4b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268032AbUIFN4b (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 09:56:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268033AbUIFN4a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 09:56:30 -0400
Received: from mxfep02.bredband.com ([195.54.107.73]:29876 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S268032AbUIFN4O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 09:56:14 -0400
Subject: [FYI] "kernel BUG at fs/nfs/inode.c:152!"
From: Ian Kumlien <pomac@vapor.com>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Da7Kx5hkhMNTwNse0CgZ"
Message-Id: <1094478972.3318.397.camel@big>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 06 Sep 2004 15:56:12 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Da7Kx5hkhMNTwNse0CgZ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

When my networking card died yesterday (sundance based d-link card) i
used dhclient to update the route. Unfortunately it caused it to change
ip, thus today i had some NFS problems...

fstab entry:
blue:/mnt/large /mnt/large      nfs   =20
user,async,soft,rsize=3D32768,wsize=3D32768,tcp     0 0

Anyways, i did a bunch of umount -f's and so on and so forth as i have
done a million times before, but when i tried remounting it, nothing
happened... A quick ps aux |grep revealed:

root     26793  0.0  0.0  1740  696 ?        D    14:23   0:00
/bin/umount /mnt/large
root     26800  0.0  0.0  1868  828 ?        D    14:23   0:00
/bin/mount /mnt/large
root     26805  0.0  0.0  1868  828 ?        D    14:23   0:00
/bin/mount /mnt/large
root     26807  0.0  0.0  1868  828 ?        D    14:23   0:00
/bin/mount /mnt/large
root     26809  0.0  0.0  1868  828 ?        D    14:23   0:00
/bin/mount /mnt/large

And to further my agony a dmesg revealed:

------------[ cut here ]------------
kernel BUG at fs/nfs/inode.c:152!
invalid operand: 0000 [#1]
Modules linked in: nls_cp437 vfat fat floppy nvidia twofish serpent blowfis=
h sha256 crypto_null ip6table_filter ip6_tables forcedethCPU:    0
EIP:    0060:[<c01a8bb0>]    Tainted: P   VLI
EFLAGS: 00210286   (2.6.9-rc1-bk7)
EIP is at nfs_clear_inode+0x50/0x70
eax: ffffffff   ebx: f70595a8   ecx: edc36c60   edx: f710cf60
esi: f7059490   edi: 000000ce   ebp: c042792c   esp: c05cbf04
ds: 007b   es: 007b   ss: 0068
Process umount (pid: 26773, threadinfo=3Dc05ca000 task=3Ddf308bb0)
Stack: 00000002 f70595a8 c05cbf2c c016058d f70595a8 c01605dc 00000000 c1bff=
64c
       c1bff600 c0160736 c05cbf2c c05cbf2c c1bff600 c1bff64c c042a460 c05ca=
000
       c01506f5 ef95c000 00000015 c042a5a0 08050278 c0150dd9 f7e8cc00 c01ab=
2dc
Call Trace:
 [<c016058d>] clear_inode+0x8d/0xa0
 [<c01605dc>] dispose_list+0x3c/0x70
 [<c0160736>] invalidate_inodes+0x66/0x80
 [<c01506f5>] generic_shutdown_super+0x55/0x100
 [<c0150dd9>] kill_anon_super+0x9/0x20
 [<c01ab2dc>] nfs_kill_super+0xc/0x70
 [<c0150623>] deactivate_super+0x43/0x60
 [<c0162e4b>] sys_umount+0x3b/0x90
 [<c03a693d>] schedule+0x27d/0x450
 [<c0103db9>] sysenter_past_esp+0x52/0x71
Code: d4 39 43 d4 75 2f 8b 86 b4 00 00 00 85 c0 74 05 e8 f6 f8 1e 00 8b 86 =
ac 00 00 00 85 c0 75 0c 8b 5c 24 04 8b 74 24 08 83 c4 0c c3 <0f> 0b 98 00 7=
a 28 3c c0 eb ea 0f 0b 94 00 7a 28 3c c0 eb c7 8d

This is, as stated before, just FYI... Anyone feeling like making nvidia
comments can read this and just skip mailing "/me no care".

CC, Since i'm not subbed.

--=20
Ian Kumlien <pomac () vapor ! com> -- http://pomac.netswarm.net

--=-Da7Kx5hkhMNTwNse0CgZ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBPGx77F3Euyc51N8RAia5AJ9MiJbpakXMnzIEDFhNfKYQEKQ+bgCePfGk
x9hFuX/2lYi9Vn0JhK1wJoo=
=mRUD
-----END PGP SIGNATURE-----

--=-Da7Kx5hkhMNTwNse0CgZ--

