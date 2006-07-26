Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030292AbWGZVlX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030292AbWGZVlX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 17:41:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030306AbWGZVlX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 17:41:23 -0400
Received: from mga05.intel.com ([192.55.52.89]:60445 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S1030292AbWGZVlW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 17:41:22 -0400
X-IronPort-AV: i="4.07,185,1151910000"; 
   d="scan'208"; a="105286178:sNHT140783202"
Date: Wed, 26 Jul 2006 14:15:31 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>, Dave Jones <davej@redhat.com>,
       Ingo Molnar <mingo@elte.hu>, Chuck Ebbert <76306.1226@compuserve.com>,
       Ashok Raj <ashok.raj@intel.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] Reorganize the cpufreq cpu hotplug locking to not be totally bizare
Message-ID: <20060726141531.A22927@unix-os.sc.intel.com>
References: <200607242023_MC3-1-C5FE-CADB@compuserve.com> <Pine.LNX.4.64.0607241752290.29649@g5.osdl.org> <20060725185449.GA8074@elte.hu> <1153855844.8932.56.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0607251355080.29649@g5.osdl.org> <1153921207.3381.21.camel@laptopd505.fenrus.org> <20060726155114.GA28945@redhat.com> <Pine.LNX.4.64.0607261007530.29649@g5.osdl.org> <1153942954.3381.50.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0607261319160.4168@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.64.0607261319160.4168@g5.osdl.org>; from torvalds@osdl.org on Wed, Jul 26, 2006 at 01:22:24PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2006 at 01:22:24PM -0700, Linus Torvalds wrote:
> 
> Of course, that's why people want recursive locks in the first place, and 
> it's also why we've (largely successfully) have avoided them - it allows 
> for people being way too lazy about locking, and allows for really broken 
> schenarios like this.
> 
> I wonder if we could just make the workqueue code just run with preemption 
> disabled - that should also automatically protect against any CPU hotplug 

Its probably ok for this case.

before introducing the ugly recursion we did try the preempt_disable()
for cpufreq, and it worked for most all governers with preempt_disable(), 
but powernowk8 called set_cpus_allowed() in the callback path that 
threw out a scheduling while in atomic BUG().

http://lkml.org/lkml/2005/10/31/239


> events on the local CPU (and I think "local CPU" is all that the wq code 
> cares about, no?)
> 
> 		Linus

-- 
Cheers,
Ashok Raj
- Open Source Technology Center
