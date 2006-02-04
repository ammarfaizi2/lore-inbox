Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946240AbWBDBJP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946240AbWBDBJP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 20:09:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946236AbWBDBJP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 20:09:15 -0500
Received: from ns1.siteground.net ([207.218.208.2]:22480 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S1946240AbWBDBJO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 20:09:14 -0500
Date: Fri, 3 Feb 2006 17:08:57 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       manfred@colorfullife.com, shai@scalex86.org,
       alok.kataria@calsoftinc.com, sonny@burdell.org
Subject: Re: [patch 0/3] NUMA slab locking fixes
Message-ID: <20060204010857.GG3653@localhost.localdomain>
References: <20060203205341.GC3653@localhost.localdomain> <20060203140748.082c11ee.akpm@osdl.org> <Pine.LNX.4.62.0602031504460.2517@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0602031504460.2517@schroedinger.engr.sgi.com>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2006 at 03:06:16PM -0800, Christoph Lameter wrote:
> On Fri, 3 Feb 2006, Andrew Morton wrote:
> 
> > Could you please redo/retest these patches so that they apply on
> > 2.6.16-rc2.  Also, please arrange for any bugfixes to be staged ahead of
> > any optimisations - the optimisations we can defer until 2.6.17.
> 
> It seems that these two things are tightly connected. By changing the 
> locking he was able to address the hotplug breakage.

Yes,  they are.  The cachep->spinlock goes away at many places due to the 
colour_next patch and keeping the l3 around. (we should not have called that 
optimization I guess :)), and the irq disabling had to be moved to the 
l3 lock anyways.  Maybe I could have done away with patch 2 (merged it with 
patch3), but I thought keeping them seperate made it readable ....

Patchset against rc2 follows.

Thanks,
Kiran

PS: Many hotplug fixes are yet to be applied upstream I think.  I know
these slab patches work well with mm4 (with the x86_64 subtree and hotplug 
fixes in there) but I cannot really test cpu_up after cpu_down on rc2 
because it is broken as of now (pending merges, I guess).
