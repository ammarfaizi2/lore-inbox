Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268048AbUIPNLW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268048AbUIPNLW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 09:11:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268045AbUIPNLW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 09:11:22 -0400
Received: from smtp.terra.es ([213.4.129.129]:34667 "EHLO tsmtp4.mail.isp")
	by vger.kernel.org with ESMTP id S268052AbUIPNK5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 09:10:57 -0400
Date: Thu, 16 Sep 2004 15:10:52 +0200
From: Diego Calleja <diegocg@teleline.es>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: 2.6.9-rc2-mm1
Message-Id: <20040916151052.5e567252.diegocg@teleline.es>
In-Reply-To: <20040916024020.0c88586d.akpm@osdl.org>
References: <20040916024020.0c88586d.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Thu, 16 Sep 2004 02:40:20 -0700 Andrew Morton <akpm@osdl.org> escribió:

[...]

> -tty_io-hangup-locking.patch
> +tty-locking-for-269rc2.patch
> +tty-locking-for-269rc2-fixes.patch
> 
>  Alan's tty locking rework


I couldn't connect to internet, the connection didn't go beyond of...
Sep 16 15:01:51 estel chat[1235]: ATDTSOMETHING^M^M
Sep 16 15:01:51 estel chat[1235]: CONNECT
Sep 16 15:01:51 estel chat[1235]:  -- got it 
Sep 16 15:01:51 estel chat[1235]: send (\d)
Sep 16 15:01:52 estel pppd[1233]: Serial connection established.
^^^
here (the rest is from a working kernel)
Sep 16 15:01:52 estel pppd[1233]: using channel 1
Sep 16 15:01:52 estel pppd[1233]: Using interface ppp0
Sep 16 15:01:52 estel pppd[1233]: Connect: ppp0 <--> /dev/ttyS1

Unapplying those two patches quoted above made it work again, the box
is a smp 2xpentium3, the sysrq-t output of pppd was:
Sep 16 14:44:45 estel kernel: pppd          S 00000000     0  1365      1                1323 (NOTLB)
Sep 16 14:44:45 estel kernel: db495e9c 00000086 c0116680 00000000 00000000 bffff978 ffff037f 43e740f2 
Sep 16 14:44:45 estel kernel:        0000001b db8f2170 c0116680 de36b2a0 07a2d1a5 00000000 c1409f60 db8f22cc 
Sep 16 14:44:45 estel kernel:        db494000 d919f000 db495edc 00000003 c01b9739 00000000 db4221a8 c016308b 
Sep 16 14:44:45 estel kernel: Call Trace:
Sep 16 14:44:45 estel kernel:  [default_wake_function+0/16] default_wake_function+0x0/0x10
Sep 16 14:44:45 estel kernel:  [default_wake_function+0/16] default_wake_function+0x0/0x10
Sep 16 14:44:45 estel kernel:  [tty_set_ldisc+457/1232] tty_set_ldisc+0x1c9/0x4d0
Sep 16 14:44:45 estel kernel:  [locks_delete_lock+91/256] locks_delete_lock+0x5b
/0x100
Sep 16 14:44:45 estel kernel:  [autoremove_wake_function+0/80] autoremove_wake_function+0x0/0x50
Sep 16 14:44:45 estel kernel:  [autoremove_wake_function+0/80] autoremove_wake_function+0x0/0x50
Sep 16 14:44:45 estel kernel:  [serial8250_tx_empty+52/80] serial8250_tx_empty+0x34/0x50
Sep 16 14:44:45 estel kernel:  [remove_wait_queue+23/112] remove_wait_queue+0x17/0x70
Sep 16 14:44:45 estel kernel:  [tty_wait_until_sent+230/256] tty_wait_until_sent+0xe6/0x100
Sep 16 14:44:45 estel kernel:  [default_wake_function+0/16] default_wake_function+0x0/0x10
Sep 16 14:44:45 estel kernel:  [n_tty_open+0/160] n_tty_open+0x0/0xa0
Sep 16 14:44:45 estel kernel:  [n_tty_close+0/48] n_tty_close+0x0/0x30
Sep 16 14:44:45 estel kernel:  [n_tty_flush_buffer+0/96] n_tty_flush_buffer+0x0/0x60
Sep 16 14:44:45 estel kernel:  [n_tty_chars_in_buffer+0/128] n_tty_chars_in_buffer+0x0/0x80
Sep 16 14:44:45 estel kernel:  [read_chan+0/2000] read_chan+0x0/0x7d0
Sep 16 14:44:45 estel kernel:  [write_chan+0/560] write_chan+0x0/0x230
Sep 16 14:44:45 estel kernel:  [n_tty_ioctl+0/896] n_tty_ioctl+0x0/0x380
Sep 16 14:44:45 estel kernel:  [n_tty_set_termios+0/480] n_tty_set_termios+0x0/0x1e0
Sep 16 14:44:45 estel kernel:  [normal_poll+0/331] normal_poll+0x0/0x14b
Sep 16 14:44:45 estel kernel:  [n_tty_receive_buf+0/3728] n_tty_receive_buf+0x0/0xe90
Sep 16 14:44:45 estel kernel:  [n_tty_receive_room+0/64] n_tty_receive_room+0x0/0x40
Sep 16 14:44:45 estel kernel:  [n_tty_write_wakeup+0/48] n_tty_write_wakeup+0x0/0x30
Sep 16 14:44:45 estel kernel:  [sys_ioctl+255/624] sys_ioctl+0xff/0x270
Sep 16 14:44:45 estel kernel:  [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
