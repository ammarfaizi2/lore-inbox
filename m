Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751269AbWIKIhh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751269AbWIKIhh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 04:37:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751270AbWIKIhg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 04:37:36 -0400
Received: from ns.suse.de ([195.135.220.2]:31106 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751269AbWIKIhg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 04:37:36 -0400
Date: Mon, 11 Sep 2006 10:37:34 +0200
From: Nick Piggin <npiggin@suse.de>
To: Christoph Lameter <clameter@sgi.com>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: [PATCH] Fix longstanding load balancing bug in the scheduler.
Message-ID: <20060911083734.GA25953@wotan.suse.de>
References: <Pine.LNX.4.64.0609061634240.13322@schroedinger.engr.sgi.com> <20060908103529.A9121@unix-os.sc.intel.com> <Pine.LNX.4.64.0609081135590.23089@schroedinger.engr.sgi.com> <20060908130028.A9446@unix-os.sc.intel.com> <Pine.LNX.4.64.0609081316580.24016@schroedinger.engr.sgi.com> <20060908170352.C9446@unix-os.sc.intel.com> <Pine.LNX.4.64.0609082222330.25269@schroedinger.engr.sgi.com> <Pine.LNX.4.64.0609091252070.26746@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0609091252070.26746@schroedinger.engr.sgi.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 09, 2006 at 12:56:16PM -0700, Christoph Lameter wrote:
> On Fri, 8 Sep 2006, Christoph Lameter wrote:
> 
> > > one or more, it is unnecessary for the common case.
> > 
> > The common case is an arch with much less cpus. The maxinum on i386
> > f.e. is 255 meaning 8 bytes. That fits in the cacheline that is already
> > used for the stack frame of the calling function. 
> 
> Ughh. Wrong. 255 cpus require 32 bytes. System rarely have that 
> much. If you configure a kernel with less than 32 cpus then this will be 
> one word on the stack.
> 
> Also note that the patch restricts the search to online cpus. The 
> scheduler will check offline cpus without this patch. That may actually 
> result in speed improvements since the cachelines from offline cpus are
> no longer brought in during the search for the busiest group / cpu.

This should not be the case. The sched-domain structure should always
reflect the online CPUs only (see our hotplug cpu handler), and if you
find otherwise then that would be a bug.

