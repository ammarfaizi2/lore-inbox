Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262401AbUKDTmy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262401AbUKDTmy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 14:42:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262410AbUKDTmS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 14:42:18 -0500
Received: from dfw-gate4.raytheon.com ([199.46.199.233]:52589 "EHLO
	dfw-gate4.raytheon.com") by vger.kernel.org with ESMTP
	id S262401AbUKDTlK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 14:41:10 -0500
To: Ingo Molnar <mingo@elte.hu>
Cc: Mark_H_Johnson@raytheon.com, Karsten Wiese <annabellesgarden@yahoo.de>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
From: Mark_H_Johnson@raytheon.com
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm2-V0.7.1
Date: Thu, 4 Nov 2004 13:39:44 -0600
Message-ID: <OF88A40911.ECF57E25-ON86256F42.006C01DC-86256F42.006C0216@raytheon.com>
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 11/04/2004 01:39:46 PM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>there was one place missing - does the patch below fix this type of
>deadlock?

A different deadlock this time, same two actors but apparently a
different pair of locks.

Will send the full console log shortly.
  --Mark


===============================================
BUG: circular semaphore deadlock detected!
-----------------------------------------------
ksoftirqd/1/6 is deadlocking current task ksoftirqd/0/3


1) ksoftirqd/0/3 is trying to acquire this lock:
 [dfb5c8a4] {r:0,a:-1,&n->lock}
.. held by:       ksoftirqd/1/    6 [dff886f0,   0]
... acquired at:  arp_solicit+0x167/0x230
... trying at:   neigh_update+0x2a/0x390

2) ksoftirqd/1/6 is blocked on this lock:
 [c03c8900] {r:1,a:-1,ptype_lock}
.. held by:       ksoftirqd/0/    3 [dffe8020,   0]
... acquired at:  net_rx_action+0x8e/0x200

------------------------------
| showing all locks held by: |  (ksoftirqd/0/3 [dffe8020,   0]):
------------------------------

#001:             [d9044c30] {r:0,a:-1,&tp->rx_lock}
... acquired at:  rtl8139_poll+0x48/0x180 [8139too]

------------------------------
| showing all locks held by: |  (ksoftirqd/1/6 [dff886f0,   0]):
------------------------------

#001:             [dfb5c8a4] {r:0,a:-1,&n->lock}
... acquired at:  arp_solicit+0x167/0x230

