Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262648AbUC2FBv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 00:01:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262652AbUC2FBv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 00:01:51 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:25612 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S262648AbUC2FBs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 00:01:48 -0500
Date: Mon, 29 Mar 2004 06:59:42 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Jad Saklawi <jad@saklawi.info>, linux-kernel@vger.kernel.org,
       hisham@hisham.cc, llug-users@greencedars.org
Subject: Re: Fwd: MAC / IP conflict
Message-ID: <20040329045942.GC1276@alpha.home.local>
References: <405D239B.30602@mail.portland.co.uk> <40679ED8.1060502@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40679ED8.1060502@tmr.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Mar 28, 2004 at 10:58:16PM -0500, Bill Davidsen wrote:
> Jad Saklawi wrote:
> >----- Forwarded message from Hisham Mardam Bey -----
> >   Date: Sun, 21 Mar 2004 13:52:59 +0200
> >
> >In short, I need to detect when someone on the network uses my MAC and
> >my IP address.
> >
> >Longer story follows. I am on a LAN which might have some potentially
> >dangerous users. Those users might spoof my MAC address and additionally
> >use my IP address, thus forcing my box to go offline, and not be able to
> >communicate with my gateway. What I need is a passive way to check for
> >something of the sort, and perhaps a notofication into syslog (the
> >latter is not very important).
> 
> Use arpwatch, it detects ALL changes of IP<=>MAC mapping.

It won't tell him when someone else uses both IP and MAC. The real solution
is to lock the MAC on the switch if possible. Another one is to use a second
host to launch regular ARP requests and count how many replies it gets. Note
that it is also possible to do this from his host, but he will need arping
and tcpdump in promiscuous mode, because the reply address will have to be
a fake one (MAC and IP) so that the switch forwards the reply on all ports.

Completely passive solution will not always detect the event. The attacker
might send packets to another host or even to the switch itself, which will
not propagate to other ports (eg: ethernet loopback with SA=DA= his MAC).
But if they make a mistake, then listening to all incoming packets and logging
their source MAC when it's the same as his host might work. This can be
implemented very easily with arptables but just for ARP requests. ebtables
might be better suited, but needs to configure a bridge which is dangerous.

Hmmm this reminds me good memories... :-)
Willy

