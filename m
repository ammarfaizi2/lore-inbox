Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262128AbVDFHLQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262128AbVDFHLQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 03:11:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262129AbVDFHLQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 03:11:16 -0400
Received: from fmr21.intel.com ([143.183.121.13]:50622 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S262128AbVDFHKv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 03:10:51 -0400
Date: Wed, 6 Apr 2005 00:10:41 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Subject: Re: [patch 1/5] sched: remove degenerate domains
Message-ID: <20050406001041.A24403@unix-os.sc.intel.com>
References: <425322E0.9070307@yahoo.com.au> <20050406054412.GA5853@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050406054412.GA5853@elte.hu>; from mingo@elte.hu on Wed, Apr 06, 2005 at 07:44:12AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 06, 2005 at 07:44:12AM +0200, Ingo Molnar wrote:
> 
> * Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
> > This is Suresh's patch with some modifications.
> 
> > Remove degenerate scheduler domains during the sched-domain init.
> 
> actually, i'd suggest to not do this patch. The point of booting with a 
> CONFIG_NUMA kernel on a non-NUMA box is mostly for testing, and the 

Not really. All of the x86_64 kernels are NUMA enabled and most Intel x86_64
systems today are non NUMA.

> 'degenerate' toplevel domain exposed conceptual bugs in the 
> sched-domains code. In that sense removing such 'unnecessary' domains 
> inhibits debuggability to a certain degree. If we had this patch earlier 
> we'd not have experienced the wrong decisions taken by the scheduler, 
> only on the much rarer 'really NUMA' boxes.
> 
> is there any case where we'd want to simplify the domain tree? One more 
> domain level is just one (and very minor) aspect of CONFIG_NUMA - i'd 
> not want to run a CONFIG_NUMA kernel on a non-NUMA box, even if the 
> domain tree got optimized. Hm?
> 

Ingo, pardon me! Actually I used NUMA domain as an excuse to push domain
degenerate patch.... As I mentioned earlier, we should remove SMT domain
on a non-HT capable system.

Similarly I am working on adding a new core domain for dual-core systems!
All these domains are unnecessary and cause performance isssues on
non Multi-threading/Multi-core capable cpus! Agreed that performance 
impact will be minor but still...

thanks,
suresh
