Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261862AbTJ1XOx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 18:14:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261863AbTJ1XOx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 18:14:53 -0500
Received: from genericorp.net ([69.56.190.66]:64959 "EHLO
	narbuckle.genericorp.net") by vger.kernel.org with ESMTP
	id S261862AbTJ1XOv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 18:14:51 -0500
Date: Tue, 28 Oct 2003 17:12:35 -0600 (CST)
From: Dave O <cxreg@pobox.com>
X-X-Sender: count@narbuckle.genericorp.net
To: linux-kernel@vger.kernel.org
Subject: Re: ppp - Badness in local_bh_enable at kernel/softirq.c:113
In-Reply-To: <Pine.LNX.4.58.0310281607150.19873@narbuckle.genericorp.net>
Message-ID: <Pine.LNX.4.58.0310281710400.21622@narbuckle.genericorp.net>
References: <Pine.LNX.4.58.0310281607150.19873@narbuckle.genericorp.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sorry, the line number under test9 is kernel/softirq.c:121, it was 113
under test1.  Stack trace is mostly the same, however.

BTW this is pppd version 2.4.2b3 on Debian sid using gcc version 3.3.2

Badness in local_bh_enable at kernel/softirq.c:121
Call Trace:
 [<c011d991>] local_bh_enable+0x85/0x87
 [<e090cb34>] ppp_async_push+0x9e/0x180 [ppp_async]
 [<e090c458>] ppp_asynctty_wakeup+0x2d/0x5e [ppp_async]
 [<c0293a8b>] pty_unthrottle+0x58/0x5a
 [<c02906b5>] check_unthrottle+0x39/0x3b
 [<c0290757>] n_tty_flush_buffer+0x13/0x55
 [<c0293e4c>] pty_flush_buffer+0x66/0x68
 [<c028d023>] do_tty_hangup+0x47a/0x4db
 [<c028e5e0>] release_dev+0x6d8/0x704
 [<c013d451>] unmap_page_range+0x43/0x69
 [<c028e95c>] tty_release+0x0/0x66
 [<c028e989>] tty_release+0x2d/0x66
 [<c014cdcf>] __fput+0x110/0x122
 [<c014b4b5>] filp_close+0x59/0x86
 [<c011b3d1>] put_files_struct+0x84/0xe9
 [<c011bfd6>] do_exit+0x165/0x400
 [<c013f9ba>] sys_brk+0xd8/0xfd
 [<c011c2f8>] do_group_exit+0x3a/0xac
 [<c0108fd7>] syscall_call+0x7/0xb

On Tue, 28 Oct 2003, Dave O wrote:

>
> I reported this almost 3 months ago in test1, and it still happens in
> test9
>
> Simply running the command "/usr/sbin/pppd updetach pty /bin/false" will
> cause a "Badness" message and this trace:
>
