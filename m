Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262056AbULVWFg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262056AbULVWFg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 17:05:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262063AbULVWFg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 17:05:36 -0500
Received: from bgo1smout1.broadpark.no ([217.13.4.94]:10711 "EHLO
	bgo1smout1.broadpark.no") by vger.kernel.org with ESMTP
	id S262056AbULVWEn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 17:04:43 -0500
Date: Wed, 22 Dec 2004 23:04:29 +0100
From: Kristian Eide <kreide@online.no>
Subject: raid5 crash
To: linux-kernel@vger.kernel.org
Message-id: <200412222304.36585.kreide@online.no>
MIME-version: 1.0
Content-type: multipart/signed; boundary=nextPart1407899.j8blWKXOJ8;
 protocol="application/pgp-signature"; micalg=pgp-sha1
Content-transfer-encoding: 7bit
User-Agent: KMail/1.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1407899.j8blWKXOJ8
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I am running kernel 2.6.9-gentoo-r10 on an Athlon XP 2400+ computer with a =
SiI=20
3114 SATA controller hosting 4 WD2500JD-00G drives. I have combined these=20
drives into a raid5 array using software raid, but unfortunately the array =
is=20
not stable. I have tried several filesystems (ext3, reiserfs, xfs), but aft=
er=20
copying several gigabytes of data into the array (using scp) and then tryin=
g=20
to read them back (using rsync to compare over the network) always results =
in=20
data corruption. Here is the output from 'dmesg':

kernel BUG at drivers/md/raid5.c:813!
invalid operand: 0000 [#1]
Modules linked in: sata_sil libata sbp2 ohci1394 ieee1394 usb_storage ehci_=
hcd=20
usbcore
CPU:    0
EIP:    0060:[<c039cdd2>]    Not tainted VLI
EFLAGS: 00010006   (2.6.9-gentoo-r10)
EIP is at add_stripe_bio+0x1c2/0x200
eax: 00045168   ebx: d3974b00   ecx: d3974980   edx: 00000000
esi: 00045140   edi: 00000000   ebp: e33200a4   esp: f0a05ac4
ds: 007b   es: 007b   ss: 0068
Process rsync (pid: 32092, threadinfo=3Df0a04000 task=3Df6c10020)
Stack: 00000000 00000296 00000140 e3320028 00045140 00000000 d3974980 c039e=
092
       e3320028 d3974980 00000000 00000000 00000000 f0a05b1c de3e1ae0 00045=
158
       00000000 00000003 00000004 de3e1ae0 dfe90e00 00000000 00000003 f7d85=
088
Call Trace:
 [<c039e092>] make_request+0x122/0x200
 [<c032dc6f>] generic_make_request+0x15f/0x1e0
 [<c011d590>] autoremove_wake_function+0x0/0x60
 [<c032dd4d>] submit_bio+0x5d/0x100
 [<c0172d43>] mpage_bio_submit+0x23/0x40
 [<c0173170>] do_mpage_readpage+0x2d0/0x480
 [<c012367d>] __do_softirq+0x7d/0x90
 [<c02b54df>] radix_tree_node_alloc+0x1f/0x60
 [<c02b5762>] radix_tree_insert+0xe2/0x100
 [<c0136e54>] add_to_page_cache+0x54/0x80
 [<c017346b>] mpage_readpages+0x14b/0x180
 [<c018f1f0>] reiserfs_get_block+0x0/0x1450
 [<c013ddf4>] read_pages+0x134/0x140
 [<c018f1f0>] reiserfs_get_block+0x0/0x1450
 [<c013b390>] __alloc_pages+0x1d0/0x370
 [<c01081c5>] do_IRQ+0xc5/0xe0
 [<c013e04f>] do_page_cache_readahead+0xcf/0x130
 [<c013e19f>] page_cache_readahead+0xef/0x1e0
 [<c013765c>] do_generic_mapping_read+0x11c/0x4d0
 [<c0137cae>] __generic_file_aio_read+0x1be/0x1f0
 [<c0137a10>] file_read_actor+0x0/0xe0
 [<c0137e1a>] generic_file_read+0xba/0xe0
 [<c011ac24>] do_page_fault+0x194/0x591
 [<c011d590>] autoremove_wake_function+0x0/0x60
 [<c0126f6b>] update_wall_time+0xb/0x40
 [<c012739f>] do_timer+0xdf/0xf0
 [<c015270c>] vfs_read+0xbc/0x170
 [<c012367d>] __do_softirq+0x7d/0x90
 [<c0152a71>] sys_read+0x51/0x80
 [<c010603b>] syscall_call+0x7/0xb
Code: 72 08 0f ba a8 90 00 00 00 02 83 c4 0c 5b 5e 5f 5d c3 89 cb e9 cd fe =
ff=20
ff 8b 5d 00 e9 c5 fe ff ff 77 08 39 f0 0f 86 94 fe ff ff <0f> 0b 2d 0370 92=
=20
44 c0 e9 87 fe ff ff 0f 87 a8 fe ff ff 39 f0

Any idea whether this is a kernel bug or a hardware problem?
Please CC any replies to me.

Sincerely,

=2D-=20
Kristian

--nextPart1407899.j8blWKXOJ8
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBye90RBuET7ul/ccRAjgsAKCjHnry79Fr7Rq9DAzF8ZMSrX3xRQCcC/6L
rcUkL3Wzu7FA4zGpn0wxq6k=
=SWli
-----END PGP SIGNATURE-----

--nextPart1407899.j8blWKXOJ8--
