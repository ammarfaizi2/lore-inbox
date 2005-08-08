Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932357AbVHHXTL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932357AbVHHXTL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 19:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932356AbVHHXTL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 19:19:11 -0400
Received: from fmr22.intel.com ([143.183.121.14]:23449 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S932354AbVHHXTK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 19:19:10 -0400
Message-Id: <200508082318.j78NIlg21385@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Ingo Molnar'" <mingo@elte.hu>, "Nick Piggin" <nickpiggin@yahoo.com.au>
Cc: <linux-kernel@vger.kernel.org>, <linux-ia64@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>, "John Hawkes" <hawkes@sgi.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>, "Paul Jackson" <pj@sgi.com>
Subject: RE: [sched, patch] better wake-balancing, #3
Date: Mon, 8 Aug 2005 16:18:42 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
In-Reply-To: <20050730071917.GA31822@elte.hu>
Thread-Index: AcWU1viVMZHbIojDQZC0byG90xlZ8wHl+XRQ
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote on Saturday, July 30, 2005 12:19 AM
> * Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
> > > here's an updated patch. It handles one more detail: on SCHED_SMT we 
> > > should check the idleness of siblings too. Benchmark numbers still 
> > > look good.
> > 
> > Maybe. Ken hasn't measured the effect of wake balancing in 2.6.13, 
> > which is quite a lot different to that found in 2.6.12.
> > 
> > I don't really like having a hard cutoff like that -wake balancing can 
> > be important for IO workloads, though I haven't measured for a long 
> > time. [...]
> 
> well, i have measured it, and it was a win for just about everything 
> that is not idle, and even for an IPC (SysV semaphores) half-idle 
> workload i've measured a 3% gain. No performance loss in tbench either, 
> which is clearly the most sensitive to affine/passive balancing. But i'd 
> like to see what Ken's (and others') numbers are.
> 
> the hard cutoff also has the benefit that it allows us to potentially 
> make wakeup migration _more_ agressive in the future. So instead of 
> having to think about weakening it due to the tradeoffs present in e.g.  
> Ken's workload, we can actually make it stronger.


Sorry it took us a while to get the experiment done on our large db setup.
This patch has the same effectiveness compare to turning off both
SD_WAKE_BALANCE and SD_WAKE_AFFINE, (+2.2% on db OLTP workload).  We like
it a lot.

- Ken

