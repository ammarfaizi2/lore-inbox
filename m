Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263153AbUB0V3m (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 16:29:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263147AbUB0V3j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 16:29:39 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:21992
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263150AbUB0V2o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 16:28:44 -0500
Date: Fri, 27 Feb 2004 22:28:44 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.23aa2 (bugfixes and important VM improvements for the high end)
Message-ID: <20040227212844.GJ8834@dualathlon.random>
References: <20040227122936.4c1be1fd.akpm@osdl.org> <Pine.LNX.4.44.0402271544520.1747-100000@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0402271544520.1747-100000@chimarrao.boston.redhat.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 27, 2004 at 03:49:03PM -0500, Rik van Riel wrote:
> On Fri, 27 Feb 2004, Andrew Morton wrote:
> 
> > But first someone would need to demonstrate that pte_chains+4g/4g are
> > for some reason unacceptable for some real-world setup.
> 
> Agreed.  The current 2.6 VM is well tuned already so
> we should be extremely cautious not to upset it.

this is very easy:

	2.7*1024*1024*1024/4096*8*700/1024/1024 = 3780M

at ~700 tasks 4:4 will lockup with rmap.

with 3:1 and rmap the limit is down to around ~150 users.

that's nothing, way too low, normal regression test on 12G uses >1k
tasks.

regardless the 4:4 buzzword sounds a terribly wrong idea to me for the
99% of its proposed 64G usages (and with rmap 4:4 is needed even for a
8G box, not just for the 64G box, which sounds unacceptable)

my 2:2 proposal sounds to have a lot more potential technically than the
4:4. I know for sure if it was me owning that 64G hardware and running
that big software, I would first of all try 2:2 and 1.7G per process and
then compare with 4:4. I would like to get number comparisons for my 2:2
buzzword too but I failed so far (first time I asked was August 2003 and
it was for 2.4 where 2:2 is easy too). Some resource will have to be
allocated soon to test my 2:2 idea, if it turns out doing good as I
expect if compared to 4:4, I won't personally need to deal with the 4:4
2.0 design (yes 2.0 design), so I try to be optimistic for this too ;).
If I'm wrong, then we may be forced to allow a special 4:4 option to use
on the 64G boxes. I wanted to do page clustering but there are too many
other things to do first so it may be too late for 2.6 for the page
clustering (for mainline is pretty much obviously too late, I was
thinking at 2.6-aa here).
