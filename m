Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030209AbWCWITt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030209AbWCWITt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 03:19:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030210AbWCWITt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 03:19:49 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:151 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030209AbWCWITs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 03:19:48 -0500
Date: Thu, 23 Mar 2006 09:17:08 +0100
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>
Subject: 2.6.16-rt5
Message-ID: <20060323081707.GA5280@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i have released the 2.6.16-rt5 tree, which can be downloaded from the 
usual place:

   http://redhat.com/~mingo/realtime-preempt/

there's been quite some churn since -rt1:

 244 files changed, 1806 insertions(+), 1588 deletions(-)

this was mostly due to the simplification of IRQ-flag handling: 
local_irq_*() now defaults to using the raw IRQ flags. The 'soft 
irq-flag' code only had a debugging purpose, but that purpose is equally 
well suited by dont-schedule-while-in-atomic-section checks. This 
cleanup resulted in a nice 10% reduction of the -rt patch's size, and 
should make porting to architectures simpler.

another bigger change is the continued rework of the PI code by Thomas 
Gleixner: it should now be Bug Free (tm) - in particular the SMP locking 
deadlock noticed by Esben Nielsen should be fixed. There are also lots 
of updates to the PI-futex code too, by Thomas.

there are also lots of smaller fixes for regressions in -rt1.

to build a 2.6.16-rt5 tree, the following patches should be applied:

  http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.16.tar.bz2
  http://redhat.com/~mingo/realtime-preempt/patch-2.6.16-rt5

	Ingo
