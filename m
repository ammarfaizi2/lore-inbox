Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262174AbTLCWVt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 17:21:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262188AbTLCWVt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 17:21:49 -0500
Received: from ppp-RAS1-4-75.dialup.eol.ca ([64.56.227.75]:5248 "EHLO
	node1.opengeometry.net") by vger.kernel.org with ESMTP
	id S262174AbTLCWVo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 17:21:44 -0500
Date: Wed, 3 Dec 2003 17:21:45 -0500
From: William Park <opengeometry@yahoo.ca>
To: linux-kernel@vger.kernel.org
Subject: USB + SMP (MPS 1.4) --> oops
Message-ID: <20031203222145.GA673@node1.opengeometry.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear USB developers:

With SMP linux-2.6.0-test11 and MPS 1.1, USB seems to work.  But, when I
use MPS 1.4, which moves the PCI cards to irq=16-19, USB does not work.
Furthermore, when I try do 'rmmod' or stop 'rc.hotplug', it hangs with
the following:

I can't make head or tail of it, but it's just for your reference...

# sh /etc/rc.d/rc.hotplug stop
Unable to handle kernel NULL pointer dereference at virtual address 00000000
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c018fd86>]    Not tainted
EFLAGS: 00010296
EIP is at sysfs_get_dentry+0x16/0x70
eax: 00000000   ebx: ddc7cad0   ecx: ffffffff   edx: 00000000
esi: dd908de0   edi: 00000000   ebp: ddc7c624   esp: dd771e44
ds: 007b   es: 007b   ss: 0068
Process rmmod (pid: 521, threadinfo=dd770000 task=dde1b2f0)
Stack: c016615f dd771e64 dd92d500 00000000 c018fdd5 dd771e64 dd6f47c0 ddc7cad0
       ddc7c600 c018fe0b dd908de0 00000000 ddc7cad0 e1132ba0 c01cd298 dd908de0
       00000000 ddc7cad0 ddc7c6d0 c01cd426 ddc7cad0 ddc7cb2c ddc7cad0 ddc7c6d0
Call Trace:
 [<c016615f>] lookup_hash+0x1f/0x30
 [<c018fdd5>] sysfs_get_dentry+0x65/0x70
 [<c018fe0b>] sysfs_hash_and_remove+0x2b/0x7f
 [<c01cd298>] device_release_driver+0x28/0x70
 [<c01cd426>] bus_remove_device+0x56/0xa0
 [<c01cc2bf>] device_del+0x5f/0xb0
 [<c01cc323>] device_unregister+0x13/0x30
 [<e111cad9>] usb_disconnect+0xd9/0xf0 [usbcore]
 [<e1124cb9>] usb_hcd_pci_remove+0x89/0x180 [usbcore]
 [<c01a6b2b>] pci_device_remove+0x3b/0x40
 [<c01cd2d6>] device_release_driver+0x66/0x70
 [<c01cd30b>] driver_detach+0x2b/0x40
 [<c01cd55e>] bus_remove_driver+0x3e/0x80
 [<c01cd983>] driver_unregister+0x13/0x2a
 [<c01a6cc2>] pci_unregister_driver+0x12/0x20
 [<e1139fef>] uhci_hcd_cleanup+0xf/0x5e [uhci_hcd]
 [<c0136b9c>] sys_delete_module+0x13c/0x180
 [<c014bb25>] sys_munmap+0x45/0x70
 [<c01094ef>] syscall_call+0x7/0xb

Code: f2 ae f7 d1 49 31 db 89 d7 89 4c 24 10 49 83 f9 ff 74 24 8d
 /etc/hotplug/usb.rc: line 370:   521 Segmentation fault      rmmod uhci-hcd >/dev/null 2>&1

-- 
William Park, Open Geometry Consulting, <opengeometry@yahoo.ca>
Linux solution for data management and processing. 
