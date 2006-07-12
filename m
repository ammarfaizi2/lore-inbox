Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751019AbWGLUpR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751019AbWGLUpR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 16:45:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751228AbWGLUpR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 16:45:17 -0400
Received: from tornado.reub.net ([202.89.145.182]:7092 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S1751019AbWGLUpQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 16:45:16 -0400
Message-ID: <44B55F5C.4080203@reub.net>
Date: Thu, 13 Jul 2006 08:45:16 +1200
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Thunderbird 3.0a1 (Windows/20060711)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc1-mm1
References: <20060709021106.9310d4d1.akpm@osdl.org>
In-Reply-To: <20060709021106.9310d4d1.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/07/2006 9:11 p.m., Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc1/2.6.18-rc1-mm1/
> 
> - We're getting a relatively large number of crash reports coming out of the
>   core sysfs/kobject/driver/bus code, and they're all really hard to diagnose.

Just noticed this in the logs from yesterday.  It didn't cause the machine to go 
down so I didn't notice it at the time:

Jul 12 13:48:47 tornado smartd[1853]: Device: /dev/sdb, SMART Usage Attribute: 
195 Hardware_ECC_Recovered changed from 64 to 63
Jul 12 13:51:24 tornado kernel: rpmq[11203]: segfault at 00002b3f41eb445f rip 
00002b3f44aa7108 rsp 00007fff667aef80 error 4
Jul 12 13:51:24 tornado kernel: general protection fault: 0000 [1] SMP
Jul 12 13:51:24 tornado kernel: last sysfs file: /block/fd0/dev
Jul 12 13:51:24 tornado kernel: CPU 1
Jul 12 13:51:24 tornado kernel: Modules linked in: hidp rfcomm l2cap bluetooth 
ipv6 ip_gre iptable_filter iptable_nat ip_nat ip_conntrack nfnetlink iptable_man
gle ip_tables binfmt_misc i2c_i801 iTCO_wdt serio_raw
Jul 12 13:51:24 tornado kernel: Pid: 5067, comm: nagios Not tainted 
2.6.18-rc1-mm1 #1
Jul 12 13:51:24 tornado kernel: RIP: 0010:[<ffffffff8028f3a1>] 
[<ffffffff8028f3a1>] notifier_call_chain+0x1e/0x45
Jul 12 13:51:24 tornado kernel: RSP: 0018:ffff810012979d58  EFLAGS: 00010202
Jul 12 13:51:24 tornado kernel: RAX: 6b6b6b6b6b6b6b6b RBX: ffff810014ae5040 RCX: 
6b6b6b6b6b6b6b6b
Jul 12 13:51:24 tornado kernel: RDX: ffff810014ae5040 RSI: 0000000000000001 RDI: 
ffff810008034f88
Jul 12 13:51:24 tornado kernel: RBP: ffff810012979d78 R08: 0000000000000000 R09: 
0000000000000001
Jul 12 13:51:24 tornado kernel: R10: 0000000000000001 R11: 0000000000000001 R12: 
ffff810014ae5040
Jul 12 13:51:24 tornado kernel: R13: 0000000000000001 R14: ffff810014ae5040 R15: 
ffff810014ae5040
Jul 12 13:51:24 tornado kernel: FS:  00002b8b610af6f0(0000) 
GS:ffff81003f6eb430(0000) knlGS:0000000000000000
Jul 12 13:51:24 tornado kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
Jul 12 13:51:24 tornado kernel: CR2: 0000000000678ae8 CR3: 000000000c86e000 CR4: 
00000000000006e0
Jul 12 13:51:24 tornado kernel: Process nagios (pid: 5067, threadinfo 
ffff810012978000, task ffff810020fce080)
Jul 12 13:51:24 tornado kernel: Stack:  ffff810012979d88 ffff810014ae5040 
0000000000000001 0000000001200011
Jul 12 13:51:24 tornado kernel:  ffff810012979d88 ffffffff8028f3f6 
ffff810012979da8 ffffffff8028f76f
Jul 12 13:51:24 tornado kernel:  ffff81002375e000 ffff810020fce080 
ffff810012979e78 ffffffff8021ea6c
Jul 12 13:51:24 tornado kernel: Call Trace:
Jul 12 13:51:24 tornado kernel:  [<ffffffff8028f3f6>] 
raw_notifier_call_chain+0x9/0x13
Jul 12 13:51:24 tornado kernel:  [<ffffffff8028f76f>] notify_watchers+0x64/0x69
Jul 12 13:51:24 tornado kernel:  [<ffffffff8021ea6c>] copy_process+0x4dc/0x15c0
Jul 12 13:51:24 tornado kernel:  [<ffffffff80231837>] do_fork+0xf7/0x208
Jul 12 13:51:24 tornado kernel:  [<ffffffff80268ad0>] sys_clone+0x23/0x25
Jul 12 13:51:24 tornado kernel:  [<ffffffff8025f4c7>] ptregscall_common+0x67/0xac
Jul 12 13:51:24 tornado kernel:  [<ffffffff8025f182>] system_call+0x7e/0x83
Jul 12 13:51:24 tornado kernel:  [<00002b8b60df8aa9>]
Jul 12 13:51:24 tornado kernel:
Jul 12 13:51:24 tornado kernel: Code: 48 8b 59 08 4c 89 e2 4c 89 ee 48 89 cf ff 
11 66 85 c0 78 08
Jul 12 13:51:24 tornado kernel: RIP  [<ffffffff8028f3a1>] 
notifier_call_chain+0x1e/0x45
Jul 12 13:51:24 tornado kernel:  RSP <ffff810012979d58>
Jul 12 14:18:46 tornado smartd[1853]: Device: /dev/sdb, SMART Prefailure 
Attribute: 1 Raw_Read_Error_Rate changed from 63 to 64

I'm not sure who the relevant people are to look at this in more detail.

Reuben
