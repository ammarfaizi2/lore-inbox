Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264031AbRFJQfQ>; Sun, 10 Jun 2001 12:35:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264032AbRFJQfG>; Sun, 10 Jun 2001 12:35:06 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:59397 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S264031AbRFJQew>;
	Sun, 10 Jun 2001 12:34:52 -0400
Date: Sun, 10 Jun 2001 17:34:19 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Ben LaHaise <bcrl@redhat.com>
Cc: Andrew Morton <andrewm@uow.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: 3C905b partial  lockup in 2.4.5-pre5 and up to 2.4.6-pre1
Message-ID: <20010610173419.B13164@flint.arm.linux.org.uk>
In-Reply-To: <20010610093838.A13074@flint.arm.linux.org.uk> <Pine.LNX.4.33.0106101201490.9384-100000@toomuch.toronto.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0106101201490.9384-100000@toomuch.toronto.redhat.com>; from bcrl@redhat.com on Sun, Jun 10, 2001 at 12:06:08PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 10, 2001 at 12:06:08PM -0400, Ben LaHaise wrote:
> I doubt it's a change, more likely an undocumented requirement.  Look at
> it another way: is the transmitter ready when the link is down?  No.
> Why?  Because if it does attempt to transmit a packet, it will get a
> transmit error, but it can't possibly be an error since it's a normal part
> of bringing the link up.  Does this sound reasonable?

Indeed.  However, I don't believe user space should _rely_ on the flag.
The reason is that there are network cards out there where the only way
to get the link status _is_ to transmit a packet, even on 10baseT.

PCNET is one example - the "oh my god my link is down" status bit is in
the transmit ring headers, not in an easily accessible register.

The only interpretation user space can place on IFF_RUNNING for these
cards is that if its not set, packets will get dropped by the interface.
If its set, packets _may_ be dropped by the interface.

[note I've not found anything in 2.4.5 where netif_carrier_ok prevents
the net layers queueing packets for an interface, and forwarding them
on for transmission].

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

