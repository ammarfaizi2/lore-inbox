Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750832AbVK3DiO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750832AbVK3DiO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 22:38:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750835AbVK3DiO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 22:38:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:25325 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750832AbVK3DiO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 22:38:14 -0500
Date: Wed, 30 Nov 2005 04:38:08 +0100
From: Andi Kleen <ak@suse.de>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Andi Kleen <ak@suse.de>, discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: Enabling RDPMC in user space by default
Message-ID: <20051130033808.GJ19515@wotan.suse.de>
References: <20051129151515.GG19515@wotan.suse.de> <Pine.LNX.4.61.0511291837050.17356@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0511291837050.17356@montezuma.fsmlabs.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Any comments on this? 
> 
> I think that this should be best left to a profiling tool to configure and 
> not a general kernel facility. I also have very little faith in processor 
> vendors not doing to performance counters what was done to the TSC.

The use case would be small code snippets to benchmark some code
or instructions. That normally can't be done with a external
tool and exec'ing something would be quite awkward. Also 
I would like to allow this for normal users.

The performance counters definitely share some properties with TSC already -
they definitely won't be synced (because they don't tick in C states etc.)
so if you change CPUs they won't be monotone.

But I doubt we'll ever see them running at a different frequency than
the current P state, which is the big problem RDTSC has now and that's
why I'm looking for a replacement. That it's faster on P4 is just
a bonus.

However it looks like everybody except me hates the idea :/ Or perhaps
a lot of the opposition was just against the reasonable position
that profiling should not disturb the NMI watchdogs. I guess not
everybody values debuggable kernel dumps.

-Andi

