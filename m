Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262263AbUCLQLS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 11:11:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262257AbUCLQLR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 11:11:17 -0500
Received: from null.rsn.bth.se ([194.47.142.3]:22171 "EHLO null.rsn.bth.se")
	by vger.kernel.org with ESMTP id S262263AbUCLQLM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 11:11:12 -0500
Date: Fri, 12 Mar 2004 17:10:59 +0100 (CET)
From: Martin Josefsson <gandalf@wlug.westbo.se>
X-X-Sender: gandalf@tux.rsn.bth.se
To: Patrick McHardy <kaber@trash.net>
Cc: Ron Peterson <rpeterso@mtholyoke.edu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org,
       Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>
Subject: Re: network/performance problem
In-Reply-To: <40518CDC.7090805@trash.net>
Message-ID: <Pine.LNX.4.58.0403121706270.28810@tux.rsn.bth.se>
References: <20040311152728.GA11472@mtholyoke.edu> <20040311151559.72706624.akpm@osdl.org>
 <20040311233525.GA14065@mtholyoke.edu> <40518CDC.7090805@trash.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Mar 2004, Patrick McHardy wrote:

> >>c024c0d4 ip_conntrack_expect_related                  47   0.0368
> >>c0105250 default_idle                               2817  70.4250
> >>c024bae0 init_conntrack                             3053   3.7232
> >>00000000 total                                      5962   0.0041
> >>
> >>It appears that netfilter has gone berzerk and is taking your machine out.
> >>
> >>Are you really sure that nothing is sitting there injecting new rules all
> >>the time?
> >
> >
> > You mean a script calling 'iptables' to dynamically add rules?  Nothing
> > like that at all.  I dumped the current rules below.
> >
> > Are you looking at the init_conntrack numbers?  While they seem, in the
> > long run, to be getting larger, they're not increasing monotonically.
> > My ping latencies, and the CPU percentage consumed by ksoftirqd_CPU0
> > just go up and and up (albeit slowly).
> >
>
> The size-128 slab keeps growing over time, I suspect something is
> registering lots of expectations. init_conntrack has to walk the
> entire list for each new connection. Which helpers are you using ?
> Please also post the content of /proc/net/ip_conntrack and your
> config.

If you want to see the numbers of expectations registered per second you
can apply the ctstat patch from patch-o-matic and download the small
utility mentioned in the helpfile.

I can prepare a regular patch for you if it sounds interesting.
We can add a counter for the number of expectations in the linked-list as
well in order to debug this. (the ctstat patch only adds counters for
new/deleted expectations)

/Martin
