Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965077AbVITS7u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965077AbVITS7u (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 14:59:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965079AbVITS7u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 14:59:50 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:11203 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S965077AbVITS7t
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 14:59:49 -0400
Subject: Re: [discuss] Re: [PATCH] x86-64: Fix bad assumption that dualcore
	cpus have synced TSCs
From: john stultz <johnstul@us.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       discuss@x86-64.org
In-Reply-To: <20050919194934.GC12810@verdi.suse.de>
References: <1127157404.3455.209.camel@cog.beaverton.ibm.com>
	 <20050919193105.GA12810@verdi.suse.de>
	 <1127158937.3455.214.camel@cog.beaverton.ibm.com>
	 <20050919194934.GC12810@verdi.suse.de>
Content-Type: text/plain
Date: Tue, 20 Sep 2005 11:59:45 -0700
Message-Id: <1127242785.11080.20.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-09-19 at 21:49 +0200, Andi Kleen wrote:
> On Mon, Sep 19, 2005 at 12:42:16PM -0700, john stultz wrote:
> > On Mon, 2005-09-19 at 21:31 +0200, Andi Kleen wrote:
> > > On Mon, Sep 19, 2005 at 12:16:43PM -0700, john stultz wrote:
> > > > 	This patch should resolve the issue seen in bugme bug #5105, where it
> > > > is assumed that dualcore x86_64 systems have synced TSCs. This is not
> > > > the case, and alternate timesources should be used instead.
> > > 
> > > 
> > > I asked AMD some time ago and they told me it was synchronized.
> > > The TSC on K8 is C state invariant, but not P state invariant,
> > > but P states always happen synchronized on dual cores.
> > > 
> > > So I'm not quite convinced of your explanation yet.
> > 
> > Would a litter userspace test checking the TSC synchronization maybe
> > shed additional light on the issue?
> 
> Sure you can try it.

So, bugzilla.kernel.org has (temporarily at least) lost the reports from
yesterday, but from the email i got, folks using my TSC consistency
check that I posted were seeing what appears to be unsynched TSCs on
dualcore AMD systems.

Personally I suspect that the powernow driver is putting the cores
independently into low power sleep and the TSCs are being independently
halted, causing them to become unsynchronized.

Do you still feel there is some other issue here? Any ideas for shaking
out whatever else might in play?

thanks
-john



