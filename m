Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261549AbTIXRqW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 13:46:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261559AbTIXRqV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 13:46:21 -0400
Received: from web40013.mail.yahoo.com ([66.218.78.53]:28257 "HELO
	web40013.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261549AbTIXRqR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 13:46:17 -0400
Message-ID: <20030924174616.763.qmail@web40013.mail.yahoo.com>
Date: Wed, 24 Sep 2003 10:46:16 -0700 (PDT)
From: Brad Chapman <jabiru_croc@yahoo.com>
Subject: Re: Problems with the maestro3 OSS driver on 2.6.0-test5-bk10
To: zab@zabbo.net
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mr. Brown,

UPDATE: Ugh, it fails on 2.6.0-test5-mm4 as well. Here are the Oopses:

Unable to handle kernel NULL pointer dereference at virtual address 00000188
 printing eip:
e4cb4d38
*pde = 00000000
Oops: 0000 [#1]
PREEMPT
CPU:    0
EIP:    0060:[<e4cb4d38>]    Not tainted VLI
EFLAGS: 00210002
EIP is at m3_open+0x12d/0x3ad [maestro3]
eax: d324c000   ebx: 00000000   ecx: dfb4f904   edx: d2fef500
esi: dfb4f8f4   edi: 00000003   ebp: dfb4f904   esp: d324de98
ds: 007b   es: 007b   ss: 0068
Process mplayer (pid: 1260, threadinfo=d324c000 task=d5120300)
Stack: e4cb6a91 00000077 c018a343 dfca129c d324df00 d324defc 00000000 d9bfc300
       00200246 ff003850 d324c000 e4c90f40 00000000 00000003 e4c8fa59 df5adb4c
       d2fef500 00e00003 d324df28 d88e0794 d324c000 c0183718 e4cb9980 d324c000
Call Trace:
 [<c018a343>] link_path_walk+0x85e/0xdd2
 [<e4c8fa59>] soundcore_open+0x2a3/0x626 [soundcore]
 [<c0183718>] exact_match+0x0/0x5
 [<c0182fef>] chrdev_open+0x220/0x616
 [<c0175e9c>] get_empty_filp+0x75/0xe8
 [<c0182dcf>] chrdev_open+0x0/0x616
 [<c01738bc>] dentry_open+0x14d/0x218
 [<c017376d>] filp_open+0x67/0x69
 [<c0173f6d>] sys_open+0x5b/0x8b
 [<c038205a>] sysenter_past_esp+0x43/0x65

Code: db 89 e9 ff 4e 10 0f 88 58 1b 00 00 8b 54 24 40 0f b7 42 1c 66 85 46 58
75 9d 9c 8f 44 24 20 fa b8 00 e0 ff ff 21 e0 83 40 14 01 <81> bb 88 01 00 00 3c
4b 24 1d 74 26 8d 83 88 01 00 00 c7 44 24
 <6>note: mplayer[1260] exited with preempt_count 2
bad: scheduling while atomic!
Call Trace:
 [<c0120619>] schedule+0x8ee/0x8f3
 [<c015dfdc>] zap_pmd_range+0x48/0x64
 [<c015e03b>] unmap_page_range+0x43/0x69
 [<c015e28b>] unmap_vmas+0x22a/0x358
 [<c0163f05>] exit_mmap+0xce/0x2b7
 [<c0123c7c>] mmput+0xc8/0x170
 [<c012a280>] do_exit+0x27e/0x8e1
 [<c010c74e>] do_divide_error+0x0/0xfb
 [<c011d959>] do_page_fault+0x20d/0x54b
 [<c0292de9>] blk_run_queues+0x148/0x353
 [<c0261673>] pty_write+0x1cd/0x1cf
 [<c0123847>] autoremove_wake_function+0x0/0x4f
 [<c0225fc0>] __copy_from_user_ll+0x74/0x78
 [<c0149dc6>] find_get_page+0x7a/0x161
 [<c011d74c>] do_page_fault+0x0/0x54b
 [<c0382adb>] error_code+0x2f/0x38
 [<e4cb4d38>] m3_open+0x12d/0x3ad [maestro3]
 [<c018a343>] link_path_walk+0x85e/0xdd2
 [<e4c8fa59>] soundcore_open+0x2a3/0x626 [soundcore]
 [<c0183718>] exact_match+0x0/0x5
 [<c0182fef>] chrdev_open+0x220/0x616
 [<c0175e9c>] get_empty_filp+0x75/0xe8
 [<c0182dcf>] chrdev_open+0x0/0x616
 [<c01738bc>] dentry_open+0x14d/0x218
 [<c017376d>] filp_open+0x67/0x69
 [<c0173f6d>] sys_open+0x5b/0x8b
 [<c038205a>] sysenter_past_esp+0x43/0x65

bad: scheduling while atomic!
Call Trace:
 [<c0120619>] schedule+0x8ee/0x8f3
 [<c015dfdc>] zap_pmd_range+0x48/0x64
 [<c015e03b>] unmap_page_range+0x43/0x69
 [<c015e28b>] unmap_vmas+0x22a/0x358
 [<c0163f05>] exit_mmap+0xce/0x2b7
 [<c0123c7c>] mmput+0xc8/0x170
 [<c012a280>] do_exit+0x27e/0x8e1
 [<c010c74e>] do_divide_error+0x0/0xfb
 [<c011d959>] do_page_fault+0x20d/0x54b
 [<c0292de9>] blk_run_queues+0x148/0x353
 [<c0261673>] pty_write+0x1cd/0x1cf
 [<c0123847>] autoremove_wake_function+0x0/0x4f
 [<c0225fc0>] __copy_from_user_ll+0x74/0x78
 [<c0149dc6>] find_get_page+0x7a/0x161
 [<c011d74c>] do_page_fault+0x0/0x54b
 [<c0382adb>] error_code+0x2f/0x38
 [<e4cb4d38>] m3_open+0x12d/0x3ad [maestro3]
 [<c018a343>] link_path_walk+0x85e/0xdd2
 [<e4c8fa59>] soundcore_open+0x2a3/0x626 [soundcore]
 [<c0183718>] exact_match+0x0/0x5
 [<c0182fef>] chrdev_open+0x220/0x616
 [<c0175e9c>] get_empty_filp+0x75/0xe8
 [<c0182dcf>] chrdev_open+0x0/0x616
 [<c01738bc>] dentry_open+0x14d/0x218
 [<c017376d>] filp_open+0x67/0x69
 [<c0173f6d>] sys_open+0x5b/0x8b
 [<c038205a>] sysenter_past_esp+0x43/0x65

Debug: sleeping function called from invalid context at
include/asm/semaphore.h:119
in_atomic():1, irqs_disabled():0
Call Trace:
 [<c0122eae>] __might_sleep+0x9c/0xb6
 [<c0161dc5>] remove_shared_vm_struct+0x41/0x96
 [<c0164010>] exit_mmap+0x1d9/0x2b7
 [<c0123c7c>] mmput+0xc8/0x170
 [<c012a280>] do_exit+0x27e/0x8e1
 [<c010c74e>] do_divide_error+0x0/0xfb
 [<c011d959>] do_page_fault+0x20d/0x54b
 [<c0292de9>] blk_run_queues+0x148/0x353
 [<c0261673>] pty_write+0x1cd/0x1cf
 [<c0123847>] autoremove_wake_function+0x0/0x4f
 [<c0225fc0>] __copy_from_user_ll+0x74/0x78
 [<c0149dc6>] find_get_page+0x7a/0x161
 [<c011d74c>] do_page_fault+0x0/0x54b
 [<c0382adb>] error_code+0x2f/0x38
 [<e4cb4d38>] m3_open+0x12d/0x3ad [maestro3]
 [<c018a343>] link_path_walk+0x85e/0xdd2
 [<e4c8fa59>] soundcore_open+0x2a3/0x626 [soundcore]
 [<c0183718>] exact_match+0x0/0x5
 [<c0182fef>] chrdev_open+0x220/0x616
 [<c0175e9c>] get_empty_filp+0x75/0xe8
 [<c0182dcf>] chrdev_open+0x0/0x616
 [<c01738bc>] dentry_open+0x14d/0x218
 [<c017376d>] filp_open+0x67/0x69
 [<c0173f6d>] sys_open+0x5b/0x8b
 [<c038205a>] sysenter_past_esp+0x43/0x65

Should I just try the ALSA drivers w/OSS emulation? I know I should be using
them but Red Hat 9 is quite involved to get complete ALSAness working on it....

Brad

__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free, easy-to-use web site design software
http://sitebuilder.yahoo.com
