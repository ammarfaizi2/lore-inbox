Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263107AbTIAASf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 20:18:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263112AbTIAASf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 20:18:35 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:17801 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S263107AbTIAASb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 20:18:31 -0400
Date: Mon, 1 Sep 2003 01:18:19 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Larry McVoy <lm@work.bitmover.com>, Larry McVoy <lm@bitmover.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Pascal Schmidt <der.eremit@email.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bandwidth for bkbits.net (good news)
Message-ID: <20030901001819.GC29239@mail.jlokier.co.uk>
References: <1062343891.10323.12.camel@dhcp23.swansea.linux.org.uk> <20030831154450.GV24409@dualathlon.random> <20030831162243.GC18767@work.bitmover.com> <20030831163350.GY24409@dualathlon.random> <20030831164802.GA12752@work.bitmover.com> <20030831170633.GA24409@dualathlon.random> <20030831211855.GB12752@work.bitmover.com> <20030831224938.GC24409@dualathlon.random> <20030831225639.GB16620@work.bitmover.com> <20030831231305.GE24409@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030831231305.GE24409@dualathlon.random>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> On Sun, Aug 31, 2003 at 03:56:39PM -0700, Larry McVoy wrote:
> > Yet you keep insisting it will work.  Why?  What is the theory that says
> > you can keep the other end of the T1 line from being congested when you
> > don't have control over that router?  And that router has several 100Mbit
> 
> it's absolutely trivial, your end only needs to drop 99% of your
> outgoing acks and their incoming packets for every connection but voip
> while you are at the phone, you won't kill the connections but everybody
> but your voip will work. the exponential backoff and sstrash on the
> other and will rate limit everything immediatly.

Let's work it out.  We assume 99% means drop virtually everything:

  Every 19 seconds on average, 24x7, a new HTTP connection.

  Rate is not uniform throughout the day.  Let's take a wild guess and
  say it is 10 times higher at peak times.

  That's one connection every 1.9 seconds.

  Let's assume you drop 99% of outgoing ACKs.

  Then all connecting remote clients will retry their SYNs until they
  get a connection or a timeout.  Default tcp_syn_retries (assuming Linux
  clients) is 5.

  That's one SYN every 0.38 seconds.   -> bad but not awful.

Plus existing connections.  Let's pretend each connection take 100 seconds.

  That's 100/1.9 or 52 concurrent connections, roughly.

  Each of those will retry with an ACK if it has any pending ACK or data.

  When you start using the phone, that's 100 ACKs total,
  approximately, with exponential backoff.    --> bad but not awful.

These calculations are horrendously inaccurate, but should be ok
within a couple of orders of magnitude.

So, near-total annihilation of bkbits.net when Larry or any of his
team are on the phone should work.  You can either integrate the phone
system with netfilter so it is automatic when a customer calls.
Trivial ;)  Or disable bkbits.net during Larry's working day. ;)

-- Jamie
