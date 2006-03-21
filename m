Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932245AbWCUBFk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932245AbWCUBFk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 20:05:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932258AbWCUBFj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 20:05:39 -0500
Received: from test-iport-1.cisco.com ([171.71.176.117]:51576 "EHLO
	test-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S932245AbWCUBFi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 20:05:38 -0500
To: linux-kernel@vger.kernel.org
Subject: nommu_map_sg: overflow with ata_piix?
X-Message-Flag: Warning: May contain useful information
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 20 Mar 2006 17:05:35 -0800
Message-ID: <adawteoa9pc.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 21 Mar 2006 01:05:36.0815 (UTC) FILETIME=[9011CBF0:01C64C83]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just got a new dual Xeon system with 4 GB of RAM and SATA drives.
It boots fine with Debian's 2.6.15 kernel, but I just tried building a
kernel from an up-to-date Linus tree, and I get the following on boot:

scsi0 : ata_piix
ATA: abnormal status 0x7F on port 0x405F
scsi1 : ata_piix
  Vendor: ATA       Model: Maxtor 6L080M0    Rev: BACE
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
sda: Write Protect is off
SCSI device sda: drive cache: write through
SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
sda: Write Protect is off
SCSI device sda: drive cache: write through
 sda:<3>nommu_map_sg: overflow 11b8a9000+4096 of device mask ffffffff
nommu_map_sg: overflow 11b8a9000+4096 of device mask ffffffff
nommu_map_sg: overflow 11b8a9000+4096 of device mask ffffffff
nommu_map_sg: overflow 11b8a9000+4096 of device mask ffffffff
nommu_map_sg: overflow 11b8a9000+4096 of device mask ffffffff
nommu_map_sg: overflow 11b8a9000+4096 of device mask ffffffff
sd 0:0:0:0: SCSI error: return code = 0x70000

and then of course it panics because it can't find the root partition.

Some RAM is being remapped above 4 GB:

BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000dfff3000 (usable)
 BIOS-e820: 00000000dfff3000 - 00000000dfffb000 (ACPI data)
 BIOS-e820: 00000000dfffb000 - 00000000e0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fed00000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
 BIOS-e820: 00000000ffc00000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 000000011bfff000 (usable)

Any suggestions?  I can provide more debugging info if required.

Thanks,
  Roland
