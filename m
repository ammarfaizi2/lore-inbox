Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129177AbRBBCOm>; Thu, 1 Feb 2001 21:14:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129302AbRBBCOc>; Thu, 1 Feb 2001 21:14:32 -0500
Received: from adsl-63-202-13-20.dsl.snfc21.pacbell.net ([63.202.13.20]:14099
	"EHLO earth.zigamorph.net") by vger.kernel.org with ESMTP
	id <S129177AbRBBCOV>; Thu, 1 Feb 2001 21:14:21 -0500
Date: Fri, 2 Feb 2001 02:14:46 +0000 (UTC)
From: Adam Fritzler <mid@earth.zigamorph.net>
To: linux-kernel@vger.kernel.org
Subject: novatel minstrel on 2.4
Message-ID: <Pine.LNX.4.21.0102020204180.26932-100000@earth.zigamorph.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We've been trying to set up a laptop here to use a Novatel Minstrel PCMCIA
modem (wireless Richocet network).  The card shows up as a serial port
(ttySx) and accepts AT commands just like a normal modem.

It dials fine, PPP connects, gets IPs, etc just as it should.  However,
any packet over about 400 bytes gets dropped on the recieve.  Also, the RX
errors on ppp0 increment occasionally.  

TCP connections connect (because the SYN's are small), but as soon as you
start trying to do bulk transfers (`ls -la` in an ssh window, or an HTTP
GET), the connection stalls.  Pinging other hosts also works fine, except
when you do -s with a value larger than 300 or so.

It doesn't work with anything we've tried on 2.4 (changing mtu/mru, serial
port speed, etc). However, under 2.2.x, we were able to get connections to
stay running and not stall by setting the MTU on ppp0 to 120 after the ppp
comes up.  As you can imagine, this makes the modem seem even slower than
it already is.

Not that its relevent, but pppstats shows 0 in the 'vjcomp' fields of
both rx and tx (as well as 'vjerr').  I've tried starting pppd with and
without 'novj' just in case.  Same result.

Any ideas?  The 'rx error' count going up is kind of suspicious.  My
attempts at getting pppd to print more debugging output have been
futile; aparently the debug and kdebug options no longer work ('debug'
produces the LCP traffic, yes, but thats working fine).

af

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
