Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264190AbTEWVCn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 17:02:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264193AbTEWVCn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 17:02:43 -0400
Received: from h-68-165-86-241.DLLATX37.covad.net ([68.165.86.241]:34622 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S264190AbTEWVCm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 17:02:42 -0400
Subject: [BUGS] 2.5.69 syncppp
From: Paul Fulghum <paulkf@microgate.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1053724551.2589.9.camel@diemos>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 23 May 2003 16:15:52 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm seeing the following with syncppp under 2.5.69:

1. When syncppp tries to send a control protocol packet,
I see the following kernel messages:

 Badness in local_bh_enable at kernel/softirq.c:105
 Call Trace:
  [<c01254b4>] local_bh_enable+0x84/0x90
  [<c02dbbc0>] dev_queue_xmit+0x1c0/0x250
  [<cc82fd18>] sppp_lcp_open+0x78/0x90 [syncppp]
  [<cc82fe3d>] sppp_cp_timeout+0xad/0xd0 [syncppp]
  [<cc82fd90>] sppp_cp_timeout+0x0/0xd0 [syncppp]
  [<c01295dd>] run_timer_softirq+0xcd/0x190
  [<c012542b>] do_softirq+0xdb/0xe0
  [<c011790d>] smp_apic_timer_interrupt+0xcd/0x140
  [<c0108f90>] default_idle+0x0/0x40
  [<c010bc82>] apic_timer_interrupt+0x1a/0x20

This appears the indicate that dev_queue_xmit() can't
be called with local interrupts disabled (which is the
case as a spinlock is held when this call is made).

It looks like a lot of reworking is necessary if this is true.


2. When network packets are received I see the following message:

  [<c0121e65>] fix old protocol handler sppp_rcv+0x0/0x1e [syncppp]!

Any docs covering what needs to be done for this one?

Thanks,
Paul

-- 
Paul Fulghum, paulkf@microgate.com
Microgate Corporation, http://www.microgate.com


