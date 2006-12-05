Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968034AbWLEGCL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968034AbWLEGCL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 01:02:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968035AbWLEGCL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 01:02:11 -0500
Received: from chilli.pcug.org.au ([203.10.76.44]:57344 "EHLO smtps.tip.net.au"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S968034AbWLEGCJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 01:02:09 -0500
Date: Tue, 5 Dec 2006 17:01:44 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: linux-ide@vger.kernel.org
Cc: Albert Lee <albertcc@tw.ibm.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       LKML <linux-kernel@vger.kernel.org>, ppc-dev <linuxppc-dev@ozlabs.org>
Subject: Oops in pata_pdc2027x
Message-Id: <20061205170144.0b98d7e6.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 2.3.0beta5 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Tue__5_Dec_2006_17_01_44_+1100_/=VtkIWOCIWV_AP3"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Tue__5_Dec_2006_17_01_44_+1100_/=VtkIWOCIWV_AP3
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hi all,

I get an oops during initialisation of the pata_pdc2027x module on a
POWER 285 machine.  This is on a very recent Linus kernel tree
(ff51a98799931256b555446b2f5675db08de6229) with Paulus' powerpc tree
(that has now been merged). The oops looks like this:

----------------------------------------------------------------------------
Synthesizing the initial hotplug events...done.
Waiting for /dev to be fully populated...pata_pdc2027x 0001:cc:01.0: PLL input clock 32721 kHz
ata1: PATA max UDMA/133 cmd 0xD0000800801457C0 ctl 0xD000080080145FDA bmdma 0xD000080080145000 irq 324
ata2: PATA max UDMA/133 cmd 0xD0000800801455C0 ctl 0xD000080080145DDA bmdma 0xD000080080145008 irq 324
scsi1 : pata_pdc2027x
ata1.00: ATAPI, max UDMA/66
Unable to handle kernel paging request for data at address 0xc0000001007e8d80
Faulting instruction address: 0xd00000000007b660
Oops: Kernel access of bad area, sig: 11 [#1]
SMP NR_CPUS=128 NUMA
Modules linked in: pata_pdc2027x dm_mirror dm_snapshot ipr libata
NIP: D00000000007B660 LR: D00000000007B628 CTR: 0000000000000000
REGS: c0000000f4e3b5a0 TRAP: 0300   Not tainted  (2.6.19comb)
MSR: 8000000000009032 <EE,ME,IR,DR>  CR: 24000080  XER: 20000009
DAR: C0000001007E8D80, DSISR: 0000000040010000
TASK = c000000007001040[3393] 'scsi_eh_1' THREAD: c0000000f4e38000 CPU: 2
GPR00: 0000000100000000 C0000000F4E3B820 D0000000000A95C0 C00000000FA946E8
GPR04: C0000000F4E3B960 0000000000000000 0000000000000003 C0000000F4E3B890
GPR08: 0000000000000001 C0000000007E8D80 D000080080145110 C000000000033A34
GPR12: 0000000000000000 C00000000056FF80 0000000000000000 C0000000004751C8
GPR16: 4000000001C00000 C000000000473B90 0000000000000000 000000000035D800
GPR20: 000000000213AF30 C00000000053AF30 C0000000F4E3BB10 0000000000000001
GPR24: 0000000000000002 0000000000000000 C0000000F4E3B960 C00000000FA946E8
GPR28: 0000000000000003 4000000000000000 D0000000000A7980 0000000000000000
NIP [D00000000007B660] .ata_exec_internal+0x8c/0xf8 [libata]
LR [D00000000007B628] .ata_exec_internal+0x54/0xf8 [libata]
Call Trace:
[C0000000F4E3B820] [D0000000000A7980] .ipr_store_update_fw+0x100/0x6f0 [ipr] (unreliable)
[C0000000F4E3B8F0] [D00000000007C15C] .ata_set_mode+0x4dc/0x6d0 [libata]
[C0000000F4E3B9D0] [D0000000000860E0] .ata_do_eh+0x1538/0x1930 [libata]
[C0000000F4E3BC20] [D000000000083774] .ata_bmdma_drive_eh+0x1f8/0x2e8 [libata]
[C0000000F4E3BCD0] [D0000000000C17B4] .pdc2027x_error_handler+0x28/0x40 [pata_pdc2027x]
[C0000000F4E3BD50] [D000000000086DC0] .ata_scsi_error+0x32c/0x660 [libata]
[C0000000F4E3BE00] [C000000000312F7C] .scsi_error_handler+0xc8/0x80c
[C0000000F4E3BEE0] [C00000000006A0F4] .kthread+0x124/0x174
[C0000000F4E3BF90] [C000000000024D68] .kernel_thread+0x4c/0x68
Instruction dump:
57ac053e e93e8020 7f63db78 7f44d378 780007c6 7f25cb78 7f86e378 38e10070
7fbd0214 39000001 7ba0f860 78001f24 <7d69002a> 7ba0a302 7bbd4602 39200000
 done.
----------------------------------------------------------------------------

(The reference to ipr_store_update_fw is certainly not real)

The config, lspci and full boot dmesg output are available at
http://ozlabs.org/~sfr/{config,lspci,dmesg}

This machine has a only cdrom drive attached to the pdc controller.

--
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__5_Dec_2006_17_01_44_+1100_/=VtkIWOCIWV_AP3
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFdQtIFdBgD/zoJvwRAo6oAJwKOrLlQTQKfiJPcJVpk0W6LgpeMgCdF9zP
z89jW1++XUH1mT+LXus0CSA=
=cDmP
-----END PGP SIGNATURE-----

--Signature=_Tue__5_Dec_2006_17_01_44_+1100_/=VtkIWOCIWV_AP3--
