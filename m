Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261638AbUCVD0z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 22:26:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261652AbUCVD0z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 22:26:55 -0500
Received: from fep01-mail.bloor.is.net.cable.rogers.com ([66.185.86.71]:47161
	"EHLO fep01-mail.bloor.is.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id S261638AbUCVD0w convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 22:26:52 -0500
From: "Shawn Starr" <shawn.starr@rogers.com>
To: <linux-kernel@vger.kernel.org>
Subject: RE: [PANIC][2.6.5-rc2-bk1] st_probe - Detection of a SCSI tape drive (HP Colorado T4000s) - Dump included now
Date: Sun, 21 Mar 2004 22:30:08 -0500
Message-ID: <000101c40fbd$f9c242f0$030aa8c0@PANIC>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
Importance: Normal
In-Reply-To: 
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
X-Authentication-Info: Submitted using SMTP AUTH LOGIN at fep01-mail.bloor.is.net.cable.rogers.com from [67.60.40.239] using ID <shawn.starr@rogers.com> at Sun, 21 Mar 2004 22:26:16 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, this appears to be sysfs related. Is this trying to create a class for
this SCSI device but does not exist yet?

-----Original Message-----
From: Shawn Starr [mailto:shawn.starr@rogers.com] 
Sent: Sunday, March 21, 2004 10:28 PM
To: 'linux-kernel@vger.kernel.org'
Subject: [PANIC][2.6.5-rc2-bk1] st_probe - Detection of a SCSI tape drive
(HP Colorado T4000s) - Dump included now


Here is the captured dump, the st driver appears to be broken:

st: Version 20040226, fixed bufsize 32768, s/g segs 256
Unable to handle kernel NULL pointer dereference at virtual address 0000002e
printing eip: e48640fb *pde = 00000000
Oops: 0002 [#1]
PREEMPT DEBUG_PAGEALLOC
CPU:    0
EIP:    0060:[<e48640fb>]    Not tainted
EFLAGS: 00010282   (2.6.5-rc2-bk1)
EIP is at do_create_class_files+0x9b/0x130 [st]
eax: e1be2e74   ebx: ffffffea   ecx: e3febf78   edx: e4867fc8
esi: 00000000   edi: e1be2df8   ebp: 00000000   esp: e1b0fe6c
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 439, threadinfo=e1b0e000 task=e2ae29e0)
Stack: e239ef38 00900000 e3376da4 e486479b e1c5a71c 00000000 00000002
00000004
       e1c5a640 e1be2e74 e4863941 e239cf04 e48646c9 00000000 c0187e09
e19cef38
       00000000 e1be2e74 c01920ec 405e5d3a 00000000 e1be2df8 00000000
00000000 Call Trace:  [<e4863941>] st_probe+0x501/0x800 [st]  [<c0187e09>]
__lookup_hash+0x89/0xb0  [<c01920ec>] dput+0x1c/0x710  [<c01bd502>]
sysfs_create_dir+0x32/0x70  [<c0252f12>] bus_match+0x32/0x60  [<c0253029>]
driver_attach+0x59/0x90  [<c01f0b12>] kobject_register+0x22/0x60
[<c02532e1>] bus_add_driver+0x91/0xb0  [<c0253700>]
driver_register+0x80/0x90  [<e486a088>] init_st+0x88/0xcb [st]  [<c0144e2f>]
sys_init_module+0x1df/0x3a0  [<c01718ff>] filp_close+0x4f/0x80  [<c0107dd9>]
sysenter_past_esp+0x52/0x71

Code: 89 43 44 89 d8 e8 cb f7 9e db ba dc 7f 86 e4 89 d8 e8 bf f7

-----Original Message-----
From: Shawn Starr [mailto:shawn.starr@rogers.com] 
Sent: Sunday, March 21, 2004 09:45 PM
To: 'linux-kernel@vger.kernel.org'
Subject: [PANIC][2.6.5-rc2-bk1] st_probe - Detection of a SCSI tape drive
(HP Colorado T4000s)


Apon booting 2.6.5-rc2-bk1, during detection of the SCSI tape drive, the
kernel panics

The backtrace is:

st_probe
__lockup_hash
dput
sysfs_create_dir
bus_match
driver_match
kobject_register
bus_add_driver
driver_register
init_st
do_initcalls
init
init
kernel_thread_helper

Is this known? I will revert to my previous kernel 

Shawn.


