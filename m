Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264147AbUH3WF7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264147AbUH3WF7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 18:05:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264098AbUH3WFx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 18:05:53 -0400
Received: from lax-gate4.raytheon.com ([199.46.200.233]:17997 "EHLO
	lax-gate4.raytheon.com") by vger.kernel.org with ESMTP
	id S263893AbUH3WFg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 18:05:36 -0400
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q5
To: Ingo Molnar <mingo@elte.hu>
Cc: "K.R. Foley" <kr@cybsft.com>, linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       Daniel Schmitt <pnambic@unu.nu>, Lee Revell <rlrevell@joe-job.com>
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OF8AC76C1C.20634F1C-ON86256F00.007813C0@raytheon.com>
From: Mark_H_Johnson@raytheon.com
Date: Mon, 30 Aug 2004 17:04:32 -0500
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 08/30/2004 05:04:36 PM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>regarding this particular latency, could you try the attached patch
>ontop of -Q5? It turns the ->poll() loop into separate, individually
>preemptable iterations instead of one batch of processing. In theory
>this should result in latency being lower regardless of the
>netdev_max_backlog value.

First time - stopped during init script - when trying to start a network
service (automount).
Second time - stopped during init script - did not get the "OK" for
bringing up interface eth0.
Alt-SysRq-P still does not show any data [not sure why].
Alt-SysRq-T captured data - for example, shows dhclient in sys_select ->
__pollwait -> do_select -> process_timeout -> add_wait_queue ->
schedule_timeout -> __mod_timer. Very odd, almost every other task (except
initlog) is stuck in one of:
 - generic_handle_IRQ_event
 - sub_preempt_count
 - do_irqd
 - do_hardirq
and all the tasks I can see have "S" status.
Third time - ditto - back to stopping at automount start up.
Alt-SysRq-T captured data, again everything I could look at in "S" mode.
In all three cases, another system attempting to "ping" the system under
test failed to get any responses.

In all cases, Ctrl-Alt-Del was good enough to get a clean reboot.

This looks like a bad patch; will go back to the last good kernel for
further testing.

--Mark H Johnson
  <mailto:Mark_H_Johnson@raytheon.com>

