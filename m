Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270767AbTHFR4B (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 13:56:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270772AbTHFR4B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 13:56:01 -0400
Received: from mail.zmailer.org ([62.240.94.4]:3467 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id S270767AbTHFRz7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 13:55:59 -0400
Date: Wed, 6 Aug 2003 20:55:57 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Andy Isaacson <adi@hexapodia.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: TOE brain dump
Message-ID: <20030806175557.GB6898@mea-ext.zmailer.org>
References: <20030802184901.G5798@almesberger.net> <m1fzkiwnru.fsf@frodo.biederman.org> <20030804162433.L5798@almesberger.net> <m1u18wuinm.fsf@frodo.biederman.org> <20030806021304.E5798@almesberger.net> <m1llu7ushr.fsf@frodo.biederman.org> <20030806103758.H5798@almesberger.net> <20030806105830.B26920@hexapodia.org> <3F312C65.9000201@nortelnetworks.com> <20030806120145.A15543@hexapodia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030806120145.A15543@hexapodia.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 06, 2003 at 12:01:45PM -0500, Andy Isaacson wrote:
> On Wed, Aug 06, 2003 at 12:27:17PM -0400, Chris Friesen wrote:
> > Andy Isaacson wrote:
> > > On Wed, Aug 06, 2003 at 10:37:58AM -0300, Werner Almesberger wrote:
> > >>Eric W. Biederman wrote:
> > >>>to keep your latency down.  Do any ethernet switches do cut-through?
> > >>According to Google, many at least claim to do this.

Quite a while back (several years) several "cut-through" routing
things were introduced, primarily over ATMish core networks.

The idea ran essentially as: "if you can't find header address
lookup from cache, run routing and form a VC to carry rest of
the flow, if you can find a VC from cache, send the packet there"
(what the "VC" is in the end is not that important.)

NOTHING in those implementations was (as I recall) specifying about
treatment of the packet before it was fully collected into router
local buffer memory.

In very high speed local networks (like Cray T3 series switch fabric
with _routable_ packets) one can implement protocols, which carry
destination node address selector bits in header, and if the fabric
is e.g. congestion free one, there is guaranteed success at delivering
the bits to desired destination.  To make UDPish communication a bit
simpler, relevant hardware got signal back about "sent ok thru / 
collision", so the sender hardware could automagically retry the xmit.

To certain extent one could handle e.g. ethernet in similar style
by fast-switching packets by cached destination MAC addresses.
When destination MAC lookup points to some destination port in local
hardware, internal VC is formed (reserved in output end, presuming
sufficient core bandwidth to handle everything), and incoming enet
frame is sent piece by piece thru the internal switch to the output
port.  If the output port can not be contacted immediately, full frame 
(possibly two or three) need to be buffered at the receiver.

That way switch internal buffering delay would be -- lets see:
- preamble 7 bytes
- SFD      1 byte
- dest mac 6 bytes
plus processing delay, but that is absolute minimum for 100BASE-T

Cheap cluster super-computer makers are using ethernets, and other
"off the shelf" stuff, but I don't see why semi-proprietary high
performance "LANs" could not emerge for this market.
E.g. I would love to have cheapish (mere 5 times price of Cu-GE card)
"LAN" cards for cluster binding, especially if I get direct memory
access to other machine's memory.

A whole bundle of various cluster interconnects are mentioned
at this white-paper from 2001:

  http://www.dell.com/us/en/slg/topics/power_ps4q01-ctcinter.htm

VIA, VI-IP, SCI, FE, infiniband, etc...

/Matti Aarnio
