Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312498AbSDXSLA>; Wed, 24 Apr 2002 14:11:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312491AbSDXSK7>; Wed, 24 Apr 2002 14:10:59 -0400
Received: from panic.tn.gatech.edu ([130.207.137.62]:12454 "HELO gtf.org")
	by vger.kernel.org with SMTP id <S312495AbSDXSK5>;
	Wed, 24 Apr 2002 14:10:57 -0400
Date: Wed, 24 Apr 2002 14:10:55 -0400
From: Jeff Garzik <garzik@havoc.gtf.org>
To: Ben Greear <greearb@candelatech.com>
Cc: "David S. Miller" <davem@redhat.com>, jd@epcnet.de,
        linux-kernel@vger.kernel.org
Subject: Re: AW: Re: AW: Re: VLAN and Network Drivers 2.4.x
Message-ID: <20020424141055.A20763@havoc.gtf.org>
In-Reply-To: <20020424.093515.82125943.davem@redhat.com> <721506265.avixxmail@nexxnet.epcnet.de> <20020424.095951.43413800.davem@redhat.com> <3CC6EBF1.9060902@candelatech.com> <20020424134933.A17852@havoc.gtf.org> <3CC6F3BF.8050504@candelatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2002 at 11:04:47AM -0700, Ben Greear wrote:
> Jeff Garzik wrote:
> 
> > On Wed, Apr 24, 2002 at 10:31:29AM -0700, Ben Greear wrote:
> > 
> >>Also, is there any good reason that we can't get at least a compile
> >>time change into some of the drivers like tulip where we know we can
> >>get at least MOST of the cards supported with a small change?
> >>
> > 
> > The tulip patch is butt-ugly - the oversized allocation isn't needed,
> > and it just flat-out turns off large packet protection.  That's really
> > not what you want to do, even for the best tulip cards.  If an oversized
> > gram (non-VLAN) makes it into a network which such a patched tulip
> > driver, you can DoS.  So, I view the current tulip patch as unacceptable
> > too -- for security reasons, we should not even take it as a compile
> > time patch.  (and I recommend against using that patch on production
> > machines, for the same security reasons)
> 
> 
> I can DOS a tulip card with very small packets too ;)

A tulip card?  Or the stack?

Can you DoS it when CONFIG_NET_HW_FLOWCONTROL is enabled?
That's basically NAPI without the fancy acronym...


> > The proper tulip patch does not need to change packet allocation size
> > at all (it's already plenty big enough), and it needs to copy the RX
> > fragment handling code from 8139cp (which is admittedly ugly, slow path)
> > or write fresh fragment handling code.  Along with that fragment
> > handling code comes a safe way to do VLAN, and non-standard large MTUs
> > in general.
> 
> In the general case, where the packets are only 1518 (ie no DoS or mis-configured
> hardware is in effect), is there a need for the "ugly, slow path" code to run?

It depends on the chip, but most generally: no

	Jeff



