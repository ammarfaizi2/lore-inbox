Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752537AbWAFUTq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752537AbWAFUTq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 15:19:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752539AbWAFUTq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 15:19:46 -0500
Received: from mx1.redhat.com ([66.187.233.31]:56522 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1752537AbWAFUTp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 15:19:45 -0500
Date: Fri, 6 Jan 2006 15:19:28 -0500
From: Dave Jones <davej@redhat.com>
To: axboe@suse.de
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.15 cfq oops
Message-ID: <20060106201928.GI4595@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, axboe@suse.de,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like some nice slab poison...

		Dave

Oops: 0000 [#1]
last sysfs file:
/devices/pci0000:00/0000:00:1d.7/usb1/1-0:1.0/bAlternateSettingModules linked
in: usb_storage ata_piix libata e1000 ohci1394 ieee1394 uhci_hcdsCPU:    0
EIP:    0060:[<c01c312e>]    Not tainted VLI
EFLAGS: 00010002   (2.6.15-1.1819_FC5)
EIP is at rb_next+0x9/0x22
eax: 6b6b6b6b   ebx: dfed01f8   ecx: c01bf65a   edx: 6b6b6b6b
esi: c1991e98   edi: 00000202   ebp: dfed403c   esp: c03c1f14
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=c03c1000 task=c0327ba0)
Stack: c01bf662 c01b5dfa dfed01f8 c01b85dc c040c284 00000004 c1991e98 c023c8ab
       c1991e98 00000000 c040c284 00000000 c023d3a4 000194d0 00000000 dfed403c
       c1991e98 c040c284 c1991e98 00000000 c0231f2d 000194d0 00000000 000194d0
Call Trace:
 [<c01bf662>] cfq_latter_request+0x8/0x14     [<c01b5dfa>] elv_latter_request+07
[<c01b85dc>] blk_attempt_remerge+0x1d/0x3c     [<c023c8ab>] cdrom_start_read+0e
[<c023d3a4>] ide_do_rw_cdrom+0xdd/0x14a     [<c0231f2d>] start_request+0x1b1/01
[<c023220f>] ide_do_request+0x2a0/0x2fb     [<c023265e>] ide_intr+0xf3/0x11b
 [<c023c1a7>] cdrom_read_intr+0x0/0x2a1     [<c013632a>] handle_IRQ_event+0x23/c
[<c01363cd>] __do_IRQ+0x7a/0xcd     [<c01054d0>] do_IRQ+0x5c/0x77
 =======================
 [<c0103cea>] common_interrupt+0x1a/0x20     [<c0101120>] mwait_idle+0x1a/0x2e
 [<c01010a3>] cpu_idle+0x38/0x4d     [<c0390635>] start_kernel+0x17a/0x17c
Code: 85 c0 74 0b 8b 50 0c 85 d2 74 04 89 d0 eb f5 c3 8b 00 85 c0 74 0b 8b 50 0

