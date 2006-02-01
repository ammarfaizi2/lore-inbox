Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964820AbWBABsg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964820AbWBABsg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 20:48:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964824AbWBABsg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 20:48:36 -0500
Received: from fmr22.intel.com ([143.183.121.14]:31902 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S964820AbWBABsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 20:48:36 -0500
Date: Tue, 31 Jan 2006 17:48:20 -0800
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>, mingo@elte.hu,
       nickpiggin@yahoo.com.au, ak@suse.de, linux-kernel@vger.kernel.org,
       rohit.seth@intel.com, asit.k.mallick@intel.com
Subject: Re: [Patch] sched: new sched domain for representing multi-core
Message-ID: <20060131174820.A32626@unix-os.sc.intel.com>
References: <20060126015132.A8521@unix-os.sc.intel.com> <20060127000854.GA16332@elte.hu> <20060126195156.E19789@unix-os.sc.intel.com> <20060127160019.64caa6be.akpm@osdl.org> <20060130172809.A4851@unix-os.sc.intel.com> <20060131171216.449b9e06.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20060131171216.449b9e06.akpm@osdl.org>; from akpm@osdl.org on Tue, Jan 31, 2006 at 05:12:16PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2006 at 05:12:16PM -0800, Andrew Morton wrote:
> It's still not clear what's supposed to be happening here.
> 
> In build_sched_domains() we still have code which does:
> 
> 
> 	for_each_cpu_mask(...) {
> 		...
> #ifdef CONFIG_SCHED_MC
> 		...
> #endif
> #ifdef CONFIG_SCHED_SMT
> 		...
> #endif
> 		...
> 	}
> 	...
> #ifdef CONFIG_SCHED_SMT
> 	...
> #endif
> 	...
> #ifdef CONFIG_SCHED_MC
> 	...
> #endif
> 
> So in the first case the SCHED_SMT code will win and in the second case the
> SCHED_MC code will win.  I think.  

I am not sure what you mean here. At all the above pointed places, both 
MC and SMT will win if both are configured.

>  The code is so repetitive in there that
> `patch' may have put the hunks in the wrong place.

I will check your -mm tree.

> 
> What is the design intention here?  What do we _want_ to happen if both MC
> and SMT are enabled?

If both MC and SMT are enabled(and available on the system), then there will 
be two domain levels one for MC and another one for SMT.

> Also the path tests CONFIG_SCHED_MT in a few places where it meant to use
> CONFIG_SCHED_SMT, which rather casts doubt upon the testing quality.

:( Got introduced in my last version of the patch. Thanks for fixing it.

suresh
