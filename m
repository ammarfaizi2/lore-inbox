Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262492AbUCCP7y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 10:59:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262502AbUCCP7y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 10:59:54 -0500
Received: from citrine.spiritone.com ([216.99.193.133]:5327 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S262492AbUCCP7w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 10:59:52 -0500
Date: Wed, 03 Mar 2004 07:54:39 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
cc: Hugh Dickins <hugh@veritas.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       Dave McCracken <dmccr@us.ibm.com>
Subject: Re: 230-objrmap fixes for 2.6.3-mjb2
Message-ID: <8030000.1078329278@[10.10.2.4]>
In-Reply-To: <20040303070933.GB4922@dualathlon.random>
References: <20040303070933.GB4922@dualathlon.random>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--Andrea Arcangeli <andrea@suse.de> wrote (on Wednesday, March 03, 2004 08:09:33 +0100):

> While merging 230-objrmap in my tree I spotted 2 bugs potentially
> generating random memory corruption and 1 superflous bit that I dropped
> (mostly for documentation reasons, I like strict and in turn self
> documenting). Here below the fixes.

Looks good to me, but Dave is more familiar with this stuff ... Dave?

> I'm running some shm swap regression test on this right now and I'll
> leave it running for a day. In a few hours I will proceed starting
> dropping the pte_chain from the page sturcture and then I'll test the
> anon swapout. I will also follow the 6 great-effort anobjrmap posted by
> Hugh against objrmap while doing that, they're quite old (almost 1 year)
> but they still apply cleanly by hand so they're useful.

Bill has been keeping that up to date  - he may have some more recent
changes somewhere?

> About 2.5:1.5 it seems not everybody is happy to lose 512m (and it's not
> Oracle), but before ruling it out I'd like to get some real life number,
> to be sure the performance of 2.0^W4:4 are really close (if not
> "better") than 3:1 as someone said. If we go with 4:4 IMHO at the very
> least the vgettimeofday backport from x86-64 is a must. In the meantime

John has that going - there's a copy in 2.6.3-mjb1, but it has a problem
at the moment on some boxes, which he's trying to fix up. I've been 
pushing for the same thing - fixing the most common syscall will help ;-)
We're trying to get some numbers here, but have had a small setback with
some disk problems - should be this week still though.

> I keep going with the rmap removal to fixup the fork  and to get back
> the 128m of normal zone useful on the 32G boxes. Could be also that new
> cpus are a lot better at reloading the tlbs from the pagetables dunno,
> the first numbers I recall about 4:4 predates to 2000 when PII was quite
> optimal.  I'd only like to see an opteron and a xeon dealing with 4:4.

Makes sense. But why would you want 4:4 on opteron? I'm not sure we care
about the perf for anyone nutty enough to run a 32 bit kernel there ;-)

M.
