Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261718AbUJYJNh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261718AbUJYJNh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 05:13:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261726AbUJYJNg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 05:13:36 -0400
Received: from mout1.freenet.de ([194.97.50.132]:10444 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id S261718AbUJYJMl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 05:12:41 -0400
From: Michael Buesch <mbuesch@freenet.de>
To: kraxel@bytesex.org
Subject: bttv_ioctl / BKL preempt / scheduling while atomic and panic
Date: Mon, 25 Oct 2004 11:11:58 +0200
User-Agent: KMail/1.7
Cc: video4linux-list@redhat.com,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <200410251112.03241.mbuesch@freenet.de>
Content-Type: multipart/signed;
  boundary="nextPart1127907.JfeoCITSZt";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1127907.JfeoCITSZt
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

I recently had a crash with kernel 2.6.9-ck2-ac4-nozeroram
The nozeroram patch is available here:
 http://people.freenet.de/tuxsoft/other/nozeroram.diff

I got the following messages in dmesg:

Oct 25 09:39:03 lfs kernel: bad: scheduling while atomic!
Oct 25 09:39:03 lfs kernel:  [<b035ebc0>] schedule+0x4a0/0x572
Oct 25 09:39:03 lfs kernel:  [<f0a00f05>] bttv_ioctl+0x31/0x5e [bttv]
Oct 25 09:39:03 lfs kernel:  [<f09ff7ac>] bttv_do_ioctl+0x0/0x1728 [bttv]
Oct 25 09:39:03 lfs kernel:  [<b0162057>] sys_ioctl+0x1d4/0x245
Oct 25 09:39:03 lfs kernel:  [<b0104052>] work_resched+0x5/0x16
Oct 25 09:39:03 lfs kernel: bad: scheduling while atomic!
Oct 25 09:39:03 lfs kernel:  [<b035ebc0>] schedule+0x4a0/0x572
Oct 25 09:39:03 lfs kernel:  [<b01243b5>] __mod_timer+0x11d/0x159
Oct 25 09:39:03 lfs kernel:  [<b035f1b0>] schedule_timeout+0x6a/0xb7
Oct 25 09:39:03 lfs kernel:  [<b0124e06>] process_timeout+0x0/0x5
Oct 25 09:39:03 lfs kernel:  [<b0162a22>] do_select+0x294/0x2cf
Oct 25 09:39:03 lfs kernel:  [<b01625dd>] __pollwait+0x0/0xc1
Oct 25 09:39:03 lfs kernel:  [<b0162cc7>] sys_select+0x255/0x488
Oct 25 09:39:03 lfs kernel:  [<b035f904>] _spin_unlock_irq+0x9/0x1c
Oct 25 09:39:03 lfs kernel:  [<b0103fd9>] sysenter_past_esp+0x52/0x71
Oct 25 09:39:03 lfs kernel: bad: scheduling while atomic!
Oct 25 09:39:03 lfs kernel:  [<b035ebc0>] schedule+0x4a0/0x572
Oct 25 09:39:03 lfs kernel:  [<b0139799>] __alloc_pages+0x9f/0x323
Oct 25 09:39:03 lfs kernel:  [<b02c9974>] sock_aio_read+0xe8/0x100
Oct 25 09:39:03 lfs kernel:  [<b035f1fb>] schedule_timeout+0xb5/0xb7
Oct 25 09:39:03 lfs kernel:  [<b011a7f4>] add_wait_queue+0x1a/0x46
Oct 25 09:39:03 lfs kernel:  [<b031d996>] unix_poll+0xc1/0xc6
Oct 25 09:39:03 lfs kernel:  [<b0162a22>] do_select+0x294/0x2cf
Oct 25 09:39:03 lfs kernel:  [<b01625dd>] __pollwait+0x0/0xc1
Oct 25 09:39:03 lfs kernel:  [<b011a9ec>] autoremove_wake_function+0x0/0x43
Oct 25 09:39:03 lfs kernel:  [<b0162cc7>] sys_select+0x255/0x488
Oct 25 09:39:03 lfs kernel:  [<b0103fd9>] sysenter_past_esp+0x52/0x71
Oct 25 09:39:03 lfs kernel: Warning: kfree_skb on hard IRQ 00000000
Oct 25 09:39:03 lfs kernel: bad: scheduling while atomic!
Oct 25 09:39:03 lfs kernel:  [<b035ebc0>] schedule+0x4a0/0x572
Oct 25 09:39:03 lfs kernel:  [<b0139799>] __alloc_pages+0x9f/0x323
Oct 25 09:39:03 lfs kernel:  [<b02c9974>] sock_aio_read+0xe8/0x100
Oct 25 09:39:03 lfs kernel:  [<b035f1fb>] schedule_timeout+0xb5/0xb7
Oct 25 09:39:03 lfs kernel:  [<b011a7f4>] add_wait_queue+0x1a/0x46
Oct 25 09:39:03 lfs kernel:  [<b031d996>] unix_poll+0xc1/0xc6
Oct 25 09:39:03 lfs kernel:  [<b0162a22>] do_select+0x294/0x2cf
Oct 25 09:39:03 lfs kernel:  [<b01625dd>] __pollwait+0x0/0xc1
Oct 25 09:39:03 lfs kernel:  [<b011a9ec>] autoremove_wake_function+0x0/0x43
Oct 25 09:39:03 lfs kernel:  [<b0162cc7>] sys_select+0x255/0x488
Oct 25 09:39:03 lfs kernel:  [<b0103fd9>] sysenter_past_esp+0x52/0x71
Oct 25 09:39:03 lfs kernel: Warning: kfree_skb on hard IRQ 00000000
Oct 25 09:39:03 lfs kernel: bad: scheduling while atomic!
Oct 25 09:39:03 lfs kernel:  [<b035ebc0>] schedule+0x4a0/0x572
Oct 25 09:39:03 lfs kernel:  [<f0a00f05>] bttv_ioctl+0x31/0x5e [bttv]
Oct 25 09:39:03 lfs kernel:  [<f09ff7ac>] bttv_do_ioctl+0x0/0x1728 [bttv]
Oct 25 09:39:03 lfs kernel:  [<b0162057>] sys_ioctl+0x1d4/0x245
Oct 25 09:39:03 lfs kernel:  [<b01207b6>] sys_time+0x16/0x50
Oct 25 09:39:03 lfs kernel:  [<b0104052>] work_resched+0x5/0x16
Oct 25 09:39:03 lfs kernel: bad: scheduling while atomic!
Oct 25 09:39:03 lfs kernel:  [<b035ebc0>] schedule+0x4a0/0x572
Oct 25 09:39:03 lfs kernel:  [<b0139799>] __alloc_pages+0x9f/0x323
Oct 25 09:39:03 lfs kernel:  [<b02c9974>] sock_aio_read+0xe8/0x100
Oct 25 09:39:03 lfs kernel:  [<b035f1fb>] schedule_timeout+0xb5/0xb7
Oct 25 09:39:03 lfs kernel:  [<b011a7f4>] add_wait_queue+0x1a/0x46
Oct 25 09:39:03 lfs kernel:  [<b031d996>] unix_poll+0xc1/0xc6
Oct 25 09:39:03 lfs kernel:  [<b0162a22>] do_select+0x294/0x2cf
Oct 25 09:39:03 lfs kernel:  [<b01625dd>] __pollwait+0x0/0xc1
Oct 25 09:39:03 lfs kernel:  [<b011a9ec>] autoremove_wake_function+0x0/0x43
Oct 25 09:39:03 lfs kernel:  [<b0162cc7>] sys_select+0x255/0x488
Oct 25 09:39:03 lfs kernel:  [<b0103fd9>] sysenter_past_esp+0x52/0x71
Oct 25 09:39:03 lfs kernel: Warning: kfree_skb on hard IRQ 00000000
Oct 25 09:39:03 lfs kernel: bad: scheduling while atomic!
Oct 25 09:39:03 lfs kernel:  [<b035ebc0>] schedule+0x4a0/0x572
Oct 25 09:39:03 lfs kernel:  [<b01e55ab>] copy_to_user+0x32/0x45
Oct 25 09:39:03 lfs kernel:  [<b0120869>] sys_gettimeofday+0x2c/0x65
Oct 25 09:39:03 lfs kernel:  [<b0104052>] work_resched+0x5/0x16
Oct 25 09:39:03 lfs kernel: bad: scheduling while atomic!
Oct 25 09:39:03 lfs kernel:  [<b035ebc0>] schedule+0x4a0/0x572
Oct 25 09:39:03 lfs kernel:  [<b0104052>] work_resched+0x5/0x16
Oct 25 09:39:03 lfs kernel: bad: scheduling while atomic!
Oct 25 09:39:03 lfs kernel:  [<b035ebc0>] schedule+0x4a0/0x572
Oct 25 09:39:03 lfs kernel:  [<b0104052>] work_resched+0x5/0x16
Oct 25 09:39:03 lfs kernel: bad: scheduling while atomic!
Oct 25 09:39:03 lfs kernel:  [<b035ebc0>] schedule+0x4a0/0x572
Oct 25 09:39:03 lfs kernel:  [<b0139799>] __alloc_pages+0x9f/0x323
Oct 25 09:39:03 lfs kernel:  [<b02c9974>] sock_aio_read+0xe8/0x100
Oct 25 09:39:03 lfs kernel:  [<b035f1fb>] schedule_timeout+0xb5/0xb7
Oct 25 09:39:03 lfs kernel:  [<b011a7f4>] add_wait_queue+0x1a/0x46
Oct 25 09:39:03 lfs kernel:  [<b031d996>] unix_poll+0xc1/0xc6
Oct 25 09:39:03 lfs kernel:  [<b0162a22>] do_select+0x294/0x2cf
Oct 25 09:39:03 lfs kernel:  [<b01625dd>] __pollwait+0x0/0xc1
Oct 25 09:39:03 lfs kernel:  [<b011a9ec>] autoremove_wake_function+0x0/0x43
Oct 25 09:39:03 lfs kernel:  [<b0162cc7>] sys_select+0x255/0x488
Oct 25 09:39:03 lfs kernel:  [<b0103fd9>] sysenter_past_esp+0x52/0x71
Oct 25 09:39:03 lfs kernel: Warning: kfree_skb on hard IRQ 00000000
Oct 25 09:39:03 lfs kernel: bad: scheduling while atomic!
Oct 25 09:39:03 lfs kernel:  [<b035ebc0>] schedule+0x4a0/0x572
Oct 25 09:39:03 lfs kernel:  [<b01e55ab>] copy_to_user+0x32/0x45
Oct 25 09:39:03 lfs kernel:  [<b0120869>] sys_gettimeofday+0x2c/0x65
Oct 25 09:39:03 lfs kernel:  [<b0104052>] work_resched+0x5/0x16
Oct 25 09:39:03 lfs kernel: bad: scheduling while atomic!
Oct 25 09:39:03 lfs kernel:  [<b035ebc0>] schedule+0x4a0/0x572
Oct 25 09:39:03 lfs kernel:  [<b012101f>] __do_softirq+0x5f/0xca
Oct 25 09:39:03 lfs kernel:  [<b0104052>] work_resched+0x5/0x16
Oct 25 09:39:03 lfs kernel: bad: scheduling while atomic!
Oct 25 09:39:03 lfs kernel:  [<b035ebc0>] schedule+0x4a0/0x572
Oct 25 09:39:03 lfs kernel:  [<b0139799>] __alloc_pages+0x9f/0x323
Oct 25 09:39:03 lfs kernel:  [<b02c9974>] sock_aio_read+0xe8/0x100
Oct 25 09:39:03 lfs kernel:  [<b035f1fb>] schedule_timeout+0xb5/0xb7
Oct 25 09:39:03 lfs kernel:  [<b011a7f4>] add_wait_queue+0x1a/0x46
Oct 25 09:39:03 lfs kernel:  [<b031d996>] unix_poll+0xc1/0xc6
Oct 25 09:39:03 lfs kernel:  [<b0162a22>] do_select+0x294/0x2cf
Oct 25 09:39:03 lfs kernel:  [<b01625dd>] __pollwait+0x0/0xc1
Oct 25 09:39:03 lfs kernel:  [<b011a9ec>] autoremove_wake_function+0x0/0x43
Oct 25 09:39:03 lfs kernel:  [<b0162cc7>] sys_select+0x255/0x488
Oct 25 09:39:03 lfs kernel:  [<b0103fd9>] sysenter_past_esp+0x52/0x71
Oct 25 09:39:03 lfs kernel: Warning: kfree_skb on hard IRQ 00000000
Oct 25 09:39:03 lfs kernel: bad: scheduling while atomic!
Oct 25 09:39:03 lfs kernel:  [<b035ebc0>] schedule+0x4a0/0x572
Oct 25 09:39:03 lfs kernel:  [<b01e55ab>] copy_to_user+0x32/0x45
Oct 25 09:39:03 lfs kernel:  [<b0120869>] sys_gettimeofday+0x2c/0x65
Oct 25 09:39:03 lfs kernel:  [<b0104052>] work_resched+0x5/0x16
Oct 25 09:39:03 lfs kernel: bad: scheduling while atomic!
Oct 25 09:39:03 lfs kernel:  [<b035ebc0>] schedule+0x4a0/0x572
Oct 25 09:39:03 lfs kernel:  [<b0139799>] __alloc_pages+0x9f/0x323
Oct 25 09:39:03 lfs kernel:  [<b02c9974>] sock_aio_read+0xe8/0x100
Oct 25 09:39:03 lfs kernel:  [<b035f1fb>] schedule_timeout+0xb5/0xb7
Oct 25 09:39:03 lfs kernel:  [<b011a7f4>] add_wait_queue+0x1a/0x46
Oct 25 09:39:03 lfs kernel:  [<b031d996>] unix_poll+0xc1/0xc6
Oct 25 09:39:03 lfs kernel:  [<b0162a22>] do_select+0x294/0x2cf
Oct 25 09:39:03 lfs kernel:  [<b01625dd>] __pollwait+0x0/0xc1
Oct 25 09:39:03 lfs kernel:  [<b011a9ec>] autoremove_wake_function+0x0/0x43
Oct 25 09:39:03 lfs kernel:  [<b0162cc7>] sys_select+0x255/0x488
Oct 25 09:39:03 lfs kernel:  [<b0103fd9>] sysenter_past_esp+0x52/0x71
Oct 25 09:39:03 lfs kernel: Warning: kfree_skb on hard IRQ 00000000
Oct 25 09:39:03 lfs kernel: bad: scheduling while atomic!
Oct 25 09:39:03 lfs kernel:  [<b035ebc0>] schedule+0x4a0/0x572
Oct 25 09:39:03 lfs kernel:  [<b01e55ab>] copy_to_user+0x32/0x45
Oct 25 09:39:03 lfs kernel:  [<b0120869>] sys_gettimeofday+0x2c/0x65
Oct 25 09:39:03 lfs kernel:  [<b0104052>] work_resched+0x5/0x16
Oct 25 09:39:03 lfs kernel: bad: scheduling while atomic!
Oct 25 09:39:03 lfs kernel:  [<b035ebc0>] schedule+0x4a0/0x572
Oct 25 09:39:03 lfs kernel:  [<f0a00f05>] bttv_ioctl+0x31/0x5e [bttv]
Oct 25 09:39:03 lfs kernel:  [<f09ff7ac>] bttv_do_ioctl+0x0/0x1728 [bttv]
Oct 25 09:39:03 lfs kernel:  [<b0162057>] sys_ioctl+0x1d4/0x245
Oct 25 09:39:03 lfs kernel:  [<b01207b6>] sys_time+0x16/0x50
Oct 25 09:39:03 lfs kernel:  [<b0104052>] work_resched+0x5/0x16
Oct 25 09:39:03 lfs kernel: bad: scheduling while atomic!
Oct 25 09:39:03 lfs kernel:  [<b035ebc0>] schedule+0x4a0/0x572
Oct 25 09:39:03 lfs kernel:  [<b01243b5>] __mod_timer+0x11d/0x159
Oct 25 09:39:03 lfs kernel:  [<b035f1b0>] schedule_timeout+0x6a/0xb7
Oct 25 09:39:03 lfs kernel:  [<b01178ca>] try_to_wake_up+0x1e1/0x26d
Oct 25 09:39:03 lfs kernel:  [<b0124e06>] process_timeout+0x0/0x5
Oct 25 09:39:03 lfs kernel:  [<b0162a22>] do_select+0x294/0x2cf
Oct 25 09:39:03 lfs kernel:  [<b01625dd>] __pollwait+0x0/0xc1
Oct 25 09:39:03 lfs kernel:  [<b0104d3b>] print_context_stack+0x1d/0x59
Oct 25 09:39:03 lfs kernel:  [<b0162cc7>] sys_select+0x255/0x488
Oct 25 09:39:03 lfs kernel:  [<b0103fd9>] sysenter_past_esp+0x52/0x71
Oct 25 09:39:03 lfs kernel: bad: scheduling while atomic!
Oct 25 09:39:03 lfs kernel:  [<b035ebc0>] schedule+0x4a0/0x572
Oct 25 09:39:03 lfs kernel:  [<b0139799>] __alloc_pages+0x9f/0x323
Oct 25 09:39:03 lfs kernel:  [<b02c9974>] sock_aio_read+0xe8/0x100
Oct 25 09:39:03 lfs kernel:  [<b035f1fb>] schedule_timeout+0xb5/0xb7
Oct 25 09:39:03 lfs kernel:  [<b011a7f4>] add_wait_queue+0x1a/0x46
Oct 25 09:39:03 lfs kernel:  [<b031d996>] unix_poll+0xc1/0xc6
Oct 25 09:39:03 lfs kernel:  [<b0162a22>] do_select+0x294/0x2cf
Oct 25 09:39:03 lfs kernel:  [<b01625dd>] __pollwait+0x0/0xc1
Oct 25 09:39:03 lfs kernel:  [<b011a9ec>] autoremove_wake_function+0x0/0x43
Oct 25 09:39:03 lfs kernel:  [<b0162cc7>] sys_select+0x255/0x488
Oct 25 09:39:03 lfs kernel:  [<b0103fd9>] sysenter_past_esp+0x52/0x71
Oct 25 09:39:03 lfs kernel: Warning: kfree_skb on hard IRQ 00000000
[snipped thousands of scheduling while atomic messages]
Then the kernel panicked.

BKL preempt is enabled. I think this could be the reason for the crash.
(normal preempt is enabled as well)
It's all non-reproduceable.

=2D-=20
Regards Michael Buesch  [ http://www.tuxsoft.de.vu ]


--nextPart1127907.JfeoCITSZt
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBfMNjFGK1OIvVOP4RAk0YAJ9I+SihqysY0HoBUT5GT4VfNY2YGwCbBMB4
GDWPWTBAwybpiNXT47+jacg=
=61mL
-----END PGP SIGNATURE-----

--nextPart1127907.JfeoCITSZt--
