Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269569AbRHCTz4>; Fri, 3 Aug 2001 15:55:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269572AbRHCTzq>; Fri, 3 Aug 2001 15:55:46 -0400
Received: from ux10.cso.uiuc.edu ([128.174.5.79]:62459 "EHLO ux10.cso.uiuc.edu")
	by vger.kernel.org with ESMTP id <S269569AbRHCTzm>;
	Fri, 3 Aug 2001 15:55:42 -0400
Date: Fri, 3 Aug 2001 14:55:51 -0500
From: neal king groothuis <groothui@students.uiuc.edu>
To: linux-kernel@vger.kernel.org
Subject: Possible ARP bug
Message-ID: <20010803145550.A11102@ux10.cso.uiuc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I'm observing some odd behavior in the the kernel's sending of ARP
requests.  I've got a computer (call it Computer A) that sits on two
networks (Network A and Network B, and respective Addresses 1 and 2.)
Another computer, Computer B, has an interface only on Network A.
Now, Computer B needs to connect to Computer A's address on Network B
(Address 2).  When Computer A wants to send a packet back to Computer B
to negotiate the connection, it sees that it is on a subnet with Computer
B and tries to send the data back out over Network A.  Of course, this
generates an ARP request.  The bad thing is, the ARP request has Address
2 as the source protocol address, but since it's going out over Network
B, it has the source MAC address of Computer B's Network B interface.
Thus, we get corruption in the tables of anyone listening to the
ARP traffic, associating Address 2 with the MAC address of the wrong
card.  

This appears to be a similar problem to that posted by Sourav Sen
on this list on July 23, but with "incorrect" ARP requests rather than
replies (so just turning on arpfiltering won't help.)  Shouldn't an
ARP request leaving an interface have an IP address associated with that
interface as the source?

						TIA,
						- neal groothuis

-- 
PGP key available upon request or at http://www.imsa.edu/~ngroot/
