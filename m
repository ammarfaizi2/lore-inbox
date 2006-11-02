Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752255AbWKBTFP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752255AbWKBTFP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 14:05:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752258AbWKBTFO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 14:05:14 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:10163 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1752256AbWKBTFN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 14:05:13 -0500
Date: Fri, 3 Nov 2006 00:34:50 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Dave Jones <davej@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Gautham Shenoy <ego@in.ibm.com>
Subject: Re: Remove hotplug cpu crap from cpufreq.
Message-ID: <20061102190450.GB23489@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20061101225925.GA17363@redhat.com> <Pine.LNX.4.64.0611011507480.25218@g5.osdl.org> <20061101161723.f132d208.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061101161723.f132d208.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

On Wed, Nov 01, 2006 at 04:17:23PM -0800, Andrew Morton wrote:
> On Wed, 1 Nov 2006 15:09:52 -0800 (PST)
> Linus Torvalds <torvalds@osdl.org> wrote:
> 
> Gautham's work is "add lots of complex machinery so cpufreq's existing crap
> works as it was supposed to".  We end up with complex machinery as well as
> crappy cpufreq.
> 
> The alternative is to rip all that stuff out of cpufreq and then go back
> and reimplement cpufreq cpu-hotplug safety from scratch.

No matter what we do with cpufreq, cpufreq needs to protect itself against 
the cpu going away. I am not too confident about the long term viability of the
implicit callback order-based locking. Sooner or later, someone
will add another complex per-cpu subsystem with calls to another
per-cpu subsystem and will violate locking order between the two
subsystems.

IMO, the right thing to do would be to convert lock_cpu_hotplug() to
a get_cpu_hotplug()/put_cpu_hotplug() type semantics and use a more
scalable implementation underneath (as opposed to a global
semaphore/mutex).

We have had some discussion on taking a look at the overall design
of the cpufreq and its cpu drivers themselves, but we need
solve this issue in the short term.

Thanks
Dipankar
