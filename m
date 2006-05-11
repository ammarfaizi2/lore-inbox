Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030342AbWEKQxm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030342AbWEKQxm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 12:53:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030355AbWEKQxm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 12:53:42 -0400
Received: from mga06.intel.com ([134.134.136.21]:48728 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S1030342AbWEKQxm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 12:53:42 -0400
TrustInternalSourcedMail: True
X-ExchangeTrusted: True
X-IronPort-AV: i="4.05,116,1146466800"; 
   d="scan'208"; a="34842530:sNHT140893977"
Date: Thu, 11 May 2006 09:53:09 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Shaohua Li <shaohua.li@intel.com>, linux-kernel@vger.kernel.org,
       zwane@linuxpower.ca, vatsa@in.ibm.com, ashok.raj@intel.com
Subject: Re: [PATCH 0/10] bulk cpu removal support
Message-ID: <20060511095308.A15483@unix-os.sc.intel.com>
References: <1147067137.2760.77.camel@sli10-desk.sh.intel.com> <20060510230606.076271b2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20060510230606.076271b2.akpm@osdl.org>; from akpm@osdl.org on Wed, May 10, 2006 at 11:06:06PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2006 at 11:06:06PM -0700, Andrew Morton wrote:
Hi Andrew,

> Shaohua Li <shaohua.li@intel.com> wrote:
> >
> > CPU hotremove will migrate tasks and redirect interrupts off dead cpu.
> 
> This seems an awful lot of code for something which happens so infrequently.
> 
> How big is the problem you're fixing here, and what are the
> user-observeable effects of these changes?

This is useful when say a NUMA node is being removed. With new multi-core
CPUs comming up, considering a 2 core with HT, we could have up to 4 logical
per socket. On NUMA node with 4 sockets, a node removal will mean we 
do 16 single cpu offlines. Each time the process and interrupts could
end up on a CPU that might be removed just immediatly.

The same is also useful for SMP Suspend/resume cases since the logical offline
is same here as well.

Even thought the code changes seem a lot, most of it is just preparation of
functions ready to accept a cpumask_t instead of a single cpu like earlier.
The reason we split them to smaller chunks so the scope of change is well
understood with each patch.

The major changes are

 - stop machine to run cpu offline functions on each cpu going offline
 - prepare offline functions in offline path to take cpumask_t
 - Some task migrate dead lock removal consideration that we ran into
    during stress test.

I know Shaohua ran tests for more than 20+ hrs with the patch, both on i386 
and x86_64.

once we get some time deltas on a bigger machine it will help a lot. 
Iam also trying to check with some OEM';s who have such large machines for
some data.. keep posted.

ashokr

-- 
Cheers,
Ashok Raj
- Open Source Technology Center
