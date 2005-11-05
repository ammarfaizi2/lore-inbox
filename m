Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932072AbVKEQHW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932072AbVKEQHW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 11:07:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932090AbVKEQHW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 11:07:22 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:45680
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S932072AbVKEQHW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 11:07:22 -0500
Date: Sat, 5 Nov 2005 17:07:20 +0100
From: Andrea Arcangeli <andrea@cpushare.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: disable tsc with seccomp
Message-ID: <20051105160720.GB14064@opteron.random>
References: <20051105134727.GF18861@opteron.random> <200511051637.44432.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511051637.44432.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 05, 2005 at 04:37:44PM +0100, Andi Kleen wrote:
> It was useless, you can get exactly the same information by using RDPMC 
> on perfctr 0 which always runs the NMI watchdog and counts all cycles too.

nmi watchdog is off in my system, but it was used to be very slow.
Anyway performance counters should be turned off too. They can be turned
off on a per task basis right? Just switching another cr4 bit or what?

The fact turning off the tsc is not enough to remove all timing info, is
sure not a good reason to remove that code IMHO, infact we should
disable more stuff if there are other ways to gather that information.

The fast path cost is constant and not measurable, no matter how much
stuff we disable in the slow path. So that's not a problem. We must
disable everything that can be disabled and that can provide potential
high precision timing info to userland.  For example we could also flip
the ptes to non-present over the hpet mapping. Zero-cost! The only
_fixed_ cost is the one we already had before you backed out the
feature. But note that hpet is a very very low prio compared to tsc, the
precision is not high enough for it to matter, but certainly I would
welcome a patch flipping the hpet ptes too. I only care about turning
off timings sources that allows to count cycles.
