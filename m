Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263017AbTJFJvP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 05:51:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262982AbTJFJvP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 05:51:15 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:26555 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S263017AbTJFJvN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 05:51:13 -0400
Date: Mon, 6 Oct 2003 11:51:12 +0200
From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Badness in local_bh_enable at kernel/softirq.c:119
Message-ID: <20031006095112.GB2070@stud.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-URL: http://wwwcip.informatik.uni-erlangen.de/~sithglan/
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I am encountering the following
'Badness in local_bh_enable at kernel/softirq.c:119'
when hanging up pppoe. This is of course reproducable for me.

Badness in local_bh_enable at kernel/softirq.c:119
Call Trace:
 [<c011d1b4>] local_bh_enable+0x38/0x54
 [<c029de95>] ppp_async_push+0x171/0x17c
 [<c029d68f>] ppp_asynctty_wakeup+0x27/0x4c
 [<c02446c7>] pty_unthrottle+0x23/0x48
 [<c0241541>] check_unthrottle+0x31/0x38
 [<c02415a0>] reset_buffer_flags+0x58/0x60
 [<c02415b3>] n_tty_flush_buffer+0xb/0x40
 [<c02449ee>] pty_flush_buffer+0x1a/0x48
 [<c023e7bf>] do_tty_hangup+0x113/0x31c
 [<c023e9e2>] tty_vhangup+0xa/0x10
 [<c024469d>] pty_close+0xfd/0x104
 [<c023f6aa>] release_dev+0x202/0x538
 [<c0138ce2>] unmap_page_range+0x3a/0x5c
 [<c023fd0e>] tty_release+0xa/0x10
 [<c0145f57>] __fput+0x3b/0xb0
 [<c0145f1b>] fput+0x13/0x14
 [<c0144cef>] filp_close+0x63/0x6c
 [<c011b298>] put_files_struct+0x4c/0xb4
 [<c011bc72>] do_exit+0x156/0x280
 [<c011bdc3>] sys_exit+0xf/0x10
 [<c010a627>] syscall_call+0x7/0xb

I am running http://linux.bkbits.net/linux-2.5 . Expect the kern.log
output I have no other problems.

Greetings,
	Thomas
