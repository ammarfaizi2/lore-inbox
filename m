Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263322AbTDRXQB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 19:16:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263323AbTDRXQB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 19:16:01 -0400
Received: from nika.frontier.iarc.uaf.edu ([137.229.94.16]:1664 "EHLO
	nika.frontier.iarc.uaf.edu") by vger.kernel.org with ESMTP
	id S263322AbTDRXP6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 19:15:58 -0400
Date: Fri, 18 Apr 2003 15:27:56 -0800
From: Christopher Swingley <cswingle@iarc.uaf.edu>
To: linux-kernel@vger.kernel.org
Subject: 2.5.67 oops upon removing USB flash drive
Message-ID: <20030418232756.GA831@iarc.uaf.edu>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-gpg-fingerprint: B96C 58DC 0643 F8FE C9D0  8F55 1542 1A4F 0698 252E
X-gpg-key: [http://www.frontier.iarc.uaf.edu/~cswingle/gnupgkey.asc]
X-URL: [http://www.frontier.iarc.uaf.edu/~cswingle/]
X-Editor: VIM [http://www.vim.org]
X-message-flag: Consider Linux: fast, reliable, secure & free!
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings!

Kernel 2.5.67, no modules, AMD K7 processor.

Inserting, mounting and then removing a USB mass storage device caused 
the oops at the bottom of this message.  Afterwords USB mass storage 
devices no longer worked.

My apologies if this is too much (or not enough) information.

Booting back to 2.4.20 now. . .

Chris
-- 
Christopher S. Swingley          email: cswingle@iarc.uaf.edu
IARC -- Frontier Program         Please use encryption.  GPG key at:
University of Alaska Fairbanks   www.frontier.iarc.uaf.edu/~cswingle/

Snip from /var/log/kern.log:

hub 1-0:0: debounce: port 1: delay 100ms stable 4 status 0x101
hub 1-0:0: new USB device on port 1, assigned address 3
scsi1 : SCSI emulation for USB Mass Storage devices
  Vendor: Trek      Model: ThumbDrive Smart  Rev: 1.11
  Type:   Direct-Access                      ANSI SCSI revision: 02
SCSI device sda: 515840 512-byte hdwr sectors (264 MB)
sda: Write Protect is off
sda: Mode Sense: 03 00 00 00
sda: cache data unavailable
sda: assuming drive cache: write through
 sda: sda1
Attached scsi removable disk sda at scsi1, channel 0, id 0, lun 0
WARNING: USB Mass Storage data integrity not assured
USB Mass Storage device found at 3
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on sd(8,1), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Slab corruption: start=d69cd498, expend=d69cd517, problemat=d69cd4c8
Last user: [seq_release+24/48](seq_release+0x18/0x30)
Data: ************************************************68 A2 C3 DE ***************************************************************************A5 
Next: 71 F0 2C .C8 3B 18 C0 71 F0 2C .********************
slab error in check_poison_obj(): cache `size-128': object was modified after freeing
Call Trace:
 [__slab_error+33/48] __slab_error+0x21/0x30
 [check_poison_obj+380/400] check_poison_obj+0x17c/0x190
 [kmalloc+170/352] kmalloc+0xaa/0x160
 [usb_alloc_urb+23/128] usb_alloc_urb+0x17/0x80
 [usb_alloc_urb+23/128] usb_alloc_urb+0x17/0x80
 [usb_sg_init+267/640] usb_sg_init+0x10b/0x280
 [usb_stor_msg_common+185/224] usb_stor_msg_common+0xb9/0xe0
 [usb_stor_bulk_transfer_sglist+48/176] usb_stor_bulk_transfer_sglist+0x30/0xb0
 [usb_stor_bulk_transfer_sg+42/96] usb_stor_bulk_transfer_sg+0x2a/0x60
 [usb_stor_Bulk_transport+237/368] usb_stor_Bulk_transport+0xed/0x170
 [timer_interrupt+534/832] timer_interrupt+0x216/0x340
 [usb_stor_invoke_transport+35/688] usb_stor_invoke_transport+0x23/0x2b0
 [usb_stor_transparent_scsi_command+205/272] usb_stor_transparent_scsi_command+0xcd/0x110
 [usb_stor_control_thread+1101/1504] usb_stor_control_thread+0x44d/0x5e0
 [usb_stor_control_thread+0/1504] usb_stor_control_thread+0x0/0x5e0
 [kernel_thread_helper+5/20] kernel_thread_helper+0x5/0x14

usb 1-1: USB disconnect, address 3
Unable to handle kernel paging request at virtual address 6b6b6b6d
 printing eip:
c019814b
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[proc_match+11/48]    Not tainted
EFLAGS: 00010202
EIP is at proc_match+0xb/0x30
eax: 6b6b6b6b   ebx: 00000001   ecx: 00000001   edx: dfe61e48
esi: dfe61e48   edi: dfe61e4a   ebp: dfe61e00   esp: dfe61df8
ds: 007b   es: 007b   ss: 0068
Process khubd (pid: 4, threadinfo=dfe60000 task=dff8d320)
Stack: d69cd4c8 dfe61e4a dfe61e24 c019950d 00000001 dfe61e48 6b6b6b6b c399ac08 
       dfe61e48 dfe61eb4 dfe61e48 dfe61e54 c02cced1 dfe61e48 d69cd498 dfe61e48 
       c0464561 00000001 c399ac08 dfe61e90 dff80031 c011b3b0 dfe61eac dfe61eb4 
Call Trace:
 [remove_proc_entry+93/240] remove_proc_entry+0x5d/0xf0
 [scsi_proc_host_rm+49/96] scsi_proc_host_rm+0x31/0x60
 [default_wake_function+0/32] default_wake_function+0x0/0x20
 [scsi_unregister+431/464] scsi_unregister+0x1af/0x1d0
 [storage_disconnect+563/702] storage_disconnect+0x233/0x2be
 [usb_device_remove+99/160] usb_device_remove+0x63/0xa0
 [device_release_driver+75/112] device_release_driver+0x4b/0x70
 [bus_remove_device+86/176] bus_remove_device+0x56/0xb0
 [device_del+76/112] device_del+0x4c/0x70
 [device_unregister+13/26] device_unregister+0xd/0x1a
 [usb_disconnect+142/208] usb_disconnect+0x8e/0xd0
 [usb_hub_port_connect_change+87/736] usb_hub_port_connect_change+0x57/0x2e0
 [usb_hub_port_status+131/144] usb_hub_port_status+0x83/0x90
 [usb_hub_events+536/1104] usb_hub_events+0x218/0x450
 [usb_hub_thread+44/208] usb_hub_thread+0x2c/0xd0
 [usb_hub_thread+0/208] usb_hub_thread+0x0/0xd0
 [default_wake_function+0/32] default_wake_function+0x0/0x20
 [kernel_thread_helper+5/20] kernel_thread_helper+0x5/0x14

Code: 0f b7 48 02 3b 4d 08 75 10 8b 78 04 fc a8 00 f3 a6 0f 94 c0 
