Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265645AbUEZQNV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265645AbUEZQNV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 12:13:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265646AbUEZQNV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 12:13:21 -0400
Received: from h013.c000.snv.cp.net ([209.228.32.77]:25844 "HELO
	c000.snv.cp.net") by vger.kernel.org with SMTP id S265645AbUEZQNS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 12:13:18 -0400
X-Sent: 26 May 2004 16:13:15 GMT
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
From: dag@bakke.com
Subject: xfsdump hangs - 2.6.6 && 2.6.7-rc1-bk3
X-Sent-From: dag@bakke.com
Date: Wed, 26 May 2004 09:13:14 -0700 (PDT)
X-Mailer: Web Mail 5.6.3-1
Message-Id: <20040526091315.17983.h012.c000.wm@mail.bakke.com.criticalpath.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I experience hangs with xfsdump, when dumping my rootfs to a USB 2.0
connected drive. The hangs are reproducible within 0.2-2 GB of dump, and
always come together with one or two instances of :

pagebuf_get: failed to lookup pages

I do not know if this is a problem with xfs, ide, scsi, usb, VM or some
other area of the kernel. But it is reproducible with 2.6.6 + a few
select patches, and with plain 2.6.7-rc1-bk3.

I have collected sysrq-t, sysrq-p info. A snippet below.
If none of this explains the hang, maybe the gurus would like to point a
browser at:

http://thaifood.homeip.net/xfsdumphang/xfsdump.dmesg.txt 
http://thaifood.homeip.net/xfsdumphang/config-2.6.7-rc1-bk3
http://thaifood.homeip.net/xfsdumphang/lspci.txt
http://thaifood.homeip.net/xfsdumphang/lsusb.txt
 
 xfssyncd      S C04F25E0     0   331      1           342   317 (L-TLB)
 cfccbf9c 00000046 c1370610 c04f25e0 cfc31d60 c0238bec cfc31d98 c04fecd8 
 00000031 00000000 cfccbfb0 00002773 37e96cbf 00000210 c13707b8 000a43c5 
 cfccbfb0 00000000 00000000 c03d2ec3 cfccbfb0 000a43c5 00000000 c048e508 
 Call Trace:
 [<c0238bec>] pagebuf_rele+0x2c/0x120
 [<c03d2ec3>] schedule_timeout+0x63/0xc0
 [<c0121110>] process_timeout+0x0/0x10
 [<c023f5e7>] xfssyncd+0x57/0xc0
 [<c023f590>] xfssyncd+0x0/0xc0
 [<c0103f4d>] kernel_thread_helper+0x5/0x18
 
 usb-storage   S C04F2A88     0   342      1           343   331 (L-TLB)
 cfc09f4c 00000046 c13ff0d0 c04f2a88 0000020f 3ccbf196 00000000 c58bfcea 
 c58c004c 0000020f c13ff0d0 0000012d c58c004c 0000020f c1370238 c13b0f04 
 00000246 cfc08000 c1370090 c03d24c7 cfc08000 c13b0f0c 00000000 00000001 
 Call Trace:
 [<c03d24c7>] __down_interruptible+0xa7/0x140
 [<c0115e60>] default_wake_function+0x0/0x20
 [<c011555d>] wake_up_process+0x1d/0x30
 [<c03d2573>] __down_failed_interruptible+0x7/0xc
 [<c032eead>] .text.lock.usb+0x5/0x58
 [<c01158f7>] schedule_tail+0x17/0x50
 [<c0105c82>] ret_from_fork+0x6/0x14
 [<c032e150>] usb_stor_control_thread+0x0/0x280
 [<c032e150>] usb_stor_control_thread+0x0/0x280
 [<c0103f4d>] kernel_thread_helper+0x5/0x18
 
 scsi_eh_0     S C04F25E0     0   343      1           485   342 (L-TLB)
 cfab7f78 00000046 cfab96b0 c04f25e0 00000000 00000000 00000000 00000000 
 00000086 cfab7f7c c13ff650 000015c8 2850a2f5 00000184 cfab9858 cfab7fd4 
 00000246 cfab6000 cfab96b0 c03d24c7 cfab6000 cfab7fdc 00000000 00000001 
 Call Trace:
 [<c03d24c7>] __down_interruptible+0xa7/0x140
 [<c0115e60>] default_wake_function+0x0/0x20
 [<c03d2573>] __down_failed_interruptible+0x7/0xc
 [<c02ddca8>] .text.lock.scsi_error+0x41/0x49
 [<c02dd960>] scsi_error_handler+0x0/0x110
 [<c0103f4d>] kernel_thread_helper+0x5/0x18



A few more bits of info, as I have no idea where to start *): 
- the target filesystem is writeable after xfsdump hangs
- the USB2IDE chip is an ISD-300.
- the USB 2.0 controller is a NEC chip on a CardBus card.
- gcc 3.3, xfsdump 2.2.16

*) Yeah, I can start doing a binary search for a working kernel....



Anyone?


Dag B
