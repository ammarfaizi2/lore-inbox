Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263787AbTEFOtj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 10:49:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263789AbTEFOtj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 10:49:39 -0400
Received: from franka.aracnet.com ([216.99.193.44]:1959 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S263787AbTEFOtc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 10:49:32 -0400
Date: Tue, 06 May 2003 08:01:26 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 667] New: Removing USB mass storage causes slab corruption, oops 
Message-ID: <12980000.1052233286@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=667

           Summary: Removing USB mass storage causes slab corruption, oops
    Kernel Version: 2.5.69
            Status: NEW
          Severity: normal
             Owner: greg@kroah.com
         Submitter: cswingle@iarc.uaf.edu


Distribution: Debian GNU/Linux, unstable
Hardware Environment: PIII 500 MHz laptop, Intel PIIX4 USB/IDE
Software Environment: No module support, only existing hardware devices compiled
into kernel
Problem Description: Removal of USB mass storage device causes slab corruption,
then kernel oops.  USB devices no longer work after oops but kernel continues to
run.

Steps to reproduce:  Insert and remove USB mass storage device a few times. 
Mounting the device doesn't appear to be necessary.  All of the mass storage
devices I've tried cause this bug, usually on the third (slab corruption) and
fourth (oops) removal.

Note that this is the same behavior as reported in Bug #633.

Here's the kernel log messages after the third (slab corruption) and fourth
(oops) removal.  The insertion is in between.

scsi0 : SCSI emulation for USB Mass Storage devices
  Vendor: Generic   Model: USB SD Reader     Rev: 2.00
  Type:   Direct-Access                      ANSI SCSI revision: 02
Slab corruption: start=c79e1784, expend=c79e17e3, problemat=c79e17b4
Last user: [load_elf_interp+310/560](load_elf_interp+0x136/0x230)
Data: ************************************************74 12 9E C7
*******************************************A5 
Next: 71 F0 2C .66 26 1B C0 71 F0 2C .********************
slab error in check_poison_obj(): cache `size-96': object was modified after freeing
Call Trace:
 [check_poison_obj+347/432] check_poison_obj+0x15b/0x1b0
 [kmalloc+361/448] kmalloc+0x169/0x1c0
 [load_elf_interp+162/560] load_elf_interp+0xa2/0x230
 [load_elf_interp+162/560] load_elf_interp+0xa2/0x230
 [load_elf_binary+1075/3200] load_elf_binary+0x433/0xc80
 [copy_strings+515/592] copy_strings+0x203/0x250
 [load_elf_binary+0/3200] load_elf_binary+0x0/0xc80
 [search_binary_handler+133/320] search_binary_handler+0x85/0x140
 [do_execve+489/528] do_execve+0x1e9/0x210
 [sys_execve+77/128] sys_execve+0x4d/0x80
 [syscall_call+7/11] syscall_call+0x7/0xb

SCSI device sda: 250880 512-byte hdwr sectors (128 MB)
sda: Write Protect is off
sda: Mode Sense: 03 00 00 00
sda: cache data unavailable
sda: assuming drive cache: write through
 sda: sda1
Attached scsi removable disk sda at scsi0, channel 0, id 0, lun 0
WARNING: USB Mass Storage data integrity not assured
USB Mass Storage device found at 4
usb 1-1: USB disconnect, address 4
Unable to handle kernel paging request at virtual address 6b6b6b6d
 printing eip:
c01bc363
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[proc_match+19/64]    Not tainted
EFLAGS: 00010286
EIP is at proc_match+0x13/0x40
eax: 6b6b6b6b   ebx: c79e1784   ecx: 6b6b6b6b   edx: c11f5dc8
esi: c11f5dc8   edi: c79e17b4   ebp: c11f5d8c   esp: c11f5d84
ds: 007b   es: 007b   ss: 0068
Process khubd (pid: 4, threadinfo=c11f4000 task=c114d320)
Stack: 00000001 c79e17b4 c11f5db4 c01bd962 00000001 c11f5dc8 6b6b6b6b c11f5db4 
       c11f5dc8 c7e901b0 c11f5dc8 c6c87c68 c11f5de0 c0332422 c11f5dc8 c79e1784 
       00000000 c6e00030 c6c87c68 c11f5e58 c7e901b0 c7e901b0 c6e04e00 c11f5e58 
Call Trace:
 [remove_proc_entry+82/288] remove_proc_entry+0x52/0x120
 [scsi_proc_host_rm+66/112] scsi_proc_host_rm+0x42/0x70
 [scsi_unregister+253/576] scsi_unregister+0xfd/0x240
 [scsi_remove_device+64/80] scsi_remove_device+0x40/0x50
 [scsi_remove_device+64/80] scsi_remove_device+0x40/0x50
 [storage_disconnect+430/786] storage_disconnect+0x1ae/0x312
 [iput+99/144] iput+0x63/0x90
 [storage_disconnect+0/786] storage_disconnect+0x0/0x312
 [usb_device_remove+151/160] usb_device_remove+0x97/0xa0
 [device_release_driver+94/96] device_release_driver+0x5e/0x60
 [bus_remove_device+127/208] bus_remove_device+0x7f/0xd0
 [device_del+108/176] device_del+0x6c/0xb0
 [device_unregister+20/34] device_unregister+0x14/0x22
 [usb_disconnect+199/352] usb_disconnect+0xc7/0x160
 [usb_hub_port_connect_change+831/848] usb_hub_port_connect_change+0x33f/0x350
 [usb_hub_port_status+104/176] usb_hub_port_status+0x68/0xb0
 [usb_hub_events+1014/1392] usb_hub_events+0x3f6/0x570
 [allow_signal+204/512] allow_signal+0xcc/0x200
 [usb_hub_thread+53/240] usb_hub_thread+0x35/0xf0
 [default_wake_function+0/32] default_wake_function+0x0/0x20
 [usb_hub_thread+0/240] usb_hub_thread+0x0/0xf0
 [kernel_thread_helper+5/24] kernel_thread_helper+0x5/0x18

Code: 0f b7 48 02 3b 4d 08 74 14 31 c0 8b 34 24 8b 7c 24 04 89 ec


