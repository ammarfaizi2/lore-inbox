Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265056AbTLCQlt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 11:41:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265063AbTLCQlt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 11:41:49 -0500
Received: from haybaler.sackheads.org ([205.158.174.201]:47630 "EHLO
	haybaler.sackheads.org") by vger.kernel.org with ESMTP
	id S265056AbTLCQlr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 11:41:47 -0500
Date: Wed, 3 Dec 2003 11:41:46 -0500
From: Jimmie Mayfield <mayfield+kernel@sackheads.org>
To: linux-kernel@vger.kernel.org
Subject: 2.4.23 : timeouts and lost interrupts using IDE-SCSI
Message-ID: <20031203164146.GA81344@sackheads.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Since upgrading from 2.4.20 to 2.4.23, I can no longer mount my ATAPI CDROM and
CDR/W drives using IDE-SCSI.  Attempts to mount those drives result in
lost interrupts messages:

Dec  3 08:21:10 kaon kernel: scsi : aborting command due to timeout : pid 2114, scs
i2, channel 0, id 0, lun 0 Read (10) 00 00 00 00 10 00 00 01 00 
Dec  3 08:21:10 kaon kernel: hdc: DMA interrupt recovery
Dec  3 08:21:10 kaon kernel: hdc: lost interrupt


Kernel is able to successfully probe for and identify these devices, however:

Dec  3 08:20:40 kaon kernel: hdc: attached ide-scsi driver.
Dec  3 08:20:41 kaon kernel: hdd: attached ide-scsi driver.
Dec  3 08:20:41 kaon kernel: scsi2 : SCSI host adapter emulation for IDE ATAPI devi
ces
Dec  3 08:20:41 kaon kernel:   Vendor: HITACHI   Model: CDR-8430          Rev: 0024
Dec  3 08:20:41 kaon kernel:   Type:   CD-ROM                             ANSI SCSI
 revision: 02
Dec  3 08:20:41 kaon kernel:   Vendor:           Model: CD-R/RW RW7060A   Rev: 1.50
Dec  3 08:20:41 kaon kernel:   Type:   CD-ROM                             ANSI SCSI
 revision: 02
Dec  3 08:20:41 kaon kernel: Attached scsi CD-ROM sr0 at scsi2, channel 0, id 0, lu
n 0
Dec  3 08:20:41 kaon kernel: Attached scsi CD-ROM sr1 at scsi2, channel 0, id 1, lu
n 0
Dec  3 08:20:41 kaon kernel: sr0: scsi3-mmc drive: 14x/32x cd/rw xa/form2 cdda tray
Dec  3 08:20:41 kaon kernel: Uniform CD-ROM driver Revision: 3.12
Dec  3 08:20:41 kaon kernel: sr1: scsi3-mmc drive: 24x/24x writer cd/rw xa/form2 cd
da tray


I can revert back to 2.4.20 and the drives are mountable once again so I do not
believe it's a hardware failure.  Similarly, I can build 2.4.23 with IDE CDROM
support instead of relying on SCSI emulation and things work (though I suspect
not having SCSI emulation enabled will cause problems when burning CDs).


System specs:

IBM Intellistation MPro
SMP P2-400 (2 CPUs)
440BX chipset
ACPI automatically disabled "because your bios is from 98 and too old"
CDROM as hdc, CDR/W as hdd
   both these devices are attached to the onboard PIIX4 controller
kernels compiled with gcc 2.95.3


Jimmie

-- 
Jimmie Mayfield  
http://www.sackheads.org/mayfield       email: mayfield+kernel@sackheads.org
My mail provider does not welcome UCE -- http://www.sackheads.org/uce

