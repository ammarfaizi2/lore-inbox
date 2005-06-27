Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261458AbVF0UZ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261458AbVF0UZ4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 16:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261680AbVF0UXj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 16:23:39 -0400
Received: from dsl093-119-032.blt1.dsl.speakeasy.net ([66.93.119.32]:24032
	"EHLO bushido.realityfailure.org") by vger.kernel.org with ESMTP
	id S261665AbVF0UVo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 16:21:44 -0400
Date: Mon, 27 Jun 2005 16:21:38 -0400 (EDT)
From: John Jasen <jjasen@realityfailure.org>
X-X-Sender: jjasen@bushido
To: linux-kernel@vger.kernel.org
Subject: bonding driver issues: slave interface not coming up
Message-ID: <Pine.LNX.4.63.0506271620160.12410@bushido>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (bushido.realityfailure.org [10.0.0.10]); Mon, 27 Jun 2005 16:21:40 -0400 (EDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello;

In short, using redhat enterprise 4, we're attempting to bond two tg3
gigabit cards in XOR mode.

These cards are plugged into a cisco 2970 switch, configured with
etherchannel bonding in src-dst-mac, which looks to be mode 2.

The problem area is, upon boot, the first slave NIC does not come up.
Furthermore, running ethtool against the slave yields the following message:

[root@XXX ~]# ethtool eth0
Settings for eth0:
Cannot get device settings: Resource temporarily unavailable
         Supports Wake-on: g
         Wake-on: d
         Current message level: 0x000000ff (255)
         Link detected: no

Now, curiously enough, after boot, logging in and bringing down the
bonding interface, then bringing it back up will activate both
interfaces. ie:

ifdown bond0
ifup bond0

ethtool eth0
[root@XXX ~]# ethtool eth0
Settings for eth0:
         Supported ports: [ MII ]
         Supported link modes:   10baseT/Half 10baseT/Full
                                 100baseT/Half 100baseT/Full
                                 1000baseT/Half 1000baseT/Full
         Supports auto-negotiation: Yes
         Advertised link modes:  Not reported
         Advertised auto-negotiation: No
         Speed: 1000Mb/s
         Duplex: Full
         Port: Twisted Pair
         PHYAD: 1
         Transceiver: internal
         Auto-negotiation: off
         Supports Wake-on: g
         Wake-on: d
         Current message level: 0x000000ff (255)
         Link detected: yes

Attempts at debugging that we've taken and their results:

duplex/speed forced on both switch and card: no effect
turning off spanning tree protocol: no effect
enabling fastport: no effect
switching from tg3 to bcm5700 drivers: no effect
attempting to down and up the interface in /etc/rc.d/init.d/network: no
effect
attempting a script that runs after network and irqbalance to do the
same thing: no effect
putting something in rc.local to do the same: works, our current ugly
workaround
breaking the bond, using the interfaces as two independent NICS: works
restarting the bond0 interface manually: works

This problem also manifests on more than one system, which would seem to
preclude possible cable, host, or port problems.

Any ideas, or any further information I can send you to help diagnose?
Any help would be much appreciated.

-- 
-- John E. Jasen (jjasen@realityfailure.org)
-- No one will sorrow for me when I die, because those who would
-- are dead already. -- Lan Mandragoran, The Wheel of Time, New Spring
