Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262925AbUB0S7l (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 13:59:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262934AbUB0S7k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 13:59:40 -0500
Received: from smtp-out1.xs4all.nl ([194.109.24.11]:62729 "EHLO
	smtp-out1.xs4all.nl") by vger.kernel.org with ESMTP id S262925AbUB0S6T
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 13:58:19 -0500
Date: Fri, 27 Feb 2004 19:57:58 +0100
From: Jurriaan <thunder7@xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: bio_put oopses in 2.6.3-mm3 when resyncing reiserfs/raid1
Message-ID: <20040227185758.GA8450@middle.of.nowhere>
Reply-To: Jurriaan <thunder7@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Message-Flag: Still using Outlook? Please Upgrade to real software!
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got this in 2.6.3-mm3 when rsyncing my reiserfs on raid1 system.
The taint is vmware (with the latest vmware-any-any updates) but X
hadn't been started, let alone vmware. It happened multiple times,
until I rebooted 2.6.3-mm1 and all was fine again. I don't see any
patches in 2.6.3-mm4 that would solve this, and I couldn't find any
similar reports on lkml.

So here goes:

Feb 27 13:45:26 middle kernel:  printing eip:
Feb 27 13:45:26 middle kernel: c015a889
Feb 27 13:45:26 middle kernel: Oops: 0000 [#1]
Feb 27 13:45:26 middle kernel: PREEMPT 
Feb 27 13:45:26 middle kernel: CPU:    0
Feb 27 13:45:26 middle kernel: EIP:    0060:[bio_put+9/64]    Tainted: P   VLI
Feb 27 13:45:26 middle kernel: EFLAGS: 00010282
Feb 27 13:45:26 middle kernel: EIP is at bio_put+0x9/0x40
Feb 27 13:45:26 middle kernel: eax: 00000000   ebx: 00000000   ecx: f7c05b80   edx: 00000000
Feb 27 13:45:26 middle kernel: esi: 00000002   edi: 00000000   ebp: f7b79e0c   esp: f7b79e08
Feb 27 13:45:26 middle kernel: ds: 007b   es: 007b   ss: 0068
Feb 27 13:45:26 middle kernel: Process md0_resync (pid: 17, threadinfo=f7b78000 task=f7b8d210)
Feb 27 13:45:26 middle kernel: Stack: f5b8c980 f7b79e34 c03a009a 00000000 00000010 00000000 f5b8cbc0 f64781c0 
Feb 27 13:45:26 middle kernel:        f7b78000 f7c0b5c0 f7b79e60 f7b79e98 c013be37 00000200 f7c05b80 00000000 
Feb 27 13:45:26 middle kernel:        c030157d 00000000 f7b8d210 c011eea0 f7b79e78 f7b79e78 f7daf800 f572f900 
Feb 27 13:45:26 middle kernel: Call Trace:
Feb 27 13:45:26 middle kernel:  [r1buf_pool_alloc+282/304] r1buf_pool_alloc+0x11a/0x130
Feb 27 13:45:26 middle kernel:  [mempool_alloc+103/336] mempool_alloc+0x67/0x150
Feb 27 13:45:26 middle kernel:  [generic_make_request+269/400] generic_make_request+0x10d/0x190
Feb 27 13:45:26 middle kernel:  [autoremove_wake_function+0/80] autoremove_wake_function+0x0/0x50
Feb 27 13:45:26 middle kernel:  [autoremove_wake_function+0/80] autoremove_wake_function+0x0/0x50
Feb 27 13:45:26 middle kernel:  [bio_add_page+51/64] bio_add_page+0x33/0x40
Feb 27 13:45:26 middle kernel:  [sync_request+236/912] sync_request+0xec/0x390
Feb 27 13:45:26 middle kernel:  [md_do_sync+540/1872] md_do_sync+0x21c/0x750
Feb 27 13:45:26 middle kernel:  [md_thread+198/416] md_thread+0xc6/0x1a0
Feb 27 13:45:26 middle kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
Feb 27 13:45:26 middle kernel:  [md_thread+0/416] md_thread+0x0/0x1a0
Feb 27 13:45:26 middle kernel:  [kernel_thread_helper+5/12] kernel_thread_helper+0x5/0xc
Feb 27 13:45:26 middle kernel: 
Feb 27 13:45:26 middle kernel: Code: c7 00 05 00 00 00 e9 29 ff ff ff c7 45 f0 04 00 00 00 e9 1d ff ff ff 8d 74 26 00 8d bc 27 00 00 00 00 55 89 e5 83 ec 04 8b 55 08 <8b> 42 2c 85 c0 74 1b ff 4a 2c 0f 94 c0 84 c0 75 02 c9 c3 c7 42 

.config available on request, of course.

Kind regards,
Jurriaan
-- 
Okay...how did Aragorn turn a Broken Sword into Anarion?  The book
mentions "forging".  Nice euphemism for "hacking"; he obviously went
to the Forge of Hex Editing.  I think he took cheating lessons from
Gandalf.
	point 2 (new) in 'Tolkien's poor writing'.
Debian (Unstable) GNU/Linux 2.6.3-mm3 3940 bogomips load av: 0.62 0.74 0.53
