Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752244AbWAEWna@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752244AbWAEWna (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 17:43:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752204AbWAEWna
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 17:43:30 -0500
Received: from fmr21.intel.com ([143.183.121.13]:704 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S1752150AbWAEWn3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 17:43:29 -0500
Date: Thu, 5 Jan 2006 14:42:10 -0800
From: Ashok Raj <ashok.raj@intel.com>
To: Tony Luck <tony.luck@intel.com>
Cc: Nathan Lynch <ntl@pobox.com>, linux-kernel@vger.kernel.org,
       Ben Collins <bcollins@debian.org>, Andrew Morton <akpm@osdl.org>,
       ashok.raj@intel.com
Subject: Re: [PATCH] fix workqueue oops during cpu offline
Message-ID: <20060105144210.A14956@unix-os.sc.intel.com>
References: <20060105045810.GE16729@localhost.localdomain> <12c511ca0601051345pee8d8wc735507d361fa65e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <12c511ca0601051345pee8d8wc735507d361fa65e@mail.gmail.com>; from tony.luck@intel.com on Thu, Jan 05, 2006 at 01:45:50PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2006 at 01:45:50PM -0800, Tony Luck wrote:
> On 1/4/06, Nathan Lynch <ntl@pobox.com> wrote:
> > This is where things go wrong -- any_online_cpu() now gets 1, not 0.
> > In queue_work, the cpu_workqueue_struct at per_cpu_ptr(wq->cpu_wq, 1) is
> > uninitialized.
> 
> Same issue on ia64 when I tried to add Ashok' s patch to allow
> removal of cpu0 (BSP in ia64-speak).  Ashok told me that this fix
> solves the problem for us too.
> 

Is this safe to use in NUMA path as well? Not that memory hot-remove is there
yet today, but if a NUMA node is being removed, i would assume the memory for 
that node goes with it. i.e assuming alloc_percpu() gets node local memory for 
each cpu.

So is it safe to continue to reference an area of an offline cpu that may not
exist?



-- 
Cheers,
Ashok Raj
- Open Source Technology Center
