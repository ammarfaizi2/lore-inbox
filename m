Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263279AbTDRWaG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 18:30:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263284AbTDRWaG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 18:30:06 -0400
Received: from anor.ics.muni.cz ([147.251.4.35]:10943 "EHLO anor.ics.muni.cz")
	by vger.kernel.org with ESMTP id S263279AbTDRWaF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 18:30:05 -0400
To: linux-kernel@vger.kernel.org
Subject: Oops in ide_xlate_1024 in 2.5.67-ac2
X-URL: http://www.fi.muni.cz/~pekon/
From: Petr Konecny <pekon@informatics.muni.cz>
Date: 19 Apr 2003 00:42:02 +0200
Message-ID: <qwwr87z1l8l.fsf@decibel.fi.muni.cz>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Portable Code)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am getting the appended oops. It happens after I plug in USB storage
device and sd_mod gets modprobed by hotplug. It checks partitions on the
disk and oopses during that. It looks similar to the bug reported here:
http://www.ussg.iu.edu/hypermail/linux/kernel/0302.2/1305.html

                                                Petr

 hub 1-0:0: debounce: port 1: delay 100ms stable 4 status 0x101
 hub 1-0:0: new USB device on port 1, assigned address 2
 SCSI subsystem initialized
 Initializing USB Mass Storage driver...
 scsi0 : SCSI emulation for USB Mass Storage devices
   Vendor: IC25N040  Model: ATCS04-0          Rev: CA4O
   Type:   Direct-Access                      ANSI SCSI revision: 02
 drivers/usb/core/usb.c: registered new driver usb-storage
 USB Mass Storage support registered.
 SCSI device sda: 78140160 512-byte hdwr sectors (40008 MB)
 SCSI device sda: drive cache: write through
  /dev/scsi/host0/bus0/target0/lun0:<1>Unable to handle kernel NULL pointer dereference at virtual address 00000030
  printing eip:
 c021043e
 Oops: 0002 [#1]
 CPU:    0
 EIP:    0060:[ide_xlate_1024+190/496]    Not tainted
 EFLAGS: 00010246
 EIP is at ide_xlate_1024+0xbe/0x1f0
 eax: 00000000   ebx: 00000000   ecx: 00000000   edx: c8051e70
 esi: c8051e70   edi: 00000003   ebp: c6d05e08   esp: c6d05dcc
 ds: 007b   es: 007b   ss: 0068
 Process modprobe (pid: 695, threadinfo=c6d04000 task=cb21e700)
 Stack: c8051e70 00000000 000000d0 00000001 00000000 c6d05e20 00000000 00000000 
        c02f9432 00000000 
 Call Trace:
  [blkdev_readpage+0/32] blkdev_readpage+0x0/0x20
  [handle_ide_mess+245/640] handle_ide_mess+0xf5/0x280
  [msdos_partition+60/928] msdos_partition+0x3c/0x3a0
  [vsprintf+39/48] vsprintf+0x27/0x30
  [sprintf+31/48] sprintf+0x1f/0x30
  [check_partition+194/384] check_partition+0xc2/0x180
  [register_disk+207/368] register_disk+0xcf/0x170
  [blk_register_region+138/256] blk_register_region+0x8a/0x100
  [add_disk+81/96] add_disk+0x51/0x60
  [exact_match+0/16] exact_match+0x0/0x10
  [exact_lock+0/32] exact_lock+0x0/0x20
  [<cd1256e4>] sd_attach+0x1b4/0x270 [sd_mod]
  [<cd126d20>] +0x0/0xe0 [sd_mod]
  [driver_register+58/64] driver_register+0x3a/0x40
  [<cd15e3f9>] scsi_register_device+0xc9/0x100 [scsi_mod]
  [<cd126d20>] +0x0/0xe0 [sd_mod]
  [<cd111052>] +0x52/0x66 [sd_mod]
  [<cd126c60>] sd_template+0x0/0x90 [sd_mod]
  [<cd125ad9>] +0x5/0x10c [sd_mod]
  [sys_init_module+305/512] sys_init_module+0x131/0x200
  [<cd126d20>] +0x0/0xe0 [sd_mod]
  [syscall_call+7/11] syscall_call+0x7/0xb
 
 Code: 89 43 30 8b 55 dc 85 d2 75 0b 8b 45 dc 83 c4 30 5b 5e 5f 5d 
