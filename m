Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932071AbWFFCvj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932071AbWFFCvj (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 22:51:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932072AbWFFCvj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 22:51:39 -0400
Received: from pool-72-66-198-190.ronkva.east.verizon.net ([72.66.198.190]:41414
	"EHLO turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S932071AbWFFCvi (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 22:51:38 -0400
Message-Id: <200606060250.k562oCrA004583@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Andrew Morton <akpm@osdl.org>, arjan@infradead.org, mingo@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.17-rc5-mm3-lockdep - 
From: Valdis.Kletnieks@vt.edu
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1149562212_3257P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 05 Jun 2006 22:50:12 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1149562212_3257P
Content-Type: text/plain; charset=us-ascii

It's living longer before it throws a complaint - we're making it out of
rc.sysinit and into rc5.d ;)  This time we were in an 'id' command from this:

test `id -u` = 0  || exit 4

in either S11mcstrans or S18auditd.  Looks like the Firewire (which I
don't actually use for anything) threw an IRQ at an inopportune time?

(Obviously I stress different code paths than Arjan or Ingo.  But if
I did the same things they did, it wouldn't be interesting.. ;)

[  464.687000] (              id-2700 |#0): new 569737200 us user-latency.
[  464.687000] stopped custom tracer.
[  464.687000] 
[  464.687000] ============================
[  464.687000] [ BUG: illegal lock usage! ]
[  464.687000] ----------------------------
[  464.687000] illegal {in-hardirq-W} -> {hardirq-on-W} usage.
[  464.687000] id/2700 [HC0[0]:SC0[1]:HE1:SE0] takes:
[  464.687000]  (&list->lock){++..}, at: [<c0351a07>] unix_stream_connect+0x334/0x408
[  464.687000] {in-hardirq-W} state was registered at:
[  464.687000]   [<c012dd45>] lockdep_acquire+0x67/0x7f
[  464.687000]   [<c0383f11>] _spin_lock_irqsave+0x30/0x3f
[  464.687000]   [<c02fa93f>] skb_dequeue+0x18/0x49
[  464.687000]   [<f086b7f1>] hpsb_bus_reset+0x5e/0xa2 [ieee1394]
[  464.687000]   [<f0887007>] ohci_irq_handler+0x370/0x726 [ohci1394]
[  464.687000]   [<c013f9a8>] handle_IRQ_event+0x1d/0x52
[  464.687000]   [<c0140bc4>] handle_level_irq+0x97/0xe3
[  464.687000]   [<c01045d0>] do_IRQ+0x8b/0xaf
[  464.687000] irq event stamp: 2964
[  464.687000] hardirqs last  enabled at (2963): [<c0384223>] _spin_unlock_irqrestore+0x3b/0x6d
[  464.687000] hardirqs last disabled at (2962): [<c0383ef5>] _spin_lock_irqsave+0x14/0x3f
[  464.687000] softirqs last  enabled at (2956): [<c0119da0>] __do_softirq+0x9d/0xa5
[  464.687000] softirqs last disabled at (2964): [<c0383f6b>] _spin_lock_bh+0x10/0x3a
[  464.687000] 
[  464.687000] other info that might help us debug this:
[  464.687000] 1 locks held by id/2700:
[  464.687000]  #0:  (&u->lock){--..}, at: [<c03517bb>] unix_stream_connect+0xe8/0x408
[  464.687000] 
[  464.687000] stack backtrace:
[  464.687000]  [<c01032d6>] show_trace_log_lvl+0x64/0x125
[  464.687000]  [<c0103865>] show_trace+0x1b/0x20
[  464.687000]  [<c010391c>] dump_stack+0x1f/0x24
[  464.687000]  [<c012bfb1>] print_usage_bug+0x1a8/0x1b4
[  464.687000]  [<c012c6c7>] mark_lock+0x2ba/0x4e5
[  464.687000]  [<c012d2b8>] __lockdep_acquire+0x476/0xa91
[  464.687000]  [<c012dd45>] lockdep_acquire+0x67/0x7f
[  464.687000]  [<c0383f87>] _spin_lock_bh+0x2c/0x3a
[  464.687000]  [<c0351a07>] unix_stream_connect+0x334/0x408
[  464.687000]  [<c02f7236>] sys_connect+0x6e/0xa3
[  464.687000]  [<c02f79da>] sys_socketcall+0x96/0x190
[  464.687000]  [<c03845e2>] sysenter_past_esp+0x63/0xa1


--==_Exmh_1149562212_3257P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEhO1kcC3lWbTT17ARAtflAJ9uHmethENAMx6/mylkeIg1EFfneQCeKo6j
Qd9FXVbKuPDyA6RMFd03l9o=
=hC1W
-----END PGP SIGNATURE-----

--==_Exmh_1149562212_3257P--
