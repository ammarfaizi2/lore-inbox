Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263978AbTEWJSv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 05:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263980AbTEWJSv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 05:18:51 -0400
Received: from bart.one-2-one.net ([217.115.142.76]:61202 "EHLO
	bart.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id S263978AbTEWJSs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 05:18:48 -0400
Date: Fri, 23 May 2003 11:38:38 +0200 (CEST)
From: Martin Diehl <lists@mdiehl.de>
X-X-Sender: martin@notebook.home.mdiehl.de
To: "David S. Miller" <davem@redhat.com>
cc: akpm@digeo.com, Greg KH <greg@kroah.com>, <linux-kernel@vger.kernel.org>,
       Jean Tourrilhes <jt@hpl.hp.com>
Subject: Re: [2.5.69] rtnl-deadlock with usermodehelper and keventd
In-Reply-To: <20030522.235905.42785280.davem@redhat.com>
Message-ID: <Pine.LNX.4.44.0305230934490.14825-100000@notebook.home.mdiehl.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 May 2003, David S. Miller wrote:

>    Asking just because there was another user hitting this deadlock:
> 
> It's fixed in current 2.5.x sources, wake up :-)

Oops, sorry for the noise, I hadn't noticed this yet.

But nope, unfortunately it's still hanging! I've just tested with 
2.5.69-bk15. Running into the same deadlock due to sleeping with rtnl 
hold. This time however it seems it's triggered from sysfs side!

Thanks anyway!
Martin

-------------------------

May 23 11:07:31 srv kernel: events/0      D C02B05DC 4294946908     4      1             5     3 (L-TLB)
May 23 11:07:31 srv kernel: Call Trace:
May 23 11:07:31 srv kernel:  [__down+197/368] __down+0xc5/0x170
May 23 11:07:31 srv kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
May 23 11:07:31 srv kernel:  [__down_failed+8/12] __down_failed+0x8/0xc
May 23 11:07:31 srv kernel:  [.text.lock.rtnetlink+5/94] .text.lock.rtnetlink+0x5/0x5e
May 23 11:07:31 srv kernel:  [linkwatch_event+33/48] linkwatch_event+0x21/0x30
May 23 11:07:32 srv kernel:  [worker_thread+478/752] worker_thread+0x1de/0x2f0
May 23 11:07:32 srv kernel:  [linkwatch_event+0/48] linkwatch_event+0x0/0x30
May 23 11:07:32 srv kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
May 23 11:07:32 srv kernel:  [ret_from_fork+6/32] ret_from_fork+0x6/0x20
May 23 11:07:32 srv kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
May 23 11:07:32 srv kernel:  [worker_thread+0/752] worker_thread+0x0/0x2f0
May 23 11:07:32 srv kernel:  [kernel_thread_helper+5/24] kernel_thread_helper+0x5/0x18

May 23 11:07:32 srv kernel: irattach      D 00000000 19710128  2109      1                2104 (NOTLB)
May 23 11:07:32 srv kernel: Call Trace:
May 23 11:07:32 srv kernel:  [wait_for_completion+220/352] wait_for_completion+0xdc/0x160
May 23 11:07:32 srv kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
May 23 11:07:32 srv kernel:  [__wake_up+83/144] __wake_up+0x53/0x90
May 23 11:07:32 srv kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
May 23 11:07:32 srv kernel:  [call_usermodehelper+290/301] call_usermodehelper+0x122/0x12d
May 23 11:07:32 srv kernel:  [__call_usermodehelper+0/96] __call_usermodehelper+0x0/0x60
May 23 11:07:32 srv kernel:  [__call_usermodehelper+0/96] __call_usermodehelper+0x0/0x60
May 23 11:07:32 srv kernel:  [sprintf+18/32] sprintf+0x12/0x20
May 23 11:07:32 srv kernel:  [kset_hotplug+419/464] kset_hotplug+0x1a3/0x1d0
May 23 11:07:32 srv kernel:  [kobject_del+75/96] kobject_del+0x4b/0x60
May 23 11:07:32 srv kernel:  [class_device_del+166/192] class_device_del+0xa6/0xc0
May 23 11:07:32 srv kernel:  [class_device_unregister+11/32] class_device_unregister+0xb/0x20
May 23 11:07:32 srv kernel:  [unregister_netdevice+356/496] unregister_netdevice+0x164/0x1f0
May 23 11:07:32 srv kernel:  [unregister_netdev+16/48] unregister_netdev+0x10/0x30
May 23 11:07:32 srv kernel:  [_end+206658744/1070163436] +0x128/0x75c [sir_dev]
May 23 11:07:32 srv kernel:  [_end+206653994/1070163436] sirdev_put_instance+0xfe/0x110 [sir_dev]
May 23 11:07:32 srv kernel:  [tty_wait_until_sent+235/256] tty_wait_until_sent+0xeb/0x100
May 23 11:07:32 srv kernel:  [_end+206513126/1070163436] irtty_close+0x3a/0x141 [irtty_sir]
May 23 11:07:32 srv kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
May 23 11:07:32 srv kernel:  [tty_set_ldisc+205/464] tty_set_ldisc+0xcd/0x1d0
May 23 11:07:32 srv kernel:  [serial8250_tx_empty+60/128] serial8250_tx_empty+0x3c/0x80
May 23 11:07:32 srv kernel:  [uart_wait_until_sent+150/224] uart_wait_until_sent+0x96/0xe0
May 23 11:07:32 srv kernel:  [_end+206514243/1070163436] +0x274/0x31d [irtty_sir]
May 23 11:07:32 srv kernel:  [_end+206512540/1070163436] irtty_open+0x0/0x210 [irtty_sir]
May 23 11:07:32 srv kernel:  [_end+206513068/1070163436] irtty_close+0x0/0x141 [irtty_sir]
May 23 11:07:32 srv kernel:  [_end+206511964/1070163436] irtty_ioctl+0x0/0x240 [irtty_sir]
May 23 11:07:32 srv kernel:  [_end+206510924/1070163436] irtty_receive_buf+0x0/0xb0 [irtty_sir]
May 23 11:07:32 srv kernel:  [_end+206511100/1070163436] irtty_receive_room+0x0/0x30 [irtty_sir]
May 23 11:07:32 srv kernel:  [_end+206511148/1070163436] irtty_write_wakeup+0x0/0x40 [irtty_sir]
May 23 11:07:32 srv kernel:  [_end+206517164/1070163436] +0x0/0x100 [irtty_sir]
May 23 11:07:32 srv kernel:  [dput+28/608] dput+0x1c/0x260
May 23 11:07:32 srv kernel:  [tty_ioctl+888/1152] tty_ioctl+0x378/0x480
May 23 11:07:32 srv kernel:  [sys_ioctl+646/744] sys_ioctl+0x286/0x2e8
May 23 11:07:32 srv kernel:  [sys_fcntl64+89/112] sys_fcntl64+0x59/0x70
May 23 11:07:32 srv kernel:  [sys_fcntl64+101/112] sys_fcntl64+0x65/0x70
May 23 11:07:32 srv kernel:  [syscall_call+7/11] syscall_call+0x7/0xb

