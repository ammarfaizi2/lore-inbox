Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129307AbRB0APx>; Mon, 26 Feb 2001 19:15:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129300AbRB0APk>; Mon, 26 Feb 2001 19:15:40 -0500
Received: from kanga.kvack.org ([216.129.200.3]:59409 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id <S129307AbRB0APP>;
	Mon, 26 Feb 2001 19:15:15 -0500
Date: Mon, 26 Feb 2001 19:11:20 -0500 (EST)
From: "Benjamin C.R. LaHaise" <blah@kvack.org>
To: "David S. Miller" <davem@redhat.com>
cc: michael@linuxmagic.com, Jan Rekorajski <baggins@sith.mimuw.edu.pl>,
        Chris Wedgwood <cw@f00f.org>, linux-kernel@vger.kernel.org,
        netdev@oss.sgi.com, waltje@uWalt.NL.Mugnet.ORG
Subject: Re: [UPDATE] zerocopy.. While working on ip.h stuff
In-Reply-To: <15002.61250.224811.987948@pizda.ninka.net>
Message-ID: <Pine.LNX.3.96.1010226190859.12521B-100000@kanga.kvack.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Feb 2001, David S. Miller wrote:

> At gigapacket rates, it becomes an issue.  This guy is talking about
> tinkering with new IP _options_, not just the header.  So even if the
> IP header itself fits totally in a cache line, the options afterwardsd
> likely will not and thus require another cache miss.

Hmmm, one way around this is to have the packet queue store things in
in a linear array of pointers to data areas, then process things in
bursts, ie:

	- find packet data areas for queued packets
	- walk list doing prefetches of ip header and options
	- then actually do the packet processing (save output for later)

That will require a number of new hooks for pipelining operations, though.
Just a thought.

		-ben

