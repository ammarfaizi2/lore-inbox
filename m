Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264669AbUFGNVj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264669AbUFGNVj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 09:21:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264733AbUFGNS4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 09:18:56 -0400
Received: from postfix3-2.free.fr ([213.228.0.169]:908 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP id S264697AbUFGNRy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 09:17:54 -0400
Message-ID: <40C46AF3.7040603@dlfp.org>
Date: Mon, 07 Jun 2004 15:17:39 +0200
From: Benoit Dejean <TazForEver@dlfp.org>
Reply-To: TazForEver@free.fr
User-Agent: Mozilla Thunderbird 0.6 (X11/20040528)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, cyplp@free.fr
Subject: Re: [2.6.6 panic] via-rhine and acpi sleep 3
References: <40C314C4.4080006@dlfp.org> <20040607123358.GB11860@elf.ucw.cz>
In-Reply-To: <20040607123358.GB11860@elf.ucw.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek a écrit :
> 
> Try suspend-to-disk working, first.

i'm working with set top box without disk, so i'm not interesting in 
STSW. i've been able to save some logs by mounting /var/log with NFS, 
but i've handwritten the kernel panic message.

so i've tried STSW, but it first failed because i have no swap partitions

Jun  7 14:51:24 cyp kernel: Stopping tasks: 
===========================================|
Jun  7 14:51:24 cyp kernel: Freeing memory: ......................|
Jun  7 14:51:24 cyp kernel: /critical section: counting pages to 
copy.[nosave pfn 0x2ed]........................... (pages needed: 
16186+512=16698 free: 41141)
Jun  7 14:51:24 cyp kernel: Suspend Machine: There's not enough swap 
space available, on 16698 pages short
Jun  7 14:51:24 cyp kernel: Suspend Machine: Suspend failed, trying to 
recover...
Jun  7 14:51:24 cyp kernel: Fixing swap signatures... ok
Jun  7 14:51:24 cyp kernel: Restarting tasks...<3>bad: scheduling while 
atomic!
Jun  7 14:51:24 cyp kernel: Call Trace:
Jun  7 14:51:24 cyp kernel:  [<c026ddb3>] schedule+0x5c3/0x5d0
Jun  7 14:51:24 cyp kernel:  [<c0111e8c>] try_to_wake_up+0x9c/0x150
Jun  7 14:51:24 cyp kernel:  [<c012a554>] thaw_processes+0xa4/0xe0
Jun  7 14:51:24 cyp kernel:  [<c012b98a>] software_suspend+0x8a/0xc0
Jun  7 14:51:24 cyp kernel:  [<c01d520a>] acpi_system_write_sleep+0x6a/0x90
Jun  7 14:51:24 cyp sleepd[402]: 14 sec sleep; resetting timer
Jun  7 14:51:24 cyp kernel:  [<c01d51a0>] acpi_system_write_sleep+0x0/0x90
Jun  7 14:51:24 cyp kernel:  [<c0147cad>] vfs_write+0x9d/0x100
Jun  7 14:51:24 cyp kernel:  [<c0147d8c>] sys_write+0x2c/0x50
Jun  7 14:51:24 cyp kernel:  [<c0103e47>] syscall_call+0x7/0xb
Jun  7 14:51:24 cyp kernel:
Jun  7 14:51:24 cyp kernel:  done
Jun  7 14:51:24 cyp kernel: bad: scheduling while atomic!
Jun  7 14:51:24 cyp kernel: Call Trace:
Jun  7 14:51:24 cyp kernel:  [<c026ddb3>] schedule+0x5c3/0x5d0
Jun  7 14:51:24 cyp kernel:  [<c0147cc1>] vfs_write+0xb1/0x100
Jun  7 14:51:24 cyp kernel:  [<c0147d8c>] sys_write+0x2c/0x50
Jun  7 14:51:24 cyp kernel:  [<c0103e7a>] work_resched+0x5/0x16
Jun  7 14:51:24 cyp kernel:
Jun  7 14:51:24 cyp kernel: bad: scheduling while atomic!
Jun  7 14:51:24 cyp kernel: Call Trace:
Jun  7 14:51:24 cyp kernel:  [<c026ddb3>] schedule+0x5c3/0x5d0
Jun  7 14:51:24 cyp kernel:  [<c0115ff7>] release_console_sem+0xc7/0xd0
Jun  7 14:51:24 cyp kernel:  [<c0115e6d>] printk+0x10d/0x180
Jun  7 14:51:24 cyp kernel:  [<c0113207>] sys_sched_yield+0x87/0xd0
Jun  7 14:51:24 cyp kernel:  [<c01524db>] coredump_wait+0x2b/0x90
Jun  7 14:51:24 cyp kernel:  [<c0152633>] do_coredump+0xf3/0x1b1
Jun  7 14:51:24 cyp kernel:  [<c0129b01>] kallsyms_lookup+0x1b1/0x1c0
Jun  7 14:51:24 cyp kernel:  [<c011d64b>] __dequeue_signal+0xeb/0x170
Jun  7 14:51:24 cyp kernel:  [<c011d635>] __dequeue_signal+0xd5/0x170
Jun  7 14:51:24 cyp kernel:  [<c011d6e5>] dequeue_signal+0x15/0x70
Jun  7 14:51:24 cyp kernel:  [<c011eefe>] get_signal_to_deliver+0x25e/0x350
Jun  7 14:51:24 cyp kernel:  [<c0103bb4>] do_signal+0x54/0xe0
Jun  7 14:51:24 cyp kernel:  [<c0115e6d>] printk+0x10d/0x180
Jun  7 14:51:24 cyp kernel:  [<c0111c77>] recalc_task_prio+0xb7/0x230
Jun  7 14:51:24 cyp kernel:  [<c0104316>] show_trace+0x66/0xc0
Jun  7 14:51:24 cyp kernel:  [<c026db13>] schedule+0x323/0x5d0
Jun  7 14:51:24 cyp kernel:  [<c0110db0>] do_page_fault+0x0/0x4dc
Jun  7 14:51:24 cyp kernel:  [<c0103c77>] do_notify_resume+0x37/0x40
Jun  7 14:51:24 cyp kernel:  [<c0103e9e>] work_notifysig+0x13/0x15

after adding a swap file, i've tried again
saving did well, but when trying to wake up my box rebooted it. nothing 
in the log.

i'm very willing to make tests but my boss he's not :/ so i have no time 
to spend on testing Suspend To Disk.

thank you
