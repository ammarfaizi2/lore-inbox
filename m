Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130685AbQLNFO2>; Thu, 14 Dec 2000 00:14:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132289AbQLNFOR>; Thu, 14 Dec 2000 00:14:17 -0500
Received: from minotaur.onthe.net.au ([203.18.78.13]:47130 "EHLO
	minotaur.onthe.net.au") by vger.kernel.org with ESMTP
	id <S130685AbQLNFOG>; Thu, 14 Dec 2000 00:14:06 -0500
Date: Thu, 14 Dec 2000 15:43:35 +1100
From: Chris Dunlop <chris@onthe.net.au>
To: linux-kernel@vger.kernel.org
Subject: Source address selection
Message-ID: <20001214154335.A26969@minotaur.onthe.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In 2.2.x and/or 2.4.x, is there any way of preventing IP address[es]
attached to interface aliases being selected as a source address when
userland code creates a socket without binding to a particular address ?

>From Documentation/proc.txt:

  /proc/sys/net/ipv4/conf/hidden

  Hide addresses attached to this device from another devices.  Such
  addresses will never be selected by source address autoselection
  mechanism, host does not answer broadcast ARP requests for them, does
  not announce it as source address of ARP requests, but they are still
  reachable via IP. This flag is activated only if it is enabled both in
  specific device section and in "all" section.

The part about "Such addresses will never be selected by source address
autoselection" seems to be exactly what I want.   I'm not so sure
about the "does not answer broadcast ARP requests" part.  Does this mean
that an interface marked as 'hidden' can't accept incoming connections ?

However the proc entry applies per real interface and there doesn't seem
to be a way of applying it per alias interface.

The situation is...

I have a host ("gw") currently running 2.2.16, connected via a single
physical interface to a switch.  Also on the switch are several upstream
providers, and a bunch of other devices: hosts, access servers etc.  The
switch is VLANed so that there is no direct traffic between the
upstreams and the other devices, it's all routed by gw.  Gw is running
BGP (Zebra) to the upstreams.  To establish the BGP sessions, gw has
several interface aliases with IP addresses as assigned by the
upstreams.

With the interface aliases configured, "gw" is sending packets into our
network with source addresses of the interface aliases.  This causes
issues with firewalling etc., but also causes problems for protocols
that require forward and reverse name lookups to match (e.g. kerberos),
as we are not in control of these IPs.  I'd like to prevent the box from
using the IPs on the aliases as source addresses, except of course when
an application binds to that address.

Is there a way to do this ?

Or is there a better way of dealing with the problem ?


Cheers,

Chris.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
