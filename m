Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965169AbWJBRjt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965169AbWJBRjt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 13:39:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965164AbWJBRjt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 13:39:49 -0400
Received: from mx1.redhat.com ([66.187.233.31]:41605 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965169AbWJBRjs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 13:39:48 -0400
Message-ID: <45214EDC.6060706@redhat.com>
Date: Mon, 02 Oct 2006 12:39:40 -0500
From: Clark Williams <williams@redhat.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Thomas Gleixner <tglx@linutronix.de>
CC: Ingo Molnar <mingo@elte.hu>, john stultz <johnstul@us.ibm.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: hrtimers bug message on 2.6.18-rt4
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Thomas, et al,

I was debugging a PI mutex stress test when I got the following message
on my Athlon64x2 (running 2.6.18-rt4):

BUG: time warp detected!
prev > now, 101878c199393108 > 101878c081eaca2b:
= 4685981405 delta, on CPU#0
 [<c0104c3c>] show_trace+0x2c/0x30
 [<c0104dcb>] dump_stack+0x2b/0x30
 [<c012ec89>] getnstimeofday+0x249/0x270
 [<c013e893>] ktime_get_ts+0x23/0x60
 [<c013e8ef>] ktime_get+0x1f/0x60
 [<c013f042>] hrtimer_interrupt+0x62/0x310
 [<c0114557>] smp_apic_timer_interrupt+0x77/0x90
 [<c0103f33>] apic_timer_interrupt+0x1f/0x24
 [<c0101bc4>] cpu_idle+0x84/0xe0
 [<c01007a4>] rest_init+0x54/0x60
 [<c06258f6>] start_kernel+0x396/0x460
 [<00000000>] 0x0
skipping trace printing on CPU#0 != -1

I've seen this at least three times on -rt4. I'm building -rt5 as I
write this, so I'll run the test again on the new kernel and see what
(if anything) changes.

If you want my test, grab:

   http://people.redhat.com/williams/tests/pi_tests.tar.gz

and build pi_stress.

Clark


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFFIU7cHyuj/+TTEp0RAkfdAJ9KLtBlfgYljBYhBatL+/BatsdygwCZAYkz
9d2C/aSysAX5OppUlqbpSzQ=
=kcN9
-----END PGP SIGNATURE-----
