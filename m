Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262264AbUCGRdR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 12:33:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262282AbUCGRdQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 12:33:16 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:44548
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262264AbUCGRdL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 12:33:11 -0500
Date: Sun, 7 Mar 2004 18:33:52 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Ingo Molnar <mingo@elte.hu>, Peter Zaitsev <peter@mysql.com>,
       Andrew Morton <akpm@osdl.org>, riel@redhat.com, mbligh@aracnet.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.23aa2 (bugfixes and important VM improvements for the high end)
Message-ID: <20040307173352.GC4922@dualathlon.random>
References: <20040303193343.52226603.akpm@osdl.org> <1078371876.3403.810.camel@abyss.local> <20040305103308.GA5092@elte.hu> <20040305141504.GY4922@dualathlon.random> <20040305143210.GA11897@elte.hu> <20040305145837.GZ4922@dualathlon.random> <20040305152622.GA14375@elte.hu> <20040305155317.GC4922@dualathlon.random> <20040307084120.GB17629@elte.hu> <404AF991.9040709@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <404AF991.9040709@cyberone.com.au>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 07, 2004 at 09:29:37PM +1100, Nick Piggin wrote:
> 
> 
> Ingo Molnar wrote:
> 
> >* Andrea Arcangeli <andrea@suse.de> wrote:
> >
> >
> >>[...] but I'm quite confortable to say that up to 16G (included) 4:4
> >>is worthless unless you've to deal with the rmap waste IMHO. [...]
> >>
> >
> >i've seen workloads on 8G RAM systems that easily filled up the ~800 MB
> >lowmem zone. (it had to do with many files and having them as a big
> >dentry cache, so yes, it's unfixable unless you start putting inodes
> >into highmem which is crazy. And yes, performance broke down unless most
> >of the dentries/inodes were cached in lowmem.)
> >
> >
> 
> If you still have any of these workloads around, they would be

I also have workloads that would die with 4:4 and rmap.

the question is if they tested this in the stock 2.4 or 2.4-aa VM, or if
this was tested on kernels with rmap.

most kernels are also broken w.r.t. lowmem reservation, there are huge
vm design breakages in tons of 2.4 out there, those breakages would
generate lomwm shortages too, so just saying the 8G box runs out of
lowmem is meaningless unless we know exactly which kind of 2.4
incarnation was running on that box.

For istance google was running out of lowmem zone even on 2.5G boxes
until I fixed it, and the fix was merged in mainline only around 2.4.23,
so unless I'm sure all relevant fixes were applied the 8G runs out of
lowmem means nothing to me, since it was running out of lowmem for me
too for ages even on the 4G boxes until I've fixed all those issues in
the vm, not related to the pinned amount of memory.

alternatively if they can count the number of tasks, and the number of
files open, we  can do the math and count the mbytes of lowmem pinned,
that as well can demonstrate it was a limitation of the 3:1 and not a
design bug of the vm in-use on that box.
