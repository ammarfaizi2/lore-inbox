Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261464AbUKHIOU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261464AbUKHIOU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 03:14:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261452AbUKHIOU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 03:14:20 -0500
Received: from mx1.elte.hu ([157.181.1.137]:1928 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261774AbUKHIOP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 03:14:15 -0500
Date: Mon, 8 Nov 2004 10:16:19 +0100
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark_H_Johnson@Raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>
Subject: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm3-V0.7.19
Message-ID: <20041108091619.GA9897@elte.hu>
References: <20041019180059.GA23113@elte.hu> <20041020094508.GA29080@elte.hu> <20041021132717.GA29153@elte.hu> <20041022133551.GA6954@elte.hu> <20041022155048.GA16240@elte.hu> <20041022175633.GA1864@elte.hu> <20041025104023.GA1960@elte.hu> <20041027001542.GA29295@elte.hu> <20041103105840.GA3992@elte.hu> <20041106155720.GA14950@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041106155720.GA14950@elte.hu>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


i have released the -V0.7.19 Real-Time Preemption patch, which can be
downloaded from the usual place:

   http://redhat.com/~mingo/realtime-preempt/

this release includes fixes only.

Changes since -V0.7.18:

 - fixed a merge bug introduced in -V0.7.18, breaking bit-spinlocks used
   by ext3's journalling code. This could/should fix the kjournald crash
   reported by Adam Heath, Gunther Persoons and Eran Mann. Bug triggered
   on !SMP kernels only.

 - added upstream patch to fix a crash in bttv/btcx_riscmem_free(), 
   reported by Shane Shrybman.

 - made modlist_lock raw again - this could fix the /proc/acpi related
   asserts reported by Karsten Wiese.

 - fixed -RT locking bug in zap_completion_queue(), this could fix the 
   asserts reported by Shane Shrybman and others.

to create a -V0.7.19 tree from scratch, the patching order is:

   http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.9.tar.bz2
   http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.10-rc1.bz2
   http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc1/2.6.10-rc1-mm3/2.6.10-rc1-mm3.bz2
   http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.10-rc1-mm3-V0.7.19

	Ingo
