Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261260AbTI3JUt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 05:20:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261256AbTI3JUs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 05:20:48 -0400
Received: from main.gmane.org ([80.91.224.249]:29845 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261260AbTI3JUq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 05:20:46 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Andreas Schwarz <usenet.2117@andreas-s.net>
Subject: Nullpointer dereference in sysfs_get_dentry (2.6.0-test6-mm1)
Date: Tue, 30 Sep 2003 09:20:42 +0000 (UTC)
Message-ID: <slrnbniinj.41m.usenet.2117@home.andreas-s.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-TCPA-ist-scheisse: yes
User-Agent: slrn/0.9.8.0 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes rmmod hangs when I try to unload uhci-hcd.

Kernel: 2.6.0-test6-mm1

Log:
=======================================================

uhci-hcd 0000:00:13.0: remove, state 1
usb usb4: USB disconnect, address 1
usb 4-1: USB disconnect, address 5
Unable to handle kernel NULL pointer dereference at virtual address
00000000
printing eip:
c0184ec6
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c0184ec6>]    Not tainted
EFLAGS: 00010286
EIP is at sysfs_get_dentry+0x16/0x80
eax: 00000000   ebx: ceefd2cc   ecx: ffffffff   edx: 00000000
esi: cf25b600   edi: 00000000   ebp: ce8f3e24   esp: ccbade44
ds: 007b   es: 007b   ss: 0068
Process rmmod (pid: 7510, threadinfo=ccbac000 task=c9a02100)
Stack: c016043f ccbade60 00000000 00000000 c0184f1b cdc06f00 ceefd2cc ce8f3e00
c0184f5a cf25b600 00000000 ceefd2cc d19b5060 c0230098 cf25b600 00000000
ceefd2cc ce8f3ecc c0230205 ceefd2cc ceefd324 ceefd2cc ce8f3ecc c022effd
Call Trace:
[<c016043f>] lookup_hash+0x1f/0x30
[<c0184f1b>] sysfs_get_dentry+0x6b/0x80
[<c0184f5a>] sysfs_hash_and_remove+0x2a/0x7d
[<c0230098>] device_release_driver+0x28/0x70
[<c0230205>] bus_remove_device+0x55/0xa0
[<c022effd>] device_del+0x5d/0xa0
[<c022f053>] device_unregister+0x13/0x30
[<d199ecd8>] usb_disconnect+0xd8/0xf0 [usbcore]
[<d19a6d78>] usb_hcd_pci_remove+0x88/0x190 [usbcore]
[<c01e167b>] pci_device_remove+0x3b/0x40
[<c02300d6>] device_release_driver+0x66/0x70
[<c0230100>] driver_detach+0x20/0x30
[<c023032d>] bus_remove_driver+0x3d/0x80
[<c0230753>] driver_unregister+0x13/0x28
[<c01e1856>] pci_unregister_driver+0x16/0x30
[<d1aa3e4f>] uhci_hcd_cleanup+0xf/0x5e [uhci_hcd]
[<c0131cb2>] sys_delete_module+0x122/0x170
[<c0146394>] sys_munmap+0x44/0x70
[<c010931b>] syscall_call+0x7/0xb

Code: f2 ae f7 d1 49 89 4c 24 0c 49 31 db 83 f9 ff 89 d7 74 2a 8

-- 
AVR-Tutorial, über 350 Links
Forum für AVRGCC und MSPGCC
-> http://www.mikrocontroller.net

