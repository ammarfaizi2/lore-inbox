Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030374AbWEKRHE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030374AbWEKRHE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 13:07:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030375AbWEKRHD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 13:07:03 -0400
Received: from smtp.osdl.org ([65.172.181.4]:54162 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030374AbWEKRHC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 13:07:02 -0400
Date: Thu, 11 May 2006 10:02:15 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ashok Raj <ashok.raj@intel.com>
Cc: shaohua.li@intel.com, linux-kernel@vger.kernel.org, zwane@linuxpower.ca,
       vatsa@in.ibm.com, ashok.raj@intel.com
Subject: Re: [PATCH 0/10] bulk cpu removal support
Message-Id: <20060511100215.588e89aa.akpm@osdl.org>
In-Reply-To: <20060511095308.A15483@unix-os.sc.intel.com>
References: <1147067137.2760.77.camel@sli10-desk.sh.intel.com>
	<20060510230606.076271b2.akpm@osdl.org>
	<20060511095308.A15483@unix-os.sc.intel.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ashok Raj <ashok.raj@intel.com> wrote:
>
> On Wed, May 10, 2006 at 11:06:06PM -0700, Andrew Morton wrote:
> Hi Andrew,
> 
> > Shaohua Li <shaohua.li@intel.com> wrote:
> > >
> > > CPU hotremove will migrate tasks and redirect interrupts off dead cpu.
> > 
> > This seems an awful lot of code for something which happens so infrequently.
> > 
> > How big is the problem you're fixing here, and what are the
> > user-observeable effects of these changes?
> 
> This is useful when say a NUMA node is being removed. With new multi-core
> CPUs comming up, considering a 2 core with HT, we could have up to 4 logical
> per socket. On NUMA node with 4 sockets, a node removal will mean we 
> do 16 single cpu offlines. Each time the process and interrupts could
> end up on a CPU that might be removed just immediatly.
> 
> The same is also useful for SMP Suspend/resume cases since the logical offline
> is same here as well.
> 
> Even thought the code changes seem a lot, most of it is just preparation of
> functions ready to accept a cpumask_t instead of a single cpu like earlier.
> The reason we split them to smaller chunks so the scope of change is well
> understood with each patch.
> 
> The major changes are
> 
>  - stop machine to run cpu offline functions on each cpu going offline
>  - prepare offline functions in offline path to take cpumask_t
>  - Some task migrate dead lock removal consideration that we ran into
>     during stress test.
> 
> I know Shaohua ran tests for more than 20+ hrs with the patch, both on i386 
> and x86_64.
> 
> once we get some time deltas on a bigger machine it will help a lot. 
> Iam also trying to check with some OEM';s who have such large machines for
> some data.. keep posted.
> 

OK, thanks.  I'm a little surprised that this patch wasn't accompanied by a
problem description, really.  I mean, if a single CPU offlining takes three
milliseconds then why bother?

I assume it must take much longer, else you wouldn't have written the code.
Have you any ballpark numbers for how long it _does_ take?

