Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932674AbVHPMR4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932674AbVHPMR4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 08:17:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932675AbVHPMR4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 08:17:56 -0400
Received: from mx1.elte.hu ([157.181.1.137]:42659 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S932674AbVHPMRz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 08:17:55 -0400
Date: Tue, 16 Aug 2005 14:18:43 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>
Subject: 2.6.13-rc6-rt3
Message-ID: <20050816121843.GA24308@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


i have released the 2.6.13-rc6-rt3 tree, which can be downloaded from 
the usual place:

  http://redhat.com/~mingo/realtime-preempt/

Changes since 2.6.13-rc6-rt2:

 - reverted an incorrect tasklist_lock -> lock_task() conversion that 
   slipped in via an earlier hack in the HRT code. The issue it tried to 
   solve is mooted by the RCU-tasklist-lock code.

 - introduce mutex_chprio() as the mechanism for High Resolution timers 
   to dynamically change the priority of the HRT softirq thread. [This
   fixes a latency/priority bug in where the dynamic prio would override 
   the inherited priority, and when the PI mechanism restores priority 
   it would override the HRT priority.]

 - now that HR-timer dynamic priorities have the proper framework, 
   removed the HIGH_RES_TIMERS_DYN_PRIO config option and made the 
   feature unconditional.

to build a 2.6.13-rc6-rt3 tree, the following patches should be applied:

   http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.12.tar.bz2
   http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.13-rc6.bz2
   http://redhat.com/~mingo/realtime-preempt/patch-2.6.13-rc6-rt3

	Ingo
