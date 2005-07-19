Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261575AbVGSQyU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261575AbVGSQyU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 12:54:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261578AbVGSQyU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 12:54:20 -0400
Received: from opersys.com ([64.40.108.71]:60425 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261575AbVGSQxo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 12:53:44 -0400
Message-ID: <42DD2EA4.5040507@opersys.com>
Date: Tue, 19 Jul 2005 12:47:32 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Weird USB errors on HD
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have a usb-attached HD that I use from time to time. When it's connected
to my desktop through a hub it works flawlessly. When connected to my Dell
D600 Laptop, however, it sometimes randomly exhibits a loud click (as if the
heads went berzerk) and the device goes unrecognized (i.e. the USB layer drops
the device and then redetects it again; meanwhile there is FS corruption.)

The same behavior happens with 2.4.x and 2.6.x

In /var/log/messages I see something like:
hub 3-0:1.0: over-current change on port 1
hub 1-0:1.0: over-current change on port 3
...
usb 1-3: USB disconnect, address 2
usb 1-3: new high speed USB device using ehci_hcd and address 3
...
usb-storage: device found at 3
usb-storage: waiting for device to settle before scanning

This doesn't seem too good.

Here's the complete passage from /var/log/messages:
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 384296
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 384296
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 384296
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 384296
EXT3-fs error (device sda): ext3_free_branches: Read failure, inode=1046532, block=48037
Aborting journal on device sda.
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 4176
printk: 813 messages suppressed.
Buffer I/O error on device sda, logical block 522
lost page write due to I/O error on sda
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 0
Buffer I/O error on device sda, logical block 0
lost page write due to I/O error on sda
EXT3-fs error (device sda) in ext3_reserve_inode_write: Journal has aborted
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 0
Buffer I/O error on device sda, logical block 0
lost page write due to I/O error on sda
EXT3-fs error (device sda) in ext3_reserve_inode_write: Journal has aborted
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 0
Buffer I/O error on device sda, logical block 0
lost page write due to I/O error on sda
EXT3-fs error (device sda) in ext3_orphan_del: Journal has aborted
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 0
Buffer I/O error on device sda, logical block 0
lost page write due to I/O error on sda
EXT3-fs error (device sda) in ext3_truncate: Journal has aborted
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 0
Buffer I/O error on device sda, logical block 0
lost page write due to I/O error on sda
ext3_abort called.
EXT3-fs error (device sda): ext3_journal_start_sb: Detected aborted journal
Remounting filesystem read-only
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 3254080
hub 3-0:1.0: over-current change on port 1
hub 1-0:1.0: over-current change on port 3
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 3254088
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 3254096
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 3254104
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 3254088
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 3254088
usb 1-3: USB disconnect, address 2
scsi0 (0:0): rejecting I/O to device being removed
Buffer I/O error on device sda, logical block 458754
lost page write due to I/O error on sda
scsi0 (0:0): rejecting I/O to device being removed
Buffer I/O error on device sda, logical block 517070
lost page write due to I/O error on sda
scsi0 (0:0): rejecting I/O to device being removed
Buffer I/O error on device sda, logical block 1
lost page write due to I/O error on sda
scsi0 (0:0): rejecting I/O to device being removed
Buffer I/O error on device sda, logical block 393218
lost page write due to I/O error on sda
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to dead device
EXT3-fs error (device sda): ext3_find_entry: reading directory #228929 offset 0
scsi0 (0:0): rejecting I/O to dead device
EXT3-fs error (device sda): ext3_find_entry: reading directory #1046529 offset 0
usb 1-3: new high speed USB device using ehci_hcd and address 3
scsi1 : SCSI emulation for USB Mass Storage devices
usb-storage: device found at 3
usb-storage: waiting for device to settle before scanning
scsi0 (0:0): rejecting I/O to dead device
EXT3-fs error (device sda): ext3_find_entry: reading directory #196225 offset 0
scsi0 (0:0): rejecting I/O to dead device
EXT3-fs error (device sda): ext3_find_entry: reading directory #228929 offset 0
scsi0 (0:0): rejecting I/O to dead device
EXT3-fs error (device sda): ext3_find_entry: reading directory #196225 offset 0
scsi0 (0:0): rejecting I/O to dead device
EXT3-fs error (device sda): ext3_find_entry: reading directory #228929 offset 0
scsi0 (0:0): rejecting I/O to dead device
EXT3-fs error (device sda): ext3_find_entry: reading directory #228929 offset 0
scsi0 (0:0): rejecting I/O to dead device
EXT3-fs error (device sda): ext3_find_entry: reading directory #228929 offset 0
scsi0 (0:0): rejecting I/O to dead device
EXT3-fs error (device sda): ext3_find_entry: reading directory #228929 offset 0
scsi0 (0:0): rejecting I/O to dead device
EXT3-fs error (device sda): ext3_find_entry: reading directory #228929 offset 0
scsi0 (0:0): rejecting I/O to dead device
EXT3-fs error (device sda): ext3_find_entry: reading directory #228929 offset 0
scsi0 (0:0): rejecting I/O to dead device
EXT3-fs error (device sda): ext3_find_entry: reading directory #228929 offset 0
scsi0 (0:0): rejecting I/O to dead device
EXT3-fs error (device sda): ext3_find_entry: reading directory #228929 offset 0
scsi0 (0:0): rejecting I/O to dead device
EXT3-fs error (device sda): ext3_find_entry: reading directory #228929 offset 0
scsi0 (0:0): rejecting I/O to dead device
EXT3-fs error (device sda): ext3_find_entry: reading directory #277985 offset 0
scsi0 (0:0): rejecting I/O to dead device
EXT3-fs error (device sda): ext3_find_entry: reading directory #277985 offset 0
scsi0 (0:0): rejecting I/O to dead device
EXT3-fs error (device sda): ext3_find_entry: reading directory #277985 offset 0
scsi0 (0:0): rejecting I/O to dead device
EXT3-fs error (device sda): ext3_find_entry: reading directory #277985 offset 0
scsi0 (0:0): rejecting I/O to dead device
EXT3-fs error (device sda): ext3_find_entry: reading directory #277985 offset 0
scsi0 (0:0): rejecting I/O to dead device
EXT3-fs error (device sda): ext3_find_entry: reading directory #277985 offset 0
scsi0 (0:0): rejecting I/O to dead device
EXT3-fs error (device sda): ext3_find_entry: reading directory #277985 offset 0
scsi0 (0:0): rejecting I/O to dead device
EXT3-fs error (device sda): ext3_find_entry: reading directory #277985 offset 0
scsi0 (0:0): rejecting I/O to dead device
EXT3-fs error (device sda): ext3_find_entry: reading directory #277985 offset 0
scsi0 (0:0): rejecting I/O to dead device
EXT3-fs error (device sda): ext3_find_entry: reading directory #277985 offset 0
scsi0 (0:0): rejecting I/O to dead device
EXT3-fs error (device sda): ext3_find_entry: reading directory #277985 offset 0
scsi0 (0:0): rejecting I/O to dead device
EXT3-fs error (device sda): ext3_find_entry: reading directory #277985 offset 0
scsi0 (0:0): rejecting I/O to dead device
EXT3-fs error (device sda): ext3_find_entry: reading directory #277985 offset 0
scsi0 (0:0): rejecting I/O to dead device
EXT3-fs error (device sda): ext3_find_entry: reading directory #277985 offset 0
scsi0 (0:0): rejecting I/O to dead device
EXT3-fs error (device sda): ext3_find_entry: reading directory #228929 offset 0
scsi0 (0:0): rejecting I/O to dead device
EXT3-fs error (device sda): ext3_find_entry: reading directory #228929 offset 0
scsi0 (0:0): rejecting I/O to dead device
EXT3-fs error (device sda): ext3_find_entry: reading directory #228929 offset 0
scsi0 (0:0): rejecting I/O to dead device
EXT3-fs error (device sda): ext3_find_entry: reading directory #228929 offset 0
scsi0 (0:0): rejecting I/O to dead device
EXT3-fs error (device sda): ext3_find_entry: reading directory #228929 offset 0
scsi0 (0:0): rejecting I/O to dead device
EXT3-fs error (device sda): ext3_find_entry: reading directory #228929 offset 0
scsi0 (0:0): rejecting I/O to dead device
EXT3-fs error (device sda): ext3_find_entry: reading directory #228929 offset 0
scsi0 (0:0): rejecting I/O to dead device
EXT3-fs error (device sda): ext3_find_entry: reading directory #1046529 offset 0
scsi0 (0:0): rejecting I/O to dead device
EXT3-fs error (device sda): ext3_find_entry: reading directory #1046529 offset 0
scsi0 (0:0): rejecting I/O to dead device
EXT3-fs error (device sda): ext3_find_entry: reading directory #1046529 offset 0
scsi0 (0:0): rejecting I/O to dead device
EXT3-fs error (device sda): ext3_find_entry: reading directory #1046529 offset 0
scsi0 (0:0): rejecting I/O to dead device
EXT3-fs error (device sda): ext3_find_entry: reading directory #1046529 offset 0
scsi0 (0:0): rejecting I/O to dead device
EXT3-fs error (device sda): ext3_find_entry: reading directory #1046529 offset 0
scsi0 (0:0): rejecting I/O to dead device
EXT3-fs error (device sda): ext3_find_entry: reading directory #1046529 offset 0
scsi0 (0:0): rejecting I/O to dead device
EXT3-fs error (device sda): ext3_find_entry: reading directory #1046529 offset 0
scsi0 (0:0): rejecting I/O to dead device
EXT3-fs error (device sda): ext3_find_entry: reading directory #1046529 offset 0
scsi0 (0:0): rejecting I/O to dead device
EXT3-fs error (device sda): ext3_find_entry: reading directory #1046529 offset 0
scsi0 (0:0): rejecting I/O to dead device
EXT3-fs error (device sda): ext3_find_entry: reading directory #1046529 offset 0
scsi0 (0:0): rejecting I/O to dead device
EXT3-fs error (device sda): ext3_find_entry: reading directory #1046529 offset 0
scsi0 (0:0): rejecting I/O to dead device
EXT3-fs error (device sda): ext3_find_entry: reading directory #1046529 offset 0
scsi0 (0:0): rejecting I/O to dead device
EXT3-fs error (device sda): ext3_find_entry: reading directory #1046529 offset 0
scsi0 (0:0): rejecting I/O to dead device
EXT3-fs error (device sda): ext3_find_entry: reading directory #1046529 offset 0
scsi0 (0:0): rejecting I/O to dead device
EXT3-fs error (device sda): ext3_find_entry: reading directory #1046529 offset 0
scsi0 (0:0): rejecting I/O to dead device
EXT3-fs error (device sda): ext3_find_entry: reading directory #1046529 offset 0
scsi0 (0:0): rejecting I/O to dead device
EXT3-fs error (device sda): ext3_find_entry: reading directory #1046529 offset 0
scsi0 (0:0): rejecting I/O to dead device
EXT3-fs error (device sda): ext3_find_entry: reading directory #1046529 offset 0
scsi0 (0:0): rejecting I/O to dead device
EXT3-fs error (device sda): ext3_find_entry: reading directory #1046529 offset 0
scsi0 (0:0): rejecting I/O to dead device
EXT3-fs error (device sda): ext3_find_entry: reading directory #1046529 offset 0
scsi0 (0:0): rejecting I/O to dead device
EXT3-fs error (device sda): ext3_find_entry: reading directory #1046529 offset 0
scsi0 (0:0): rejecting I/O to dead device
EXT3-fs error (device sda): ext3_find_entry: reading directory #1046529 offset 0
scsi0 (0:0): rejecting I/O to dead device
EXT3-fs error (device sda): ext3_find_entry: reading directory #1046529 offset 0
scsi0 (0:0): rejecting I/O to dead device
EXT3-fs error (device sda): ext3_find_entry: reading directory #1046529 offset 0
scsi0 (0:0): rejecting I/O to dead device
EXT3-fs error (device sda): ext3_find_entry: reading directory #1046529 offset 0
scsi0 (0:0): rejecting I/O to dead device
EXT3-fs error (device sda): ext3_find_entry: reading directory #228929 offset 0
scsi0 (0:0): rejecting I/O to dead device
EXT3-fs error (device sda): ext3_find_entry: reading directory #228929 offset 0
scsi0 (0:0): rejecting I/O to dead device
EXT3-fs error (device sda): ext3_find_entry: reading directory #228929 offset 0
scsi0 (0:0): rejecting I/O to dead device
EXT3-fs error (device sda): ext3_find_entry: reading directory #196225 offset 0
scsi0 (0:0): rejecting I/O to dead device
EXT3-fs error (device sda): ext3_find_entry: reading directory #212577 offset 0
scsi0 (0:0): rejecting I/O to dead device
EXT3-fs error (device sda): ext3_find_entry: reading directory #212577 offset 0
scsi0 (0:0): rejecting I/O to dead device
EXT3-fs error (device sda): ext3_find_entry: reading directory #196225 offset 0
scsi0 (0:0): rejecting I/O to dead device
EXT3-fs error (device sda): ext3_find_entry: reading directory #163521 offset 0
scsi0 (0:0): rejecting I/O to dead device
EXT3-fs error (device sda): ext3_find_entry: reading directory #163521 offset 0
  Vendor: FUJITSU   Model: MHT2040AT         Rev: 0022
  Type:   Direct-Access                      ANSI SCSI revision: 00
SCSI device sdb: 78140160 512-byte hdwr sectors (40008 MB)
sdb: assuming drive cache: write through
SCSI device sdb: 78140160 512-byte hdwr sectors (40008 MB)
sdb: assuming drive cache: write through
 sdb: unknown partition table
Attached scsi disk sdb at scsi1, channel 0, id 0, lun 0
usb-storage: device scan complete
scsi0 (0:0): rejecting I/O to dead device
EXT3-fs error (device sda): ext3_find_entry: reading directory #163521 offset 0
scsi0 (0:0): rejecting I/O to dead device
EXT3-fs error (device sda): ext3_find_entry: reading directory #163521 offset 0
scsi0 (0:0): rejecting I/O to dead device
EXT3-fs error (device sda): ext3_readdir: directory #2 contains a hole at offset 0
scsi0 (0:0): rejecting I/O to dead device
EXT3-fs error (device sda): ext3_readdir: directory #2 contains a hole at offset 0
scsi0 (0:0): rejecting I/O to dead device
printk: 5 messages suppressed.
Buffer I/O error on device sda, logical block 522
lost page write due to I/O error on sda
usb 1-3: USB disconnect, address 3
usb 1-3: new high speed USB device using ehci_hcd and address 4
scsi2 : SCSI emulation for USB Mass Storage devices
usb-storage: device found at 4
usb-storage: waiting for device to settle before scanning
  Vendor: FUJITSU   Model: MHT2040AT         Rev: 0022
  Type:   Direct-Access                      ANSI SCSI revision: 00
SCSI device sda: 78140160 512-byte hdwr sectors (40008 MB)
sda: assuming drive cache: write through
SCSI device sda: 78140160 512-byte hdwr sectors (40008 MB)
sda: assuming drive cache: write through
 sda: unknown partition table
Attached scsi disk sda at scsi2, channel 0, id 0, lun 0
usb-storage: device scan complete
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda, internal journal
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
usb 1-3: USB disconnect, address 4

Any chances someone has seen this before or if there's something I can do
to stop this from happening anymore?

Thanks,

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
