Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261685AbVB1Qvw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261685AbVB1Qvw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 11:51:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261694AbVB1QuM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 11:50:12 -0500
Received: from mail-in-08.arcor-online.net ([151.189.21.48]:34001 "EHLO
	mail-in-08.arcor-online.net") by vger.kernel.org with ESMTP
	id S261685AbVB1Qqs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 11:46:48 -0500
Message-ID: <42234B1C.1080500@arcor.de>
Date: Mon, 28 Feb 2005 17:47:24 +0100
From: Prakash Punnoor <prakashp@arcor.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050222)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: 2.6.11-rc5: sata_sil shows drive twice...
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig9B0D2A627EF7DA39908A26D7"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9B0D2A627EF7DA39908A26D7
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

hi,

dmesg shows this:


-- ACPI: PCI Interrupt Link [APC3] enabled at IRQ 18
ACPI: PCI interrupt 0000:01:0b.0[A] -> GSI 18 (level, high) -> IRQ 18
ata1: SATA max UDMA/100 cmd 0xF0806080 ctl 0xF080608A bmdma 0xF0806000 irq 18
ata2: SATA max UDMA/100 cmd 0xF08060C0 ctl 0xF08060CA bmdma 0xF0806008 irq 18
ata1: dev 0 cfg 49:2f00 82:346b 83:7f01 84:4003 85:3c69 86:3c01 87:4003 88:20ff
ata1: dev 0 ATA, max UDMA7, 156368016 sectors: lba48
ata1: dev 0 configured for UDMA/100
scsi0 : sata_sil
ata2: no device found (phy stat 00000000)
scsi1 : sata_sil
  Vendor: ATA       Model: SAMSUNG SP0812C   Rev: SU10
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 156368016 512-byte hdwr sectors (80060 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 156368016 512-byte hdwr sectors (80060 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 sda4 < sda5 >
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0


but I only have one physical drive attached. I don't seem to have problems
though. Yesterday I got an oops, but I don't know whether it is connected. I
copied it here just in case.

I don't know whether rc4 or earlier showed this beahaviour. I am sure that
2.6.10 didn't show it.

If you need more info, just shout...

Here the oops:

nable to handle kernel paging request at virtual address 3ce0d5d8
 printing eip:
b0187fe1
*pde = 00000000
Oops: 0000 [#1]
PREEMPT
Modules linked in: nvidia
CPU:    0
EIP:    0060:[<b0187fe1>]    Tainted: P      VLI
EFLAGS: 00010206   (2.6.11-rc5-ck1)
EIP is at do_task_stat+0x1a1/0x7a0
eax: 00000000   ebx: 3ce0d528   ecx: ef1af2e0   edx: 00000001
esi: e282a590   edi: 00000001   ebp: 00000000   esp: e8dbbe10
ds: 007b   es: 007b   ss: 0068
Process gkrellm2 (pid: 13551, threadinfo=e8dba000 task=e807daa0)
Stack: d1a89000 b047fcec 00001784 e8dbbf4c 00000053 0000177f 00007ff8 00007623
       00008802 00007ff8 00802000 00000249 0000f602 00000000 00000000 00000000
       00000000 00000d82 00000048 0000001e 0000000a 00000001 00000000 000eea81
Call Trace:
 [<b016e9cf>] __d_lookup+0x10f/0x190
 [<b01856d3>] task_dumpable+0x33/0x60
 [<b0185807>] pid_revalidate+0x37/0xe0
 [<b0163d2d>] do_lookup+0x5d/0x90
 [<b016d559>] dput+0x99/0x280
 [<b0129808>] in_group_p+0x38/0x80
 [<b0184c80>] proc_info_read+0x50/0x90
 [<b0156086>] vfs_read+0x126/0x130
 [<b0156311>] sys_read+0x41/0x70
 [<b0103119>] sysenter_past_esp+0x52/0x75
Code: 00 00 00 e8 82 f1 f8 ff 8b 86 70 04 00 00 85 c0 0f 85 5a 05 00 00 8b 8e
6c 04 00 00 85 c9 0f 84 ba 00 00 00 8b 59 50 85 db 74 3b <8b> 83 b0 00 00 00
89 84 24 0c 01 00 00 8b 43 04 8b 50 64 c1 e2
 <6>note: gkrellm2[13551] exited with preempt_count 1
scheduling while atomic: gkrellm2/0x10000001/13551
 [<b045b235>] schedule+0x405/0x4c0
 [<b0145017>] unmap_page_range+0x67/0x90
 [<b045bb8a>] cond_resched+0x2a/0x50
 [<b0145259>] unmap_vmas+0x219/0x240
 [<b014a026>] exit_mmap+0x76/0x160
 [<b0118772>] mmput+0x32/0xb0
 [<b011d301>] do_exit+0xb1/0x3f0
 [<b010430b>] die+0x17b/0x180
 [<b0114f00>] do_page_fault+0x0/0x586
 [<b0114f00>] do_page_fault+0x0/0x586
 [<b01152a5>] do_page_fault+0x3a5/0x586
 [<b0113239>] set_ioapic_affinity_irq+0x79/0xa0
 [<b0123c7b>] run_timer_softirq+0x12b/0x1e0
 [<b0107bb5>] timer_interrupt+0x85/0x160
 [<b02aa817>] vsnprintf+0x2e7/0x510
 [<b0114f00>] do_page_fault+0x0/0x586
 [<b0103b83>] error_code+0x2b/0x30
 [<b0187fe1>] do_task_stat+0x1a1/0x7a0
 [<b016e9cf>] __d_lookup+0x10f/0x190
 [<b01856d3>] task_dumpable+0x33/0x60
 [<b0185807>] pid_revalidate+0x37/0xe0
 [<b0163d2d>] do_lookup+0x5d/0x90
 [<b016d559>] dput+0x99/0x280
 [<b0129808>] in_group_p+0x38/0x80
 [<b0184c80>] proc_info_read+0x50/0x90
 [<b0156086>] vfs_read+0x126/0x130
 [<b0156311>] sys_read+0x41/0x70
 [<b0103119>] sysenter_past_esp+0x52/0x75



Cheers.

Prakash Punnoor

formerly known as Prakash K. Cheemplavam

--------------enig9B0D2A627EF7DA39908A26D7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCI0scxU2n/+9+t5gRApRzAJ4oO6wgn0oADkjZmWKrN/KliJQD8QCgjrXy
/r+Qrn9etPIMWSyFH09sKkY=
=3A0Z
-----END PGP SIGNATURE-----

--------------enig9B0D2A627EF7DA39908A26D7--
