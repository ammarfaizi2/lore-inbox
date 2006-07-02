Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932577AbWGBBEb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932577AbWGBBEb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 21:04:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932584AbWGBBEb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 21:04:31 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:16247 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932577AbWGBBEa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 21:04:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=EnV6wau6djfRjJyUKLedqhxkoU3Px3LWDMAr8Ts0tC2Cej2od5VHUBXPW4jGCbiK4dTFEOBP/Q8r0hoabDXt7uiFEfoXdQsrwiJ0nJLlFVdvRg6wJsyWPyx+rckgcuubIlr6GHnf3unAbjR487DrqjO857v0XYAj2zzln7vvhHg=
Message-ID: <a44ae5cd0607011804i2326c350ta6262feec1e6805e@mail.gmail.com>
Date: Sat, 1 Jul 2006 18:04:30 -0700
From: "Miles Lane" <miles.lane@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: 2.6.17-mm4 + hostap + pcmcia + lockdep -- possible recursive locking detected -- (af_callback_keys + sk->sk_family#3){-.-?}, at: [<c119d8db>] sock_def_readable+0x15/0x69
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have patches for hostap, pcmcia and lockdep applied to this kernel.
These patches are the ones resulting from several recent message
threads.
I just noticed this in my kernel log:

[ INFO: possible recursive locking detected ]
---------------------------------------------
multiload-apple/2820 is trying to acquire lock:
 (af_callback_keys + sk->sk_family#3){-.-?}, at: [<c119d8db>]
sock_def_readable+0x15/0x69

but task is already holding lock:
 (af_callback_keys + sk->sk_family#3){-.-?}, at: [<c119d8db>]
sock_def_readable+0x15/0x69

other info that might help us debug this:
3 locks held by multiload-apple/2820:
 #0:  (rtnl_mutex){--..}, at: [<c120028e>] mutex_lock+0x1c/0x1f
 #1:  (af_callback_keys + sk->sk_family#3){-.-?}, at: [<c119d8db>]
sock_def_readable+0x15/0x69
 #2:  (&priv->lock){.+..}, at: [<f90472c9>]
ipw_irq_tasklet+0x54/0x10c1 [ipw2200]

stack backtrace:
 [<c1003502>] show_trace_log_lvl+0x54/0xfd
 [<c1003b6a>] show_trace+0xd/0x10
 [<c1003c0e>] dump_stack+0x19/0x1b
 [<c102ccd6>] __lock_acquire+0x755/0x970
 [<c102d1b6>] lock_acquire+0x60/0x80
 [<c1201533>] _read_lock+0x23/0x32
 [<c119d8db>] sock_def_readable+0x15/0x69
 [<c11b5621>] netlink_broadcast+0x1c6/0x2b8
 [<c11ad712>] wireless_send_event+0x28a/0x29c
 [<f9047d02>] ipw_irq_tasklet+0xa8d/0x10c1 [ipw2200]
 [<c101a4e7>] tasklet_action+0x45/0x76
 [<c101a709>] __do_softirq+0x55/0xb0
 [<c1004a64>] do_softirq+0x58/0xbd
 [<c101a6a8>] irq_exit+0x3f/0x4b
 [<c1004b89>] do_IRQ+0xc0/0xcf
 [<c1002fd9>] common_interrupt+0x25/0x2c
