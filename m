Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271095AbRIAS2t>; Sat, 1 Sep 2001 14:28:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271105AbRIAS2j>; Sat, 1 Sep 2001 14:28:39 -0400
Received: from tantalophile.demon.co.uk ([193.237.65.219]:9088 "EHLO
	kushida.degree2.com") by vger.kernel.org with ESMTP
	id <S271095AbRIAS2W>; Sat, 1 Sep 2001 14:28:22 -0400
Date: Sat, 1 Sep 2001 19:22:42 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Andi Kleen <ak@muc.de>
Cc: "David S . Miller" <davem@redhat.com>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, linux-kernel@vger.kernel.org
Subject: Re: Excessive TCP retransmits over lossless, high latency link
Message-ID: <20010901192242.A2714@thefinal.cern.ch>
In-Reply-To: <20010901181729.A2204@thefinal.cern.ch> <20010901194141.44617@colin.muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010901194141.44617@colin.muc.de>; from ak@muc.de on Sat, Sep 01, 2001 at 07:41:41PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Sat, Sep 01, 2001 at 07:17:29PM +0200, Jamie Lokier wrote:
> > The appended "tcpdump -i ppp0 -n" trace shows an excessive number of
> > retransmits from the remote POP server.  The retransmits are triggered
> > by excessive duplicate ACKs from the local client.  By excessive, I mean
> > lots of retransmits of the same data.
> 
> The duplicate ACKs should not cause any retransmits (unless the sender
> is badly broken), because they contain a high enough ACK number.

We are receiving frames with sequence number <= the ACK we're sending.

When the remote end receives those ACKs, it is seeing a series of
duplicate ACKs for data it sent about 5 frames ago.  So of course it
retransmits the data starting from 5 frames ago.  As it receives a whole
series of the same duplicate ACK, it retransmits from the same place
each time.

I don't see what is broken about the remote end in this case.

> The problem is really that a TCP sender cannot recover from a too short RTT 
> estimate; if the RTT is longer and it doesn't get any acks it'll assume 
> packet loss and never has a chance to find out about the longer RTT, because
> that only works with new ACKs. 
> 
> The standard initial RTT is 3 seconds; but your RTT is 5.2s. 

Actually, 5.2s is the most common packet interarrival time.  The RTT is
more like 23s!

> What you can do is to change the initial RTT on the sender side. On Linux
> it can be done with the "irtt" option of route or the equivalent one of
> iproute2. Most other OS have a similar way to configure the IRTT. 

Unfortunately I cannot change the IRTT on my ISP's mail server, or for
that matter on anyone's web server.

Are you saying that the IRTT must be larger than the actual RTT, and the
estimates can only go down?  I thought IRTT was a rough guess and it
was expected to go either up or down.

-- Jamie
