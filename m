Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261264AbVAUADj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261264AbVAUADj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 19:03:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261500AbVAUADj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 19:03:39 -0500
Received: from pop-a065c10.pas.sa.earthlink.net ([207.217.121.184]:18315 "EHLO
	pop-a065c10.pas.sa.earthlink.net") by vger.kernel.org with ESMTP
	id S261264AbVAUADG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 19:03:06 -0500
From: John Mock <kd6pag@qsl.net>
To: linux-kernel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>
cc: greg@kroah.com
Subject: SCSI oops in 2.6.10 [was: usb-storage oops (PowerMac 8500/G3)]
Message-Id: <E1CrmGP-000135-00@penngrove.fdns.net>
Date: Thu, 20 Jan 2005 16:02:57 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry about the confusion, but it appears the 'oops' is not specific to
the USB subsystem, as it seems also to occur with an ordinary SCSI module
as well under 2.6.10 (PPC).  In this case, it's a ZIP drive connected via
'mac53c94' module, and in addition to, as noted before, the same problem
with USB digital camera and an IOMEGA CD/RW drive (see earlier posting 
"2.6.11-rc1 vs. PowerMac 8500/G3 (and VAIO laptop) [usb-storage oops]").

Additional details gladly provided upon request.

				 -- JM

Attachments: SCSI oops from 'mac53c94'
	     Example of usb-storage variant of same/similar 'oops'
-------------------------------------------------------------------------------
	...
scsi1 : 53C94
  Vendor: IOMEGA    Model: ZIP 100           Rev: C.18
  Type:   Direct-Access                      ANSI SCSI revision: 02
Oops: kernel access of bad area, sig: 11 [#1]
PREEMPT 
NIP: C009ABA4 LR: C009ABA4 SP: CC467C40 REGS: cc467b90 TRAP: 0600    Not tainted
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 6B6B6BD7, DSISR: 00000000
TASK = cd3b4b30[1094] 'modprobe' THREAD: cc466000
Last syscall: 120 
GPR00: C009ABA4 CC467C40 CD3B4B30 C01AADE0 00000047 00000047 CC467C78 0000000A 
GPR08: FFFFFFFF 00008000 CDC2A6AC CC467C40 42002448 1001E284 100013A4 00000000 
GPR16: 00000000 00000000 00000000 00000000 100013A4 100186E0 00000000 CC467D98 
GPR24: CC467D9C 00000001 00000000 CCC84994 CC467C78 CC40941C CCC84998 6B6B6BD7 
NIP [c009aba4] create_dir+0x38/0x1d0
LR [c009aba4] create_dir+0x38/0x1d0
Call trace:
 [c009ad98] sysfs_create_dir+0x48/0x94
 [c00ad688] create_dir+0x28/0x6c
 [c00ad98c] kobject_add+0x5c/0x15c
 [c00eaa40] device_add+0xb8/0x18c
 [c0111f9c] scsi_sysfs_add_sdev+0x78/0x39c
 [c01107c4] scsi_add_lun+0x2f8/0x364
 [c011091c] scsi_probe_and_add_lun+0xec/0x1d8
 [c0111110] scsi_scan_target+0x7c/0xec
 [c01111fc] scsi_scan_channel+0x7c/0x9c
 [c01112f4] scsi_scan_host_selected+0xd8/0x138
 [cf854b40] mac53c94_probe+0x208/0x26c [mac53c94]
 [c0103fd4] macio_device_probe+0x80/0x9c
 [c00ebfec] driver_probe_device+0x4c/0xa0
 [c00ec184] driver_attach+0x88/0xc8
 [c00ec7c8] bus_add_driver+0xd0/0x11c
-------------------------------------------------------------------------------
Jan 19 15:17:58 penngrove kernel:   Vendor: NIKON     Model: NIKON DSC E4500   Rev: 1.00
Jan 19 15:17:58 penngrove kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
Jan 19 15:17:58 penngrove kernel: input: Logitech N48 on usb-0000:00:0e.0-1
Jan 19 15:17:58 penngrove kernel: hub 4-0:1.0: port 2, status 0100, change 0000, 12 Mb/s
Jan 19 15:17:58 penngrove kernel: Oops: kernel access of bad area, sig: 11 [#1]
Jan 19 15:17:58 penngrove kernel: PREEMPT 
Jan 19 15:17:58 penngrove kernel: NIP: C009BF14 LR: C009BF14 SP: CCF63DC0 REGS: ccf63d10 TRAP: 0300    Not tainted
Jan 19 15:17:58 penngrove kernel: MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
Jan 19 15:17:58 penngrove kernel: DAR: 00000074, DSISR: 40000000
Jan 19 15:17:58 penngrove kernel: TASK = ccb5ebf0[1651] 'usb-stor-scan' THREAD: ccf62000
Jan 19 15:17:58 penngrove kernel: Last syscall: -1 
Jan 19 15:17:58 penngrove kernel: GPR00: C009BF14 CCF63DC0 CCB5EBF0 C01AF674 00000047 00000047 CCF63DF8 0000000A 
Jan 19 15:17:58 penngrove kernel: GPR08: FFFFFFFF 00008000 CC9185C8 CCF63DC0 42002448 1001E284 100013A4 00000000 
Jan 19 15:17:58 penngrove kernel: GPR16: 00000000 00000000 00000000 00000000 100013A4 100187C0 00000000 CCF63F18 
Jan 19 15:17:58 penngrove kernel: GPR24: CCF63F1C 00000001 00000000 CCC61184 CCF63DF8 CCC1EE84 CCC61188 00000074 
Jan 19 15:17:58 penngrove kernel: NIP [c009bf14] create_dir+0x38/0x1d0
Jan 19 15:17:58 penngrove kernel: LR [c009bf14] create_dir+0x38/0x1d0
Jan 19 15:17:58 penngrove kernel: Call trace:
Jan 19 15:17:58 penngrove kernel:  [c009c108] sysfs_create_dir+0x48/0x94
Jan 19 15:17:58 penngrove kernel:  [c00ae97c] create_dir+0x28/0x6c
Jan 19 15:17:58 penngrove kernel:  [c00aec80] kobject_add+0x5c/0x15c
Jan 19 15:17:58 penngrove kernel:  [c00ec960] device_add+0xc4/0x19c
Jan 19 15:17:58 penngrove kernel:  [c0114590] scsi_sysfs_add_sdev+0x78/0x3a4
Jan 19 15:17:58 penngrove kernel:  [c0112a88] scsi_add_lun+0x2f8/0x364
Jan 19 15:17:58 penngrove kernel:  [c0112be0] scsi_probe_and_add_lun+0xec/0x1fc
Jan 19 15:17:58 penngrove kernel:  [c0113414] scsi_scan_target+0x7c/0xec
Jan 19 15:17:58 penngrove kernel:  [c0113500] scsi_scan_channel+0x7c/0x9c
Jan 19 15:17:58 penngrove kernel:  [c01135f8] scsi_scan_host_selected+0xd8/0x138
Jan 19 15:17:58 penngrove kernel:  [cfb04dc0] usb_stor_scan_thread+0x6c/0x124 [usb_storage]
Jan 19 15:17:58 penngrove kernel:  [c00066c4] kernel_thread+0x44/0x60
===============================================================================
