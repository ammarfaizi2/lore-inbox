Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262052AbUCSJQ1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 04:16:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262058AbUCSJQ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 04:16:27 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:10760 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S262052AbUCSJQZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 04:16:25 -0500
Message-ID: <405ABA74.5030409@aitel.hist.no>
Date: Fri, 19 Mar 2004 10:16:36 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: no, en
MIME-Version: 1.0
To: RANDAZZO@ddc-web.com
CC: linux-kernel@vger.kernel.org
Subject: Re: 2 nics in the same machine...
References: <89760D3F308BD41183B000508BAFAC4104B17010@DDCNYNTD>
In-Reply-To: <89760D3F308BD41183B000508BAFAC4104B17010@DDCNYNTD>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

RANDAZZO@ddc-web.com wrote:
> I have connected two nics in the same machine with a null modem cable...
> 
> I have configured nic 1 to be 156.15.16.1 and nic 2 to be 156.15.16.2
> 
> I have adjusted the routes so that nic 1 routes to nic 2 and vice versa...
> 
> how come when I ping 156.15.16.1 it does not go out nic 2...
> 
> am I missing something?

Kernel sees that it have a ping packet destined for 156.15.16.1
Kernel notices it has several NICs available, so it chooses
the one closest to the destination.  NIC1 _is_ 156.15.16.1 so it
_is_ the destination.
Kernel figures that the packet is already here, and never sends it
out on the wire.

A crossed cable between two NICS in the same machine is
a testing setup, right?

If you want to test NICs (or cables & hubs) do this:

1. Run a packet sniffer on the "listening" NIC.  Run it in
   promiscuous mode so it'll even sniff packets not meant for it.

2. Set a default route to the "sending" NIC.  Or at least a route
   to some network that isn't on your machine.

3. Ping the remote network.  You will not get an answer, but:
   The packet will be sent through the "sending" NIC, 
   and sniffed by the "listening" NIC.  So you'll verify that
   NICs and cable works.  Optionally make a script that reverses
   the roles of the two NICs if you want to test both ways.

If, on the other hand, you're testing apps/protocols, don't worry that 
the traffic don't hit the wire.  A test utilizing internal loopback
is just as good.  If you really need traffic to go out on a wire, then
you likely need two or more machines for a realistic test too.

Helge Hafting

