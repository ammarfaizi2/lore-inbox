Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265062AbTLRKvm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 05:51:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265080AbTLRKvm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 05:51:42 -0500
Received: from c3p0.cc.swin.edu.au ([136.186.1.30]:30732 "EHLO swin.edu.au")
	by vger.kernel.org with ESMTP id S265062AbTLRKvk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 05:51:40 -0500
Date: Thu, 18 Dec 2003 21:51:37 +1100 (EST)
From: Tim Connors <tconnors+lkml181203@astro.swin.edu.au>
X-X-Sender: tconnors@tellurium.ssi.swin.edu.au
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: BUG in ppp 2.6.0-test11
Message-ID: <Pine.LNX.4.53.0312182148550.4950@tellurium.ssi.swin.edu.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


bug and subsequent very fragile ppp behaviour from a ppp server:

I had dialed in to my home computer, and after some minutes, it hung up. Dialing in from then
on would always get get me a dead carrier just after the Connect: ppp0 <--> /dev/ttyS0 line
on the client machine. A few times, I was able to keep it open a bit longer, where I
discovered the bug. Reboot has fixed behaviour, at least for now.


Dec 15 10:02:33 bohr kernel: CSLIP: code copyright 1989 Regents of the University of California
Dec 15 10:02:33 bohr pppd[919]: pppd 2.4.2b3 started by LOGIN, uid 0
Dec 15 10:02:34 bohr kernel: PPP generic driver version 2.4.2
Dec 15 10:02:34 bohr pppd[919]: Using interface ppp0
Dec 15 10:02:34 bohr pppd[919]: Connect: ppp0 <--> /dev/ttyS0
Dec 15 10:02:39 bohr pppd[919]: user tconnors logged in
Dec 15 10:02:39 bohr pppd[919]: PAP peer authentication succeeded for tconnors
Dec 15 10:02:39 bohr pppd[919]: Couldn't set pass-filter in kernel: Invalid argument
Dec 15 10:02:39 bohr kernel: PPP BSD Compression module registered
Dec 15 10:02:39 bohr kernel: PPP Deflate Compression module registered
Dec 15 10:02:40 bohr pppd[919]: found interface eth0 for proxy arp
Dec 15 10:02:40 bohr pppd[919]: local  IP address 192.168.2.1
Dec 15 10:02:40 bohr pppd[919]: remote IP address 192.168.1.3
Dec 15 10:03:00 bohr ntpdate[7524]: no servers can be used, exiting
Dec 15 10:18:13 bohr kernel: Badness in local_bh_enable at kernel/softirq.c:121
Dec 15 10:18:13 bohr kernel: Call Trace:
Dec 15 10:18:13 bohr kernel:  [local_bh_enable+111/128] local_bh_enable+0x6f/0x80
Dec 15 10:18:13 bohr kernel:  [__crc_generic_file_aio_write+1199591/1760761] ppp_async_push+0xa3/0x180 [ppp_async]
Dec 15 10:18:13 bohr kernel:  [__crc_generic_file_aio_write+1197831/1760761] ppp_asynctty_wakeup+0x23/0x60 [ppp_async]
Dec 15 10:18:13 bohr pppd[919]: Hangup (SIGHUP)
Dec 15 10:18:13 bohr pppd[919]: Modem hangup
Dec 15 10:18:13 bohr kernel:  [uart_flush_buffer+100/128] uart_flush_buffer+0x64/0x80
Dec 15 10:18:13 bohr kernel:  [do_tty_hangup+897/1024] do_tty_hangup+0x381/0x400
Dec 15 10:18:13 bohr kernel:  [worker_thread+412/640] worker_thread+0x19c/0x280
Dec 15 10:18:13 bohr kernel:  [do_tty_hangup+0/1024] do_tty_hangup+0x0/0x400
Dec 15 10:18:13 bohr kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
Dec 15 10:18:13 bohr kernel:  [ret_from_fork+6/32] ret_from_fork+0x6/0x20
Dec 15 10:18:13 bohr kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
Dec 15 10:18:13 bohr kernel:  [worker_thread+0/640] worker_thread+0x0/0x280
Dec 15 10:18:13 bohr kernel:  [kernel_thread_helper+5/28] kernel_thread_helper+0x5/0x1c
Dec 15 10:18:13 bohr kernel:
Dec 15 10:18:13 bohr kernel: Badness in local_bh_enable at kernel/softirq.c:121
Dec 15 10:18:13 bohr kernel: Call Trace:
Dec 15 10:18:13 bohr kernel:  [local_bh_enable+111/128] local_bh_enable+0x6f/0x80
Dec 15 10:18:13 bohr kernel:  [__crc_generic_file_aio_write+1199591/1760761] ppp_async_push+0xa3/0x180 [ppp_async]
Dec 15 10:18:13 bohr kernel:  [__crc_generic_file_aio_write+1199347/1760761] ppp_async_send+0xf/0x60 [ppp_async]
Dec 15 10:18:13 bohr kernel:  [__crc_in_egroup_p+102914/1634005] ppp_channel_push+0x97/0x1e0 [ppp_generic]
Dec 15 10:18:13 bohr kernel:  [__crc_generic_file_aio_write+1197859/1760761] ppp_asynctty_wakeup+0x3f/0x60 [ppp_async]
Dec 15 10:18:13 bohr kernel:  [uart_flush_buffer+100/128] uart_flush_buffer+0x64/0x80
Dec 15 10:18:13 bohr pppd[919]: Connection terminated.
Dec 15 10:18:13 bohr pppd[919]: Connect time 15.7 minutes.
Dec 15 10:18:13 bohr pppd[919]: Sent 1048548 bytes, received 261635 bytes.
...
(it went on and on and on, all with the same timestamp)

-- 
TimC -- http://astronomy.swin.edu.au/staff/tconnors/
Adding features does not necessarily increase functionality -- it just
makes the manuals thicker.
