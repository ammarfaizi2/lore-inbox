Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263507AbTEDFmI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 01:42:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263510AbTEDFmI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 01:42:08 -0400
Received: from ma-northadams1b-60.bur.adelphia.net ([24.52.166.60]:640 "EHLO
	ma-northadams1b-60.bur.adelphia.net") by vger.kernel.org with ESMTP
	id S263507AbTEDFmG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 01:42:06 -0400
Date: Sun, 4 May 2003 01:54:21 -0400
From: Eric Buddington <eric@ma-northadams1b-60.bur.adelphia.net>
To: linux-kernel@vger.kernel.org
Subject: 2.5.68: BUG at usb-storage:963 on 'rmmod uhci-hcd'
Message-ID: <20030504015421.A267@ma-northadams1b-60.bur.adelphia.net>
Reply-To: ebuddington@wesleyan.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: ECS Labs
X-Eric-Conspiracy: there is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel 2.5.68
modprobe/rmmod version 2.4.22
homebuilt distribution
USB Surfboard cable modem 
USB-IDE case (external box) with NEC CD-RW drive

When using USB cable modem, I get "uhci: host controller halted. very
bad".  If burning a CD (via USB) at the same time, that message
repeats fast until the CD burn is done (apparently successfully).

Upon trying to rmmod the uhci-hcd module, I get the BUG shown in the dmesg output below.

The "uhci: host controller halted" problem is repeatable. I'm not sure about the BUG.

I do not see this problem with modules 'usb-uhci' and 'CDCether' under 2.4.20.

-Eric

------------ USB entries from /proc/pci -------------
  Bus  0, device  16, function  0:
    USB Controller: VIA Technologies, Inc. USB (rev 128).
      IRQ 9.
      Master Capable.  Latency=32.  
      I/O at 0x8800 [0x881f].
  Bus  0, device  16, function  1:
    USB Controller: VIA Technologies, Inc. USB (#2) (rev 128).
      IRQ 9.
      Master Capable.  Latency=32.  
      I/O at 0x8400 [0x841f].
  Bus  0, device  16, function  2:
    USB Controller: VIA Technologies, Inc. USB (#3) (rev 128).
      IRQ 9.
      Master Capable.  Latency=32.  
      I/O at 0x8000 [0x801f].
  Bus  0, device  16, function  3:
    USB Controller: VIA Technologies, Inc. USB 2.0 (rev 130).
      IRQ 9.
      Master Capable.  Latency=32.  
      Non-prefetchable 32 bit memory at 0xf1000000 [0xf10000ff].
------------ end USB entries from /proc/pci -------------


------------ dmesg output ----------------
usb-storage: -- transfer complete
usb-storage: Bulk status result = 0
usb-storage: Bulk status Sig 0x53425355 T 0xc4 R 0 Stat 0x0
usb-storage: scsi cmd done, result=0x0
usb-storage: *** thread sleeping.
ehci-hcd 00:10.3: remove, state 1
usb usb1: USB disconnect, address 1
usb 1-3: USB disconnect, address 2
usb 1-3: unregistering interfaces
usb-storage: storage_disconnect() called
SCSI device not inactive - rq_status=0, target=0, pid=0, state=4102, owner=257.
drivers/scsi/hosts.c:247: spin_is_locked on uninitialized spinlock ca3caebc.
Device busy???
usb-storage: -- SCSI refused to unregister
------------[ cut here ]------------
kernel BUG at drivers/usb/storage/usb.c:963!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<d0ad18fe>]    Not tainted
EFLAGS: 00010286
EIP is at storage_disconnect+0x19e/0x351 [usb_storage]
eax: 0000002e   ebx: ca3cae60   ecx: c03bdb80   edx: 0002ebdf
esi: cde7d600   edi: cfe2129c   ebp: c25d3dd4   esp: c25d3db0
ds: 007b   es: 007b   ss: 0068
Process rmmod (pid: 7928, threadinfo=c25d2000 task=c2adf980)
Stack: d0add660 00000077 c03c2210 ca4793bc 00000246 00000246 c019d1c3 d0ad1760 
       d0ae94bc c25d3df4 d0aaa1ca cfe2129c 00000077 d0ae9420 cfe212b4 d0ae9438 
       cfe212b4 c25d3e0c c027a8d6 cfe212b4 cfe212e0 d0acae20 d0acae64 c25d3e28 
Call Trace:
 [<d0add660>] +0x1ec0/0x6adc [usb_storage]
 [<c019d1c3>] iput+0x63/0x80
 [<d0ad1760>] storage_disconnect+0x0/0x351 [usb_storage]
 [<d0ae94bc>] usb_storage_driver+0x9c/0xc4 [usb_storage]
 [<d0aaa1ca>] usb_device_remove+0x9a/0xa0 [usbcore]
 [<d0ae9420>] usb_storage_driver+0x0/0xc4 [usb_storage]
 [<d0ae9438>] usb_storage_driver+0x18/0xc4 [usb_storage]
 [<c027a8d6>] device_release_driver+0x66/0x70
 [<d0acae20>] usb_bus_type+0x0/0x100 [usbcore]
 [<d0acae64>] usb_bus_type+0x44/0x100 [usbcore]
 [<c027aa66>] bus_remove_device+0x76/0xc0
 [<c0279c0c>] device_del+0x6c/0xa0
 [<c0279c54>] device_unregister+0x14/0x20
 [<d0aaacd9>] usb_disconnect+0xd9/0x180 [usbcore]
 [<d0abd678>] +0x0/0xca8 [usbcore]
 [<d0acb180>] usb_hcd_operations+0x0/0x20 [usbcore]
 [<d0aaad6e>] usb_disconnect+0x16e/0x180 [usbcore]
 [<d0abd678>] +0x0/0xca8 [usbcore]
 [<d0acb180>] usb_hcd_operations+0x0/0x20 [usbcore]
 [<d0ab5e27>] usb_hcd_pci_remove+0x87/0x1e0 [usbcore]
 [<d0af23a0>] +0x0/0xc [ehci_hcd]
 [<d0af5648>] ehci_pci_driver+0x28/0xe0 [ehci_hcd]
 [<d0af5648>] ehci_pci_driver+0x28/0xe0 [ehci_hcd]
 [<c0247d46>] pci_device_remove+0x36/0x40
 [<c027a8d6>] device_release_driver+0x66/0x70
 [<d0af56b0>] ehci_pci_driver+0x90/0xe0 [ehci_hcd]
 [<d0af56b0>] ehci_pci_driver+0x90/0xe0 [ehci_hcd]
 [<c027a902>] driver_detach+0x22/0x40
 [<c027abf5>] bus_remove_driver+0x55/0xa0
 [<d0af5648>] ehci_pci_driver+0x28/0xe0 [ehci_hcd]
 [<d0af5654>] ehci_pci_driver+0x34/0xe0 [ehci_hcd]
 [<d0af5648>] ehci_pci_driver+0x28/0xe0 [ehci_hcd]
 [<d0af5700>] +0x0/0x140 [ehci_hcd]
 [<c027b09a>] driver_unregister+0x1a/0x42
 [<d0af5648>] ehci_pci_driver+0x28/0xe0 [ehci_hcd]
 [<d0af2392>] +0x12/0x20 [ehci_hcd]
 [<d0af5648>] ehci_pci_driver+0x28/0xe0 [ehci_hcd]
 [<c01438c5>] sys_delete_module+0x1c5/0x220
 [<c0164377>] sys_munmap+0x57/0x80
 [<c010a2db>] syscall_call+0x7/0xb

Code: 0f 0b c3 03 23 2a ae d0 83 c4 1c 5b 5e c9 c3 8b 86 c0 00 00 
---------- dmesg ends ----------------- 
