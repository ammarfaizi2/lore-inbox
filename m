Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265569AbUFDCnH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265569AbUFDCnH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 22:43:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265572AbUFDCnH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 22:43:07 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:46751 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S265569AbUFDCnD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 22:43:03 -0400
Date: Thu, 3 Jun 2004 19:47:55 -0700
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, ak@muc.de, ashok.raj@intel.com,
       hch@infradead.org, jbarnes@sgi.com, joe.korty@ccur.com,
       manfred@colorfullife.com, colpatch@us.ibm.com, mikpe@csd.uu.se,
       nickpiggin@yahoo.com.au, rusty@rustcorp.com.au, Simon.Derr@bull.net,
       wli@holomorphy.com, "David S. Miller" <davem@redhat.com>
Subject: Re: [PATCH] cpumask 5/10 rewrite cpumask.h - single bitmap based
 implementation
Message-Id: <20040603194755.667e584b.pj@sgi.com>
In-Reply-To: <20040603170725.4b3f8b34.akpm@osdl.org>
References: <20040603094339.03ddfd42.pj@sgi.com>
	<20040603101010.4b15734a.pj@sgi.com>
	<20040603170725.4b3f8b34.akpm@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew wrote:
> Paul Jackson <pj@sgi.com> wrote:
> >
> > 	Major rewrite of cpumask to use a single implementation,
> > 	as a struct-wrapped bitmap.
> >
> > ...
> >
> > +typedef struct { DECLARE_BITMAP(bits, NR_CPUS); } cpumask_t;
>
> We avoided doing this because in some situations the compiler will not pass
> such a cpumask_t in a register, ever.  An efficiency problem on sparc64,
> apparently.

When I contacted Dave Miller about this specific problem on March 26,
2004, he explained that this was more of a problem on sparc32, and that
since SMP on sparc32 wasn't in robust shape yet (my words), he seemed
(from what I could tell) not to be objecting too strongly.

I've added Dave to the Cc list, in case he wants to add or something, or
correct my efforts to represent his position.

At this point, if sparc (32 or 64) is a concern, I'd look into adding
arch-specific code for that case.  The overall cleanup of cpumasks
pleases me enough that I would seek to minimize the impact on the
generic case for specific arch's that require an alternative
implementation.

My current understanding is that such a special case is not required
for sparc, or any other arch.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
