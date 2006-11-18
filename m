Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755518AbWKRNMp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755518AbWKRNMp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 08:12:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755524AbWKRNMp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 08:12:45 -0500
Received: from mx2.mail.ru ([194.67.23.122]:7558 "EHLO mx2.mail.ru")
	by vger.kernel.org with ESMTP id S1755518AbWKRNMo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 08:12:44 -0500
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: samuel@sortiz.org
Subject: 2.6.19-rc5: lockdep warnings starting irattach
Date: Sat, 18 Nov 2006 16:12:25 +0300
User-Agent: KMail/1.9.5
Cc: irda-users@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611181612.36008.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I experimented with SyncCE; after starting IrDA I got this:

Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:09: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ip_tables: (C) 2000-2006 Netfilter Core Team

=============================================
[ INFO: possible recursive locking detected ]
2.6.19-rc5-2avb #2
- ---------------------------------------------
pppd/26425 is trying to acquire lock:
 (&hashbin->hb_spinlock){....}, at: [<dfdea87a>] irlmp_slsap_inuse+0x5a/0x170 
[irda]

but task is already holding lock:
 (&hashbin->hb_spinlock){....}, at: [<dfdea857>] irlmp_slsap_inuse+0x37/0x170 
[irda]

other info that might help us debug this:
1 lock held by pppd/26425:
 #0:  (&hashbin->hb_spinlock){....}, at: [<dfdea857>] 
irlmp_slsap_inuse+0x37/0x170 [irda]

stack backtrace:
 [<c010413c>] dump_trace+0x1cc/0x200
 [<c010418a>] show_trace_log_lvl+0x1a/0x30
 [<c01047f2>] show_trace+0x12/0x20
 [<c01048c9>] dump_stack+0x19/0x20
 [<c01346ca>] __lock_acquire+0x8fa/0xc20
 [<c0134d2d>] lock_acquire+0x5d/0x80
 [<c02a851c>] _spin_lock+0x2c/0x40
 [<dfdea87a>] irlmp_slsap_inuse+0x5a/0x170 [irda]
 [<dfdebab2>] irlmp_open_lsap+0x62/0x180 [irda]
 [<dfdf35d1>] irttp_open_tsap+0x181/0x230 [irda]
 [<dfdc0c3d>] ircomm_open_tsap+0x5d/0xa0 [ircomm]
 [<dfdc05d8>] ircomm_open+0xb8/0xd0 [ircomm]
 [<dfdd0477>] ircomm_tty_open+0x4f7/0x570 [ircomm_tty]
 [<c020bbe4>] tty_open+0x174/0x340
 [<c016bd69>] chrdev_open+0x89/0x170
 [<c0167bd6>] __dentry_open+0xa6/0x1d0
 [<c0167da5>] nameidata_to_filp+0x35/0x40
 [<c0167df9>] do_filp_open+0x49/0x50
 [<c0167e47>] do_sys_open+0x47/0xd0
 [<c0167f0c>] sys_open+0x1c/0x20
 [<c010307d>] sysenter_past_esp+0x56/0x8d
 [<b7f86410>] 0xb7f86410
 =======================

This apparently happens when irattach is run. Interface itself (irda0) is 
created as far as I can tell.

Please let me know if additional information is required.

- -andrey

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFXwbDR6LMutpd94wRAiUpAJwIK5hSusOwFUloh0jXOb5hk5iVwgCfX7Iq
c5kRWItPWR9WGw4jORPd21k=
=oax8
-----END PGP SIGNATURE-----
