Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751183AbWGGF07@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751183AbWGGF07 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 01:26:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751185AbWGGF07
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 01:26:59 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:47780 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751183AbWGGF06 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 01:26:58 -0400
Date: Thu, 6 Jul 2006 22:26:32 -0700
From: Paul Jackson <pj@sgi.com>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Cc: suresh.b.siddha@intel.com, vatsa@in.ibm.com, nickpiggin@yahoo.com.au,
       mingo@elte.hu, hawkes@sgi.com, dino@in.ibm.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: [PATCH 2.6.16-mm1 2/2] sched_domains: Allocate sched_groups
 dynamically
Message-Id: <20060706222632.2e403bd1.pj@sgi.com>
In-Reply-To: <20060706173607.F13512@unix-os.sc.intel.com>
References: <20060325082804.GB17011@in.ibm.com>
	<20060706170151.cdb1dc6c.pj@sgi.com>
	<20060706170824.E13512@unix-os.sc.intel.com>
	<20060706173417.e7d1e39e.pj@sgi.com>
	<20060706173607.F13512@unix-os.sc.intel.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suresh wrote:
> It is quite possible that the kernel you are testing doesn't have multi-core
> scheduler domain. If so, then you may not run into this issue.

Aha - we have a winner.

CONFIG_SCHED_MC was not enabled in this kernel.

Now what I see matches what it should.

    On a Hyper-Thread (but not Multi-Core) x86_64 system that I
    tested with CONFIG_SCHED_MC enabled, your patch was required to
    keep single-cpu cpu_exclusive cpusets from instantly locking
    up the system.

    On a Multi-Core (but not Hyper-Thread) IA64 Montecito system
    that did -not- have CONFIG_SCHED_MC enabled, there is no
    such problem with single-cpu cpu_exclusive cpusets in the
    first place.  It worked ok, even without the patch.

Thank-you.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
