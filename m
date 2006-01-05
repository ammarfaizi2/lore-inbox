Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750776AbWAEXQX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750776AbWAEXQX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 18:16:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750780AbWAEXQX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 18:16:23 -0500
Received: from thorn.pobox.com ([208.210.124.75]:59287 "EHLO thorn.pobox.com")
	by vger.kernel.org with ESMTP id S1750776AbWAEXQX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 18:16:23 -0500
Date: Thu, 5 Jan 2006 17:18:06 -0600
From: Nathan Lynch <ntl@pobox.com>
To: Ashok Raj <ashok.raj@intel.com>
Cc: Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
       Ben Collins <bcollins@debian.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] fix workqueue oops during cpu offline
Message-ID: <20060105231806.GF16729@localhost.localdomain>
References: <20060105045810.GE16729@localhost.localdomain> <12c511ca0601051345pee8d8wc735507d361fa65e@mail.gmail.com> <20060105144210.A14956@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060105144210.A14956@unix-os.sc.intel.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ashok Raj wrote:
> On Thu, Jan 05, 2006 at 01:45:50PM -0800, Tony Luck wrote:
> > On 1/4/06, Nathan Lynch <ntl@pobox.com> wrote:
> > > This is where things go wrong -- any_online_cpu() now gets 1, not 0.
> > > In queue_work, the cpu_workqueue_struct at per_cpu_ptr(wq->cpu_wq, 1) is
> > > uninitialized.
> > 
> > Same issue on ia64 when I tried to add Ashok' s patch to allow
> > removal of cpu0 (BSP in ia64-speak).  Ashok told me that this fix
> > solves the problem for us too.
> > 
> 
> Is this safe to use in NUMA path as well? Not that memory hot-remove is there
> yet today, but if a NUMA node is being removed, i would assume the memory for 
> that node goes with it. i.e assuming alloc_percpu() gets node local memory for 
> each cpu.

I guess I don't understand your concern here -- the workqueue patch
doesn't introduce any potential difficulty with memory or node removal
that alloc_percpu didn't already have.


> So is it safe to continue to reference an area of an offline cpu that may not
> exist?

Yes.
