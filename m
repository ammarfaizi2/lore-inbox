Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932540AbVHINgu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932540AbVHINgu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 09:36:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932544AbVHINgu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 09:36:50 -0400
Received: from van-1-67.lab.dnainternet.fi ([62.78.96.67]:53673 "EHLO
	mail.zmailer.org") by vger.kernel.org with ESMTP id S932540AbVHINgt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 09:36:49 -0400
Date: Tue, 9 Aug 2005 16:36:47 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: linux-kernel@vger.kernel.org
Subject: Soft lockup in e100 driver ?
Message-ID: <20050809133647.GK22165@mea-ext.zmailer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Running very recent Fedora Core Development kernel I can following
soft-oops..   ( 2.6.12-1.1455_FC5smp )


e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex
BUG: soft lockup detected on CPU#0!

Pid: 10743, comm:             ifconfig
EIP: 0060:[<f88bf2f9>] CPU: 0
EIP is at e100_clean_cbs+0x2f/0x12b [e100]
 EFLAGS: 00000293    Not tainted  (2.6.12-1.1455_FC5smp)
EAX: 495c7c2b EBX: 495c7c2b ECX: f6c311a0 EDX: 00000000
ESI: 00000040 EDI: f6c30000 EBP: f71a4b20 DS: 007b ES: 007b
CR0: 8005003b CR2: 0804a544 CR3: 01e9cd80 CR4: 000006f0
 [<f88c0708>] e100_down+0x66/0x9a [e100]
 [<f88c1623>] e100_close+0xa/0xd [e100]
 [<c02b7adb>] dev_close+0x40/0x7e
 [<c02b8f59>] dev_change_flags+0x46/0xf5
 [<c02f76b3>] devinet_ioctl+0x564/0x5df
 [<c02af22c>] sock_ioctl+0xc3/0x250
 [<c02af169>] sock_ioctl+0x0/0x250
 [<c01762ef>] do_ioctl+0x1f/0x6d
 [<c017648f>] vfs_ioctl+0x50/0x1c6
 [<c0176662>] sys_ioctl+0x5d/0x6f
 [<c010394d>] syscall_call+0x7/0xb
 [<c014473f>] softlockup_tick+0x6f/0x80
 [<c01085b8>] timer_interrupt+0x2d/0x75
 [<c01448dd>] handle_IRQ_event+0x2e/0x5a
 [<c01449cb>] __do_IRQ+0xc2/0x127
 [<c0105f7e>] do_IRQ+0x4e/0x86
 =======================
 [<c01160cc>] smp_apic_timer_interrupt+0xc1/0xca
 [<c0104382>] common_interrupt+0x1a/0x20
 [<f88bf2f9>] e100_clean_cbs+0x2f/0x12b [e100]
 [<f88c0708>] e100_down+0x66/0x9a [e100]
 [<f88c1623>] e100_close+0xa/0xd [e100]
 [<c02b7adb>] dev_close+0x40/0x7e
 [<c02b8f59>] dev_change_flags+0x46/0xf5
 [<c02f76b3>] devinet_ioctl+0x564/0x5df
 [<c02af22c>] sock_ioctl+0xc3/0x250
 [<c02af169>] sock_ioctl+0x0/0x250
 [<c01762ef>] do_ioctl+0x1f/0x6d
 [<c017648f>] vfs_ioctl+0x50/0x1c6
 [<c0176662>] sys_ioctl+0x5d/0x6f
 [<c010394d>] syscall_call+0x7/0xb



Preconditions for this are:

- E100 card stopped working for some reason (no idea why, it just
  does sometimes at this oldish 2x P-III machine)
- There are active datastreams running in and out
  (around 0.2 Mbps out, multiple megabits in.)
- Commanding then "ifconfig eth0 down" results in what feels like 
  system freezing, but it does recover in about 30-60 seconds
  (it takes long enough for me to sweat bullets...)
- While in freeze state, keyboard can go crazy, but mouse does
  respond, as well as tvtime shows bt848 captured live video.
