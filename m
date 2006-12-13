Return-Path: <linux-kernel-owner+w=401wt.eu-S1751776AbWLNACH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751776AbWLNACH (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 19:02:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751780AbWLNACH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 19:02:07 -0500
Received: from mga06.intel.com ([134.134.136.21]:6122 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751776AbWLNACG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 19:02:06 -0500
X-Greylist: delayed 584 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 19:02:05 EST
X-ExtLoop1: 1
X-IronPort-AV: i="4.12,164,1165219200"; 
   d="scan'208"; a="174180876:sNHT13969586365"
Date: Wed, 13 Dec 2006 15:19:27 -0800
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>, nickpiggin@yahoo.com.au,
       vatsa@in.ibm.com, clameter@sgi.com, tglx@linutronix.de,
       arjan@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Patch: dynticks: idle load balancing
Message-ID: <20061213151926.C12795@unix-os.sc.intel.com>
References: <20061211155304.A31760@unix-os.sc.intel.com> <20061213224317.GA2986@elte.hu> <20061213231316.GA13849@elte.hu> <20061213150314.B12795@unix-os.sc.intel.com> <20061213233157.GA20470@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20061213233157.GA20470@elte.hu>; from mingo@elte.hu on Thu, Dec 14, 2006 at 12:31:57AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2006 at 12:31:57AM +0100, Ingo Molnar wrote:
> 
> * Siddha, Suresh B <suresh.b.siddha@intel.com> wrote:
> 
> > On Thu, Dec 14, 2006 at 12:13:16AM +0100, Ingo Molnar wrote:
> > > there's another bug as well: in schedule() resched_cpu() is called with 
> > > the current runqueue held in two places, which is deadlock potential. 
> > 
> > resched_cpu() was getting called after prepare_task_switch() which 
> > releases the current runqueue lock. Isn't it?
> 
> no, it doesnt release it. The finish stage is what releases it.

I see.

> the other problem is load_balance(): there this_rq is locked and you 
> call resched_cpu() unconditionally.

But here resched_cpu() was called after double_rq_unlock().

thanks,
suresh
