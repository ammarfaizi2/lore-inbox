Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966853AbWKTWSg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966853AbWKTWSg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 17:18:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966875AbWKTWSe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 17:18:34 -0500
Received: from mx1.redhat.com ([66.187.233.31]:5258 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S966869AbWKTWSC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 17:18:02 -0500
Message-ID: <456228D7.80507@redhat.com>
Date: Mon, 20 Nov 2006 16:14:47 -0600
From: Clark Williams <williams@redhat.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20061027)
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       john stultz <johnstul@us.ibm.com>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Time warp on 2.6.19-rc6-rt4
X-Enigmail-Version: 0.94.1.2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Ingo/Thomas/John/et al,

I've seen sporadic time warp messages while running my pi_stress program
(http://people.redhat.com/williams/tests/pi_tests-1.7.tar.gz). The
frequency of time warp occurrences has been gong down over time, but I
just got one on a dual Opteron running 2.6.19-rc6-rt4:

- --------------
$ sudo ./pi_stress --signal
Starting PI Stress test
    Test threads using scheduler policy: SCHED_FIFO
      Admin priority:    99
      Reporter priority: 98
    10 groups of 3 threads will be created
      High priority:     97
      Med priority:      96
      Low priority:      95
    Admin threads running on processor: 0
    Test threads running on processor:  1
Press Ctrl-C to stop test
Current Inversions: 1032940
Stoppping test
Total inversion performed: 6836686
- --------------

The Current Inversions line is dynamically updated, but after I noticed
it had stopped updating, I looked a the console and found:

- --------------
BUG: time warp detected!
prev > now, 10277e5c84132156 > 10277e5b6c9e0baf:
= 4688516519 delta, on CPU#0

Call Trace:
 [<ffffffff8026e647>] dump_trace+0xaa/0x3f2
 [<ffffffff8026e9c9>] show_trace+0x3a/0x58
 [<ffffffff8026ec03>] dump_stack+0x15/0x17
 [<ffffffff8025cd91>] getnstimeofday+0x142/0x150
 [<ffffffff802a2aff>] sys_clock_gettime+0x4d/0x98
 [<ffffffff802601cf>] system_call+0xef/0x15c
DWARF2 unwinder stuck at system_call+0xef/0x15c

Leftover inexact backtrace:


skipping trace printing on CPU#0 != -1
hdb: lost interrupt
hdb: lost interrupt
- --------------

The system was still running, but in my test the timer wasn't updating.
This was actually one of Ingo's prepackaged kernel-rt rpms, so I don't
have much debug on.

Anything you want me to try?

Clark
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFFYijXHyuj/+TTEp0RAslPAKCdeI1cbm8hINu0b2aR38LCeEaYZgCdHPAG
Heb3RlEy2UnmZX1rUpBvmN4=
=zDdd
-----END PGP SIGNATURE-----
