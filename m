Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271032AbTHOVrV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 17:47:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271064AbTHOVrU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 17:47:20 -0400
Received: from mail.mplayerhq.hu ([192.190.173.45]:49100 "EHLO
	mail.mplayerhq.hu") by vger.kernel.org with ESMTP id S271032AbTHOVrT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 17:47:19 -0400
Date: Fri, 15 Aug 2003 23:59:57 +0200 (CEST)
From: Szabolcs Berecz <szabi@mplayerhq.hu>
To: <linux-kernel@vger.kernel.org>
Subject: [2.6.0-test1-ac2] Badness in local_bh_enable at kernel/softirq.c:113
Message-ID: <Pine.LNX.4.33.0308152349320.20618-100000@mail.mplayerhq.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I was connected to the net with a modem, there was no reply (it's the fault
of my ISP), and I got this in the syslog:

Aug 15 23:23:37 localhost pppd[1871]: No response to 4 echo-requests
Aug 15 23:23:37 localhost pppd[1871]: Serial link appears to be disconnected.

The modem was still online. After running poff:

Aug 15 23:23:43 localhost pppd[1871]: Connection terminated.
Aug 15 23:23:43 localhost pppd[1871]: Connect time 4.2 minutes.
Aug 15 23:23:43 localhost pppd[1871]: Sent 59789 bytes, received 314664 bytes.
Aug 15 23:24:07 localhost pppd[1871]: Terminating on signal 15.
Aug 15 23:24:07 localhost pppd[1871]: Hangup (SIGHUP)
Aug 15 23:24:07 localhost kernel: Badness in local_bh_enable at kernel/softirq.c:113
Aug 15 23:24:07 localhost kernel: Call Trace:
Aug 15 23:24:07 localhost kernel:  [local_bh_enable+53/104] local_bh_enable+0x35/0x68
Aug 15 23:24:07 localhost kernel:  [_end+100160393/1070835544] ppp_async_push+0x18d/0x198 [ppp_async]
Aug 15 23:24:07 localhost kernel:  [_end+100158331/1070835544] ppp_asynctty_wakeup+0x27/0x4c [ppp_async]
Aug 15 23:24:07 localhost kernel:  [uart_flush_buffer+100/108] uart_flush_buffer+0x64/0x6c
Aug 15 23:24:07 localhost kernel:  [do_tty_hangup+316/892] do_tty_hangup+0x13c/0x37c
Aug 15 23:24:07 localhost kernel:  [worker_thread+442/636] worker_thread+0x1ba/0x27c
Aug 15 23:24:07 localhost kernel:  [worker_thread+0/636] worker_thread+0x0/0x27cAug 15 23:24:07 localhost kernel:  [do_tty_hangup+0/892] do_tty_hangup+0x0/0x37cAug 15 23:24:07 localhost kernel:  [default_wake_function+0/24] default_wake_function+0x0/0x18
Aug 15 23:24:07 localhost kernel:  [default_wake_function+0/24] default_wake_function+0x0/0x18
Aug 15 23:24:07 localhost kernel:  [kernel_thread_helper+5/12] kernel_thread_helper+0x5/0xc
Aug 15 23:24:07 localhost kernel:


Do you need any other info?

Bye,
Szabi


