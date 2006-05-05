Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751672AbWEEUax@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751672AbWEEUax (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 16:30:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751682AbWEEUax
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 16:30:53 -0400
Received: from hera.kernel.org ([140.211.167.34]:30941 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1751628AbWEEUaw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 16:30:52 -0400
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [PATCH 7/14] random: Remove SA_SAMPLE_RANDOM from network
 drivers
Date: Fri, 5 May 2006 13:30:22 -0700
Organization: OSDL
Message-ID: <20060505133022.1fea25c5@localhost.localdomain>
References: <8.420169009@selenic.com>
	<65CF7F44-0452-4E94-8FC1-03B024BCCAE7@mac.com>
	<20060505172424.GV15445@waste.org>
	<20060505191127.GA16076@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1146861022 28541 10.8.0.54 (5 May 2006 20:30:22 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Fri, 5 May 2006 20:30:22 +0000 (UTC)
X-Newsreader: Sylpheed-Claws 2.0.0 (GTK+ 2.8.6; i486-pc-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 May 2006 15:11:27 -0400
Theodore Tso <tytso@mit.edu> wrote:

> On Fri, May 05, 2006 at 12:24:26PM -0500, Matt Mackall wrote:
> > I haven't seen such an analysis, scholarly or otherwise and my bias
> > here is to lean towards the paranoid.
> > 
> > Assuming a machine with no TSC and an otherwise quiescent ethernet
> > (hackers burning the midnight oil), I think most of the
> > hard-to-analyze bits above get pretty transparent.
> 
> As always, whether or not the packet arrival times could be guessable
> and/or controlled by an attacker really depends on your threat model.
> For someone who has an ethernet monitor attached directly to the
> segment right next to your computer, it's very likely that they would
> be successful in guessing the inputs into the entropy pool.  However,
> an attacker with physical access to your machine could probably do all
> sorts of other things, such as install a keyboard sniffer, etc.  
> 
> For a remote attacker, life gets much more difficult.  Each switch,
> router, and bridge effectively has a queue into which packets must
> flow through, and that is _not_ known to a remote attacker.  This is
> especially true today, when most people don't even use repeaters, but
> rather switches/bridges, which effectly make each ethernet connection
> to each host its own separate collision domain (indeed that term
> doesn't even apply for modern high-speed ethernets).
> 
> I've always thought the right answer is that whether or not network
> packet arrival times should be used as entropy input should be
> configurable, since depending on the environment, it might or might
> not be safe, and for some hosts (particularly diskless servers), the
> network might be the only source of entropy available to them.
> 
> 						- Ted

An added problem is that many of the high speed interfaces have
interrupt mitigation. The chip will hold off the interrupt for a short
time to try and aggregate multiple packets. This has the effect
of synchronizing the interrupt, and reduces the entropy, especially
under load. NAPI also eliminates much of the entropy in network drivers.
So the quality of the entropy also depends on the chipset. Most of
the older, dumber hardware probably has better entropy but worse performance.
