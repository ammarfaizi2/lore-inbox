Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272607AbTHPE5O (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 00:57:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272608AbTHPE5O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 00:57:14 -0400
Received: from waste.org ([209.173.204.2]:32932 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S272607AbTHPE5N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 00:57:13 -0400
Date: Fri, 15 Aug 2003 23:57:11 -0500
From: Matt Mackall <mpm@selenic.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] Make cryptoapi non-optional?
Message-ID: <20030816045711.GD325@waste.org>
References: <20030809173329.GU31810@waste.org> <Mutt.LNX.4.44.0308102317470.7218-100000@excalibur.intercode.com.au> <20030810174528.GZ31810@waste.org> <20030813032038.GA1244@think> <20030813040614.GP31810@waste.org> <20030815221211.GA4306@think> <20030815235501.GB325@waste.org> <20030815170532.06e14e89.akpm@osdl.org> <20030816005806.GB21356@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030816005806.GB21356@mail.jlokier.co.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 16, 2003 at 01:58:07AM +0100, Jamie Lokier wrote:
> Andrew Morton wrote:
> > Matt Mackall <mpm@selenic.com> wrote:
> > > I'm pretty sure there was never a time when entropy
> > > accounting wasn't racy let alone wrong, SMP or no (fixed in -mm, thank
> > > you).
> > 
> > Well is has been argued that the lack of locking in the random driver is a
> > "feature", adding a little more unpredictability.
> 
> Dodgy.  Does lack of locking mean users can trick /dev/random into
> thinking it has more entropy than it does?  Or let them detect the
> time when /dev/random gains entropy, without reading it?

Yes to the first, detailed at great length in a separate message. You
can do timing attacks on the inputs either way. I'll repost my fix for
it eventually, it's low on the list.
 
> > Now I don't know if that makes sense or not, but the locking certainly has
> > a cost.  If it doesn't actually fix anything then that cost becomes a
> > waste.
> 
> Per-cpu random pools, perhaps :)

I really doubt contention here is significant, but will take about ten
lines to address if these locks ever show up on someone's Specweb
benchmark.

-- 
Matt Mackall : http://www.selenic.com : of or relating to the moon
