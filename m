Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262661AbTI1RHj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 13:07:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262665AbTI1RHi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 13:07:38 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:44528 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262661AbTI1RHe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 13:07:34 -0400
Message-ID: <3F77154D.5060307@us.ibm.com>
Date: Sun, 28 Sep 2003 10:07:25 -0700
From: Mike Christie <mikenc@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: detach <detach@hackaholic.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: kernel 2.6-test5 rmmod: kernel NULL pointer dereference
References: <35776.10.0.0.50.1064747073.squirrel@mail.hackaholic.org>
In-Reply-To: <35776.10.0.0.50.1064747073.squirrel@mail.hackaholic.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

detach wrote:

> Hello,
> 
> I hope I'm using the right method to reporting this problem, I'll send it
> to the mailing list as this problem seems to be an overall kernel problem.
> No flames please :).
> Here's what happened,
> I wrote a CD so I did a modprobe ide-scsi .. then wrote the CD, now I
> wanted to check the contents of the CD, so i did rmmod ide-scsi first so
> that i could load ide-cd. Well, rmmod hung, and I checked /proc/kern.log
> on debian woody (with custom compiled linux 2.6-test5).Here's the output in /proc/kern.log:
> 
> Sep 28 12:49:32 debian kernel: Unable to handle kernel NULL pointer
> dereference at virtual address 00000024Sep 28 12:49:32 debian kernel:  printing eip:
> Sep 28 12:49:32 debian kernel: c0176546
> Sep 28 12:49:32 debian kernel: *pde = 00000000
> Sep 28 12:49:32 debian kernel: Oops: 0002 [#1]
> Sep 28 12:49:32 debian kernel: CPU:    0
> Sep 28 12:49:32 debian kernel: EIP:    0060:[<c0176546>]    Not tainted
> Sep 28 12:49:32 debian kernel: EFLAGS: 00010202
> Sep 28 12:49:32 debian kernel: EIP is at simple_rmdir+0x26/0x50
> Sep 28 12:49:32 debian kernel: eax: 00000000   ebx: c2cb1480   ecx:
> c2cb149c   edx: ffffffd9Sep 28 12:49:32 debian kernel: esi: cde97540   edi: c2cb10c0   ebp:
> c542beac   esp: c542be9cSep 28 12:49:32 debian kernel: ds: 007b   es: 007b   ss: 0068
> Sep 28 12:49:32 debian kernel: Process rmmod (pid: 2282,
> threadinfo=c542a000 task=cbb6a650)Sep 28 12:49:32 debian kernel: Stack: c2cb1480 ca5e0c80 cde975a8 cde97540
> c542becc c018bf9e cde97540 c2cb1480Sep 28 12:49:32 debian kernel:        c2cb1480 c2cb1600 c542a000 c2cb1480
> c542beec c018c092 c2cb1480 c2cb1600Sep 28 12:49:32 debian kernel:        c2cb149c ce60c8c4 c03e9b68 cf8adec0
> c542bf04 c021b223 ce60c8c4 c03e9b20Sep 28 12:49:32 debian kernel: Call Trace:
> Sep 28 12:49:32 debian kernel:  [<c018bf9e>] remove_dir+0x6e/0x90
> Sep 28 12:49:32 debian kernel:  [<c018c092>] sysfs_remove_dir+0xc2/0x130
> Sep 28 12:49:32 debian kernel:  [<c021b223>] kobject_del+0x43/0x70
> Sep 28 12:49:32 debian kernel:  [<c0274291>] device_del+0x81/0xb0
> Sep 28 12:49:32 debian kernel:  [<cf8ac049>] idescsi_cleanup+0x49/0x60
> [ide_scsi]Sep 28 12:49:32 debian kernel:  [<c0295944>] ide_unregister_driver+0x74/0xcb
> Sep 28 12:49:32 debian kernel:  [<cf8acb7a>] exit_idescsi_module+0x2a/0x2c
> [ide_scsi]Sep 28 12:49:32 debian kernel:  [<c013582f>] sys_delete_module+0x12f/0x150
> Sep 28 12:49:32 debian kernel:  [<c014ae67>] sys_munmap+0x57/0x80
> Sep 28 12:49:32 debian kernel:  [<c010a32f>] syscall_call+0x7/0xb
> Sep 28 12:49:32 debian kernel:
> Sep 28 12:49:32 debian kernel: Code: ff 48 24 89 34 24 89 5c 24 04 e8 ab
> ff ff ff 31 d2 ff 4e 24
> A uname -a:
> 
> Linux debian 2.6.0-test5 #6 Wed Sep 24 23:03:29 CEST 2003 i686 GNU/Linux
> 

This ide-scsi rmmod oops has been fixed in 2.6.0-test6.

Mike Christie
mikenc@us.ibm.com

