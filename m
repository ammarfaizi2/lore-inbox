Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261682AbVCGISt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261682AbVCGISt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 03:18:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261684AbVCGISt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 03:18:49 -0500
Received: from www.pixelized.ch ([195.190.190.7]:32237 "EHLO mail.pixelized.ch")
	by vger.kernel.org with ESMTP id S261682AbVCGISj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 03:18:39 -0500
Message-ID: <422C0E2D.9070805@pixelized.ch>
Date: Mon, 07 Mar 2005 09:17:49 +0100
From: "Giacomo A. Catenazzi" <cate@pixelized.ch>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: oops in 2.6.11: "XFree86[2780] exited with preempt_count 1"
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

An oops in last kernel. I happens on early shutdown.

I had two other oops in last week (with latest bk tree), but
I was hard crash (still in X) and without any logs.
Because of these thee crash (over some more restart), I think
the bug is probably reproducible.

BTW, there is an extra space before "<6>note"

Mar  7 08:54:20 catee kernel: ------------[ cut here ]------------
Mar  7 08:54:20 catee kernel: PREEMPT SMP
Mar  7 08:54:20 catee kernel: Modules linked in: iptable_mangle ipt_TOS ehci_hcd
Mar  7 08:54:20 catee kernel: CPU:    2
Mar  7 08:54:20 catee kernel: EIP:    0060:[page_remove_rmap+42/64]    Not tainted VLI
Mar  7 08:54:20 catee kernel: EFLAGS: 00013286   (2.6.11-rc5)
Mar  7 08:54:20 catee kernel: EIP is at page_remove_rmap+0x2a/0x40
Mar  7 08:54:20 catee kernel: eax: ffffffff   ebx: c1f20ee0   ecx: 00000000   edx: c1fb9860
Mar  7 08:54:20 catee kernel: esi: f72b3a7c   edi: fffd7000   ebp: c1fb9860   esp: f71d0e98
Mar  7 08:54:20 catee kernel: ds: 007b   es: 007b   ss: 0068
Mar  7 08:54:20 catee kernel: Process XFree86 (pid: 2780, threadinfo=f71d0000 task=f7239530)
Mar  7 08:54:20 catee kernel: Stack: c01462bc f7239530 f773c5c0 fffd6000 fffd7000 f773c5c0 0869f298 f7636804
Mar  7 08:54:20 catee kernel:        f773c580 f75ed084 f773c580 0869f298 f773c5c0 c01471f7 f72b3a7c f75ed084
Mar  7 08:54:20 catee kernel:        7dcc3065 00000001 f7636804 f773c580 f773c5ac f7636804 f7239530 c0114fe4
Mar  7 08:54:20 catee kernel: Call Trace:
Mar  7 08:54:20 catee kernel:  [do_wp_page+540/752] do_wp_page+0x21c/0x2f0
Mar  7 08:54:20 catee kernel:  [handle_mm_fault+311/336] handle_mm_fault+0x137/0x150
Mar  7 08:54:20 catee kernel:  [do_page_fault+388/1394] do_page_fault+0x184/0x572
Mar  7 08:54:20 catee kernel:  [do_signal+187/288] do_signal+0xbb/0x120
Mar  7 08:54:20 catee kernel:  [__wake_up+56/80] __wake_up+0x38/0x50
Mar  7 08:54:20 catee kernel:  [unix_release_sock+352/576] unix_release_sock+0x160/0x240
Mar  7 08:54:20 catee kernel:  [invalidate_inode_buffers+21/144] invalidate_inode_buffers+0x15/0x90
Mar  7 08:54:20 catee kernel:  [clear_inode+18/208] clear_inode+0x12/0xd0
Mar  7 08:54:20 catee kernel:  [destroy_inode+53/64] destroy_inode+0x35/0x40
Mar  7 08:54:20 catee kernel:  [dput+30/416] dput+0x1e/0x1a0
Mar  7 08:54:20 catee kernel:  [__fput+185/288] __fput+0xb9/0x120
Mar  7 08:54:20 catee kernel:  [filp_close+79/128] filp_close+0x4f/0x80
Mar  7 08:54:20 catee kernel:  [do_page_fault+0/1394] do_page_fault+0x0/0x572
Mar  7 08:54:20 catee kernel:  [error_code+43/48] error_code+0x2b/0x30
Mar  7 08:54:20 catee kernel: Code: 00 89 c2 8b 00 f6 c4 08 75 2c f0 83 42 08 ff 0f 98 c0 84 c0
74 1f 8b 42 08 40 78 0f ba ff ff ff ff b8 10 00 00 00 e9 66 0a ff ff <0f> 0b e2 01 a1 b4 37 c0
eb e7 c3 0f 0b df 01 a1 b4 37 c0 eb ca
Mar  7 08:54:20 catee kernel:  <6>note: XFree86[2780] exited with preempt_count 1

ciao
	cate
