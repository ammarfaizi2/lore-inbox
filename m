Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263884AbUCZBHu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 20:07:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263883AbUCZAb1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 19:31:27 -0500
Received: from slimnet.xs4all.nl ([194.109.194.192]:46532 "EHLO slimnas.slim")
	by vger.kernel.org with ESMTP id S263833AbUCZAIy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 19:08:54 -0500
Subject: 2.6.5-rc2-mm3 badness
From: Jurgen Kramer <gtm.kramer@inter.nl.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1080260047.10146.4.camel@paragon.slim>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 26 Mar 2004 01:14:07 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I not sure if this has been reported yet but after booting 2.6.5-rc2-mm3
I get:

Mar 26 01:05:44 paragon kernel: on+0x8c/0x114
Mar 26 01:05:44 paragon kernel:  [<c011d8d9>]
default_wake_function+0x0/0xc
Mar 26 01:05:44 paragon kernel:  [<c011d8d9>]
default_wake_function+0x0/0xc
Mar 26 01:05:44 paragon kernel:  [<c011be87>]
sched_migrate_task+0x94/0x9d
Mar 26 01:05:44 paragon kernel:  [<c011bfd6>]
sched_balance_exec+0x5d/0x7b
Mar 26 01:05:44 paragon kernel:  [<c0164f9c>] do_execve+0x16/0x201
Mar 26 01:05:44 paragon kernel:  [<c0140d24>]
buffered_rmqueue+0x110/0x214
Mar 26 01:05:44 paragon kernel:  [<c0140ed3>] __alloc_pages+0xab/0x2e0
Mar 26 01:05:44 paragon kernel:  [<c0150656>]
page_remove_rmap+0x18/0x197
Mar 26 01:05:44 paragon kernel:  [<c014b75c>] do_wp_page+0x247/0x3ae
Mar 26 01:05:44 paragon kernel:  [<c014c7ec>]
handle_mm_fault+0x187/0x1eb
Mar 26 01:05:44 paragon syslog: klogd startup succeeded
Mar 26 01:05:44 paragon kernel:  [<c011a0ff>] do_page_fault+0x2b8/0x49f
Mar 26 01:05:44 paragon kernel:  [<c012e079>] do_sigaction+0x197/0x254
Mar 26 01:05:44 paragon kernel:  [<c012e4a4>] sys_rt_sigaction+0xd4/0xef
Mar 26 01:05:44 paragon kernel:  [<c0107b65>] sys_execve+0x35/0x68
Mar 26 01:05:44 paragon kernel:  [<c025497a>]
sysenter_past_esp+0x43/0x65
Mar 26 01:05:44 paragon kernel:
Mar 26 01:05:44 paragon kernel: bad: scheduling while atomic!
Mar 26 01:05:44 paragon kernel: Call Trace:
Mar 26 01:05:44 paragon kernel:  [<c011d891>] schedule+0x814/0x819
Mar 26 01:05:44 paragon kernel:  [<c0140d24>]
buffered_rmqueue+0x110/0x214
Mar 26 01:05:44 paragon kernel:  [<c011af9a>]
recalc_task_prio+0x8f/0x183
Mar 26 01:05:44 paragon kernel:  [<c011b0ea>] activate_task+0x5c/0x70
Mar 26 01:05:44 paragon kernel:  [<c011db9a>]
wait_for_completion+0x8c/0x114
Mar 26 01:05:44 paragon irqbalance: irqbalance startup succeeded
Mar 26 01:05:44 paragon kernel:  [<c011d8d9>]
default_wake_function+0x0/0xc
Mar 26 01:05:44 paragon kernel:  [<c011d8d9>]
default_wake_function+0x0/0xc
Mar 26 01:05:44 paragon kernel:  [<c011be87>]
sched_migrate_task+0x94/0x9d
Mar 26 01:05:44 paragon kernel:  [<c011bfd6>]
sched_balance_exec+0x5d/0x7b
Mar 26 01:05:44 paragon kernel:  [<c0164f9c>] do_execve+0x16/0x201
Mar 26 01:05:44 paragon kernel:  [<c0140d24>]
buffered_rmqueue+0x110/0x214
Mar 26 01:05:44 paragon kernel:  [<c0140ed3>] __alloc_pages+0xab/0x2e0
Mar 26 01:05:44 paragon kernel:  [<c0150656>]
page_remove_rmap+0x18/0x197
Mar 26 01:05:44 paragon kernel:  [<c014b75c>] do_wp_page+0x247/0x3ae
Mar 26 01:05:44 paragon kernel:  [<c014c7ec>]
handle_mm_fault+0x187/0x1eb
Mar 26 01:05:44 paragon kernel:  [<c011a0ff>] do_page_fault+0x2b8/0x49f
Mar 26 01:05:44 paragon kernel:  [<c012e090>] do_sigaction+0x1ae/0x254
Mar 26 01:05:44 paragon kernel:  [<c012e4a4>] sys_rt_sigaction+0xd4/0xef
Mar 26 01:05:44 paragon kernel:  [<c0107b65>] sys_execve+0x35/0x68
Mar 26 01:05:44 paragon kernel:  [<c025497a>]
sysenter_past_esp+0x43/0x65

Which keeps on going and going. I manage to get a login prompt but the
messages keep coming and the systems freezes. If more details are
needed...

Jurgen


