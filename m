Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263584AbTEDLcr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 07:32:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263586AbTEDLcr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 07:32:47 -0400
Received: from Hell.WH8.tu-dresden.de ([141.30.225.3]:56272 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id S263584AbTEDLcq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 07:32:46 -0400
Date: Sun, 4 May 2003 13:45:13 +0200
From: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Buffer Bug [2.5.67]
Message-Id: <20030504134513.53158784.us15@os.inf.tu-dresden.de>
Organization: Fiasco Core Team
X-GPG-Key: 1024D/233B9D29 (wwwkeys.pgp.net)
X-GPG-Fingerprint: CE1F 5FDD 3C01 BE51 2106 292E 9E14 735D 233B 9D29
X-Fiasco-Rulez: Yes
X-Mailer: X-Mailer 5.0 Gold
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.FciNBj':Bp)4C:"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.FciNBj':Bp)4C:
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Hello,

I've just hit the following bug with 2.5.67. Since 2.5.68 is already out and I
haven't had a chance to run it on that particular machine yet, it'd be good if
someone could comment on whether this is a known issue or maybe already fixed.

The machine in question is a Pentium-166 with a 100 MB SCSI Zip drive connected
to an Adaptec 2940 Ultra SCSI adapter. The file system on the zip disk is ext3.
The bug happened when the disk was mounted.

See kernel output below. The whole dmesg output is also available in case
someone is interested.

Regards,
-Udo.

EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,65), internal journal
buffer layer error at fs/buffer.c:127
Call Trace:
 [<c0143da8>] __wait_on_buffer+0xc8/0xd0
 [<c0115bb0>] autoremove_wake_function+0x0/0x40
 [<c01441cb>] __find_get_block_slow+0x2b/0xe0
 [<c0115bb0>] autoremove_wake_function+0x0/0x40
 [<c01453d2>] unmap_underlying_metadata+0x12/0x60
 [<c014592e>] __block_prepare_write+0x13e/0x4b0
 [<c01146e0>] __wake_up+0x20/0x50
 [<c01864be>] journal_stop+0x15e/0x1e0
 [<c0146460>] block_prepare_write+0x20/0x40
 [<c0178790>] ext3_get_block+0x0/0x70
 [<c0178d09>] ext3_prepare_write+0x89/0x1a0
 [<c0178790>] ext3_get_block+0x0/0x70
 [<c012b78d>] generic_file_aio_write_nolock+0x32d/0xa10
 [<c021e48f>] do_con_write+0x2bf/0x6f0
 [<c012bedd>] generic_file_write_nolock+0x6d/0x90
 [<c020fe94>] opost+0x94/0x190
 [<c029b04e>] sys_recvfrom+0x9e/0x100
 [<c029b091>] sys_recvfrom+0xe1/0x100
 [<c01143f0>] schedule+0x1b0/0x3c0
 [<c012d68b>] __get_free_pages+0x1b/0x70
 [<c012c09f>] generic_file_writev+0x2f/0x40
 [<c0143082>] do_readv_writev+0x142/0x260
 [<c0142c20>] do_sync_write+0x0/0xb0
 [<c0143239>] vfs_writev+0x49/0x50
 [<c01432aa>] sys_writev+0x2a/0x40
 [<c0108f17>] syscall_call+0x7/0xb

SCSI device sda: 196608 512-byte hdwr sectors (101 MB)
sda: Write Protect is off
sda: Mode Sense: 25 00 00 08
sda: cache data unavailable
sda: assuming drive cache: write through
SCSI device sda: 196608 512-byte hdwr sectors (101 MB)
sda: Write Protect is off
sda: Mode Sense: 25 00 00 08
sda: cache data unavailable
sda: assuming drive cache: write through
 sda: sda1
kjournald starting.  Commit interval 5 seconds

--=.FciNBj':Bp)4C:
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.3.1 (GNU/Linux)

iD8DBQE+tP1JnhRzXSM7nSkRArabAJ4mFb5JJysieX1gC/QqlAIQlNs/dgCfQ+3n
imDkyDKmDB8oVyvCl+toHZ0=
=rMj1
-----END PGP SIGNATURE-----

--=.FciNBj':Bp)4C:--
