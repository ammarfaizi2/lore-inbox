Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264574AbUAGSus (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 13:50:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264604AbUAGSus
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 13:50:48 -0500
Received: from waste.org ([209.173.204.2]:47260 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S264574AbUAGSuq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 13:50:46 -0500
Date: Wed, 7 Jan 2004 12:50:40 -0600
From: Matt Mackall <mpm@selenic.com>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.1-rc1-tiny2
Message-ID: <20040107185039.GC18208@waste.org>
References: <20040106054859.GA18208@waste.org> <20040107140640.GC16720@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040107140640.GC16720@suse.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 07, 2004 at 03:06:40PM +0100, Jens Axboe wrote:
> On Mon, Jan 05 2004, Matt Mackall wrote:
> > This is the fourth release of the -tiny kernel tree. The aim of this
> > tree is to collect patches that reduce kernel disk and memory
> > footprint as well as tools for working on small systems. Target users
> > are things like embedded systems, small or legacy desktop folks, and
> > handhelds.
> > 
> > Latest release includes:
> >  - various compile fixes for last release
> >  - actually include Andi Kleen's bloat-o-meter this time
> >  - optional mempool removal
> 
> Your CONFIG_MEMPOOL is completely broken as you are no longer giving the
> same guarentees (you have no reserve at all). Might as well change it to
> CONFIG_DEADLOCK instead.

It's equivalent to a pool size of zero, yes, so deadlock odds are
significantly higher with some usage scenarios. I'll add a big fat
warning.

On the other hand, the existence of pre-allocated mempools can greatly
increase the likelihood of starvation, oom, and deadlock on the rest
of the system, especially as it becomes a greater percentage of the
total free memory on a small system. In other words, I had to cut this
corner to make running in 2M work with my config. When I merge
CONFIG_BLOCK, it'll be more generally useful.

For the sake of our other readers, I'll point out that mempool doesn't
intrinisically reduce deadlock odds to zero unless we have a hard
limit on requests in flight that's strictly less than pool size.

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
