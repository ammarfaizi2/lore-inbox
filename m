Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262040AbUC3QD1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 11:03:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262750AbUC3QD1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 11:03:27 -0500
Received: from mx2.elte.hu ([157.181.151.9]:6629 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262040AbUC3QD0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 11:03:26 -0500
Date: Tue, 30 Mar 2004 18:03:36 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Erich Focht <efocht@hpce.nec.com>, nickpiggin@yahoo.com.au,
       mbligh@aracnet.com, jun.nakajima@intel.com, ricklind@us.ibm.com,
       akpm@osdl.org, kernel@kolivas.org, rusty@rustcorp.com.au,
       anton@samba.org, lse-tech@lists.sourceforge.net,
       Andi Kleen <ak@suse.de>
Subject: [patch] sched-2.6.5-rc3-mm1-A0
Message-ID: <20040330160336.GA2508@elte.hu>
References: <7F740D512C7C1046AB53446D372001730111990F@scsmsx402.sc.intel.com> <200403300030.25734.efocht@hpce.nec.com> <4069384B.9070108@yahoo.com.au> <200403301204.14303.efocht@hpce.nec.com> <20040330125805.4c62bf36.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040330125805.4c62bf36.ak@suse.de>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.26.8-itk2 (ELTE 1.1) SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the latest scheduler patch, against 2.6.5-rc3-mm1, can be found at:

	redhat.com/~mingo/scheduler-patches/sched-2.6.5-rc3-mm1-A0

this includes:

 - fork/clone-time balancing. It looks quite good here, but needs more
   testing for impact.

 - a minor fix for passive balancing. (calculating at a -1 load level
   was not perfectly precise with a runqueue length of ~4 or longer.)

 - use sync wakeups for parent-wakeup. This makes a single-task strace
   execute on only one CPU on SMP, which is precisely what we want. It
   should also be a speedup for a number of workloads where the parent
   is actively wait4()-ing for the child to exit.

	Ingo
