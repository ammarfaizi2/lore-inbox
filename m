Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423012AbWJGABe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423012AbWJGABe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 20:01:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423015AbWJGABe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 20:01:34 -0400
Received: from smtp.osdl.org ([65.172.181.4]:57750 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1423012AbWJGABd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 20:01:33 -0400
Date: Fri, 6 Oct 2006 17:00:31 -0700
From: Bryce Harrington <bryce@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Pavel Machek <pavel@ucw.cz>, vatsa@in.ibm.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, shaohua.li@intel.com,
       hotplug_sig@osdl.org, lhcs-devel@lists.sourceforge.net
Subject: Re: Status on CPU hotplug issues
Message-ID: <20061007000031.GI22139@osdl.org>
References: <20060316174447.GA8184@in.ibm.com> <20060316170814.02fa55a1.akpm@osdl.org> <20060317084653.GA4515@in.ibm.com> <20060317010412.3243364c.akpm@osdl.org> <20061006231012.GH22139@osdl.org> <20061006162924.344090f8.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061006162924.344090f8.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2006 at 04:29:24PM -0700, Andrew Morton wrote:
> Can you describe the nature of the cpu-hotplug tests you're running?  I'd
> be fairly staggered if the kernel was able to survive a full-on cpu-hotplug
> stress test for more than one second, frankly.  There's a lot of code in
> there which is non-hotplug-aware.  Running a non-preemptible kernel would
> make things appear more stable, perhaps.

Certainly, the testsuite is one the OSDL Hotplug SIG put together last
summer, and consists of several test cases:

   http://developer.osdl.org/dev/HOTPLUG/planning/hotplug_cpu_test_plan_status.html

   hotplug01:  Check IRQ behavior during cpu hotplug events
   hotplug02:  Check process migration during cpu hotplug events
   hotplug03:  Verify tasks get scheduled on newly onlined cpu's
   hotplug04:  Verify disallowing offlining all CPU's
   hotplug05:  (Unimplemented)
   hotplug06:  Check userspace tools (sar, top) during cpu hotplug events 
   hotplug07:  Stress case doing kernel compile while cpu's are
               hotplugged on and off repeatedly

It can be downloaded here:
   http://developer.osdl.org/dev/hotplug/tests/

Results are posted here:
   http://crucible.osdl.org/runs/hotplug_report.html

We've been running this testsuite fairly continuously for several
months, and irregularly for about a year before that.  We find that on
some platforms like PPC64 it's quite robust, and on others there are
issues, but the developers tend to be quick to provide fixes as the
issues are found.  I'm glad to see that the results are finally showing
green for ia64.

> > Issues were found in four areas: General kernel, cpu hotplug, sysstat,
> > and the test harness itself.
> 
> It's surprising that AMD and Intel CPUs behave differently.  Also a good
> start on diagnosing things.

I was also surprised to see this too.  Note that the .config's for the
amd and em64t machines are considerably different (different drivers,
etc.), but the cpu config should be relatively comparable.  Still, I
wouldn't rule out the different behaviors being due to configuration
differences.  We could work on homogenizing the configs of the two
systems if that would help in troubleshooting?

Thanks,
Bryce

