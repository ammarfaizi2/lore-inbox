Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261556AbULNQqo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261556AbULNQqo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 11:46:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261553AbULNQqn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 11:46:43 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:45042 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261554AbULNQqQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 11:46:16 -0500
Date: Tue, 14 Dec 2004 08:45:49 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: kernel BUG at mm/rmap.c:480 in 2.6.10-rc3-bk7
Message-ID: <20041214164548.GA18817@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


So I finally try to get dri working on my laptop and I get the following
kernel bug when killing X (the program gish was running at the time):

Any ideas?

thanks,

greg k-h

------------[ cut here ]------------
kernel BUG at mm/rmap.c:480!
invalid operand: 0000 [#1]
Modules linked in: orinoco_pci orinoco hermes radeon ehci_hcd ohci_hcd usbcore
CPU:    0
EIP:    0060:[<c0147d72>]    Not tainted VLI
EFLAGS: 00010286   (2.6.10-rc3-bk7) 
EIP is at page_remove_rmap+0x32/0x40
eax: ffffffff   ebx: 00000000   ecx: c1143440   edx: c1143440
esi: c821144c   edi: 00200000   ebp: c1143440   esp: c8aebd94
ds: 007b   es: 007b   ss: 0068
Process gish (pid: 10864, threadinfo=c8aea000 task=c7c2c040)
Stack: c0141495 c1143440 00000000 c8aebdc4 c0114720 0a1a2067 b6d13000 c7c03b6c 
       b6b13000 00000000 c0141651 c03d97f8 c7c03b68 b6913000 00200000 00000000 
       c03d97f8 b6913000 c7c03b6c b6b13000 00000000 c01416c3 c03d97f8 c7c03b68 
Call Trace:
 [<c0141495>] zap_pte_range+0x135/0x290
 [<c0114720>] recalc_task_prio+0xc0/0x1c0
 [<c0141651>] zap_pmd_range+0x61/0x80
 [<c01416c3>] unmap_page_range+0x53/0x90
 [<c0141801>] unmap_vmas+0x101/0x1e0
 [<c0145f41>] exit_mmap+0x71/0x140
 [<c01163c4>] mmput+0x24/0x80
 [<c011a756>] do_exit+0x146/0x370
 [<c011a9f7>] do_group_exit+0x37/0x80
 [<c012339a>] get_signal_to_deliver+0x1da/0x2d0
 [<c0102d1b>] do_signal+0x9b/0x170
 [<c01633b0>] __pollwait+0x0/0xd0
 [<c0163c74>] sys_select+0x3f4/0x540
 [<c0132a69>] handle_IRQ_event+0x39/0x70
 [<c0102e27>] do_notify_resume+0x37/0x3c
 [<c0102f6e>] work_notifysig+0x13/0x15
Code: c4 08 75 1d 83 42 08 ff 0f 98 c0 84 c0 74 11 8b 42 08 40 78 16 9c 58 fa ff 0d 90 34 3f c0 50 9d c3 0f 0b dd 01 e3 3e 2d c0 eb d9 <0f> 0b e0 01 e3 3e 2d c0 eb e0 8d 74 26 00 83 ec 20 b8 01 00 00 
