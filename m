Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265405AbUFOLDX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265405AbUFOLDX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 07:03:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265407AbUFOLDX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 07:03:23 -0400
Received: from colin2.muc.de ([193.149.48.15]:9234 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S265405AbUFOLDW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 07:03:22 -0400
Date: 15 Jun 2004 13:03:20 +0200
Date: Tue, 15 Jun 2004 13:03:20 +0200
From: Andi Kleen <ak@muc.de>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: pj@sgi.com, linux-kernel@vger.kernel.org,
       lse-tech <lse-tech@lists.sourceforge.net>, Andi Kleen <ak@muc.de>,
       Anton Blanchard <anton@samba.org>
Subject: Re: NUMA API observations
Message-ID: <20040615110320.GD50463@colin2.muc.de>
References: <40CE824D.9020300@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40CE824D.9020300@colorfullife.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2004 at 06:59:57AM +0200, Manfred Spraul wrote:
> >
> >
> >>I will probably make it loop and double the buffer until EINVAL
> >>ends or it passes a page and add a nasty comment.
> >
> >I agree that a loop is needed.  And yes someone didn't do a very
> >good job of designing this interface.
> >
> > 
> >
> What about fixing the interface instead? For example if user_mask_ptr 
> NULL, then sys_sched_{get,set}affinity return the bitmap size.

Or maybe just a sysctl. But it doesn't really help because
applications have to work with older kernels. I think
cpumask_t is more an kernel internal implementation detail
and should not really be exposed to user space, so 
it's better not to do the sysctl neither.

However the clear bugs in the kernel API that should be fixed:
- It should EINVAL for bits set above cpumask_t 
- It should not EINVAL as long as the passed in mask
covers all online CPUs.

-Andi
