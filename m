Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261821AbUDSUH2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 16:07:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261830AbUDSUH2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 16:07:28 -0400
Received: from 213-0-215-223.dialup.nuria.telefonica-data.net ([213.0.215.223]:57992
	"EHLO dardhal.mired.net") by vger.kernel.org with ESMTP
	id S261821AbUDSUH0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 16:07:26 -0400
Date: Mon, 19 Apr 2004 22:07:40 +0200
From: Jose Luis Domingo Lopez <linux-kernel@24x7linux.com>
To: John Pesce <pescej@sprl.db.erau.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to make Linux route multicast traffic bi-directionly between multible subnets
Message-ID: <20040419200739.GA3020@localhost>
Mail-Followup-To: John Pesce <pescej@sprl.db.erau.edu>,
	linux-kernel@vger.kernel.org
References: <1082389059.1982.15.camel@inferno>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1082389059.1982.15.camel@inferno>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 19 April 2004, at 11:37:39 -0400,
John Pesce wrote:

> The only thing I have been able to do is set a default multicast route
> to subnet A. This forwards traffic incoming from B and C to A, but what
> about the other ways?
> 
With that default route for multicast traffic the only thing you do is
route through some interface the multicast traffic for which there are
no more specific routes.

Multicast routing is in some ways different from unicast routing: with
multicast you must be able to send several copies on the original
incoming packet through one or more outgoing interfaces, namely those
that lead to hosts and networks somewhat "subscribed" to a multicast
group (the destination multicast IP in the IP packet).

As far as I know, there is no userspace tool (not saying that you can't
write one :) to insert multicast routes directly in the kernel routing
table (at least, I was not able to do anything with "ip").

> I see on bootup a kernel message about 0.96 PIM-SM. Can I somehow use
> that?
> 
The only way I know to make a Linux box route multicast traffic "as
expected" is to configure a multicast routing daemon like "mrouted". It
should listen on all interfaces declared as multicast, see IGMP packets
coming from hosts interested in some multicast groups (interested in
receiving traffic to some multicast IP addresses) and route incoming
multicast packets accordingly (sending several copies of the same packet
through all needed interfaces).

The message you see in the kernel boot log refers to one of the
protocols used for dynamic multicast routing, namely PIM-SM (Protocol
Independent Multicast, Sparse Mode). This protocol is implemented by
"mrouted", but seems to need some specific support from kernel space to
work properly (other dynamic multicast routing protocols implemented by
"mrouted" don't seem to show this requirment).

So, to summarize, your best bet is to get "mrouted" or something like
that, and have a look at the documentation bundled. You are quite right,
multicast routing documentation for Linux seems to be quite old, rather
short, and maybe out of date.

Greetings.

-- 
Jose Luis Domingo Lopez
Linux Registered User #189436     Debian Linux Sid (Linux 2.6.5)
