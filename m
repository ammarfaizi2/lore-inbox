Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262831AbUC3Gj7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 01:39:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262932AbUC3Gj7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 01:39:59 -0500
Received: from mx1.elte.hu ([157.181.1.137]:22439 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262831AbUC3Gjw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 01:39:52 -0500
Date: Tue, 30 Mar 2004 08:40:15 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@suse.de>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, jun.nakajima@intel.com,
       ricklind@us.ibm.com, linux-kernel@vger.kernel.org, akpm@osdl.org,
       kernel@kolivas.org, rusty@rustcorp.com.au, anton@samba.org,
       lse-tech@lists.sourceforge.net, mbligh@aracnet.com
Subject: Re: [Lse-tech] [patch] sched-domain cleanups, sched-2.6.5-rc2-mm2-A3
Message-ID: <20040330064015.GA19036@elte.hu>
References: <20040325162121.5942df4f.ak@suse.de> <20040325193913.GA14024@elte.hu> <20040325203032.GA15663@elte.hu> <20040329084531.GB29458@wotan.suse.de> <4068066C.507@yahoo.com.au> <20040329080150.4b8fd8ef.ak@suse.de> <20040329114635.GA30093@elte.hu> <20040329221434.4602e062.ak@suse.de> <4068B692.9020307@yahoo.com.au> <20040330083450.368eafc6.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040330083450.368eafc6.ak@suse.de>
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


* Andi Kleen <ak@suse.de> wrote:

> > So both -mm5 and Ingo's sched.patch are much worse than
> > what 2.4 and 2.6 get?
> 
> Yes (2.6 vanilla and 2.4-aa at that, i haven't tested 2.4-vanilla)
> 
> Ingo's sched.patch makes it a bit better (from 1x CPU to 1.5-1.7xCPU),
> but still much worse than the max of 3.7x-4x CPU bandwidth.

Andi, could you please try the patch below - this will test whether this
has to do with the rate of balancing between NUMA nodes. The patch
itself is not correct (it way overbalances on NUMA), but it tests the
theory.

	Ingo

--- linux/include/linux/sched.h.orig
+++ linux/include/linux/sched.h
@@ -627,7 +627,7 @@ struct sched_domain {
 	.parent			= NULL,			\
 	.groups			= NULL,			\
 	.min_interval		= 8,			\
-	.max_interval		= 256*fls(num_online_cpus()),\
+	.max_interval		= 8,			\
 	.busy_factor		= 8,			\
 	.imbalance_pct		= 125,			\
 	.cache_hot_time		= (10*1000000),		\
