Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262100AbTESNED (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 09:04:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262457AbTESNEC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 09:04:02 -0400
Received: from [195.95.38.160] ([195.95.38.160]:28149 "HELO mail.vt4.net")
	by vger.kernel.org with SMTP id S262100AbTESND7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 09:03:59 -0400
From: DevilKin <devilkin-lkml@blindguardian.org>
To: linux-kernel@vger.kernel.org
Subject: [2.5.69] Badness in local_bh_enable at kernel/softirq.c:105
Date: Mon, 19 May 2003 15:17:35 +0200
User-Agent: KMail/1.5.1
Cc: devilkin-lkml@blindguardian.org
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200305191517.41969.devilkin-lkml@blindguardian.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

In my syslogs this popped up today

May 19 12:13:59 laptop kernel: Badness in local_bh_enable at kernel/softirq.c:105
May 19 12:13:59 laptop kernel: Call Trace:
May 19 12:13:59 laptop kernel:  [local_bh_enable+141/144] local_bh_enable+0x8d/0x90
May 19 12:13:59 laptop kernel:  [_end+282016342/1070304612] ppp_async_push+0xa2/0x1b0 [ppp_async]
May 19 12:13:59 laptop kernel:  [_end+282014469/1070304612] ppp_asynctty_wakeup+0x31/0x70 [ppp_async]
May 19 12:13:59 laptop kernel:  [uart_flush_buffer+117/128] uart_flush_buffer+0x75/0x80
May 19 12:13:59 laptop kernel:  [do_tty_hangup+1092/1168] do_tty_hangup+0x444/0x490
May 19 12:13:59 laptop kernel:  [worker_thread+511/736] worker_thread+0x1ff/0x2e0
May 19 12:13:59 laptop kernel:  [do_tty_hangup+0/1168] do_tty_hangup+0x0/0x490
May 19 12:13:59 laptop kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
May 19 12:13:59 laptop kernel:  [ret_from_fork+6/20] ret_from_fork+0x6/0x14
May 19 12:13:59 laptop kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
May 19 12:13:59 laptop pppd[828]: Hangup (SIGHUP)
May 19 12:13:59 laptop pppd[828]: Modem hangup
May 19 12:13:59 laptop pppd[828]: Connection terminated.
May 19 12:13:59 laptop kernel:  [worker_thread+0/736] worker_thread+0x0/0x2e0
May 19 12:13:59 laptop kernel:  [kernel_thread_helper+5/24] kernel_thread_helper+0x5/0x18
May 19 12:13:59 laptop kernel:
May 19 12:13:59 laptop kernel: Badness in local_bh_enable at kernel/softirq.c:105
May 19 12:13:59 laptop kernel: Call Trace:
May 19 12:13:59 laptop kernel:  [local_bh_enable+141/144] local_bh_enable+0x8d/0x90
May 19 12:13:59 laptop kernel:  [_end+281914454/1070304612] ppp_channel_push+0xb2/0x1d0 [ppp_generic]
May 19 12:13:59 laptop kernel:  [_end+282014511/1070304612] ppp_asynctty_wakeup+0x5b/0x70 [ppp_async]
May 19 12:13:59 laptop kernel:  [uart_flush_buffer+117/128] uart_flush_buffer+0x75/0x80
May 19 12:13:59 laptop kernel:  [do_tty_hangup+1092/1168] do_tty_hangup+0x444/0x490
May 19 12:13:59 laptop kernel:  [worker_thread+511/736] worker_thread+0x1ff/0x2e0
May 19 12:13:59 laptop kernel:  [do_tty_hangup+0/1168] do_tty_hangup+0x0/0x490
May 19 12:13:59 laptop kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
May 19 12:13:59 laptop kernel:  [ret_from_fork+6/20] ret_from_fork+0x6/0x14
May 19 12:13:59 laptop kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
May 19 12:13:59 laptop kernel:  [worker_thread+0/736] worker_thread+0x0/0x2e0
May 19 12:13:59 laptop kernel:  [kernel_thread_helper+5/24] kernel_thread_helper+0x5/0x18
May 19 12:13:59 laptop kernel:
May 19 12:13:59 laptop kernel: Badness in local_bh_enable at kernel/softirq.c:105
May 19 12:13:59 laptop kernel: Call Trace:
May 19 12:13:59 laptop kernel:  [local_bh_enable+141/144] local_bh_enable+0x8d/0x90
May 19 12:13:59 laptop kernel:  [_end+282016342/1070304612] ppp_async_push+0xa2/0x1b0 [ppp_async]
May 19 12:13:59 laptop kernel:  [_end+282016121/1070304612] ppp_async_send+0x15/0x50 [ppp_async]
May 19 12:13:59 laptop kernel:  [_end+281913102/1070304612] ppp_push+0xaa/0x100 [ppp_generic]
May 19 12:13:59 laptop kernel:  [_end+281911349/1070304612] ppp_xmit_process+0x51/0x140 [ppp_generic]
May 19 12:13:59 laptop kernel:  [_end+281914490/1070304612] ppp_channel_push+0xd6/0x1d0 [ppp_generic]
May 19 12:13:59 laptop kernel:  [_end+282014511/1070304612] ppp_asynctty_wakeup+0x5b/0x70 [ppp_async]
May 19 12:13:59 laptop kernel:  [uart_flush_buffer+117/128] uart_flush_buffer+0x75/0x80    
May 19 12:13:59 laptop kernel:  [do_tty_hangup+1092/1168] do_tty_hangup+0x444/0x490
May 19 12:13:59 laptop kernel:  [worker_thread+511/736] worker_thread+0x1ff/0x2e0
May 19 12:13:59 laptop kernel:  [do_tty_hangup+0/1168] do_tty_hangup+0x0/0x490
May 19 12:13:59 laptop kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
May 19 12:13:59 laptop kernel:  [ret_from_fork+6/20] ret_from_fork+0x6/0x14
May 19 12:13:59 laptop kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
May 19 12:13:59 laptop kernel:  [worker_thread+0/736] worker_thread+0x0/0x2e0
May 19 12:13:59 laptop kernel:  [kernel_thread_helper+5/24] kernel_thread_helper+0x5/0x18
May 19 12:13:59 laptop kernel:  
May 19 12:13:59 laptop kernel: Badness in local_bh_enable at kernel/softirq.c:105
May 19 12:13:59 laptop kernel: Call Trace:
May 19 12:13:59 laptop kernel:  [local_bh_enable+141/144] local_bh_enable+0x8d/0x90
May 19 12:13:59 laptop kernel:  [_end+282016342/1070304612] ppp_async_push+0xa2/0x1b0 [ppp_async]
May 19 12:13:59 laptop kernel:  [_end+282016170/1070304612] ppp_async_send+0x46/0x50 [ppp_async]
May 19 12:13:59 laptop kernel:  [_end+281913102/1070304612] ppp_push+0xaa/0x100 [ppp_generic]
May 19 12:13:59 laptop kernel:  [_end+281911349/1070304612] ppp_xmit_process+0x51/0x140 [ppp_generic]
May 19 12:13:59 laptop kernel:  [_end+281914490/1070304612] ppp_channel_push+0xd6/0x1d0 [ppp_generic]
May 19 12:13:59 laptop kernel:  [_end+282014511/1070304612] ppp_asynctty_wakeup+0x5b/0x70 [ppp_async]
May 19 12:13:59 laptop kernel:  [uart_flush_buffer+117/128] uart_flush_buffer+0x75/0x80
May 19 12:13:59 laptop kernel:  [do_tty_hangup+1092/1168] do_tty_hangup+0x444/0x490
May 19 12:13:59 laptop kernel:  [worker_thread+511/736] worker_thread+0x1ff/0x2e0
May 19 12:13:59 laptop kernel:  [do_tty_hangup+0/1168] do_tty_hangup+0x0/0x490
May 19 12:13:59 laptop kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
May 19 12:13:59 laptop kernel:  [ret_from_fork+6/20] ret_from_fork+0x6/0x14
May 19 12:13:59 laptop kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
May 19 12:13:59 laptop kernel:  [worker_thread+0/736] worker_thread+0x0/0x2e0
May 19 12:13:59 laptop kernel:  [kernel_thread_helper+5/24] kernel_thread_helper+0x5/0x18
May 19 12:13:59 laptop kernel:
May 19 12:13:59 laptop kernel: Badness in local_bh_enable at kernel/softirq.c:105
May 19 12:13:59 laptop kernel: Call Trace:
May 19 12:13:59 laptop kernel:  [local_bh_enable+141/144] local_bh_enable+0x8d/0x90
May 19 12:13:59 laptop kernel:  [_end+281911349/1070304612] ppp_xmit_process+0x51/0x140 [ppp_generic]
May 19 12:13:59 laptop kernel:  [_end+281914490/1070304612] ppp_channel_push+0xd6/0x1d0 [ppp_generic]
May 19 12:13:59 laptop kernel:  [_end+282014511/1070304612] ppp_asynctty_wakeup+0x5b/0x70 [ppp_async]
May 19 12:13:59 laptop kernel:  [uart_flush_buffer+117/128] uart_flush_buffer+0x75/0x80
May 19 12:13:59 laptop kernel:  [do_tty_hangup+1092/1168] do_tty_hangup+0x444/0x490
May 19 12:13:59 laptop kernel:  [worker_thread+511/736] worker_thread+0x1ff/0x2e0
May 19 12:13:59 laptop kernel:  [do_tty_hangup+0/1168] do_tty_hangup+0x0/0x490
May 19 12:13:59 laptop kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
May 19 12:13:59 laptop kernel:  [ret_from_fork+6/20] ret_from_fork+0x6/0x14
May 19 12:13:59 laptop kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
May 19 12:13:59 laptop kernel:  [worker_thread+0/736] worker_thread+0x0/0x2e0
May 19 12:13:59 laptop kernel:  [kernel_thread_helper+5/24] kernel_thread_helper+0x5/0x18
May 19 12:13:59 laptop kernel:
May 19 12:13:59 laptop kernel: Badness in local_bh_enable at kernel/softirq.c:105
May 19 12:13:59 laptop kernel: Call Trace:
May 19 12:13:59 laptop kernel:  [local_bh_enable+141/144] local_bh_enable+0x8d/0x90
May 19 12:13:59 laptop kernel:  [_end+281914490/1070304612] ppp_channel_push+0xd6/0x1d0 [ppp_generic]
May 19 12:13:59 laptop kernel:  [_end+282014511/1070304612] ppp_asynctty_wakeup+0x5b/0x70 [ppp_async]
May 19 12:13:59 laptop kernel:  [uart_flush_buffer+117/128] uart_flush_buffer+0x75/0x80
May 19 12:13:59 laptop kernel:  [do_tty_hangup+1092/1168] do_tty_hangup+0x444/0x490
May 19 12:13:59 laptop kernel:  [worker_thread+511/736] worker_thread+0x1ff/0x2e0
May 19 12:13:59 laptop kernel:  [do_tty_hangup+0/1168] do_tty_hangup+0x0/0x490
May 19 12:13:59 laptop kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
May 19 12:13:59 laptop kernel:  [ret_from_fork+6/20] ret_from_fork+0x6/0x14
May 19 12:13:59 laptop kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
May 19 12:13:59 laptop kernel:  [worker_thread+0/736] worker_thread+0x0/0x2e0
May 19 12:13:59 laptop kernel:  [kernel_thread_helper+5/24] kernel_thread_helper+0x5/0x18
May 19 12:13:59 laptop kernel: Badness in local_bh_enable at kernel/softirq.c:105
May 19 12:13:59 laptop kernel: Call Trace:
May 19 12:13:59 laptop kernel:  [local_bh_enable+141/144] local_bh_enable+0x8d/0x90
May 19 12:13:59 laptop kernel:  [_end+282014511/1070304612] ppp_asynctty_wakeup+0x5b/0x70 [ppp_async]
May 19 12:13:59 laptop kernel:  [uart_flush_buffer+117/128] uart_flush_buffer+0x75/0x80
May 19 12:13:59 laptop kernel:  [do_tty_hangup+1092/1168] do_tty_hangup+0x444/0x490
May 19 12:13:59 laptop kernel:  [worker_thread+511/736] worker_thread+0x1ff/0x2e0
May 19 12:13:59 laptop kernel:  [do_tty_hangup+0/1168] do_tty_hangup+0x0/0x490
May 19 12:13:59 laptop kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
May 19 12:13:59 laptop kernel:  [ret_from_fork+6/20] ret_from_fork+0x6/0x14
May 19 12:13:59 laptop kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
May 19 12:13:59 laptop kernel:  [worker_thread+0/736] worker_thread+0x0/0x2e0
May 19 12:13:59 laptop kernel:  [kernel_thread_helper+5/24] kernel_thread_helper+0x5/0x18
May 19 12:13:59 laptop kernel:
May 19 12:13:59 laptop kernel: Badness in local_bh_enable at kernel/softirq.c:105
May 19 12:13:59 laptop kernel: Call Trace:
May 19 12:13:59 laptop kernel:  [local_bh_enable+141/144] local_bh_enable+0x8d/0x90
May 19 12:13:59 laptop kernel:  [_end+282016342/1070304612] ppp_async_push+0xa2/0x1b0 [ppp_async]
May 19 12:13:59 laptop kernel:  [local_bh_enable+98/144] local_bh_enable+0x62/0x90
May 19 12:13:59 laptop kernel:  [_end+282014469/1070304612] ppp_asynctty_wakeup+0x31/0x70 [ppp_async]
May 19 12:13:59 laptop kernel:  [do_tty_hangup+1078/1168] do_tty_hangup+0x436/0x490
May 19 12:13:59 laptop kernel:  [worker_thread+511/736] worker_thread+0x1ff/0x2e0
May 19 12:13:59 laptop kernel:  [do_tty_hangup+0/1168] do_tty_hangup+0x0/0x490
May 19 12:13:59 laptop kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
May 19 12:13:59 laptop kernel:  [ret_from_fork+6/20] ret_from_fork+0x6/0x14
May 19 12:13:59 laptop kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
May 19 12:13:59 laptop kernel:  [worker_thread+0/736] worker_thread+0x0/0x2e0
May 19 12:13:59 laptop kernel:  [kernel_thread_helper+5/24] kernel_thread_helper+0x5/0x18

At the very same time my pppd daemon died.

Jan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+yNlypuyeqyCEh60RAmwVAJ0ZRcdObSmB9yG3Zhm1ViMcMmY0igCePBj1
DuMc0bg12t1Bv5fpedM/sto=
=Bm+g
-----END PGP SIGNATURE-----

