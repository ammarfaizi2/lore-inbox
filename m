Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262165AbTFGGrV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 02:47:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262578AbTFGGrV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 02:47:21 -0400
Received: from pizda.ninka.net ([216.101.162.242]:10627 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262165AbTFGGrU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 02:47:20 -0400
Date: Fri, 06 Jun 2003 23:58:11 -0700 (PDT)
Message-Id: <20030606.235811.39162108.davem@redhat.com>
To: wa@almesberger.net
Cc: chas@cmf.nrl.navy.mil, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] use rtnl_{lock,unlock} during device operations
 (take 2)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030606212026.I3232@almesberger.net>
References: <20030606125416.C3232@almesberger.net>
	<200306062354.h56NsWsG002919@ginger.cmf.nrl.navy.mil>
	<20030606212026.I3232@almesberger.net>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Werner Almesberger <wa@almesberger.net>
   Date: Fri, 6 Jun 2003 21:20:26 -0300
   
   The only thing that worries me in all this is Dave's request to
   make device destruction asynchronous,

Not a request, they already are asynchronous today in 2.5.x

unregister_netdevice() rips the device out and returns, and
the problems we need to fix to make this work %100 are problems
that exist regardless of whether things operate asynchronously
or not.

For example, crap like this was always busted:

	rmmod eth0 </proc/sys/net/ipv4/conf/eth0/whatever

and now the asynchornous model forces us to fix this.

Werner, don't turn this into another one of those absolutely
rediculious discussions about module semantic threads you
guys all pile-drove into Rusty several months ago.  That stuff
stunk like pure shit and really unfairly drove Rusty up a wall.

It really showed how pointless linux-kernel discussion can
be and how much such rediculious discussions can totally impede
real progress because someone LOUD disagrees with someone's
game plan.
