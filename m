Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269473AbUI3UVB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269473AbUI3UVB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 16:21:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269470AbUI3UVB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 16:21:01 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:57762 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S269475AbUI3UUp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 16:20:45 -0400
Subject: Re: [RFC PATCH] sched_domains: Make SD_NODE_INIT per-arch
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: Andrew Morton <akpm@osdl.org>
Cc: nickpiggin@yahoo.com.au, LKML <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Andi Kleen <ak@suse.de>
In-Reply-To: <20040930122312.3f09ed73.akpm@osdl.org>
References: <1096420339.15060.139.camel@arrakis>
	 <415BC0BC.6040902@yahoo.com.au> <1096569412.20097.13.camel@arrakis>
	 <20040930122312.3f09ed73.akpm@osdl.org>
Content-Type: text/plain
Organization: IBM LTC
Message-Id: <1096575625.20097.25.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 30 Sep 2004 13:20:25 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-30 at 12:23, Andrew Morton wrote:
> Matthew Dobson <colpatch@us.ibm.com> wrote:
> >
> > I would like to try to get this in before then, unless this will really
> >  make things difficult for you.
> 
> It's about three weeks late for 2.6.9.  I already have a string of CPU
> scheduler patches awaiting the 2.6.10 stream and once we're at -rc2 we
> really should only be looking at bugfixes.

Yeah, that's entirely my fault for slacking on sending this out...  I
should have sent this a while ago.  It is a small portion of some larger
sched_domains changes that I am working on, but at some point I realized
my larger changeset will be far more controversial and have a much
larger impact than some of the smaller bits, as well as not being ready
for prime time yet.  Plus, like I said earlier, this allows
arch-specific tweaking with minimal intrusiveness from the application
of this patch forward.


> Grumble, mutter..  it looks like one of those "if it compiled, it works"
> things.  Problem is, any time anyone touches that particular piece of the
> kernel, half the architectures stop compiing.

It *should* be.  I'd be quite happy if you just picked it up in -mm to
assure it far wider testing.  I've compiled and booted it on x86, x86_64
& ppc64.  I've got no access to ia64 right now, or I'd test it there. 
But the patch *will* spit out #errors for any arch that doesn't have
SD_NODE_INIT defined if they also have NUMA defined.  I'm don't know of
anyone else (ie: *not* x86, x86_64, ppc64 & ia64) that is building NUMA
kernels, but if they are, it's a trivial patch to their
include/asm/topology.h to make the arch build.

Of course, the ultimate decision is yours, Andrew...

-Matt

