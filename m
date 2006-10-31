Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161637AbWJaJZr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161637AbWJaJZr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 04:25:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161636AbWJaJZr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 04:25:47 -0500
Received: from tufnell.london.poggs.net ([193.109.197.25]:9141 "EHLO
	tufnell.london.poggs.net") by vger.kernel.org with ESMTP
	id S1161637AbWJaJZr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 04:25:47 -0500
Date: Tue, 31 Oct 2006 09:25:50 +0000
From: Peter Hicks <peter.hicks@poggs.co.uk>
To: linux-kernel@vger.kernel.org
Subject: Thousands of interfaces
Message-ID: <20061031092550.GA8201@tufnell.london.poggs.net>
Reply-To: Peter Hicks <peter.hicks@poggs.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,

I have a dual 3GHz Xeon machine with a 2.4.21 kernel and thousands (15k+) of
ipip tunnel interfaces.  These are being used to tunnel traffic from remote
routers, over a private network, and handed off to a third party.

Creating the interfaces takes longer and longer the more there are.  For the
first thousand or so interfaces, creation takes place at the rate of 40 per
second, later it drops to around 1 per second, then one every five seconds.

The tunnels are created thus:

  ip tunnel add $interface mode ipip remote $peer local $eth0_address
  ip addr add $eth0_address peer $lanip dev $interface
  ip link set $interface arp off up
  ip route add $remote_subnet dev $interface

where $interface is the name of the tunnel, $peer is the 'external'
interface on the remote router, $eth0_address is eth0's address on the
tunnel box, and $remote_subnet is the network we're tunneling.

Is it possible to speed up creation of the interfaces?  Currently it takes
around 24 hours.  Is there are more efficient way to handle a very large
number of IP-IP tunnels?  Would upgrading to a 2.6 kernel be of use?

Is there a userspace program which would handle this application better than
using interfaces?


Peter.
