Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263015AbUAXTdW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 14:33:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263082AbUAXTdW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 14:33:22 -0500
Received: from adsl-66-136-23-146.dsl.hstntx.swbell.net ([66.136.23.146]:21396
	"EHLO dmdtech.org") by vger.kernel.org with ESMTP id S263015AbUAXTdR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 14:33:17 -0500
Message-ID: <002e01c3e2b1$6414f650$1e01a8c0@dmdtech2>
From: "Darren Dupre" <darren@dmdtech.org>
To: <linux-kernel@vger.kernel.org>
Subject: 2.6.1 Oops when attempting to access /dev/st0 without st module loaded
Date: Sat, 24 Jan 2004 13:36:41 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was about to do a tape backup, so I did the following:

modprobe advansys (automaticaly loads scsi_mod first)

tar --exclude=/sys --exclude=/proc --exclude=/mnt -cvf /dev/st0 /
which results in a segmentation fault as soon as tar is executed.

If I load the st module and try to backup, it says no such device

I believe it did this because I forgot to modprobe st (shouldn't it be done
automatically?) which I normally do but forgot to do this time around. I
keep all this stuff as modules becuase I like to be able to unhook the tape
drive and use it on other machines without having to reboot.

This is what appears in the syslog after attempting to run tar:

Unable to handle kernel NULL pointer dereference at virtual address 00000004
 printing eip:
c0158b81
*pde = 00000000
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<c0158b81>]    Not tainted
EFLAGS: 00010296
EIP is at chrdev_open+0x1f1/0x210
eax: 00000000   ebx: def1c80c   ecx: f78c35fc   edx: def1c914
esi: f78c35c0   edi: 00000000   ebp: f78c35c0   esp: e5047f1c
ds: 007b   es: 007b   ss: 0068
Process tar (pid: 10649, threadinfo=e5046000 task=ef6bf940)
Stack: f7ff0c00 00900000 e5047f28 00000000 f7415540 def1c80c 00000001
f7ff4280
       c014ecd2 def1c80c f7415540 c7f89380 00008241 00008241 cdcc0000
e5046000
       c014eb82 c7f89380 f7ff4280 00008241 e5047f70 c7f89380 f7ff4280
cdcc0005
Call Trace:
 [<c014ecd2>] dentry_open+0x142/0x210
 [<c014eb82>] filp_open+0x62/0x70
 [<c014f01b>] sys_open+0x5b/0x90
 [<c0108ee5>] sysenter_past_esp+0x52/0x71

Code: 89 50 04 89 55 3c 31 ed 89 4a 04 e9 38 fe ff ff e8 0a 04 fc
 <6>note: tar[10649] exited with preempt_count 1
bad: scheduling while atomic!
Call Trace:
 [<c0118f93>] schedule+0x563/0x570
 [<c01404e3>] unmap_page_range+0x43/0x70
 [<c01406c4>] unmap_vmas+0x1b4/0x210
 [<c01444ab>] exit_mmap+0x7b/0x190
 [<c011a924>] mmput+0x64/0xc0
 [<c011e87a>] do_exit+0x14a/0x400
 [<c0116e70>] do_page_fault+0x0/0x50c
 [<c010a081>] die+0xe1/0xf0
 [<c011704e>] do_page_fault+0x1de/0x50c
 [<c011a680>] autoremove_wake_function+0x0/0x50
 [<c0154c6b>] bio_alloc+0xcb/0x1a0
 [<c011a680>] autoremove_wake_function+0x0/0x50
 [<c0188daf>] ext3_get_inode_loc+0x17f/0x260
 [<c01890f3>] ext3_read_inode+0x203/0x2c0
 [<c0116e70>] do_page_fault+0x0/0x50c
 [<c01099b9>] error_code+0x2d/0x38
 [<c0158b81>] chrdev_open+0x1f1/0x210
 [<c014ecd2>] dentry_open+0x142/0x210
 [<c014eb82>] filp_open+0x62/0x70
 [<c014f01b>] sys_open+0x5b/0x90
 [<c0108ee5>] sysenter_past_esp+0x52/0x71

bad: scheduling while atomic!
Call Trace:
 [<c0118f93>] schedule+0x563/0x570
 [<c01404e3>] unmap_page_range+0x43/0x70
 [<c01406c4>] unmap_vmas+0x1b4/0x210
 [<c01444ab>] exit_mmap+0x7b/0x190
 [<c011a924>] mmput+0x64/0xc0
 [<c011e87a>] do_exit+0x14a/0x400
 [<c0116e70>] do_page_fault+0x0/0x50c
 [<c010a081>] die+0xe1/0xf0
 [<c011704e>] do_page_fault+0x1de/0x50c
 [<c011a680>] autoremove_wake_function+0x0/0x50
 [<c0154c6b>] bio_alloc+0xcb/0x1a0
 [<c011a680>] autoremove_wake_function+0x0/0x50
 [<c0188daf>] ext3_get_inode_loc+0x17f/0x260
 [<c01890f3>] ext3_read_inode+0x203/0x2c0
 [<c0116e70>] do_page_fault+0x0/0x50c
 [<c01099b9>] error_code+0x2d/0x38
 [<c0158b81>] chrdev_open+0x1f1/0x210
 [<c014ecd2>] dentry_open+0x142/0x210
 [<c014eb82>] filp_open+0x62/0x70
 [<c014f01b>] sys_open+0x5b/0x90
 [<c0108ee5>] sysenter_past_esp+0x52/0x71

Other possibly useful information:


KT133A chipset
Advansys 3940UW (I believe thats the model number.. its an Ultra/Wide
controller with both narrow and wide connectors internally and one wide
external connector) scsi0 : AdvanSys SCSI 3.3GJ: PCI Ultra-Wide: PCIMEM
0xF88E8F00-0xF88E8F3F, IRQ 0xA as reported by the kernel
Quantum DLT4000 DLT tape drive with the latest firmware I believe.

Please CC mails directly to me.

Darren Dupre

