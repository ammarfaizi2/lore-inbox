Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293201AbSCAPax>; Fri, 1 Mar 2002 10:30:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293101AbSCAPao>; Fri, 1 Mar 2002 10:30:44 -0500
Received: from pizda.ninka.net ([216.101.162.242]:63365 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S293086AbSCAPah>;
	Fri, 1 Mar 2002 10:30:37 -0500
Date: Fri, 01 Mar 2002 07:28:31 -0800 (PST)
Message-Id: <20020301.072831.120445660.davem@redhat.com>
To: linux-kernel@vger.kernel.org
CC: jgarzik@mandrakesoft.com, linux-net@vger.kernel.org
Subject: [BETA-0.93] Fourth test release of Tigon3 driver
From: "David S. Miller" <davem@redhat.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hey kiddies, uncle DaveM has a new release for ya:

ftp://ftp.kernel.org/pub/linux/kernel/people/davem/TIGON3/tg3-0.93.patch.gz

Changes in this release:

[FIX] Fix minimum MTU enforcement and streamline Jumbo handling
      (Jeff)
[FEATURE] Acenic gets VLAN hw acceleration support. (DaveM)
[FEATURE] 8139CP gets VLAN hw acceleration support. (Jeff)
[FEATURE] 8139CP gets MTU changing updates. (Jeff)
[FEATURE] 8139CP gets RX checksum offload. (Jeff)
[FIX] Do not program Tigon3 MTU if it is not up yet. (DaveM)
[API] VLAN hw acceleration interfaces enhanced:
	1) netdev->vlan_rx_register returns now a void, it cannot fail
	2) Add NETIF_F_HW_VLAN_FILTER and netdev->vlan_rx_add_vid
	   for RX VLAN vid filtering acceleration as discussed
           yesterday on this list.
	3) VLAN layer does destroy the VLAN group when the last VLAN
	   device in it is unregistered.  Implemented for hw
           acceleration by calling vlan_rx_register with NULL group
	   argument.
[CLEANUP] Lots of private vlan kruft moved from
          include/linux/if_vlan.h to net/8021q/vlan.h
	  Lots of totally unused stuff deleted.
[FIX] All the locking in the 8021q code has been audited, fixed, and
      cleaned up.
      Also fix refcounting, once VLAN device is made the reference to
      its' hardware device is leaked forever.  Good luck bringing
      down any interface that had VLANs attached :(  This bug has been
      in the VLAN code since it went into the tree.
[FEATURE] Use a small hash table for VLAN group lookups.
[FEATURE] Add Robert Olsson's packet generator for stress testing.
	  See Documentation/networking/pktgen.txt for how to use it.
	  Soon I will add Robert's enhancements for bundling, this
	  is just the older basic version.
[FIX] Kill work limit code, this could cause a situation that leaves
      the receive ring empty which deadlocks the Tigon3 and we never
      get any new RX interrupts so it remains empty forever.

      This is hoped to fix a hang condition reported by Lennert
      Buytenhek.  He was using Robert's packet generator which is
      one of the reasons I have integrated it :-)
[FIX] Tigon3 TX vlan tagging improperly implemented.  VLANs fully
      tested with Tigon3 and appear to work :-)

Bugs known to not be fixed in this release:

[BUG] 5703 revision chips do not work at all.

I will work on that soon, hopefully.

Please test it hard, and if you find some problem not listed in the
"not fixed yet" bug list do let us know about it.  Do not hesitate to
report "yeah it works, here is my setup" cases, I do log them and they
do help us know what kind of coverage the driver is getting and
exactly which chips have been tested.

Thanks.
