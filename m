Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264054AbUFPP3u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264054AbUFPP3u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 11:29:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264058AbUFPP3t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 11:29:49 -0400
Received: from [213.146.154.40] ([213.146.154.40]:21659 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S264054AbUFPP3l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 11:29:41 -0400
Date: Wed, 16 Jun 2004 16:29:34 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Dimitri Sivanich <sivanich@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: Option to run cache reap in thread mode
Message-ID: <20040616152934.GA13527@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Dimitri Sivanich <sivanich@sgi.com>, Andrew Morton <akpm@osdl.org>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20040616142413.GA5588@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040616142413.GA5588@sgi.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2004 at 09:24:13AM -0500, Dimitri Sivanich wrote:
> Hi,
> 
> In the process of testing per/cpu interrupt response times and CPU availability,
> I've found that running cache_reap() as a timer as is done currently results
> in some fairly long CPU holdoffs.
> 
> I would like to know what others think about running cache_reap() as a low
> priority realtime kthread, at least on certain cpus that would be configured
> that way (probably configured at boottime initially).  I've been doing some
> testing running it this way on CPU's whose activity is mostly restricted to
> realtime work (requiring rapid response times).
> 
> Here's my first cut at an initial patch for this (there will be other changes
> later to set the configuration and to optimize locking in cache_reap()).

YAKT, sigh..  I don't quite understand what you mean with a "holdoff" so
maybe you could explain what problem you see?  You don't like cache_reap
beeing called from timer context?

As for realtime stuff you're probably better off using something like rtlinux,
getting into the hrt or even real strong soft rt busuniness means messing up
the kernel horrible.  Given you're @sgi.com address you probably know what
a freaking mess and maintaince nightmare IRIX has become because of that.

