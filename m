Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965010AbWEJQP6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965010AbWEJQP6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 12:15:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965011AbWEJQP6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 12:15:58 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:2950 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S965010AbWEJQP6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 12:15:58 -0400
Date: Wed, 10 May 2006 09:16:04 -0700
From: Mike Kravetz <kravetz@us.ibm.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, Andrew Morton <akpm@osdl.org>,
       Dave Hansen <haveblue@us.ibm.com>, Andy Whitcroft <apw@shadowen.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] alloc_memory_early() routines
Message-ID: <20060510161604.GC3198@w-mikek2.ibm.com>
References: <20060509053512.GA20073@monkey.ibm.com> <20060508224952.0b43d0fd.akpm@osdl.org> <20060509210722.GD3168@w-mikek2.ibm.com> <84144f020605100009i74824233ie6feaf6fd2d9055f@mail.gmail.com> <Pine.LNX.4.64.0605100011090.3040@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0605100011090.3040@schroedinger.engr.sgi.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2006 at 12:11:59AM -0700, Christoph Lameter wrote:
> > I'd prefer you put this in mm/bootmem.c and added a
> > 
> > int slab_is_available(void)
> > {
> >       return g_cpucache_up == FULL;
> > }
> > 
> > to mm/slab.c instead.
> 
> Does slab not available mean that bootmem can be used? 

I like the 'slab_is_available()' check.  How about if we simply add
this routine and let the people doing the allocation determine what
allocator to use?

As has already been stated, slab not available does NOT imply that
bootmem can be used.  Heck, on POWER there is even an allocator used
before bootmem.  I doubt we could provide an 'intelligent' routine
to works in all cases.  So, for right now we could/should just provide
the slab not available() check.  There is only one piece of code in
SPARSEMEM that cares about this.

Sound reasonable?
-- 
Mike
