Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261786AbTJ1XDT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 18:03:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261784AbTJ1XDT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 18:03:19 -0500
Received: from genericorp.net ([69.56.190.66]:48831 "EHLO
	narbuckle.genericorp.net") by vger.kernel.org with ESMTP
	id S261786AbTJ1XDR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 18:03:17 -0500
Date: Tue, 28 Oct 2003 17:01:00 -0600 (CST)
From: Dave O <cxreg@pobox.com>
X-X-Sender: count@narbuckle.genericorp.net
To: linux-kernel@vger.kernel.org
Subject: ppp - Badness in local_bh_enable at kernel/softirq.c:113
Message-ID: <Pine.LNX.4.58.0310281607150.19873@narbuckle.genericorp.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I reported this almost 3 months ago in test1, and it still happens in
test9

Simply running the command "/usr/sbin/pppd updetach pty /bin/false" will
cause a "Badness" message and this trace:

Badness in local_bh_enable at kernel/softirq.c:119

Call Trace:
 [<c011da95>] local_bh_enable+0x85/0x87
 [<e090db34>] ppp_async_push+0x9e/0x180 [ppp_async]
 [<e090d458>] ppp_asynctty_wakeup+0x2d/0x5e [ppp_async]
 [<c0293c07>] pty_unthrottle+0x58/0x5a
 [<c02906c9>] check_unthrottle+0x39/0x3b
 [<c029076b>] n_tty_flush_buffer+0x13/0x55
 [<c0293fc8>] pty_flush_buffer+0x66/0x68
 [<c028cfc5>] do_tty_hangup+0x489/0x4ef
 [<c028e5b7>] release_dev+0x6f8/0x724
 [<c013d701>] unmap_page_range+0x43/0x69
 [<c028e933>] tty_release+0x0/0x66
 [<c028e960>] tty_release+0x2d/0x66
 [<c014cf2f>] __fput+0x110/0x122
 [<c014b615>] filp_close+0x59/0x86
 [<c011b4a9>] put_files_struct+0x84/0xe9
 [<c011c10a>] do_exit+0x165/0x400
 [<c013fc7e>] sys_brk+0xd8/0xfd
 [<c011c42c>] do_group_exit+0x3a/0xac
 [<c0108fd3>] syscall_call+0x7/0xb


