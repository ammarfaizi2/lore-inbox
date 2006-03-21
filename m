Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751778AbWCUVzq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751778AbWCUVzq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 16:55:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751782AbWCUVzq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 16:55:46 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:14014 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751778AbWCUVzp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 16:55:45 -0500
Date: Wed, 22 Mar 2006 08:55:20 +1100
From: Nathan Scott <nathans@sgi.com>
To: Pekka J Enberg <penberg@cs.Helsinki.FI>
Cc: linux-kernel@vger.kernel.org, xfs-masters@oss.sgi.com
Subject: Re: [xfs-masters] Re: [PATCH] xfs: kill kmem_zone init
Message-ID: <20060322085520.A664708@wobbly.melbourne.sgi.com>
References: <Pine.LNX.4.58.0603201501540.18684@sbz-30.cs.Helsinki.FI> <20060321082037.A653275@wobbly.melbourne.sgi.com> <Pine.LNX.4.58.0603210859450.14023@sbz-30.cs.Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.58.0603210859450.14023@sbz-30.cs.Helsinki.FI>; from penberg@cs.Helsinki.FI on Tue, Mar 21, 2006 at 09:05:14AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pekka,

On Tue, Mar 21, 2006 at 09:05:14AM +0200, Pekka J Enberg wrote:
> On Tue, 21 Mar 2006, Nathan Scott wrote:
> > Sorry, but thats just silly.  Did you even look at the code
> > around what you're changing (it has to do more than just wrap
> > up slab calls)?  So, NACK on this patch - it leaves the code
> > very confused (half zoney, half slaby), and is just unhelpful
> > code churn at the end of the day.
> 
> You're already using kmem_cache_destroy() mixed with the zone stuff so I 
> don't see your point.

Hmm, those ones have slipped through - I'll fix those up, thanks.
The vast majority of zone alloc/free uses are via the other style,
many variables are named according to those interfaces, etc, etc.

> I would really prefer to feed small bits at a time 
> so is there any way I can sweet-talk you into merging the patch?

Not without a very convincing argument, and "just kill wrappers
without even looking at the existing code" hasn't made me very
enthusiastic so far.

Regarding __GFP_NOFAIL, there are some situations where that could
be used now, and others where it should not be - it'd take a very
careful code audit and evidence of a level of low-memory-condition
testing done, etc, before such a change would be merged.  Note that
the -mm tree currently has a rework of the way incore extents are
managed within XFS, which significantly changes (in a good way) the
nature of the allocation requests we make (and hence I'm _really_,
_really_ not interested in cosmetic patches in this area just now).

cheers.

-- 
Nathan
