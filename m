Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263597AbUC3LDN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 06:03:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263603AbUC3LDN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 06:03:13 -0500
Received: from fw.osdl.org ([65.172.181.6]:9352 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263597AbUC3LDL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 06:03:11 -0500
Date: Tue, 30 Mar 2004 03:02:42 -0800
From: Andrew Morton <akpm@osdl.org>
To: Erich Focht <efocht@hpce.nec.com>
Cc: nickpiggin@yahoo.com.au, mbligh@aracnet.com, mingo@elte.hu, ak@suse.de,
       jun.nakajima@intel.com, ricklind@us.ibm.com,
       linux-kernel@vger.kernel.org, kernel@kolivas.org, rusty@rustcorp.com.au,
       anton@samba.org, lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] [patch] sched-domain cleanups,
 sched-2.6.5-rc2-mm2-A3
Message-Id: <20040330030242.56221bcf.akpm@osdl.org>
In-Reply-To: <200403301204.14303.efocht@hpce.nec.com>
References: <7F740D512C7C1046AB53446D372001730111990F@scsmsx402.sc.intel.com>
	<200403300030.25734.efocht@hpce.nec.com>
	<4069384B.9070108@yahoo.com.au>
	<200403301204.14303.efocht@hpce.nec.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erich Focht <efocht@hpce.nec.com> wrote:
>
>  > And finally, HPC
>  > applications are the very ones that should be using CPU
>  > affinities because they are usually tuned quite tightly to the
>  > specific architecture.
> 
>  There are companies mainly selling NUMA machines for HPC (SGI?), so
>  this is not a niche market.

It is niche in terms of number of machines and in terms of affected users. 
And the people who provide these machines have the resources to patch the
scheduler if needs be.

Correct me if I'm wrong, but what we have here is a situation where if we
design the scheduler around the HPC requirement, it will work poorly in a
significant number of other applications.  And we don't see a way of fixing
this without either a /proc/i-am-doing-hpc, or a config option, or
requiring someone to carry an external patch, yes?

If so then all of those seem reasonable options to me.  We should optimise
the scheduler for the common case, and that ain't HPC.

If we agree that architecturally sched-domains _can_ satisfy the HPC
requirement then I think that's good enough for now.  I'd prefer that Ingo
and Nick not have to bust a gut trying to get optimum HPC performance
before the code is even merged up.

Do you agree that sched-domains is architected appropriately?
