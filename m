Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267549AbUHTBKN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267549AbUHTBKN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 21:10:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267548AbUHTBKM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 21:10:12 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:39669 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S267549AbUHTBJx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 21:09:53 -0400
Subject: Re: 2.6.8.1-mm2
From: Nathan Lynch <nathanl@austin.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Srivatsa Vaddagiri <vatsa@in.ibm.com>,
       Rusty Russell <rusty@rustcorp.com.au>
In-Reply-To: <20040819014204.2d412e9b.akpm@osdl.org>
References: <20040819014204.2d412e9b.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1092964083.4946.7.camel@biclops.private.network>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 19 Aug 2004 20:08:03 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +dont-sleep-after-were-out-of-task-list.patch
> 
>  CPU hotplug race fix

I don't mean to be a pain, but this patch does not fix the bug I
reported.  It is still occurring on i386 and ppc64 (and proc_pid_flush
now generates lots of might_sleep warnings).

kernel BUG in migration_call at kernel/sched.c:4044!
cpu 0x1: Vector: 700 (Program Check) at [c00000027c7cb640]
    pc: c00000000004e730: .migration_call+0x150/0x350
    lr: c00000000004e6f4: .migration_call+0x114/0x350
    sp: c00000027c7cb8c0
   msr: 8000000000029032
  current = 0xc00000027c3d0a40
  paca    = 0xc000000000434880
    pid   = 4657, comm = cpuonoff.pl
1:mon> t
[c00000027c7cb8c0] c00000000004e6d8 .migration_call+0xf8/0x350 (unreliable)
[c00000027c7cb970] c000000000067330 .notifier_call_chain+0x58/0x98
[c00000027c7cba00] c0000000000743ec .cpu_down+0x1e0/0x364
[c00000027c7cbae0] c0000000001fcd3c .store_online+0x68/0x70
[c00000027c7cbb60] c0000000001f86bc .sysdev_store+0x54/0x60
[c00000027c7cbbe0] c0000000000fef70 .flush_write_buffer+0x48/0x60
[c00000027c7cbc60] c0000000000fefe8 .sysfs_write_file+0x60/0x78
[c00000027c7cbcf0] c0000000000ac720 .vfs_write+0x10c/0x164
[c00000027c7cbd90] c0000000000ac874 .sys_write+0x58/0xa4
[c00000027c7cbe30] c000000000011e00 syscall_exit+0x0/0x18
--- Exception: c01 (System Call) at 000000000fe562f8
SP (ffffe390) is in userspace


Hopefully, I should have time to perform a bisection search this
weekend.

Nathan

