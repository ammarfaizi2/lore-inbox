Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269578AbTHCTYg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 15:24:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269661AbTHCTYg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 15:24:36 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:43577 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP id S269578AbTHCTYd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 15:24:33 -0400
To: Werner Almesberger <werner@almesberger.net>
Cc: Jeff Garzik <jgarzik@pobox.com>, Nivedita Singhvi <niv@us.ibm.com>,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: TOE brain dump
References: <20030802140444.E5798@almesberger.net> <3F2BF5C7.90400@us.ibm.com>
	<3F2C0C44.6020002@pobox.com> <20030802184901.G5798@almesberger.net>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 03 Aug 2003 13:21:09 -0600
In-Reply-To: <20030802184901.G5798@almesberger.net>
Message-ID: <m1fzkiwnru.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Werner Almesberger <werner@almesberger.net> writes:

> Jeff Garzik wrote:
> > jabbering at the same time.  TCP is a "one size fits all" solution, but 
> > it doesn't work well for everyone.
> 
> But then, ten "optimized xxPs" that work well in two different
> scenarios each, but not so good in the 98 others, wouldn't be
> much fun either.

The optimized for low latency cases seem to have a strong
market in clusters.  And they are currently keeping alive
quite a few technologies.  Myrinet, Infiniband, Quadric's Elan, etc.
Having low latency and switch technologies that scale is quite
rare currently.

> Another problem of TCP is that it has grown a bit too many
> knobs you need to turn before it works over your really fast
> really long pipe. (In one of the OLS after dinner speeches,
> this was quite appropriately called the "wizard gap".)

Does anyone know which knobs to turn to make TCP go fast over
Infiniband.  (A low latency high bandwidth network?)  I get to
deal with them on a regular basis...

There is one place in low latency communications that I can think
of where TCP/IP is not the proper solution.  For low latency
communication the checksum is at the wrong end of the packet.
IB gets this one correct and places the checksum at the tail end of
the packet.  This allows the packet to start transmitting before
the checksum is computed, possibly even having the receive start
at the other end before the tail of the packet is transmitted.

Would it make any sense to do a low latency variation on TCP that
fixes that problem?  For the IP header we are fine as the data
precedes the checksum.  But the problem appears to affect all
of the upper level protocols that ride on IP, UDP, TCP, SCTP...

> > So, fix the other end of the pipeline too, otherwise this fast network 
> > stuff is flashly but pointless.  If you want to serve up data from disk, 
> > then start creating PCI cards that have both Serial ATA and ethernet 
> > connectors on them :)  Cut out the middleman of the host CPU and host 
> > memory bus instead of offloading portions of TCP that do not need to be 
> > offloaded.
> 
> That's a good point. A hierarchical memory structure can help
> here. Moving one end closer to the hardware, and letting it
> know (e.g. through sendfile) that also the other end is close
> (or can be reached more directly that through some hopelessly
> crowded main bus) may help too.

On that score it is worth noting that the next generation of
peripheral busses (Hypertransport, PCI Express, etc) are all switched.
Which means that device to device communication may be more
reasonable.  Going from a bussed interconnect to a switched
interconnect is certainly a dramatic change in infrastructure. How
that will affect the tradeoffs I don't know.  

Eric
