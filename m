Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751146AbWGZVGw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751146AbWGZVGw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 17:06:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751154AbWGZVGw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 17:06:52 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:58501 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751146AbWGZVGv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 17:06:51 -0400
Date: Wed, 26 Jul 2006 13:58:10 -0700
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>, Dave Jones <davej@redhat.com>,
       Ingo Molnar <mingo@elte.hu>, Chuck Ebbert <76306.1226@compuserve.com>,
       Ashok Raj <ashok.raj@intel.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] Reorganize the cpufreq cpu hotplug locking to not be totally bizare
Message-ID: <20060726205810.GB23488@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <200607242023_MC3-1-C5FE-CADB@compuserve.com> <Pine.LNX.4.64.0607241752290.29649@g5.osdl.org> <20060725185449.GA8074@elte.hu> <1153855844.8932.56.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0607251355080.29649@g5.osdl.org> <1153921207.3381.21.camel@laptopd505.fenrus.org> <20060726155114.GA28945@redhat.com> <Pine.LNX.4.64.0607261007530.29649@g5.osdl.org> <1153942954.3381.50.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0607261319160.4168@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0607261319160.4168@g5.osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2006 at 01:22:24PM -0700, Linus Torvalds wrote:
> I wonder if we could just make the workqueue code just run with preemption 
> disabled - that should also automatically protect against any CPU hotplug 
> events on the local CPU (and I think "local CPU" is all that the wq code 
> cares about, no?)

__create_workqueue(), destroy_workqueue() and flush_workqueue() are all 
taking CPU hotplug lock currently. AFAICS they all can block and so
disabling preemption wont work. What am I missing?

-- 
Regards,
vatsa
