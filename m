Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261197AbVCaIz4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261197AbVCaIz4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 03:55:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261200AbVCaIz4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 03:55:56 -0500
Received: from mx1.elte.hu ([157.181.1.137]:26773 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261197AbVCaIzu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 03:55:50 -0500
Date: Thu, 31 Mar 2005 10:55:41 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>
Subject: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.41-25
Message-ID: <20050331085541.GA21306@elte.hu>
References: <20050325145908.GA7146@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050325145908.GA7146@elte.hu>
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


i have released the -V0.7.41-25 Real-Time Preemption patch, which can be 
downloaded from the usual place:

   http://redhat.com/~mingo/realtime-preempt/

this release tries to stabilize things some more. In particular i've 
changed 'nocheck' semaphores to not be included in any PI or debugging 
logic. This makes them pretty much stateless and compatible. XFS seems 
to be working much better with this approach, and maybe some of the 
other problematic subsystems (USB/firewire) will improve too.

there's also a latency tracer fix which should cure some of the 
'truncated traces' problems.

i've also included Trond Myklebust's NFS client patch which should 
reduce latencies in that area (on PREEMPT_DESKTOP/VOLUNTARY kernels - 
under PREEMPT_RT the whole NFS code was fully preemptable already).  
It's experimental so be careful if you are using NFS.

to create a -V0.7.41-25 tree from scratch, the patching order is:

  http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.11.tar.bz2
  http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.12-rc1.bz2
  http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.12-rc1-V0.7.41-25

	Ingo
