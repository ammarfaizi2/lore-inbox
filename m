Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263937AbUCZEHg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 23:07:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263942AbUCZEHg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 23:07:36 -0500
Received: from waste.org ([209.173.204.2]:7342 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S263937AbUCZEHd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 23:07:33 -0500
Date: Thu, 25 Mar 2004 22:07:10 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
Cc: davidm@hpl.hp.com, davidm@napali.hpl.hp.com, linux-kernel@vger.kernel.org
Subject: Re: Fw: potential /dev/urandom scalability improvement
Message-ID: <20040326040710.GF8366@waste.org>
References: <20040325141923.7080c6f0.akpm@osdl.org> <20040325224726.GB8366@waste.org> <16483.35656.864787.827149@napali.hpl.hp.com> <20040325180014.29e40b65.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040325180014.29e40b65.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2004 at 06:00:14PM -0800, Andrew Morton wrote:
> David Mosberger <davidm@napali.hpl.hp.com> wrote:
> >
> > The
> >  patch below is updated to go on top of your patch and gives about the
> >  same performance as I reported yesterday.  For now, I defined an
> >  inline prefetch_range().  If and when all architectures get updated to
> >  define this directly, we can simply remove prefetch_range() from the
> >  driver.
> 
> We may as well stick prefetch_range() in prefetch.h.
> 
> And Matt's patch series is not a thing I want to take on board at present,
> so let's stick with the straight scalability patch for now.

Sigh, I'll trim it back to some bits I think are critical.
 
> I moved the prefetch_range() call to outside the spinlock.  Does that make
> sense?

I don't think that's actually a win. If there's contention, threads
racing to the lock will grab the same cache lines and all but one
thread's cache will end up invalidated by the time the lock is
released.

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
