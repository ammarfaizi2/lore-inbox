Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264486AbTFIPum (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 11:50:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264487AbTFIPum
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 11:50:42 -0400
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:8838 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id S264486AbTFIPu0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 11:50:26 -0400
Date: Mon, 9 Jun 2003 18:03:57 +0200
From: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: [OOPS] 2.5.70 ide-floppy
Message-Id: <20030609180357.243f65d2.us15@os.inf.tu-dresden.de>
Organization: Fiasco Core Team
X-GPG-Key: 1024D/233B9D29 (wwwkeys.pgp.net)
X-GPG-Fingerprint: CE1F 5FDD 3C01 BE51 2106 292E 9E14 735D 233B 9D29
X-Fiasco-Rulez: Yes
X-Mailer: X-Mailer 5.0 Gold
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="ke?nFiZR=.2,sAar"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--ke?nFiZR=.2,sAar
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Hi,

The ide-floppy driver in 2.5.70 and 2.5.70-bk13 seems to be badly broken. I'm
using it with a Zip drive. When booting with a zip disk in the drive, I get:

ide-floppy driver 0.99.newide
hde: 98304kB, 196608 blocks, 512 sector size
hde: 98304kB, 96/64/32 CHS, 4096 kBps, 512 sector size, 2941 rpm
 hde: hde1
 hde: hde1
kobject_register failed for hde1 (-17)
Call Trace:
 [<c020e3a0>] kobject_register+0x50/0x60
 [<c017f007>] register_disk+0x137/0x140
 [<c0269f3e>] add_disk+0x4e/0x60
 [<c0269ec0>] exact_match+0x0/0x10
 [<c0269ed0>] exact_lock+0x0/0x20
 [<c02ab1a8>] idefloppy_attach+0x168/0x190
 [<c029feeb>] ata_attach+0x4b/0xd0
 [<c02a0d88>] ide_register_driver+0xf8/0x110
 [<c02ab1eb>] idefloppy_init+0x1b/0x30
 [<c046c72c>] do_initcalls+0x2c/0xa0
 [<c01292df>] init_workqueues+0xf/0x30
 [<c01050a3>] init+0x33/0x190
 [<c0105070>] init+0x0/0x190
 [<c010707d>] kernel_thread_helper+0x5/0x18

When actually trying to access files on the zip drive's ext2 filesystem
I get the following Oops:

Unable to handle kernel paging request at virtual address 23cda96f
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<23cda96f>]    Not tainted
EFLAGS: 00010006
EIP is at 0x23cda96f
eax: ed70bdf0   ebx: 498a09dd   ecx: 00000000   edx: 00000003
esi: 8af57166   edi: 00000000   ebp: edb0de4c   esp: edb0de30
ds: 007b   es: 007b   ss: 0068
Process dnetc (pid: 163, threadinfo=edb0c000 task=ee1099c0)
Stack: c01170b1 ed70bdf0 00000003 00000000 edb0c000 00000082 effbf480 edb0de6c
       c0117101 c1780888 00000003 00000000 00000000 effaa2b4 00000001 00000001
       c016a516 ed7069c0 effbf480 00000000 c04ed5bc 00001000 c014f7c4 effbf480
Call Trace:
 [<c01170b1>] __wake_up_common+0x31/0x50
 [<c0117101>] __wake_up+0x31/0x60
 [<c016a516>] mpage_end_io_read+0x56/0x80
 [<c014f7c4>] bio_endio+0x54/0x80
 [<c0268d69>] __end_that_request_first+0x209/0x230
 [<c0296062>] ide_end_request+0x62/0x140
 [<c02a8c60>] idefloppy_do_end_request+0x60/0x90
 [<c02a99ef>] idefloppy_rw_callback+0x1f/0x30
 [<c02a92b7>] idefloppy_pc_intr+0xb7/0x320
 [<c0121c66>] update_process_times+0x46/0x60
 [<c02975fd>] ide_intr+0xed/0x180
 [<c02a9200>] idefloppy_pc_intr+0x0/0x320
 [<c010ab8a>] handle_IRQ_event+0x3a/0x70
 [<c010af07>] do_IRQ+0x97/0x140
 [<c01092a4>] common_interrupt+0x18/0x20

Code:  Bad EIP value.
 <0>Kernel panic: Fatal exception in interrupt
In interrupt handler - not syncing

Regards,
-Udo.

--ke?nFiZR=.2,sAar
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.3.1 (GNU/Linux)

iD8DBQE+5K/xnhRzXSM7nSkRAtQHAJ9bn7PCiPo19u+MacYZtTxNZvti6wCfbwpX
wiflIfR1lRYln+OaT6fYNWM=
=t09q
-----END PGP SIGNATURE-----

--ke?nFiZR=.2,sAar--
