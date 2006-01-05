Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752123AbWAEJUt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752123AbWAEJUt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 04:20:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752127AbWAEJUt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 04:20:49 -0500
Received: from 213-140-2-68.ip.fastwebnet.it ([213.140.2.68]:39337 "EHLO
	aa001msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1752123AbWAEJUs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 04:20:48 -0500
Date: Thu, 5 Jan 2006 10:20:54 +0100
From: JohnnyRun <gianni79@gamebox.net>
To: linux-kernel@vger.kernel.org
Subject: eth0 and loopback problems.
Message-ID: <20060105092052.GE3008@darkstar.mylan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all!
I think  it's a bug....

HOSTA# ifconfig eth0 192.168.0.1
HOSTA# ifconfig eth0 down
HOSTA# ping 192.168.0.1
(the ping works, like all other ICMP / TCP /UDP ... application. 
In other words: all work like eth0 in UP mode when source and
destination point comunicate via loopback device.
I think it's not correct because if eth0 is DOWN for all the hosts in
LAN should be down for me too. Or not?

Suppose another conf:

HOSTA# ifconfig
eth0      Link encap:Ethernet  HWaddr 00:10:DC:C3:5E:FF  
          inet addr:192.168.0.1  Bcast:192.168.0.255  Mask:255.0.0.0
	  BROADCAST MULTICAST  MTU:1500  Metric:1
eth1      Link encap:Ethernet  HWaddr 00:0E:35:74:16:67  
          inet addr:192.168.0.2 [...]
	  UP BROADCAST RUNNING MULTICAST  MTU:1500
lo  	 [...]

HOSTB# ifconfig eth0
eth0      Link encap:Ethernet  HWaddr 00:00:24:C8:4A:7D  
          inet addr:192.168.0.1  Bcast:1.255.255.255  Mask:255.0.0.0
	  UP BROADCAST RUNNING MULTICAST  MTU:1500
	  [...]

So, HOSTA and HOSTB share the same ip but: HOSTA eth0 is DOWN; HOSTA eth1 is
UP, HOSTB eth0 is UP. So, no conflict should be possible.
but:

HOSTB# ping 192.168.0.2
(does not reply)

So I suppose that HOSTA route the icmp reply through its lo.
But:

HOSTA# tcpdump -i lo
doesn't show any reply, and 

HOSTA# tcpdump -i eth0 
it's not permitted, because eth0 is DOWN.

The same result for TCP protocol (tested with hping).
Operative conditions: Linux 2.6.14, HOSTA eth1 is wifi.
Regards
JohnnyRun
