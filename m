Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264033AbRFJQsg>; Sun, 10 Jun 2001 12:48:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264543AbRFJQsQ>; Sun, 10 Jun 2001 12:48:16 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:42704 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S264033AbRFJQsG>;
	Sun, 10 Jun 2001 12:48:06 -0400
Message-ID: <3B23A4BB.7B4567A3@mandrakesoft.com>
Date: Sun, 10 Jun 2001 12:47:55 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
Cc: Ben LaHaise <bcrl@redhat.com>, Andrew Morton <andrewm@uow.edu.au>,
        linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: 3C905b partial  lockup in 2.4.5-pre5 and up to 2.4.6-pre1
In-Reply-To: <20010610093838.A13074@flint.arm.linux.org.uk> <Pine.LNX.4.33.0106101201490.9384-100000@toomuch.toronto.redhat.com> <20010610173419.B13164@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> Indeed.  However, I don't believe user space should _rely_ on the flag.
> The reason is that there are network cards out there where the only way
> to get the link status _is_ to transmit a packet, even on 10baseT.
> 
> PCNET is one example - the "oh my god my link is down" status bit is in
> the transmit ring headers, not in an easily accessible register.
> 
> The only interpretation user space can place on IFF_RUNNING for these
> cards is that if its not set, packets will get dropped by the interface.
> If its set, packets _may_ be dropped by the interface.

These are the exception not the rule, though, so I don't think we should
design primarily for them.  On most decent cards, we can not only ask
for link status from a register, but also get interrupts when link
change occurs [though we may still need a timer for certain link
states].


> [note I've not found anything in 2.4.5 where netif_carrier_ok prevents
> the net layers queueing packets for an interface, and forwarding them
> on for transmission].

we want netif_carrier_{on,off} to emit netlink messages.  I don't know
how DaveM would feel about such getting implemented in 2.4.x though,
even if well tested.

Note we went over netif_carrier_xxx and related issues not a week ago,
IIRC

	Jeff


P.S. netdev@oss.sgi.com added to cc.  please cc there on net
interface/driver issues...

-- 
Jeff Garzik      | Andre the Giant has a posse.
Building 1024    |
MandrakeSoft     |
