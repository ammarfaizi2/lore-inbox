Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbTIXRbj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 13:31:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261566AbTIXRbj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 13:31:39 -0400
Received: from web40011.mail.yahoo.com ([66.218.78.29]:55623 "HELO
	web40011.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261563AbTIXRbg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 13:31:36 -0400
Message-ID: <20030924173135.34012.qmail@web40011.mail.yahoo.com>
Date: Wed, 24 Sep 2003 10:31:35 -0700 (PDT)
From: Brad Chapman <jabiru_croc@yahoo.com>
Subject: Re: Problems with the maestro3 OSS driver on 2.6.0-test5-bk10
To: zab@zabbo.net
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mr. Brown,

UPDATE: The same problem appears on 2.6.0-test5-bk11. It appears to be a bug in
the /dev/dsp code. I tried running mplayer under test5-bk10 and test5-bk11, and
these are the Oopses that mplayer reports under test5-bk11:

Unable to handle kernel NULL pointer dereference at virtual address 00000188
 printing eip:
e4cbcd38
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<e4cbcd38>]    Not tainted
EFLAGS: 00210002
EIP is at m3_open+0x12d/0x3ad [maestro3]
eax: d59d0000   ebx: 00000000   ecx: df9b0ad4   edx: d517f45c
esi: df9b0ac4   edi: 00000003   ebp: df9b0ad4   esp: d59d1e98
ds: 007b   es: 007b   ss: 0068
Process mplayer (pid: 1169, threadinfo=d59d0000 task=d7738ec0)
Stack: e4cbea91 00000077 c018764f dfca3190 d59d1f00 d59d1efc 00000000 d5414380
       00200246 ff000b98 d59d0000 e4c98f40 00000000 00000003 e4c97a59 df587b3c
       d517f45c 00e00003 d59d1f28 d9437d0c d59d0000 c0180a60 e4cc1980 d59d0000
Call Trace:
 [<c018764f>] link_path_walk+0x85e/0xdd2
 [<e4c97a59>] soundcore_open+0x2a3/0x626 [soundcore]
 [<c0180a60>] exact_match+0x0/0x5
 [<c0180337>] chrdev_open+0x220/0x616
 [<c01733ac>] get_empty_filp+0x75/0xe8
 [<c0180117>] chrdev_open+0x0/0x616
 [<c0170e47>] dentry_open+0x14d/0x218
 [<c0170cf8>] filp_open+0x67/0x69
 [<c01714f8>] sys_open+0x5b/0x8b
 [<c010a179>] sysenter_past_esp+0x52/0x71

Code: 81 bb 88 01 00 00 3c 4b 24 1d 74 26 8d 83 88 01 00 00 c7 44
 <6>note: mplayer[1169] exited with preempt_count 2
bad: scheduling while atomic!
Call Trace:
 [<c011ed03>] schedule+0x8cc/0x8d1
 [<c015b6a5>] zap_pmd_range+0x47/0x63
 [<c015b704>] unmap_page_range+0x43/0x69
 [<c015b954>] unmap_vmas+0x22a/0x358
 [<c01615ad>] exit_mmap+0xce/0x2b7
 [<c012218a>] mmput+0xb7/0x145
 [<c01287ea>] do_exit+0x27e/0x8e1
 [<c010b378>] do_divide_error+0x0/0xfb
 [<c011c142>] do_page_fault+0x14a/0x476
 [<c028fd75>] blk_run_queues+0x148/0x353
 [<c025e033>] pty_write+0x1cd/0x1cf
 [<c0121d7c>] autoremove_wake_function+0x0/0x4f
 [<c0222960>] __copy_from_user_ll+0x74/0x78
 [<c0148735>] find_get_page+0x7a/0x161
 [<c011bff8>] do_page_fault+0x0/0x476
 [<c010abf5>] error_code+0x2d/0x38
 [<e4cbcd38>] m3_open+0x12d/0x3ad [maestro3]
 [<c018764f>] link_path_walk+0x85e/0xdd2
 [<e4c97a59>] soundcore_open+0x2a3/0x626 [soundcore]
 [<c0180a60>] exact_match+0x0/0x5
 [<c0180337>] chrdev_open+0x220/0x616
 [<c01733ac>] get_empty_filp+0x75/0xe8
 [<c0180117>] chrdev_open+0x0/0x616
 [<c0170e47>] dentry_open+0x14d/0x218
 [<c0170cf8>] filp_open+0x67/0x69
 [<c01714f8>] sys_open+0x5b/0x8b
 [<c010a179>] sysenter_past_esp+0x52/0x71

bad: scheduling while atomic!
Call Trace:
 [<c011ed03>] schedule+0x8cc/0x8d1
 [<c015b6a5>] zap_pmd_range+0x47/0x63
 [<c015b704>] unmap_page_range+0x43/0x69
 [<c015b954>] unmap_vmas+0x22a/0x358
 [<c01615ad>] exit_mmap+0xce/0x2b7
 [<c012218a>] mmput+0xb7/0x145
 [<c01287ea>] do_exit+0x27e/0x8e1
 [<c010b378>] do_divide_error+0x0/0xfb
 [<c011c142>] do_page_fault+0x14a/0x476
 [<c028fd75>] blk_run_queues+0x148/0x353
 [<c025e033>] pty_write+0x1cd/0x1cf
 [<c0121d7c>] autoremove_wake_function+0x0/0x4f
 [<c0222960>] __copy_from_user_ll+0x74/0x78
 [<c0148735>] find_get_page+0x7a/0x161
 [<c011bff8>] do_page_fault+0x0/0x476
 [<c010abf5>] error_code+0x2d/0x38
 [<e4cbcd38>] m3_open+0x12d/0x3ad [maestro3]
 [<c018764f>] link_path_walk+0x85e/0xdd2
 [<e4c97a59>] soundcore_open+0x2a3/0x626 [soundcore]
 [<c0180a60>] exact_match+0x0/0x5
 [<c0180337>] chrdev_open+0x220/0x616
 [<c01733ac>] get_empty_filp+0x75/0xe8
 [<c0180117>] chrdev_open+0x0/0x616
 [<c0170e47>] dentry_open+0x14d/0x218
 [<c0170cf8>] filp_open+0x67/0x69
 [<c01714f8>] sys_open+0x5b/0x8b
 [<c010a179>] sysenter_past_esp+0x52/0x71

This is with mplayer 0.90. I will try 2.6.0-test5-mm4 next.

Brad

__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free, easy-to-use web site design software
http://sitebuilder.yahoo.com
