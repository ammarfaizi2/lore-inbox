Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261206AbUDSXIm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261206AbUDSXIm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 19:08:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261248AbUDSXIl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 19:08:41 -0400
Received: from ausmtp02.au.ibm.com ([202.81.18.187]:37037 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP id S261206AbUDSXIj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 19:08:39 -0400
Subject: Re: [lhcs-devel] Re: CPU Hotplug broken -mm5 onwards
From: Rusty Russell <rusty@rustcorp.com.au>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Srivatsa Vaddagiri <vatsa@in.ibm.com>, rusty@au1.ibm.com,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       LHCS list <lhcs-devel@lists.sourceforge.net>
In-Reply-To: <408458D5.5030208@yahoo.com.au>
References: <20040418170613.GA21769@in.ibm.com>
	 <408348B6.7020606@yahoo.com.au> <20040419125853.GB6835@in.ibm.com>
	 <408458D5.5030208@yahoo.com.au>
Content-Type: text/plain
Message-Id: <1082416075.5564.4.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 20 Apr 2004 09:07:57 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-04-20 at 08:55, Nick Piggin wrote:
> > So, as Rusty said, I think we really need to consider removing
> > lock_cpu_hotplug from sched_migrate_task. AFAICS that lock
> > was needed to prevent adding tasks to dead cpus. The same 
> > can be accomplished by removing lock_cpu_hotplug from sched_migrate_task
> > and adding a cpu_is_offline check in __migrate_task.
> > This will eliminate all the deadlocks I have been hitting.
> > 
> 
> Yes this would be a better idea. Care to send Andrew a patch
> against -mm?

What surprises me is that this is a regression.  The original hotplug
code on top of Nicksched(TM) removed that lock as part of the "don't
change cpus_allowed to migrate on exec" fix.  When we pushed the patch
straight into Linus' tree, we had to do lock_cpu_hotplug because we
didn't have that code.

Obviously, it escaped somewhere...

Cheers,
Rusty.
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

