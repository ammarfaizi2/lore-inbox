Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750791AbWJQTEh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750791AbWJQTEh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 15:04:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751421AbWJQTEh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 15:04:37 -0400
Received: from mga09.intel.com ([134.134.136.24]:9020 "EHLO mga09.intel.com")
	by vger.kernel.org with ESMTP id S1750791AbWJQTEg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 15:04:36 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,321,1157353200"; 
   d="scan'208"; a="146458412:sNHT20221747"
Date: Tue, 17 Oct 2006 11:43:06 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Paul Jackson <pj@sgi.com>
Cc: Dinakar Guniguntala <dino@in.ibm.com>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Paul Menage <menage@google.com>, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org, Martin Bligh <mbligh@google.com>,
       Rohit Seth <rohitseth@google.com>, dipankar@in.ibm.com
Subject: Re: [RFC] Cpuset: explicit dynamic sched domain control flags
Message-ID: <20061017114306.A19690@unix-os.sc.intel.com>
References: <20061016230351.19049.29855.sendpatchset@jackhammer.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20061016230351.19049.29855.sendpatchset@jackhammer.engr.sgi.com>; from pj@sgi.com on Mon, Oct 16, 2006 at 04:03:51PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2006 at 04:03:51PM -0700, Paul Jackson wrote:
> From: Paul Jackson <pj@sgi.com>
> 
> I should get agreement from the other folks who care about the
> interaction of cpusets and sched domains before submitting this
> to Andrew for staging in *-mm.

Your post actually reminds me that sched domain setup for exclusive
cpusets are broken in the presence of cpu hotplug. That perhaps
is a different context and will kick a different thread with interested
parties.

> In particular, I remain unsure of myself around the sched domain
> code, and could use some feedback from someone with more of a
> clue on whether I broke something here.

I am not familiar with how job manager uses the cpusets but
the current meaning/usage of 'cpu_exclusive' seems logical to me.

Your current proposal seems to be wrong and broken.

What your patch does is to have overlapping cpusets, lets take for
example 2 cpusets and one cpuset with sched domain and another with
no sched domain.

All is fine(from cpu scheduler perspective) when the cpuset with
sched domain is active and the job in cpuset with no sched domain is
inactive. What happens when the job in the cpuset with no sched domain
becomes active? In this case, scheduler can't make use of all cpus
that this cpuset is allowed to use. This is because schedule domains in
the system are paritioned based on the cpusets which define sched domain.

cpus allowed for this cpuset(which doesnt define sched domain) may be spread
across multiple sched domain partitions and scheduling doesn't happen across
domain partitions.

thanks,
suresh
