Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262082AbVHCGcM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262082AbVHCGcM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 02:32:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262084AbVHCGcM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 02:32:12 -0400
Received: from mx1.redhat.com ([66.187.233.31]:14480 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262082AbVHCGcK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 02:32:10 -0400
Date: Wed, 3 Aug 2005 14:36:44 +0800
From: David Teigland <teigland@redhat.com>
To: Pekka Enberg <penberg@gmail.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-cluster@redhat.com,
       Pekka Enberg <penberg@cs.helsinki.fi>
Subject: Re: [PATCH 00/14] GFS
Message-ID: <20050803063644.GD9812@redhat.com>
References: <20050802071828.GA11217@redhat.com> <84144f0205080203163cab015c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84144f0205080203163cab015c@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02, 2005 at 01:16:53PM +0300, Pekka Enberg wrote:

> > +void *gmalloc_nofail_real(unsigned int size, int flags, char *file,
> > +			  unsigned int line)
> > +{
> > +	void *x;
> > +	for (;;) {
> > +		x = kmalloc(size, flags);
> > +		if (x)
> > +			return x;
> > +		if (time_after_eq(jiffies, gfs2_malloc_warning + 5 * HZ)) {
> > +			printk("GFS2: out of memory: %s, %u\n",
> > +			       __FILE__, __LINE__);
> > +			gfs2_malloc_warning = jiffies;
> > +		}
> > +		yield();
> 
> This does not belong in a filesystem. It also seems like a very bad
> idea. What are you trying to do here? If you absolutely must not fail,
> use __GFP_NOFAIL instead.

will do, carried over from before NOFAIL existed

> -mm has memory leak detection patches and there are others floating
> around. Please do not introduce yet another subsystem-specific debug
> allocator.

ok, thanks
Dave

