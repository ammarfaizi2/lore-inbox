Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262700AbVDAKsH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262700AbVDAKsH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 05:48:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262699AbVDAKsH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 05:48:07 -0500
Received: from mx2.elte.hu ([157.181.151.9]:55996 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262700AbVDAKsD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 05:48:03 -0500
Date: Fri, 1 Apr 2005 12:47:24 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Steven Rostedt <rostedt@goodmis.org>
Subject: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.43-00
Message-ID: <20050401104724.GA31971@elte.hu>
References: <20050325145908.GA7146@elte.hu> <20050331085541.GA21306@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050331085541.GA21306@elte.hu>
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


i have released the -V0.7.43-00 Real-Time Preemption patch, which can be 
downloaded from the usual place:

  http://redhat.com/~mingo/realtime-preempt/

this release too is a step towards more robustness. I found a bug that
caused an infinite recursion and subsequent spontaneous reboot. The bug
was once again related to lock->debug locks, so i decided to get rid of
them altogether: from now on every lock in the -RT domain is debugged.

To be able to use code that relies on incompatible properties of stock
Linux semaphores (and rwsems), i've added a new compile-time
semaphore-type mechanism that enables the easy switching from RT
semaphores to stock semaphores. I've done this conversion for all
subsystems that needed it - e.g. XFS, firewire, USB and SCSI. XFS seems
to be working much better with this approach - BYMMV.

but an unavoidable side-effect is that the whole codebase got turned 
upside down once again, so be careful and expect a few rough edges.  In 
particular keep an eye on new compile-time warnings related to 
semaphores - code that gives a warning might build but it will almost 
certainly not work.

to create a -V0.7.43-00 tree from scratch, the patching order is:

  http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.11.tar.bz2
  http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.12-rc1.bz2
  http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.12-rc1-V0.7.43-00

	Ingo
