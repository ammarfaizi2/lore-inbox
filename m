Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262113AbTIDVbN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 17:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264839AbTIDVbN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 17:31:13 -0400
Received: from pop.gmx.net ([213.165.64.20]:22661 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262113AbTIDVbB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 17:31:01 -0400
Subject: [2.6.0-test-x] Kernel Oops and pppd segfault
From: Florian Zimmermann <florian.zimmermann@gmx.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1062711059.8011.4.camel@mindfsck>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 04 Sep 2003 23:30:59 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have posted that to linux-ppp mailing list, but
no answer for 2 weeks now..

so here again: 

I cannot get ppp working with 2.6.0-test kernels (test1, test3, test4)
I am using the ppp-2.4.1 package
Kernel config:
CONFIG_PPP=m
# CONFIG_PPP_MULTILINK is not set
# CONFIG_PPP_FILTER is not set
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_BSDCOMP=m
# CONFIG_PPPOE is not set

and here comes the Oops when i want to start 'pppd':

PPP generic driver version 2.4.2
devfs_mk_cdev: could not append to parent for ppp
failed to register PPP device (-17)
Unable to handle kernel paging request at virtual address d1964580
 printing eip:
c015bbb9
*pde = 013d0067
*pte = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c015bbb9>]    Not tainted
EFLAGS: 00010202
EIP is at cdev_get+0x29/0xc0
eax: c6de8000   ebx: d1964580   ecx: 0000006c   edx: c015ba90
esi: 00000001   edi: cb8c6f40   ebp: 00006c00   esp: c6de9eb4
ds: 007b   es: 007b   ss: 0068
Process pppd (pid: 3323, threadinfo=c6de8000 task=c725c680)
Stack: c03aa4f0 cc280ec0 00006c00 00000000 c015ba9f cb8c6f40 c0275a0a
00006c00
       cb8c6f40 00000000 c6de8000 c6de8000 cb8c6f40 c015ba80 000000ff
c6de8000
       00000000 00000000 00000000 c015b882 cffe1c00 00006c00 c6de9f10
00000000
Call Trace:
 [<c015ba9f>] exact_lock+0xf/0x20
 [<c0275a0a>] kobj_lookup+0x11a/0x210
 [<c015ba80>] exact_match+0x0/0x10
 [<c015b882>] chrdev_open+0x192/0x210
 [<c01b2140>] devfs_open+0x0/0x110
 [<c01b2232>] devfs_open+0xf2/0x110
 [<c015146a>] dentry_open+0x14a/0x220
 [<c0151318>] filp_open+0x68/0x70
 [<c01517bb>] sys_open+0x5b/0x90
 [<c01091db>] syscall_call+0x7/0xb

Code: 83 3b 02 0f 84 7d 00 00 00 ff 83 00 01 00 00 b8 00 e0 ff ff
 <6>note: pppd[3323] exited with preempt_count 1
bad: scheduling while atomic!
Call Trace:
 [<c011a15a>] schedule+0x3ba/0x3c0
 [<c0142f33>] unmap_page_range+0x43/0x70
 [<c0143128>] unmap_vmas+0x1c8/0x220
 [<c0146e6b>] exit_mmap+0x7b/0x190
 [<c011bb25>] mmput+0x65/0xc0
 [<c011f910>] do_exit+0x120/0x3d0
 [<c010a27c>] die+0xec/0xf0
 [<c01188aa>] do_page_fault+0x14a/0x453
 [<c012c744>] queue_work+0x84/0xa0
 [<c012c6b1>] call_usermodehelper+0x101/0x110
 [<c012c540>] __call_usermodehelper+0x0/0x70
 [<c0118760>] do_page_fault+0x0/0x453
 [<c0109c05>] error_code+0x2d/0x38
 [<c015ba90>] exact_lock+0x0/0x20
 [<c015bbb9>] cdev_get+0x29/0xc0
 [<c015ba9f>] exact_lock+0xf/0x20
 [<c0275a0a>] kobj_lookup+0x11a/0x210
 [<c015ba80>] exact_match+0x0/0x10
 [<c015b882>] chrdev_open+0x192/0x210
 [<c01b2140>] devfs_open+0x0/0x110
 [<c01b2232>] devfs_open+0xf2/0x110
 [<c015146a>] dentry_open+0x14a/0x220
 [<c0151318>] filp_open+0x68/0x70
 [<c01517bb>] sys_open+0x5b/0x90
 [<c01091db>] syscall_call+0x7/0xb

what is wrong here?



