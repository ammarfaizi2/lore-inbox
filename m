Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268225AbUJOQ7Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268225AbUJOQ7Y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 12:59:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268206AbUJOQ7P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 12:59:15 -0400
Received: from dfw-gate4.raytheon.com ([199.46.199.233]:1344 "EHLO
	dfw-gate4.raytheon.com") by vger.kernel.org with ESMTP
	id S268177AbUJOQ5O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 12:57:14 -0400
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U3
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, Andrew Rodland <arodland@entermail.net>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Daniel Walker <dwalker@mvista.com>, "K.R. Foley" <kr@cybsft.com>,
       linux-kernel@vger.kernel.org,
       Lorenzo Allegrucci <l_allegrucci@yahoo.it>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OFB6EC1D35.D97E8854-ON86256F2E.005B1743@raytheon.com>
From: Mark_H_Johnson@raytheon.com
Date: Fri, 15 Oct 2004 11:56:20 -0500
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 10/15/2004 11:56:24 AM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>i have released the -U3 PREEMPT_REALTIME patch:
>
>
http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc4-mm1-U3

>
Built without any problems, booted as single user and had no errors until I
started running init scripts.

First attempt - When I got to S10network start, had a couple
messages displayed about sleeping in invalid contexts (scrolled by too
fast).
It ended with a kernel bug, looked similar to what I reported before. The
new data displayed included:

preempt count: 4
entry 1: schedule+0x46/0x810 / (ksoftirqd+0xd4/0xf0)
entry 2: _spin_lock_irqsave+0x1f/0x80 / (schedule+0x108/0x810)
entry 3: _spin_lock+0x67/0x70 / (load_balance_newidle+0x66/0xc0)
entry 4: _spin_lock+0x67/0x70 / (die_nmi+0x1b/0xa0)

System locked up, hardware reset to reboot. After reboot, noticed
I did capture some data, will send that separately.

Second attempt - basically the same symptom. The kernel BUG output was
incomplete with a "preempt count: 4" but only one entry displayed
(same as entry 1 above).

System locked up, hardware reset to reboot. Will boot with max_cpus=1
to see if I get farther.

Third attempt - had two outputs of tracing data while starting the
network interface. Tried a couple ping commands with numeric destinations
and the machine had no response (displayed) on the first one, Ctrl-C to
abort. On the second try, the system responded the same until I hit Ctrl-C,
no response. Alt-SysRq-T did display task data, ping was in D mode, and
call trace was pretty deep. Thought it was somewhat odd that it (and
several
tasks above it) had a preempt count:1 with
entry 1: _spin_lock+0x1f/0x70 / (__handle_sysrq+0x1f/0xf0)
not sure if that is the expected behavior or not.

Alt-SysRq-S had the same traceback as I reported before. Rebooted with
Alt-SysRq-B.

As mentioned before, will send the system log data in a separate
message.

--Mark H Johnson
  <mailto:Mark_H_Johnson@raytheon.com>

