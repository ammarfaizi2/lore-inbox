Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751357AbWBQCy1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751357AbWBQCy1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 21:54:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751359AbWBQCy1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 21:54:27 -0500
Received: from fmr22.intel.com ([143.183.121.14]:49625 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751357AbWBQCy0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 21:54:26 -0500
Date: Thu, 16 Feb 2006 18:54:03 -0800
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       npiggin@suse.de, Ingo Molnar <mingo@elte.hu>,
       Steven Rostedt <rostedt@goodmis.org>,
       Linus Torvalds <torvalds@osdl.org>, Con Kolivas <kernel@kolivas.org>
Subject: Re: [PATCH] Fix smpnice high priority task hopping problem
Message-ID: <20060216185403.B27025@unix-os.sc.intel.com>
References: <43F3C9C6.5080606@bigpond.net.au> <20060216171357.A27025@unix-os.sc.intel.com> <43F53553.50904@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <43F53553.50904@bigpond.net.au>; from pwil3058@bigpond.net.au on Fri, Feb 17, 2006 at 01:30:43PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2006 at 01:30:43PM +1100, Peter Williams wrote:
> On a normal system, would either of them be moved anyway?

Possible. Because when the migration thread runs it moves the current running
task out of the processor and the checks in can_migrate_task() like
"sd->nr_balance_failed > sd->cache_nice_tries" can result in cache hot task
move to the idle package.. This is a round about way and we should not depend
on this behavior..

> 
> > 
> > To fix my reported problem, we need to make sure that find_busiest_group()
> > doesn't find an imbalance..
> 
> I disagree.  If this causes a problem with your "optimizations" then I 
> think that you need to fix the "optimizations".
> 
> There's a rational argument (IMHO) that this patch should be applied 
> even in the absence of the smpnice patches as it prevents 
> active_load_balance() doing unnecessary work.  If this isn't good for 
> hypo threading then hypo threading is a special case and needs to handle 
> it as such.

active load balance is designed only with HT optimizations in mind. And now
multi-core optimizations also use this active load balance. No one else uses
active load balance.

thanks,
suresh
