Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266837AbUJRQZ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266837AbUJRQZ6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 12:25:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266833AbUJRQZ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 12:25:58 -0400
Received: from dfw-gate4.raytheon.com ([199.46.199.233]:28210 "EHLO
	dfw-gate4.raytheon.com") by vger.kernel.org with ESMTP
	id S266837AbUJRQZk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 12:25:40 -0400
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>
From: Mark_H_Johnson@raytheon.com
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U5
Date: Mon, 18 Oct 2004 11:24:46 -0500
Message-ID: <OFF2CA4065.A5BB2E79-ON86256F31.005A287D-86256F31.005A2895@raytheon.com>
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 10/18/2004 11:24:51 AM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>i have released the -U5 Real-Time Preemption patch:
>
>
http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc4-mm1-U5

I am getting build problems - specifically with:

  CC [M]  drivers/char/ipmi/ipmi_watchdog.o
  CC [M]  fs/jfs/jfs_dmap.o
drivers/char/ipmi/ipmi_watchdog.c:389: warning: type defaults to `int' in
declaration of `DECLARE_MUTEX_LOCKED'
drivers/char/ipmi/ipmi_watchdog.c:389: warning: parameter names (without
types) in function declaration
drivers/char/ipmi/ipmi_watchdog.c: In function `heartbeat_free_smi':
drivers/char/ipmi/ipmi_watchdog.c:393: error: `heartbeat_wait_lock'
undeclared (first use in this function)
drivers/char/ipmi/ipmi_watchdog.c:393: error: (Each undeclared identifier
is reported only once
drivers/char/ipmi/ipmi_watchdog.c:393: error: for each function it appears
in.)
drivers/char/ipmi/ipmi_watchdog.c: In function `heartbeat_free_recv':
drivers/char/ipmi/ipmi_watchdog.c:398: error: `heartbeat_wait_lock'
undeclared (first use in this function)
drivers/char/ipmi/ipmi_watchdog.c: In function `ipmi_heartbeat':
drivers/char/ipmi/ipmi_watchdog.c:476: error: `heartbeat_wait_lock'
undeclared (first use in this function)
drivers/char/ipmi/ipmi_watchdog.c: At top level:
drivers/char/ipmi/ipmi_watchdog.c:389: warning: `DECLARE_MUTEX_LOCKED'
declared `static' but never defined

If I read the patch correctly, this should be recoded as
  DECLARE_MUTEX
instead, but a quick grep of the source code indicates we have about
20 more places where DECLARE_MUTEX_LOCKED is still used. Should I do
a global replace on that or is something else needed?

I also had a compile failure in XFS. The messages are:
  CC [M]  fs/xfs/quota/xfs_dquot_item.o
  CC [M]  fs/xfs/quota/xfs_trans_dquot.o
fs/xfs/quota/xfs_dquot_item.c: In function `xfs_qm_dquot_logitem_pushbuf':
fs/xfs/quota/xfs_dquot_item.c:266: error: structure has no member named
`count'
fs/xfs/quota/xfs_dquot_item.c:279: error: structure has no member named
`count'

This refers to a macro defined at
fs/xfs/linux-2.6/sema.h:51:#define valusema(sp)
(atomic_read(&(sp)->count))

Not quite sure if this is an error due to type changes or yet another
name collision.

Please advise how to proceed.

  --Mark

