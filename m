Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265125AbUF1SrR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265125AbUF1SrR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 14:47:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265128AbUF1SrR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 14:47:17 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:2315 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S265125AbUF1SrP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 14:47:15 -0400
Date: Mon, 28 Jun 2004 20:37:09 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Miquel van Smoorenburg <miquels@cistron.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: TCP-RST Vulnerability - Doubt
Message-ID: <20040628183709.GL29808@alpha.home.local>
References: <40DC9B00@webster.usu.edu> <20040625150532.1a6d6e60.davem@redhat.com> <cbp62t$a38$1@news.cistron.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cbp62t$a38$1@news.cistron.nl>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 28, 2004 at 01:22:37PM +0000, Miquel van Smoorenburg wrote:
> 
> MD5 protection on BGP sessions isn't very common yet.

The Cisco routers we deployed 3.5 years ago were already configured with MD5
enabled on BGP, this was on IOS 12.0 at this time. And I guess that Cisco
still has a good share amongst the BGP setups.

> MD5 uses CPU,
> and routers don't usually have much of that. Which means that now an
> MD5 CPU attack is possible instead of a TCP RST attack.

MD5 is not that much expensive. I even wonder if all those new routers
with VPN hardware acceleration, MD5 could not be computed in hardware
at nearly no cost.
 
> The "TTL hack" solution is safer. Make sure sender uses a TTL
> of 255, on the receiver discard all packets with a TTL < 255.
> You can use iptables to implement that on a Linux box.

This will not work in an eBGP multi-hop setup. However, you can often
still discard packets with a TTL < 252 or something like that, which
might imply a packet from outside the provider's area.

But the real problem is that the provider should do the anti-spoofing
himself and not accept BGP packets from the wrong NIC ! And it's relatively
easy to show them where they're bad.

Regards,
Willy

