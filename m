Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263497AbTL2O7l (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 09:59:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263513AbTL2O7l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 09:59:41 -0500
Received: from dsl-217-155-72-205.zen.co.uk ([217.155.72.205]:45574 "EHLO
	nicole.computer-surgery.co.uk") by vger.kernel.org with ESMTP
	id S263497AbTL2O7i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 09:59:38 -0500
Date: Mon, 29 Dec 2003 14:59:37 +0000
To: LKML <linux-kernel@vger.kernel.org>
Subject: [2.4.18] oops in lvm or raid
Message-ID: <20031229145936.GA19936@computer-surgery.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="M9NhX3UHpAaciwkO"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-GPG-Fingerprint: ADAD DF3A AE05 CA28 3BDB  D352 7E81 8852 817A FB7B
X-GPG-Key: 1024D/817AFB7B (wwwkeys.uk.pgp.net)
From: Roger Gammans <roger@computer-surgery.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi

The system in question runs:-
   ext3-> lvm->raid1(hdc,hde) -> ide( piix  , pdc202xx )

We had a power failure here which caused serve corruption=20
on our system, after coming back up one of the ext3 partitions
wouldn't recover its journal and there was manual fsck ing
gave warnings of serve data loss. Before fscking I created a=20
lvm snapshot of the partition desperately hoping that the lvm=20
meta data was intact. And used this to write the raw filesystem image
pre-fsck to a tape.

Anyway to cut the chase I forgot to delete this snapshot partition
before recovering filesystem form a backup and at about the time
the snapshot got full I got the following kernel messages....


Dec 29 13:15:23 turin kernel: lvm -- giving up to snapshot /dev/rootvg/data=
_root on /dev/rootvg/data_20031218: out of spa
Dec 29 13:15:23 turin kernel: Unable to handle kernel paging request at vir=
tual address 00015618
Dec 29 13:15:23 turin kernel:  printing eip:
Dec 29 13:15:23 turin kernel: c4847a7c
                              c4847a7c -> lvm_snapshot_remap_block (c4847a0=
c)
Dec 29 13:15:23 turin kernel: *pde =3D 00000000
Dec 29 13:15:23 turin kernel: Oops: 0000
Dec 29 13:15:23 turin kernel: CPU:    0
Dec 29 13:15:23 turin kernel: EIP:    0010:[raid1:__insmod_raid1_O/lib/modu=
les/2.4.18-bf2.4/kernel/drivers/md+-169348/96]
Dec 29 13:15:23 turin kernel: EFLAGS: 00010246
Dec 29 13:15:23 turin kernel: eax: 0000ffff   ebx: 00015618   ecx: c2741600=
   edx: 00000000
Dec 29 13:15:23 turin kernel: esi: 0111e1f8   edi: 00000900   ebp: 00000000=
   esp: c1173e58
Dec 29 13:15:23 turin kernel: ds: 0018   es: 0018   ss: 0018
Dec 29 13:15:23 turin kernel: Process kswapd (pid: 4, stackpage=3Dc1173000)
Dec 29 13:15:23 turin kernel: Stack: c2741600 0111e178 c2741770 c2741170 c0=
392520 00002ac3 00000038 00000000=20
Dec 29 13:15:23 turin kernel:        c4844a5d c1173eb6 c1173eb8 0111e178 c2=
741600 00003a00 c3abc500 0111c0b8=20
Dec 29 13:15:23 turin kernel:        01680000 011240b8 01680000 c2741000 c3=
b9f000 0111e178 000088e0 09005920=20
Dec 29 13:15:23 turin kernel: Call Trace: [raid1:__insmod_raid1_O/lib/modul=
es/2.4.18-bf2.4/kernel/drivers/md+-181667/96]=20
Dec 29 13:15:23 turin kernel:    [try_to_free_buffers+174/212] [try_to_rele=
ase_page+63/72] [shrink_cache+458/728] [shrink
Dec 29 13:15:23 turin kernel:    [kswapd_balance+18/40] [kswapd+153/188] [k=
ernel_thread+40/56]=20
		c0392520 -> tasklist_lock (c0392510)
		c4844a5d -> lvm_init (c4843060)
Dec 29 13:15:23 turin kernel:=20
Dec 29 13:15:23 turin kernel: Code: 8b 0b eb 03 45 8b 09 39 d9 74 27 39 71 =
08 75 f4 66 39 79 0c=20


The lines without a date stamp I manually added with my own hand oops
decoding which doesn't seem to match the ksymoops handling.=20

This is a stock kernel (bf2.4) from debian stable (Version: 2.4.18-5)

More information available on request, I'm going to try to find time
to set a similar system up to try to reproduce but that might not be
this week.

TTFN
--=20
Roger. 	                        Home| http://www.sandman.uklinux.net/
Master of Peng Shui.      (Ancient oriental art of Penguin Arranging)
Work|Independent Sys Consultant | http://www.computer-surgery.co.uk/
So what are the eigenvalues and eigenvectors of 'The Matrix'? --anon

--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE/8EFYfoGIUoF6+3sRAlhgAJ0chyqM/WywGucuPDQmWtvZYvTpHACgicLn
pEFH336ApBkbYdwmX9f7qKo=
=Vhf7
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--
