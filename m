Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262654AbUCEPwm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 10:52:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262655AbUCEPwl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 10:52:41 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:33297
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262654AbUCEPwj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 10:52:39 -0500
Date: Fri, 5 Mar 2004 16:53:17 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Peter Zaitsev <peter@mysql.com>, Andrew Morton <akpm@osdl.org>,
       riel@redhat.com, mbligh@aracnet.com, linux-kernel@vger.kernel.org
Subject: Re: 2.4.23aa2 (bugfixes and important VM improvements for the high end)
Message-ID: <20040305155317.GC4922@dualathlon.random>
References: <Pine.LNX.4.44.0402280950500.1747-100000@chimarrao.boston.redhat.com> <20040229014357.GW8834@dualathlon.random> <1078370073.3403.759.camel@abyss.local> <20040303193343.52226603.akpm@osdl.org> <1078371876.3403.810.camel@abyss.local> <20040305103308.GA5092@elte.hu> <20040305141504.GY4922@dualathlon.random> <20040305143210.GA11897@elte.hu> <20040305145837.GZ4922@dualathlon.random> <20040305152622.GA14375@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040305152622.GA14375@elte.hu>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 05, 2004 at 04:26:22PM +0100, Ingo Molnar wrote:
> have you tried TPC-C/TPC-H?

not sure, I'm not the one dealing with the testing, but most relevant
data is public on the official websites. the limit reached is around 5k
users with 8cpus 32G and I don't recall that limit to be zone-normal
bound.  With 2.6 and bio and remap_file_pages we may reduce the
zone-normal usage as well (after dropping rmap).

But I definitely agree going past that with 3:1 is not feasible.

Overall we may argue about the 32G (especially a 32-way would be more
problematic due the 4 times higher per-cpu memory reservation in
zone-normal, I mean 48M of zone-normal are just wasted in the page
allocator per-cpu logic, without counting the other per-cpu stuff, all
would be easily fixable by limiting the per-cpu sizes, though for 2.4 it
probably doesn't worth it), but I'm quite confortable to say that up to
16G (included) 4:4 is worthless unless you've to deal with the rmap
waste IMHO. And <= 16G probably counts for 99% of machines out there
which are handled optimally by 3:1.
