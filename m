Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129159AbRBPEQX>; Thu, 15 Feb 2001 23:16:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129107AbRBPEQO>; Thu, 15 Feb 2001 23:16:14 -0500
Received: from tomts8.bellnexxia.net ([209.226.175.52]:12711 "EHLO
	tomts8-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S129104AbRBPEQK>; Thu, 15 Feb 2001 23:16:10 -0500
Message-ID: <3A8CA97F.EB514999@sympatico.ca>
Date: Thu, 15 Feb 2001 23:15:59 -0500
From: Chris Friesen <chris_friesen@sympatico.ca>
X-Mailer: Mozilla 4.74 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
Newsgroups: comp.os.linux.networking
To: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: calling all gurus!  odd and subtle network problem
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to get some ideas on what the heck caused a problem with the network
at work, and I was hoping someone might have some ideas.

Yesterday we were having some major network problems, many machines were
completely bogged down.  This morning I came in to work to find my linux box
unplugged from the network and a note saying to call the network engineering
dept.

We have a large pool of IP addresses set aside for assignment by DHCP to support
laptops and whatnot.  Apparently the network problems were caused by a
particular MAC address being associated with essentially the entire pool of
DHCP-assigned addresses, so the DHCP client boxes were all trying to negotiate
for an address and kept getting error messages and trying again.  This
apparently caused enough traffic that it bogged down the rest of the network.

The kicker is that the NIC with the MAC address in question happened to be in my
G4 box running linux (yellowdog, 2.2.17 kernel).  It was a D-Link 530TX NIC, if
it matters.  The linux box was not configured as a DHCP server or client, and
both interfaces on the box were configured with static IP addresses.  The
motherboard interface was eth0 and was set to an address on the corporate LAN. 
The other NIC was eth1 and was set to an address in the 192.168 range for
testing.  The machine has been up and running in this configuration since
september of last year with no known issues.  I made no changes at the time the
problems started.

My understanding of the evidence is that 1) in the routers my MAC address was
associated with hundreds if not thousands of IP addresses.  2) it was sending
out packets to all boxes configured via DHCP that there was an IP address
conflict and that it in fact owned that IP address (not sure exactly what packet
this would be, but I saw a printout of an error message from a DHCP-configured
printer). 3) when they pulled my machine off the LAN, the problem stopped.  4)
today we pulled the NIC with the MAC address in question and hooked the box back
up using only eth0, and everything seems to be working fine.

On my box, the linux kernel had no knowledge of the IP addresses, "ifconfig" and
"ip addr" both showed just the two addresses assigned to it (I checked it during
the problems for work related reasons).  /etc/hosts has about 9 entries, all
ones that I've put in.

Does anyone have any ideas as to what was going on?  My only theory is that
something is screwy with the card or the drivers, but I have no idea why it
would run fine for almost 6 months then suddenly start causing problems.

I eagerly await your opinions.

Chris
