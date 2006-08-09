Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751365AbWHIUn3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751365AbWHIUn3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 16:43:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751366AbWHIUn3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 16:43:29 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:41393 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1751365AbWHIUn2 (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 16:43:28 -0400
Message-Id: <200608092043.k79KhKdt012789@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc3-mm2 - ext3 locking issue?
In-Reply-To: Your message of "Wed, 09 Aug 2006 13:01:51 PDT."
             <20060809130151.f1ff09eb.akpm@osdl.org>
From: Valdis.Kletnieks@vt.edu
References: <20060806030809.2cfb0b1e.akpm@osdl.org> <200608091906.k79J6Zrc009211@turing-police.cc.vt.edu>
            <20060809130151.f1ff09eb.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1155156200_4328P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 09 Aug 2006 16:43:20 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1155156200_4328P
Content-Type: text/plain; charset=us-ascii

On Wed, 09 Aug 2006 13:01:51 PDT, Andrew Morton said:

> > Yum managed to get wedged: 'echo t > /proc/sysrq-trigger' says:
> > 
> > [ 4514.840000] yum           D D5C32AA0     0  4747   4430                 
    (NOTLB)
> > [ 4514.840000]        d5c3dda4 d5c3dd78 00000007 d5c32aa0 bd3ddd00 00000338
 00000000 d5c32bc0
> > [ 4514.840000]        c1601628 d5c3dd9c 64600300 0000001f d5c3ddd8 d5c3ddd8
 c1601628 d5c3ddac
> > [ 4514.840000]        c034fef8 d5c3ddb4 c0136e8e d5c3ddcc c0350026 c0136e58
 d5c3ddd8 00000000
> > [ 4514.840000] Call Trace:
> > [ 4514.840000]  [<c034fef8>] io_schedule+0x25/0x44
> > [ 4514.840000]  [<c0136e8e>] sync_page+0x36/0x3a
> > [ 4514.840000]  [<c0350026>] __wait_on_bit_lock+0x30/0x58
> > [ 4514.840000]  [<c0136e44>] __lock_page+0x51/0x59
> > [ 4514.840000]  [<c013f099>] truncate_inode_pages_range+0x1de/0x230
> > [ 4514.840000]  [<c013f0f7>] truncate_inode_pages+0xc/0x11
> > [ 4514.840000]  [<c018ea12>] ext3_delete_inode+0x16/0xbd
> > [ 4514.840000]  [<c016798f>] generic_delete_inode+0xb6/0x130
> > [ 4514.840000]  [<c0167a1b>] generic_drop_inode+0x12/0x166
> > [ 4514.840000]  [<c01673f1>] iput+0x67/0x6a
> > [ 4514.840000]  [<c0165662>] dentry_iput+0x97/0xcc
> > [ 4514.840000]  [<c016613d>] dput+0x183/0x19c
> > [ 4514.840000]  [<c015f64f>] sys_renameat+0x17a/0x1d3
> > [ 4514.840000]  [<c015f6ba>] sys_rename+0x12/0x14
> > [ 4514.840000]  [<c0102849>] sysenter_past_esp+0x56/0x79
> > 
> > A careful check of the dmesg doesn't reveal anything particularly helpful,
> > like an oops or other relevant kernel message.
> 
> Usually this means that there's an IO request in flight and it got lost
> somewhere.  Device driver bug, IO scheduler bug, etc.  Conceivably a
> lost interrupt (hardware bug, PCI setup bug, etc).
> 
> Which device driver and which IO sched are you using?

Aug  9 13:33:13 turing-police kernel: [   11.297507] libata version 2.00 loaded.
Aug  9 13:33:14 turing-police kernel: [   11.297763] ata_piix 0000:00:1f.1: version 2.00ac6
Aug  9 13:33:14 turing-police kernel: [   11.297780] PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
Aug  9 13:33:14 turing-police kernel: [   11.299245] ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
Aug  9 13:33:14 turing-police kernel: [   11.299786] ACPI: PCI Interrupt 0000:00:1f.1[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
Aug  9 13:33:14 turing-police kernel: [   11.300638] PCI: Setting latency timer of device 0000:00:1f.1 to 64
Aug  9 13:33:15 turing-police kernel: [   11.300720] ata1: PATA max UDMA/100 cmd 0x1F0 ctl 0x3F6 bmdma 0xBFA0 irq 14
Aug  9 13:33:15 turing-police kernel: [   11.301381] scsi0 : ata_piix
...

Disk was running with 'cfq' scheduler.  I checked the dmesg, and only odd thing
was this:

Aug  9 14:30:24 turing-police kernel: [ 3535.720000] end_request: I/O error, dev fd0, sector 0

Wierd though - floppy and ATA are on different IRQs according to /proc/interrupts:

           CPU0       
  0:   11122651    XT-PIC-level    timer
  1:      12532    XT-PIC-level    i8042
  2:          0    XT-PIC-level    cascade
  5:     190651    XT-PIC-level    Intel 82801CA-ICH3
  6:          5    XT-PIC-level    floppy
  8:          1    XT-PIC-level    rtc
  9:          1    XT-PIC-level    acpi
 11:     238728    XT-PIC-level    uhci_hcd:usb1, uhci_hcd:usb2, uhci_hcd:usb3, yenta, yenta, yenta, ohci1394, pcmcia2.0, eth3
 12:        114    XT-PIC-level    i8042
 14:     172656    XT-PIC-level    libata
 15:          0    XT-PIC-level    libata
NMI:          0 
LOC:          0 
ERR:          1
MIS:          0

(For the record, the laptop doesn't even *have* a floppy drive installed at the
moment)


--==_Exmh_1155156200_4328P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFE2kjocC3lWbTT17ARAuTDAKCEO/nfv4Uxs7Lzh0+Y/33AY7nYdQCguKB4
Hn4iYf8MgOiP0GylVmDDo9c=
=3Y8D
-----END PGP SIGNATURE-----

--==_Exmh_1155156200_4328P--
