Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262761AbTJTUDq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 16:03:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262769AbTJTUDq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 16:03:46 -0400
Received: from toulouse-4-a7-62-147-202-252.dial.proxad.net ([62.147.202.252]:9856
	"EHLO albireo.free.fr") by vger.kernel.org with ESMTP
	id S262761AbTJTUDp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 16:03:45 -0400
Message-Id: <200310202004.h9KK42UH001490@albireo.free.fr>
Date: Mon, 20 Oct 2003 22:04:02 +0200 (CEST)
From: frahm@irsamc.ups-tlse.fr
Reply-To: frahm@irsamc.ups-tlse.fr
Subject: 2.6.0-test8: Badness in local_bh_enable at kernel/softirq.c:121
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got the following message in dmesg: 

Badness in local_bh_enable at kernel/softirq.c:121
Call Trace:
 [<c011e3de>] local_bh_enable+0x7e/0x80
 [<e88d7b90>] ppp_async_push+0x90/0x180 [ppp_async]
 [<c01621b5>] destroy_inode+0x35/0x60
 [<e88d7471>] ppp_asynctty_wakeup+0x31/0x70 [ppp_async]
 [<c02192a9>] uart_flush_buffer+0x59/0x60
 [<c01dc0c7>] do_tty_hangup+0x3a7/0x3f0
 [<c01dc18d>] disassociate_ctty+0x3d/0x130
 [<c011cb2f>] do_exit+0x1ff/0x2e0
 [<c011ccd4>] do_group_exit+0x54/0x80
 [<c012534e>] get_signal_to_deliver+0x1be/0x300
 [<c0109002>] do_signal+0xe2/0x120
 [<c015ca30>] __pollwait+0x0/0xd0
 [<c015d13d>] sys_select+0x25d/0x540
 [<c012550b>] sigprocmask+0x4b/0xc0
 [<c0109099>] do_notify_resume+0x59/0x5c
 [<c010923a>] work_notifysig+0x13/0x15


It appeared when I had strange problems with ppp, i.e. the access to
the name-server did not properly work and stopping of the pppd-daemon
led to the above message. This error is not reproducible, i.e. I could
establish a well working ppp-connection right after this. 
I can provide the full dmesg-log and .config if necessary or useful.


Greetings,

Klaus Frahm.




