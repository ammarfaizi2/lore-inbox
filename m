Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261791AbUBWClg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 21:41:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261784AbUBWClg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 21:41:36 -0500
Received: from service.sh.cvut.cz ([147.32.127.214]:655 "EHLO
	service.sh.cvut.cz") by vger.kernel.org with ESMTP id S261783AbUBWCl2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 21:41:28 -0500
Date: Mon, 23 Feb 2004 03:41:25 +0100
From: Pavol Luptak <P.Luptak@sh.cvut.cz>
To: linux-kernel@vger.kernel.org
Cc: linux-raid@vger.kernel.org
Subject: SW RAID5 + high memory support freezes 2.6.3 kernel
Message-ID: <20040223024124.GA1590@psilocybus>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,
issue http://www.spinics.net/lists/lvm/msg10322.html could be still present
in the current 2.6.3 kernel. I am able to repeat the conditions to halt the=
=20
2.6.3 kernel (using mkfs.ext3 on RAID device):

Feb 23 02:52:12 psilocybus kernel: Unable to handle kernel NULL pointer der=
eference at virtual address 00000008
Feb 23 02:52:12 psilocybus kernel: printing eip:
Feb 23 02:52:12 psilocybus kernel: f9885205
Feb 23 02:52:12 psilocybus kernel: *pde =3D 00000000
Feb 23 02:52:12 psilocybus kernel: Oops: 0000 [#1]
Feb 23 02:52:12 psilocybus kernel: CPU:    0
Feb 23 02:52:12 psilocybus kernel: EIP:    0060:[<f9885205>]    Tainted: PF=
=20
Feb 23 02:52:12 psilocybus kernel: EFLAGS: 00010246
Feb 23 02:52:12 psilocybus kernel: EIP is at make_request+0x5/0x210 [raid5]
Feb 23 02:52:12 psilocybus kernel: eax: f10e2f2b   ebx: f6631800   ecx: f7f=
e9040   edx: 00001000
Feb 23 02:52:12 psilocybus kernel: esi: 00000008   edi: c644dbc0   ebp: 025=
c0e08   esp: c1b8bcd0
Feb 23 02:52:12 psilocybus kernel: ds: 007b   es: 007b   ss: 0068
Feb 23 02:52:12 psilocybus kernel: Process pdflush (pid: 6, threadinfo=3Dc1=
b8a000 task=3Dc1b8d900)
Feb 23 02:52:12 psilocybus kernel: Stack: c021aea6 f6631800 c644dbc0 e79694=
f0 f9857b01 c19f94a8 00000001 ffb28000=20
Feb 23 02:52:12 psilocybus kernel: db022000 00001000 025c0e10 0000000c 0000=
0001 00000001 00000000 025c0e10=20
Feb 23 02:52:12 psilocybus kernel: f66e4000 00000000 c644dd40 c644dbc0 f985=
7c03 c644dbc0 c644dbc0 c644dd40=20
Feb 23 02:52:12 psilocybus kernel: Call Trace:
Feb 23 02:52:12 psilocybus kernel: [<c021aea6>] generic_make_request+0x106/=
0x180
Feb 23 02:52:12 psilocybus kernel: [<f9857b01>] loop_transfer_bio+0xc1/0x12=
0 [loop]
Feb 23 02:52:12 psilocybus kernel: [<f9857c03>] loop_make_request+0xa3/0x15=
0 [loop]
Feb 23 02:52:12 psilocybus kernel: [<c021aea6>] generic_make_request+0x106/=
0x180
Feb 23 02:52:12 psilocybus kernel: [<c015bb2b>] bio_alloc+0xcb/0x1a0
Feb 23 02:52:12 psilocybus kernel: [<c021af5d>] submit_bio+0x3d/0x70
Feb 23 02:52:12 psilocybus kernel: [<c0159a10>] __block_write_full_page+0x1=
d0/0x3d0
Feb 23 02:52:12 psilocybus kernel: [<c018fd13>] ext3_journal_dirty_data+0x2=
3/0x60
Feb 23 02:52:12 psilocybus kernel: [<c015b244>] block_write_full_page+0xe4/=
0xf0
Feb 23 02:52:12 psilocybus kernel: [<c015df90>] blkdev_get_block+0x0/0x50
Feb 23 02:52:12 psilocybus kernel: [<c015e0ef>] blkdev_writepage+0x1f/0x30
Feb 23 02:52:12 psilocybus kernel: [<c015df90>] blkdev_get_block+0x0/0x50
Feb 23 02:52:12 psilocybus kernel: [<c017840e>] mpage_writepages+0x20e/0x300
Feb 23 02:52:12 psilocybus kernel: [<c017840e>] mpage_writepages+0x20e/0x300
Feb 23 02:52:12 psilocybus kernel: [<c015e0d0>] blkdev_writepage+0x0/0x30
Feb 23 02:52:12 psilocybus kernel: [<c015f31f>] generic_writepages+0x1f/0x23
Feb 23 02:52:12 psilocybus kernel: [<c013fdee>] do_writepages+0x1e/0x40
Feb 23 02:52:12 psilocybus kernel: [<c0176b54>] __sync_single_inode+0xd4/0x=
230
Feb 23 02:52:12 psilocybus kernel: [<c0176efe>] sync_sb_inodes+0x19e/0x260
Feb 23 02:52:12 psilocybus kernel: [<c017700d>] writeback_inodes+0x4d/0xa0
Feb 23 02:52:12 psilocybus kernel: [<c013fb2b>] background_writeout+0x7b/0x=
c0
Feb 23 02:52:12 psilocybus kernel: [<c0140212>] __pdflush+0xd2/0x1d0
Feb 23 02:52:12 psilocybus kernel: [<c0140310>] pdflush+0x0/0x20
Feb 23 02:52:12 psilocybus kernel: [<c014031f>] pdflush+0xf/0x20
Feb 23 02:52:12 psilocybus kernel: [<c013fab0>] background_writeout+0x0/0xc0
Feb 23 02:52:12 psilocybus kernel: [<c0109284>] kernel_thread_helper+0x0/0xc
Feb 23 02:52:12 psilocybus kernel: [<c0109289>] kernel_thread_helper+0x5/0xc
Feb 23 02:52:12 psilocybus kernel:=20
Feb 23 02:52:12 psilocybus kernel: Code: a7 c0 09 b6 d3 db 66 06 71 67 67 d=
7 32 47 2a 92 23 22 ee b1=20
Feb 23 02:52:12 psilocybus kernel: int3: 0000 [#2]
Feb 23 02:52:12 psilocybus kernel: CPU:    0
Feb 23 02:52:12 psilocybus kernel: EIP:    0060:[<f9885147>]    Tainted: PF=
=20
Feb 23 02:52:12 psilocybus kernel: EFLAGS: 00000217
Feb 23 02:52:12 psilocybus kernel: EIP is at raid5_unplug_device+0x7/0xc0 [=
raid5]
Feb 23 02:52:12 psilocybus kernel: eax: f6631765   ebx: 00000212   ecx: c1b=
d0a10   edx: c1bd0a00
Feb 23 02:52:12 psilocybus kernel: esi: f66318f4   edi: f66318f0   ebp: c1b=
a2000   esp: c1ba3f6c
Feb 23 02:52:12 psilocybus kernel: ds: 007b   es: 007b   ss: 0068
Feb 23 02:52:12 psilocybus kernel: Process kblock0 f25f3ee0 f5e326c0 000000=
01 00000000=20
Feb 23 02:52:12 psilocybus kernel: f7dc15c0 00d8cfe8 ffffe000 f25f2000 f989=
2378 f7dc15c0 00d8cfe8 00000001=20
Feb 23 02:52:12 psilocybus kernel: f7dc1664 00004000 00d8cf00 00000008 0000=
011d 0df83a00 f98981bc c011b25e=20
Feb 23 02:52:12 psilocybus kernel: Call Trace:
Feb 23 02:52:12 psilocybus kernel: [<f9892378>] md_do_sync+0x228/0x780 [md]
Feb 23 02:52:12 psilocybus kernel: [<c011b25e>] recalc_task_prio+0x8e/0x1b0
Feb 23 02:52:12 psilocybus kernel: [<f98912a6>] md_thread+0xc6/0x1a0 [md]

So, RAID5 works for me only without high memory support.

Pavol
--=20
___________________________________________________________________________=
__
[wilder@hq.sk] [http://trip.sk/wilder/] [talker: ttt.sk 5678] [ICQ: 1334035=
56]

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAOWhUhL+8XxdK5TIRAjfUAJ9bPjkvqN8D3NZl33DQnLKybxdl0wCfdqmr
xCtdd3HfzicVC3lMClLH5ts=
=qxeV
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--
