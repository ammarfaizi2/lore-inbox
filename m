Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262758AbUC2IqD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 03:46:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262768AbUC2IqD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 03:46:03 -0500
Received: from ns.suse.de ([195.135.220.2]:49362 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262758AbUC2IqA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 03:46:00 -0500
Date: Mon, 29 Mar 2004 10:45:31 +0200
From: Andi Kleen <ak@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andi Kleen <ak@suse.de>, jun.nakajima@intel.com, ricklind@us.ibm.com,
       piggin@cyberone.com.au, linux-kernel@vger.kernel.org, akpm@osdl.org,
       kernel@kolivas.org, rusty@rustcorp.com.au, anton@samba.org,
       lse-tech@lists.sourceforge.net, mbligh@aracnet.com
Subject: Re: [Lse-tech] [patch] sched-domain cleanups, sched-2.6.5-rc2-mm2-A3
Message-ID: <20040329084531.GB29458@wotan.suse.de>
References: <7F740D512C7C1046AB53446D372001730111990F@scsmsx402.sc.intel.com> <20040325154011.GB30175@wotan.suse.de> <20040325190944.GB12383@elte.hu> <20040325162121.5942df4f.ak@suse.de> <20040325193913.GA14024@elte.hu> <20040325203032.GA15663@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040325203032.GA15663@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2004 at 09:30:32PM +0100, Ingo Molnar wrote:
> 
> * Andi Kleen <ak@suse.de> wrote:
> 
> > That won't help for threaded programs that use clone(). OpenMP is such
> > a case.
> 
> this patch:
> 
>         redhat.com/~mingo/scheduler-patches/sched-2.6.5-rc2-mm3-A4
> 
> does balancing at wake_up_forked_process()-time.
> 
> but it's a hard issue. Especially after fork() we do have a fair amount
> of cache context, and migrating at this point can be bad for
> performance.

I ported it by hand to the -mm4 scheduler now and tested it. While
it works marginally better than the standard -mm scheduler 
(you get 1 1/2 the bandwidth of one CPU instead of one) it's still
still much worse than the optimum of nearly 4 CPUs archived by
2.4 or the standard scheduler.

-Andi
