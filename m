Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932269AbWHKQX5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932269AbWHKQX5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 12:23:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932264AbWHKQX5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 12:23:57 -0400
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:27343 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S932238AbWHKQX4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 12:23:56 -0400
Date: Fri, 11 Aug 2006 18:23:52 +0200
From: Luca <kornos.it@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org
Subject: [2.6.18-rc4] lockdep warning at inet6_addr_add
Message-ID: <20060811162352.GA14795@dreamland.darkstar.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I get a warning from lockdep during boot; 2.6.18-rc3 don't have this
warning. I see a similar report in the archive (I haven't found time to
test the patch...):

http://marc.theaimsgroup.com/?l=linux-netdev&m=115506258902757&w=2

but my stacktrace is a bit different, so I'm reporting this one too:

=================================
[ INFO: inconsistent lock state ]
---------------------------------
inconsistent {in-softirq-W} -> {softirq-on-W} usage.
ifconfig/1812 [HC0[0]:SC0[0]:HE1:SE1] takes:
 (&ifa->lock){-+..}, at: [<f1a0a4b9>] inet6_addr_add+0xd9/0x160 [ipv6]
{in-softirq-W} state was registered at:
  [<b01342dd>] lock_acquire+0x5d/0x80
  [<b030bafa>] _spin_lock_bh+0x3a/0x50
  [<f1a0b76b>] addrconf_dad_timer+0x5b/0x100 [ipv6]
  [<b0122bb9>] run_timer_softirq+0x149/0x170
  [<b011ee62>] __do_softirq+0x62/0xc0
  [<b011ef15>] do_softirq+0x55/0x60
  [<b011f18b>] irq_exit+0x4b/0x50
  [<b01059ec>] do_IRQ+0x4c/0x90
  [<b0103c15>] common_interrupt+0x25/0x2c
  [<b0101aa1>] cpu_idle+0x41/0x70
  [<b0100537>] rest_init+0x37/0x40
  [<b03fe7aa>] start_kernel+0x2ba/0x360
  [<b0100199>] 0xb0100199
irq event stamp: 4501
hardirqs last  enabled at (4501): [<b011f525>] local_bh_enable_ip+0x95/0x110
hardirqs last disabled at (4499): [<b011f4bf>] local_bh_enable_ip+0x2f/0x110
softirqs last  enabled at (4500): [<f1a0729e>] ipv6_add_addr+0x3e/0x270 [ipv6]
softirqs last disabled at (4488): [<b030bc6e>] _read_lock_bh+0xe/0x50

other info that might help us debug this:
1 lock held by ifconfig/1812:
 #0:  (rtnl_mutex){--..}, at: [<b030a73c>] mutex_lock+0x1c/0x20

stack backtrace:
 [<b0104312>] show_trace+0x12/0x20
 [<b01048e9>] dump_stack+0x19/0x20
 [<b01320de>] print_usage_bug+0x23e/0x250
 [<b0132a39>] mark_lock+0x5a9/0x5c0
 [<b0133a86>] __lock_acquire+0x806/0xd20
 [<b01342dd>] lock_acquire+0x5d/0x80
 [<b030baa5>] _spin_lock+0x35/0x50
 [<f1a0a4b9>] inet6_addr_add+0xd9/0x160 [ipv6]
 [<f1a0a7d9>] addrconf_add_ifaddr+0x69/0x80 [ipv6]
 [<f1a02342>] inet6_ioctl+0x72/0x90 [ipv6]
 [<b02aaa9e>] sock_ioctl+0xfe/0x1f0
 [<b01720f8>] do_ioctl+0x28/0x80
 [<b01721a7>] vfs_ioctl+0x57/0x2c0
 [<b0172449>] sys_ioctl+0x39/0x60
 [<b0103173>] syscall_call+0x7/0xb


Luca
-- 
Home: http://kronoz.cjb.net
Il tempo speso
a coltivare sogni
non è sprecato.
