Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275218AbTHGIPH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 04:15:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275220AbTHGIPH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 04:15:07 -0400
Received: from [195.95.38.160] ([195.95.38.160]:64507 "HELO mail.vt4.net")
	by vger.kernel.org with SMTP id S275218AbTHGIPD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 04:15:03 -0400
From: Jan De Luyck <lkml@kcore.org>
To: linux-kernel@vger.kernel.org
Subject: Badness in local_bh_enable at kernel/softirq.c:113
Date: Thu, 7 Aug 2003 10:14:53 +0200
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308071014.53819.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello list,
F.Y.I:

My ppp link went down, and kppp hung. I had to kill -9 it, after which this showed up in my logs:

Aug  7 10:10:08 laptop pppd[1090]: tcsetattr: Invalid argument
Aug  7 10:10:08 laptop pppd[1090]: Exit.
Aug  7 10:11:10 laptop kernel: Badness in local_bh_enable at kernel/softirq.c:113
Aug  7 10:11:10 laptop kernel: Call Trace:
Aug  7 10:11:10 laptop kernel:  [local_bh_enable+134/144] local_bh_enable+0x86/0x90
Aug  7 10:11:10 laptop kernel:  [acqseq_lock.5+282550698/1070065048] ppp_async_push+0xa2/0x190 [ppp_async]
Aug  7 10:11:10 laptop kernel:  [acqseq_lock.5+282548837/1070065048] ppp_asynctty_wakeup+0x2d/0x60 [ppp_async]
Aug  7 10:11:10 laptop kernel:  [uart_flush_buffer+109/128] uart_flush_buffer+0x6d/0x80
Aug  7 10:11:10 laptop kernel:  [do_tty_hangup+1155/1264] do_tty_hangup+0x483/0x4f0
Aug  7 10:11:10 laptop kernel:  [uart_unconfigure_port+152/160] uart_unconfigure_port+0x98/0xa0
Aug  7 10:11:10 laptop kernel:  [uart_unregister_port+127/153] uart_unregister_port+0x7f/0x99
Aug  7 10:11:10 laptop kernel:  [unregister_serial+23/32] unregister_serial+0x17/0x20
Aug  7 10:11:10 laptop kernel:  [acqseq_lock.5+284542522/1070065048] serial_remove+0xa2/0xb0 [8250_cs]
Aug  7 10:11:10 laptop kernel:  [acqseq_lock.5+284546506/1070065048] serial_event+0x52/0x100 [8250_cs]
Aug  7 10:11:10 laptop kernel:  [acqseq_lock.5+284497878/1070065048] send_event+0x5e/0x70 [pcmcia_core]
Aug  7 10:11:10 laptop kernel:  [acqseq_lock.5+284498008/1070065048] socket_remove_drivers+0x20/0x50 [pcmcia_core]
Aug  7 10:11:10 laptop kernel:  [acqseq_lock.5+284498075/1070065048] socket_shutdown+0x13/0x60 [pcmcia_core]
Aug  7 10:11:10 laptop kernel:  [acqseq_lock.5+284499467/1070065048] socket_remove+0x13/0x60 [pcmcia_core]
Aug  7 10:11:10 laptop kernel:  [acqseq_lock.5+284499650/1070065048] socket_detect_change+0x6a/0x90 [pcmcia_core]
Aug  7 10:11:10 laptop kernel:  [acqseq_lock.5+284500032/1070065048] pccardd+0x158/0x1c0 [pcmcia_core]
Aug  7 10:11:10 laptop kernel:  [default_wake_function+0/48] default_wake_function+0x0/0x30
Aug  7 10:11:10 laptop kernel:  [ret_from_fork+6/20] ret_from_fork+0x6/0x14
Aug  7 10:11:10 laptop kernel:  [default_wake_function+0/48] default_wake_function+0x0/0x30
Aug  7 10:11:10 laptop kernel:  [acqseq_lock.5+284499688/1070065048] pccardd+0x0/0x1c0 [pcmcia_core]
Aug  7 10:11:10 laptop kernel:  [kernel_thread_helper+5/16] kernel_thread_helper+0x5/0x10

Jan

