Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261186AbTHXPUz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Aug 2003 11:20:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261209AbTHXPUz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Aug 2003 11:20:55 -0400
Received: from web40505.mail.yahoo.com ([66.218.78.122]:63571 "HELO
	web40505.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261186AbTHXPUx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Aug 2003 11:20:53 -0400
Message-ID: <20030824152052.57555.qmail@web40505.mail.yahoo.com>
Date: Sun, 24 Aug 2003 08:20:52 -0700 (PDT)
From: Alex Davis <alex14641@yahoo.com>
Subject: Re: [RFC] patch for invalid packet time from ULOG target of iptables
To: Harald Welte <laforge@gnumonks.org>
Cc: linux-kernel@vger.kernel.org, ulogd@lists.gnumonks.org,
       Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>
In-Reply-To: <20030824150024.GF10987@sunbeam.de.gnumonks.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I understand. Thanks.

-Alex


--- Harald Welte <laforge@gnumonks.org> wrote:
> On Sun, Aug 24, 2003 at 07:16:00AM -0700, Alex Davis wrote:
> > I've just started playing with the ULOG target in
> > iptables, and I've noticed that the 'timestamp_sec'
> > member of the ulog_packet_msg_t struct paseed to
> > the user is always 0 for locally generated packets.
> 
> This is a well-known behaviour (see the list archives of
> netfilter-devel@lists.netfilter.org or ulogd@lists.gnumonks.org).
> 
> This is _NOT_ considered a bug, but a feature.
> 
> > I was thinking of patching the ipt_ulog_target
> > function in net/ipv4/netfilter/ipt_ULOG.c to
> > check if timestamp_sec is 0 and if so, set it
> > to the current time by adding code to test
> > 'timestamp_sec' after it's been set. E.g;
> 
> so how would you then differentiate in userspace between 
> 
> a) a skb receive timestamp
> b) a timestamp created within the ULOG target (which can be very
>    different, think of async packets via QUEUE, etc.)
> 
> We definitely don't want to have one field in the packet that has
> different semantics according from which hook it came in.
> 
> What ulogd currently does, is _always_ logging the userspace time,
> disregarding the skb receive timestamp.  This is way closer to the LOG
> target behaviuor anyway, since in this case the time is prepended by
> syslogd (which just calls gettimeofday() from userspace).
> 
> -- 
> - Harald Welte <laforge@gnumonks.org>               http://www.gnumonks.org/
> ============================================================================
> Programming is like sex: One mistake and you have to support it your lifetime
> 

> ATTACHMENT part 2 application/pgp-signature 


=====
I code, therefore I am

__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free, easy-to-use web site design software
http://sitebuilder.yahoo.com
