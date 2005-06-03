Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261389AbVFCQqZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261389AbVFCQqZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 12:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261391AbVFCQqZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 12:46:25 -0400
Received: from ns2.suse.de ([195.135.220.15]:9172 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261389AbVFCQp4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 12:45:56 -0400
Date: Fri, 3 Jun 2005 18:45:51 +0200
From: Andi Kleen <ak@suse.de>
To: "Lynch, Rusty" <rusty.lynch@intel.com>
Cc: Andi Kleen <ak@suse.de>, akpm@osdl.org, linux-kernel@vger.kernel.org,
       Vara Prasad <prasadav@us.ibm.com>, Hien Nguyen <hien@us.ibm.com>,
       Prasanna S Panchamukhi <prasanna@in.ibm.com>,
       Jim Keniston <jkenisto@us.ibm.com>
Subject: Re: [patch] x86_64 specific function return probes
Message-ID: <20050603164551.GS23831@wotan.suse.de>
References: <032EB457B9DBC540BFB1B7B519C78B0E07499DE4@orsmsx404.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <032EB457B9DBC540BFB1B7B519C78B0E07499DE4@orsmsx404.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 03, 2005 at 09:40:26AM -0700, Lynch, Rusty wrote:
> From: Andi Kleen [mailto:ak@suse.de]
> >On Thu, Jun 02, 2005 at 01:58:50PM -0700, Rusty Lynch wrote:
> >> The following patch adds the x86_64 architecture specific
> implementation
> >
> >[....]
> >
> >Thanks for the long description.
> >
> >but...
> >
> >> +struct task_struct  *arch_get_kprobe_task(void *ptr)
> >> +{
> >> +	return ((struct thread_info *) (((unsigned long) ptr) &
> >> +					(~(THREAD_SIZE -1))))->task;
> >> +}
> >
> >and
> >
> >
> >> +	tsk = arch_get_kprobe_task(sara);
> >
> >
> >This is still wrong when the code is not executing on the process
> >stack, but on a interrupt/Exception stack. Any reason you cannot
> >just use current here?
> >
> >-Andi
> 
> Ah... you are talking about if someone registers a return probe on
> something like an interrupt handler, right? 

Yes.

> 
> I was under the impression that I could not always count on the current
> I get from interrupt context to map to the current seen by the target
> function (that triggers the breakpoint.)  It sounds like an invalid
> assumption lead to some extra complexity that isn't correct for all
> cases.


It is an invalid assumption, current works in all contexts. Except
if your GS is broken, but that should only happen when the kernel
is already very crashed.

-Andi
