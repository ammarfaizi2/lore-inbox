Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317857AbSFSLvH>; Wed, 19 Jun 2002 07:51:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317858AbSFSLvG>; Wed, 19 Jun 2002 07:51:06 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:62984 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S317857AbSFSLvA>; Wed, 19 Jun 2002 07:51:00 -0400
Date: Wed, 19 Jun 2002 07:46:35 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Samuel Maftoul <maftoul@esrf.fr>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: NAPI for eepro100
In-Reply-To: <20020613091553.B3142@pcmaftoul.esrf.fr>
Message-ID: <Pine.LNX.3.96.1020619073646.1119F-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jun 2002, Samuel Maftoul wrote:

> Maybe a bit off topic, but we (at my work) are using plenty of eepro100
> cards with both drivers ( e100 and eepro100 )(shipped with dell
> machines, and others).
> We have lot of problem with these card: from link autonegociation to the
> really frequent cmd_timeout.
> We expreienced some freezes, slowdowns, problems with copying from NFS
> to a Firwire disk ( systematic cmd_timeout at about 250 MB).

Yes, this would be better in the cosl.networking, but a quick answer since
it seems kernel related. I had problems with these until recent kernels.
The e100 driver helped in some cases, but other issues were reported. I
don't really have any problems now, on news servers which get ~250GB/day
in and push ~700 out (yes, they run 70-80Mbit all day).

This may be related to the blessing of the new scheduler.
 
> Do you have any advice ? should I test eepro100 NAPI driver ? 
> I've try to play with ethtool(chang some eepro100 bits , like the
> "sleeping" one ...

We noticed long ago that different blades on the same switch would work
right with either auto at both ends or 100TX forced at both ends. Don;t
know why, just look at ifconfig reports for collisions and if you see them
change the settings.
 
> I have quitely the same card at home wich doesn't make any problem ( I
> noticed some cmd_timeout when I changed my hub).
> Is this hub related ? Is there a standart way autonegociation is working
> ( we use mostly cisco switches, are they compliant?).

You have said both "hub" and "switch" in this paragraph, trying to run
a hub full deplex will cause problems. I have no idea what a "switching
hub" means, I see them around cheap, but not from Cisco.

> We are actually trying to force 10FD or 100FD any new installed card
> because we think this is the best way to avoid performances problem ...

We have never found the slightest way to predect if auto or forced 100TX
works with any given blade in any given switch. But it doesn't change, so
get it right and it's fixed. See above, look for collisions, try auto
first. No collisions, it's as good as it gets.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

