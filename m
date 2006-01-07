Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751494AbWAGHLV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751494AbWAGHLV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 02:11:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751404AbWAGHLV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 02:11:21 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:23456
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751356AbWAGHLU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 02:11:20 -0500
Date: Fri, 06 Jan 2006 23:10:54 -0800 (PST)
Message-Id: <20060106.231054.43576567.davem@davemloft.net>
To: ak@suse.de
Cc: paulmck@us.ibm.com, dada1@cosmosbay.com, alan@lxorguk.ukuu.org.uk,
       torvalds@osdl.org, linux-kernel@vger.kernel.org, dipankar@in.ibm.com,
       manfred@colorfullife.com, netdev@vger.kernel.org
Subject: Re: [PATCH, RFC] RCU : OOM avoidance and lower latency
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <200601070209.02157.ak@suse.de>
References: <200601062157.42470.ak@suse.de>
	<20060106.161721.124249301.davem@davemloft.net>
	<200601070209.02157.ak@suse.de>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@suse.de>
Date: Sat, 7 Jan 2006 02:09:01 +0100

> I always disliked the per chain spinlocks even for other hash tables like
> TCP/UDP multiplex - it would be much nicer to use a much smaller separately 
> hashed lock table and save cache. In this case the special case of using
> a one entry only lock hash table makes sense.

I used to think they were a great technique.  But in each case I
thought they could be applied, better schemes have come along.
In the case of the page cache we went to a per-address-space tree,
and here in the routing cache we went to RCU.

There are RCU patches around for the TCP hashes and I'd like to
put those in at some point as well.  In fact, they'd be even
more far reaching since Arnaldo abstracted away the socket
hashing stuff into an inet_hashtables subsystem.
