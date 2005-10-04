Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964790AbVJDInn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964790AbVJDInn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 04:43:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964792AbVJDInn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 04:43:43 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:17597 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964790AbVJDInm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 04:43:42 -0400
Date: Tue, 4 Oct 2005 10:44:05 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
       david singleton <dsingleton@mvista.com>, Todd.Kneisel@bull.com,
       Felix Oxley <lkml@oxley.org>
Subject: 2.6.14-rc3-rt2
Message-ID: <20051004084405.GA24296@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


i have released the 2.6.14-rc3-rt2 tree, which can be downloaded from 
the usual place:

  http://redhat.com/~mingo/realtime-preempt/

the biggest change in this release is the long-anticipated merge of a 
streamlined version of the "robust futexes/mutexes with priority 
queueing and priority inheritance" code into the -rt tree. The original 
upstream patch is from Todd Kneisel, with further improvements, cleanups 
and -RT integration done by David Singleton.

robustness is handled by extending the futex framework with 
registering/unregistering ops and extended wait/wake ops. Priority 
queueing and inheritance is implemented by embedding the rt_mutex object 
into the robust-futex structure. This approach made the patches 
significantly simpler and smaller (but still not trivial at all) than 
e.g. the fusyn patchset was.

the intent of this merge is to provide a testing basis for the new futex 
code, with a goal of merging it upstream. The userspace APIs might still 
change. These changes should not affect existing futex users. (To make 
use of the new capabilities, additional glibc patches are needed.)

Changes since 2.6.14-rc2-rt1:

 - robust/PI mutexes/futexes (Todd Kneisel, David Singleton)

 - ktimer update (Thomas Gleixner)

 - change boot-time locking in the IDE layer, to make mode-setting safer

 - mkiss.c build fix (reported by Felix Oxley)

to build a 2.6.14-rc3-rt2 tree, the following patches should be applied:

  http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.13.tar.bz2
  http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.14-rc3.bz2
  http://redhat.com/~mingo/realtime-preempt/patch-2.6.14-rc3-rt2

	Ingo
