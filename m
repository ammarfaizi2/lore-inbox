Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265636AbUAGVDN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 16:03:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265639AbUAGVDM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 16:03:12 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:16652 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S265636AbUAGVDJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 16:03:09 -0500
Date: Wed, 7 Jan 2004 22:02:55 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, netdev@oss.sgi.com,
       linux-net@vger.kernel.org
Subject: Re: Problem with 2.4.24 e1000 and keepalived
Message-ID: <20040107210255.GA545@alpha.home.local>
References: <20040107200556.0d553c40.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040107200556.0d553c40.skraw@ithnet.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephan,

On Wed, Jan 07, 2004 at 08:05:56PM +0100, Stephan von Krawczynski wrote:
> Setup is a simple pair of routers with 2 nics each, all e1000. If you start a
> vrrp setup with keepalived and interface state is down during keepalived
> startup, then the failover does not work. If the nics are UP during startup
> everything works well. Now the kernel part of the story: the exact same setup
> works with tulip cards.
> Is there a difference regarding UP/DOWN state handling/events in e1000 and
> tulip. e100 and eepro100 show the same problem btw.

I noticed the exact same problem about 1 year ago with the early 2.4
bonding code and eepro100. At this time, I attributed this to a yet
undiscovered but in the bonding state machine, and could not investigate
much since it was on a remote production machine. Someone went there and
rebooted it and everything went OK. Before the reboot, the switch alredy
detected an UP link, while the bonding code saw it down (using MII at this
time, not ethtool). I recently read one report (here or on keepalived list)
about someone who got the same problem with another eepro100. I wonder
whether there would not be a bug either in the driver or in the chip itself.

What I noticed is that if you load the driver while the cable is unplugged,
and then plug it, the MII status says the link is still down. Unfortunately,
the only e100 I have access to are in prod at a customer's and I really
cannot make tests there.

Cheers,
Willy

