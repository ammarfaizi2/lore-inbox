Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261551AbUEAVdN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261551AbUEAVdN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 May 2004 17:33:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261580AbUEAVdN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 May 2004 17:33:13 -0400
Received: from outmx009.isp.belgacom.be ([195.238.3.4]:25550 "EHLO
	outmx009.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S261551AbUEAVdJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 May 2004 17:33:09 -0400
Subject: [OOPS 2.6.6-rc2] quota / sda1
From: FabF <Fabian.Frederick@skynet.be>
To: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1083447548.6718.12.camel@bluerhyme.real3>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 01 May 2004 23:39:10 +0200
Content-Transfer-Encoding: 7bit
X-RAVMilter-Version: 8.4.3(snapshot 20030212) (outmx009.isp.belgacom.be)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

       Using quota v2 / Linux 2.6.6-rc2 on usb storage, I've got
following results :

EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 240k freed
usb 2-1: new full speed USB device using address 2
scsi0 : SCSI emulation for USB Mass Storage devices
  Vendor: xxx   Model: xxx      Rev: 1.30
  Type:   Direct-Access                      ANSI SCSI revision: 02
SCSI device sda: 31745 512-byte hdwr sectors (16 MB)
sda: assuming Write Enabled
sda: assuming drive cache: write through
 sda: sda1
Attached scsi removable disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
USB Mass Storage device found at 2
hub 3-0:1.0: over-current change on port 2
...
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
scsi: Device offlined - not ready after error recovery: host 0 channel 0
id 0 lun 0
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 11298
Buffer I/O error on device sda1, logical block 5633
scsi0 (0:0): rejecting I/O to offline device
Buffer I/O error on device sda1, logical block 5634
Buffer I/O error on device sda1, logical block 5635
Buffer I/O error on device sda1, logical block 5636
Buffer I/O error on device sda1, logical block 5637
Buffer I/O error on device sda1, logical block 5638
Buffer I/O error on device sda1, logical block 5639
scsi0 (0:0): rejecting I/O to offline device
Buffer I/O error on device sda1, logical block 5638
scsi0 (0:0): rejecting I/O to offline device
Buffer I/O error on device sda1, logical block 5633
Buffer I/O error on device sda1, logical block 5634
Buffer I/O error on device sda1, logical block 5635
usb 2-1: USB disconnect, address 2
sd 0:0:0:0: Illegal state transition offline->cancel
Badness in scsi_device_set_state at drivers/scsi/scsi_lib.c:1640
Call Trace:
 [<c0218bdd>] scsi_device_set_state+0xcd/0x120
 [<c0214029>] scsi_device_cancel+0x29/0xf5
 [<c0214140>] scsi_device_cancel_cb+0x0/0x20
 [<c01dac79>] device_for_each_child+0x49/0x80
 [<c0214195>] scsi_host_cancel+0x35/0xb0
 [<c0214140>] scsi_device_cancel_cb+0x0/0x20
 [<c022aa82>] usb_buffer_free+0x52/0x60
 [<c021422b>] scsi_remove_host+0x1b/0x60
 [<c02423f8>] storage_disconnect+0x38/0x48
 [<c02297d8>] usb_unbind_interface+0x78/0x80
 [<c01dbb96>] device_release_driver+0x66/0x70
 [<c01dbcd4>] bus_remove_device+0x54/0xa0
 [<c01dabbd>] device_del+0x5d/0xa0
 [<c01dac13>] device_unregister+0x13/0x30
 [<c022f5e0>] usb_disable_device+0x70/0xb0
 [<c022a3c6>] usb_disconnect+0x96/0xf0
 [<c022c4c1>] hub_port_connect_change+0x281/0x290
 [<c022be53>] hub_port_status+0x43/0xb0
 [<c022c7e6>] hub_events+0x316/0x360
 [<c022c865>] hub_thread+0x35/0xf0
 [<c0114100>] default_wake_function+0x0/0x20
 [<c022c830>] hub_thread+0x0/0xf0
 [<c0103ea5>] kernel_thread_helper+0x5/0x10

It appears on both ext2/ext3 and should be scsi (emulation) relevant
only...

I tried adding usrquota in fstab after boot.It works perfectly...

Regards,
FabF



