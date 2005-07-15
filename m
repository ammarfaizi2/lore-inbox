Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263372AbVGOSOG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263372AbVGOSOG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 14:14:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263353AbVGOSLd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 14:11:33 -0400
Received: from fmr22.intel.com ([143.183.121.14]:10202 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S261997AbVGOSKM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 14:10:12 -0400
Date: Fri, 15 Jul 2005 11:09:21 -0700
From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
To: Andi Kleen <ak@suse.de>
Cc: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
       "Brown, Len" <len.brown@intel.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, vojtech@suse.cz,
       christoph@lameter.com
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
Message-ID: <20050715110920.B16008@unix-os.sc.intel.com>
References: <F7DC2337C7631D4386A2DF6E8FB22B300410F46A@hdsmsx401.amr.corp.intel.com.suse.lists.linux.kernel> <p73y8889f4v.fsf@bragg.suse.de> <20050715102349.A15791@unix-os.sc.intel.com> <20050715175700.GE15783@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050715175700.GE15783@wotan.suse.de>; from ak@suse.de on Fri, Jul 15, 2005 at 07:57:01PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2005 at 07:57:01PM +0200, Andi Kleen wrote:
> > I wouldn't say it is totally impossible. There are ways in which Linux can work
> > without a reliable Local APIC timer. One option being - make one CPU that gets 
> > the external timer interrupt multicast an IPI to all the other CPUs that
> > wants to get periodic timer interrupt.
> 
> That doesn't mix very well with variable ticks. And I believe
> we really need them.

It should work with variable ticks as we can easily add/remove CPUs from this
multicast destination.
  
> For no tick in idle you need a timer for each CPU that
> can be programmed to a reasonably long interval to wake you
> up after longer idleness. And all that
> should work without bouncing cache lines around all the time
> because that doesn't work on larger systems.

And each CPU timer itself does very little writes in terms of caches. The
two things that happen here are scheduler_tick and kstat_accounting. 
Or am I missing something? Did you have anything specific in mind wrt 
bouncing cachelines?

Thanks,
Venki


