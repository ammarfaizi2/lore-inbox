Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264472AbTLOXg5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 18:36:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264482AbTLOXg4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 18:36:56 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:38318
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S264472AbTLOXgz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 18:36:55 -0500
Date: Tue, 16 Dec 2003 00:37:46 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: wli@holomorphy.com, kernel@kolivas.org, chris@cvine.freeserve.co.uk,
       riel@redhat.com, linux-kernel@vger.kernel.org, mbligh@aracnet.com
Subject: Re: 2.6.0-test9 - poor swap performance on low end machines
Message-ID: <20031215233746.GO6730@dualathlon.random>
References: <200311031148.40242.kernel@kolivas.org> <200311032113.14462.chris@cvine.freeserve.co.uk> <200311041355.08731.kernel@kolivas.org> <20031208135225.GT19856@holomorphy.com> <20031208194930.GA8667@k3.hellgate.ch> <20031208204817.GA19856@holomorphy.com> <20031210215235.GC11193@dualathlon.random> <20031210220525.GA28912@k3.hellgate.ch> <20031210224445.GE11193@dualathlon.random> <20031215153122.1d915475.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031215153122.1d915475.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 15, 2003 at 03:31:22PM -0800, Andrew Morton wrote:
> Single-threaded qsbench is OK on 2.6.  Last time I looked it was a little
> quicker than 2.4.  It's when you go to multiple qsbench instances that
> everything goes to crap.
> 
> It's interesting to watch the `top' output during the run.  In 2.4 you see
> three qsbench instances have consumed 0.1 seconds CPU and the fourth has
> consumed 45 seconds and then exits.
> 
> In 2.6 all four processes consume CPU at the same rate.  Really, really
> slowly.

sounds good, so this seems only a fariness issue. 2.6 is more fair but
fariness in this case means much inferior performance.

The reason 2.4 runs faster could be a more aggressive "young" pagetable
heuristic via the swap_out clock algorithm. as soon as one program grows
a bit its rss, it will run for longer, and the longer it runs the more
pages it marks "young" during a clock scan, and the more pages it marks
young the bigger it will grow. This keeps going until it's the by far
biggest task and takes almost all available cpu. This is optimal for
performance, but not optimal for fariness. So 2.6 may be better or worse
depending if fariness payoffs or not, obviously in qsbench it doesn't
since it's not even measured.
