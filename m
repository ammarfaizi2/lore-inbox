Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261304AbTDMRrZ (for <rfc822;willy@w.ods.org>); Sun, 13 Apr 2003 13:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261320AbTDMRrZ (for <rfc822;linux-kernel-outgoing>);
	Sun, 13 Apr 2003 13:47:25 -0400
Received: from franka.aracnet.com ([216.99.193.44]:39871 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S261304AbTDMRrX (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Apr 2003 13:47:23 -0400
Date: Sun, 13 Apr 2003 10:59:05 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 580] New: freeze after ~12 hours of operation, kswapd OOPS in logs
Message-ID: <900000.1050256745@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=580

           Summary: freeze after ~12 hours of operation, kswapd OOPS in logs
    Kernel Version: 2.5.67
            Status: NEW
          Severity: normal
             Owner: akpm@digeo.com
         Submitter: mhughes@mhughes.dhs.org


Distribution: Red Hat 8.0
Hardware Environment: Athlon XP1900
Software Environment: gcc 3.2
Problem Description: hang - no ctrl-alt-del, no ping, etc.

Steps to reproduce: Happens consistently within 24 hours of bootup, had similar
problems with 2.5.65. Generally occurs when system is idle (X, a screensaver
running, possibly cron jobs).

ver_linux returns:
Linux penguin 2.5.67 #1 Sat Apr 12 20:42:46 PDT 2003 i686 athlon i386 GNU/Linux

Gnu C                  3.2
Gnu make               3.79.1
util-linux             2.11r
mount                  2.11r
module-init-tools      implemented
e2fsprogs              1.27
jfsutils               1.0.17
reiserfsprogs          3.6.2
pcmcia-cs              3.1.31
PPP                    2.4.1
isdn4k-utils           3.1pre4
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0.12
Modules Loaded

> From /var/log/messages:

Apr 13 04:04:41 penguin kernel: Unable to handle kernel paging request at
virtual address e628dfc0
Apr 13 04:04:41 penguin kernel:  printing eip:
Apr 13 04:04:41 penguin kernel: c013acb5
Apr 13 04:04:41 penguin kernel: *pde = 00000000
Apr 13 04:04:41 penguin kernel: Oops: 0002 [#1]
Apr 13 04:04:41 penguin kernel: CPU:    0
Apr 13 04:04:41 penguin kernel: EIP:    0060:[<c013acb5>]    Not tainted
Apr 13 04:04:41 penguin kernel: EFLAGS: 00010012
Apr 13 04:04:41 penguin kernel: EIP is at cache_flusharray+0x75/0x130
Apr 13 04:04:41 penguin kernel: eax: ffffffff   ebx: 0000000e   ecx: 03627bea  
edx: 00000006
Apr 13 04:04:41 penguin kernel: esi: d89ef000   edi: dffebd70   ebp: dfe29da0  
esp: dfe29d7c
Apr 13 04:04:41 penguin kernel: ds: 007b   es: 007b   ss: 0068
Apr 13 04:04:41 penguin kernel: Process kswapd0 (pid: 7, threadinfo=dfe28000
task=dfe3b880)
Apr 13 04:04:42 penguin kernel: Stack: dfe29d9c c01255f6 dffebd7c dffebd8c
dfe5ac10 0000007c dfe5ac00 00000282
Apr 13 04:04:42 penguin kernel:        d7f452c0 dfe29dbc c013ae70 dffebd70
dfe5ac00 dfe28000 d7f45280 00000001
Apr 13 04:04:42 penguin kernel:        dfe29dd4 c0145825 dffebd70 d7f452c0
00000005 d7f45280 dfe29df4 c01451f2
Apr 13 04:04:42 penguin kernel: Call Trace:
Apr 13 04:04:42 penguin kernel:  [<c01255f6>] update_process_times+0x46/0x50
Apr 13 04:04:42 penguin kernel:  [<c013ae70>] kmem_cache_free+0x40/0x50
Apr 13 04:04:42 penguin kernel:  [<c0145825>] __pte_chain_free+0x65/0x70
Apr 13 04:04:42 penguin kernel:  [<c01451f2>] page_referenced+0xb2/0xc0
Apr 13 04:04:42 penguin kernel:  [<c013dac7>] refill_inactive_zone+0x497/0x500
Apr 13 04:04:42 penguin kernel:  [<c011a596>] schedule+0x196/0x3a0
Apr 13 04:04:42 penguin kernel:  [<c0125a14>] schedule_timeout+0x64/0xb0
Apr 13 04:04:42 penguin kernel:  [<c01640a4>] dput+0x24/0x1e0
Apr 13 04:04:42 penguin kernel:  [<c01259a0>] process_timeout+0x0/0x10
Apr 13 04:04:42 penguin kernel:  [<c027dd22>] blk_congestion_wait+0x92/0xa0
Apr 13 04:04:42 penguin kernel:  [<c013dbc9>] shrink_zone+0x99/0xa0
Apr 13 04:04:42 penguin kernel:  [<c011bdc0>] autoremove_wake_function+0x0/0x50
Apr 13 04:04:42 penguin kernel:  [<c013de56>] balance_pgdat+0x106/0x170
Apr 13 04:04:42 penguin kernel:  [<c013dfa0>] kswapd+0xe0/0xf0
Apr 13 04:04:42 penguin kernel:  [<c011bdc0>] autoremove_wake_function+0x0/0x50
Apr 13 04:04:42 penguin kernel:  [<c010ad72>] ret_from_fork+0x6/0x14
Apr 13 04:04:42 penguin kernel:  [<c011bdc0>] autoremove_wake_function+0x0/0x50
Apr 13 04:04:42 penguin kernel:  [<c013dec0>] kswapd+0x0/0xf0
Apr 13 04:04:42 penguin kernel:  [<c0108e4d>] kernel_thread_helper+0x5/0x18
Apr 13 04:04:42 penguin kernel:
Apr 13 04:04:42 penguin kernel: Code: 89 44 8e 18 8b 46 10 89 4e 14 48 85 c0 89
46 10 0f 85 89 00
Apr 13 04:04:42 penguin kernel:  <6>note: kswapd0[7] exited with preempt_count 3
Apr 13 04:04:42 penguin kernel: Unable to handle kernel paging request at
virtual address e628dfc0
Apr 13 04:04:42 penguin kernel:  printing eip:

This was the last thing in the logs until restart. 

I'm afraid I'm not sure if/how to do oops decoding at the moment - /proc/ksyms
doesn't seem to exist? If someone can point me to a discussion or instructions
on this, I'd be happy to update this bug ...

