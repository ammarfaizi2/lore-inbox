Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266985AbTGGNPA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 09:15:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266987AbTGGNPA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 09:15:00 -0400
Received: from iucha.net ([209.98.146.184]:28479 "EHLO mail.iucha.net")
	by vger.kernel.org with ESMTP id S266985AbTGGNO6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 09:14:58 -0400
Date: Mon, 7 Jul 2003 08:29:32 -0500
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Subject: 2.5.74-bk5 strange oops in handle_mm_fault
Message-ID: <20030707132932.GA18994@iucha.net>
Mail-Followup-To: Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline
X-message-flag: Microsoft: Where do you want to go today? Nevermind, you are coming with us!
X-gpg-key: http://iucha.net/florin_iucha.gpg
X-gpg-fingerprint: 41A9 2BDE 8E11 F1C5 87A6  03EE 34B3 E075 3B90 DFE4
User-Agent: Mutt/1.5.4i
From: florin@iucha.net (Florin Iucha)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

What makes this oops strange is that it occured when ripping a cd
using a SCSI CD-RW, yet ide_* is on the call stack. The other process
running was oggenc.

florin

APIC error on CPU0: 00(02)
Unable to handle kernel paging request at virtual address 2d45a020
 printing eip:
daf7c385
*pde =3D 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<daf7c385>]    Not tainted
EFLAGS: 00210217
EIP is at 0xdaf7c385
eax: 00000086   ebx: c5a8b404   ecx: 00000000   edx: d8a2f800
esi: 40429000   edi: c2ba80a4   ebp: d8d7c000   esp: d8d7ded8
ds: 007b   es: 007b   ss: 0068
Process cdparanoia (pid: 2582, threadinfo=3Dd8d7c000 task=3Dd8a5d340)
Stack: 00000001 c0143a5b daf7c380 d989c380 40429000 c2ba80a4 c5a8b404 00104=
025=20
       c046478c daf7c380 daf7c3a0 d989c380 d8a5d340 c0118cb1 daf7c380 d989c=
380=20
       40429000 00000001 00000001 40429000 c046478c c04646e0 00030002 c0464=
78c=20
Call Trace:
 [<c0143a5b>] handle_mm_fault+0x13b/0x170
 [<c0118cb1>] do_page_fault+0x251/0x451
 [<c02a91b2>] ide_dma_intr+0xa2/0xc0
 [<c02a9110>] ide_dma_intr+0x0/0xc0
 [<c010cc6a>] handle_IRQ_event+0x3a/0x70
 [<c010cfeb>] do_IRQ+0xbb/0x130
 [<c0118a60>] do_page_fault+0x0/0x451
 [<c010b4e5>] error_code+0x2d/0x38

Code: 38 34 d9 80 72 34 d9 00 b0 4a 40 00 b0 a8 c5 01 00 00 00 01=20
 <1>Unable to handle kernel NULL pointer dereference at virtual address 000=
00086
 printing eip:
d90f5043
*pde =3D 00000000
Oops: 0002 [#2]
CPU:    0
EIP:    0060:[<d90f5043>]    Not tainted
EFLAGS: 00210256
EIP is at 0xd90f5043
eax: 00000086   ebx: da5f8080   ecx: 00000017   edx: d934b900
esi: 081258a8   edi: d902e494   ebp: 00000001   esp: d8aabed8
ds: 007b   es: 007b   ss: 0068
Process abcde (pid: 1461, threadinfo=3Dd8aaa000 task=3Dd924cc40)
Stack: 00000001 c0143a5b d90f5040 d934b900 081258a8 d902e494 da5f8080 18fae=
067=20
       d8aabef8 d90f5040 d90f5060 d934b900 d924cc40 c0118cb1 d90f5040 d934b=
900=20
       081258a8 00000001 00000001 081258a8 bfffed88 c012002e 00030002 d8a5d=
3e4=20
Call Trace:
 [<c0143a5b>] handle_mm_fault+0x13b/0x170
 [<c0118cb1>] do_page_fault+0x251/0x451
 [<c012002e>] wait_task_zombie+0x14e/0x1c0
 [<c01203f8>] sys_wait4+0x1b8/0x260
 [<c011a3f0>] default_wake_function+0x0/0x30
 [<c01288b8>] sys_rt_sigprocmask+0xe8/0x160
 [<c011a3f0>] default_wake_function+0x0/0x30
 [<c0118a60>] do_page_fault+0x0/0x451
 [<c010b4e5>] error_code+0x2d/0x38

Code: d9 18 34 34 d9 c0 ea 32 d9 00 00 00 40 00 80 5f da 01 00 00=20
=20

--=20

"NT is to UNIX what a doughnut is to a particle accelerator."

--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/CXW8NLPgdTuQ3+QRArVgAJ0ayNFkFniiqC9ux5XUe0W6r6awfwCgk8nk
w+/N6LRVT0sZaKMnTe/4WCU=
=eVP0
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--
