Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266149AbUGOCPX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266149AbUGOCPX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 22:15:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266154AbUGOCPX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 22:15:23 -0400
Received: from mailgate2.mysql.com ([213.136.52.47]:14771 "EHLO
	mailgate.mysql.com") by vger.kernel.org with ESMTP id S266149AbUGOCPN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 22:15:13 -0400
Subject: Re: VM Problems in 2.6.7 (Too active OOM Killer)
From: Peter Zaitsev <peter@mysql.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Andrew Morton <akpm@osdl.org>, andrea@suse.de,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040715015431.GF3411@holomorphy.com>
References: <1089771823.15336.2461.camel@abyss.home>
	 <20040714031701.GT974@dualathlon.random>
	 <1089776640.15336.2557.camel@abyss.home>
	 <20040713211721.05781fb7.akpm@osdl.org>
	 <1089848823.15336.3895.camel@abyss.home>
	 <20040714154427.14234822.akpm@osdl.org>
	 <1089851451.15336.3962.camel@abyss.home>
	 <20040715015431.GF3411@holomorphy.com>
Content-Type: text/plain
Organization: MySQL
Message-Id: <1089857602.15336.4120.camel@abyss.home>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 14 Jul 2004 19:13:23 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-07-14 at 18:54, William Lee Irwin III wrote:

> The only method the kernel now has to relocate userspace memory is IO.
> When mlocked, or if anonymous when there's no swap, it's pinned.

OK. So it is practically technical difficulty rather than fundamental
reason ?   Why "move to other zone" way is not implemented ? It normally
should be cheaper than IO ?


> On Wed, Jul 14, 2004 at 05:30:52PM -0700, Peter Zaitsev wrote:
> > Aha I see. So user level memory allocations can't cause OOM only kernel
> > level allocations can ?   In this case why do not you have some reserved
> > amount of space for these types of allocations by default ? 
> 
> Userspace allocations can also trigger OOM, it's merely that in this
> case only allocations restricted to ZONE_NORMAL or below, e.g. kernel
> allocations, are affected. Your memory pressure is restricted to one zone.

Right. After being explained what without swap you have all pages pinned
it makes sense.  On other hand  why user Allocation will trigger OOM if
there are pages in other zone which still can be used ? Or are there any
restriction on this ?


> 
> In order to relocate a userspace page, the kernel performs IO to write
> the page to some backing store, then lazily faults it back in later. When
> the userspace page lacks a backing store, e.g. anonymous pages on
> swapless systems, Linux does not now understand how to relocate them.

Can't it just be just (theoretically) moved to other zone with
appropriate system tables modifications ? 

Well anyway it is good to hear "pinned anonymous" is only issue on
swapless systems.   Together with the fact what 2.6 VM does not seems to
swap without a good reason as 2.4 one did, I perhaps can just have swap
file enabled. 


-- 
Peter Zaitsev, Senior Support Engineer
MySQL AB, www.mysql.com



