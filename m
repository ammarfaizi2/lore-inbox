Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266582AbUBDUjT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 15:39:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264441AbUBDUhs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 15:37:48 -0500
Received: from ousrvr.oulu.fi ([130.231.240.1]:21982 "EHLO oulu.fi")
	by vger.kernel.org with ESMTP id S264300AbUBDUed (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 15:34:33 -0500
Date: Wed, 4 Feb 2004 22:34:27 +0200
From: Jacek Kawa <jfk@zeus.polsl.gliwice.pl>
To: linux-kernel@vger.kernel.org
Subject: 2.6.1,  Badness in local_bh_enable at kernel/softirq.c:121
Message-ID: <20040204203426.GA1841@miriel.finwe.eu.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Kreatorzy Kreacji Bialej
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!
For last 3 days I have had some problems with link, and there were
many disconnect/connect tries, short ppp sessions etc. 

I found something like this in logs
(with:  Linux finwe 2.6.1 #10 Wed Jan 14 13:22:06 CET 2004 i686 GNU/Linux
	pppd version 2.4.2 ):

Feb  2 21:43:58:
----------------
pppd[853]: Hangup (SIGHUP)
pppd[853]: Modem hangup
pppd[853]: Connection terminated.
pppd[853]: Connect time 0.2 minutes.
pppd[853]: Sent 1136 bytes, received 504 bytes.
kernel: Badness in local_bh_enable at kernel/softirq.c:121
kernel: Call Trace:
kernel:  [local_bh_enable+137/144] local_bh_enable+0x89/0x90
kernel:  [_end+206959978/1070000488] ppp_async_push+0xa2/0x190 [ppp_async]
kernel:  [_end+206958149/1070000488] ppp_asynctty_wakeup+0x2d/0x60 [ppp_async]
kernel:  [_end+206275288/1070000488] uart_flush_buffer+0x0/0x80 [serial_core]
kernel:  [_end+206275397/1070000488] uart_flush_buffer+0x6d/0x80 [serial_core]
kernel:  [do_tty_hangup+1144/1248] do_tty_hangup+0x478/0x4e0
kernel:  [worker_thread+477/720] worker_thread+0x1dd/0x2d0
kernel:  [do_tty_hangup+0/1248] do_tty_hangup+0x0/0x4e0
kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
kernel:  [ret_from_fork+6/20] ret_from_fork+0x6/0x14
kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
kernel:  [worker_thread+0/720] worker_thread+0x0/0x2d0
kernel:  [kernel_thread_helper+5/16] kernel_thread_helper+0x5/0x10

Feb  4 08:22:29:
----------------
kernel: Badness in local_bh_enable at kernel/softirq.c:121
kernel: Call Trace:
kernel:  [local_bh_enable+137/144] local_bh_enable+0x89/0x90
kernel:  [_end+206972266/1070000488] ppp_async_push+0xa2/0x190 [ppp_async]
kernel:  [_end+206970437/1070000488] ppp_asynctty_wakeup+0x2d/0x60 [ppp_async]
kernel:  [_end+206275288/1070000488] uart_flush_buffer+0x0/0x80 [serial_core]
kernel:  [_end+206275397/1070000488] uart_flush_buffer+0x6d/0x80 [serial_core]
kernel:  [do_tty_hangup+1144/1248] do_tty_hangup+0x478/0x4e0
kernel:  [worker_thread+477/720] worker_thread+0x1dd/0x2d0
kernel:  [do_tty_hangup+0/1248] do_tty_hangup+0x0/0x4e0
kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
kernel:  [ret_from_fork+6/20] ret_from_fork+0x6/0x14
pppd[875]: Hangup (SIGHUP)
kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
pppd[875]: Modem hangup
kernel:  [worker_thread+0/720] worker_thread+0x0/0x2d0
pppd[875]: Connection terminated.
kernel:  [kernel_thread_helper+5/16] kernel_thread_helper+0x5/0x10
pppd[875]: Connect time 24.2 minutes.

config: http://www.student.oulu.fi/~jkawa/kernel/config-2.6.1
ver_linux: http://www.student.oulu.fi/~jkawa/kernel/ver_linux

bye

-- 
Jacek Kawa  **Waiting for the miracle to come [Cohen]**
