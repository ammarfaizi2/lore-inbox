Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272592AbRIFUwh>; Thu, 6 Sep 2001 16:52:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272593AbRIFUwa>; Thu, 6 Sep 2001 16:52:30 -0400
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:20752 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S272591AbRIFUwM>; Thu, 6 Sep 2001 16:52:12 -0400
Date: Thu, 6 Sep 2001 22:52:29 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Andi Kleen <ak@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
        Wietse Venema <wietse@porcupine.org>,
        Matthias Andree <matthias.andree@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: notion of a local address [was: Re: ioctl SIOCGIFNETMASK: ip alias
Message-ID: <20010906225229.K13547@emma1.emma.line.org>
Mail-Followup-To: Andi Kleen <ak@suse.de>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Wietse Venema <wietse@porcupine.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20010906221152.F13547@emma1.emma.line.org> <E15f5gd-0000Pu-00@the-village.bc.nu> <20010906223103.A13300@gruyere.muc.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20010906223103.A13300@gruyere.muc.suse.de>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen did not read the patch, but flamed:

> On Thu, Sep 06, 2001 at 09:23:43PM +0100, Alan Cox wrote:
> > > Alan, SIOCGIFCONF is working sufficiently, it's SIOCGIFNETMASK that
> > > we're talking about. SIOCGIFNETMASK works properly on any other system
> > > or - as far as I can currently test - with my patch.
> > 
> > Then that is worth looking into.
> 
> First it would break lots of linux user land (which doesn't initialise sin_addr
> in SIOCGIFNETMASK) and special casing for "local networks" is in any case bogus.
> Netmask checking is only needed for that; it's not even needed for local address
> checking.

Sorry, Sir. You are missing the point, and it seems to me you have
neither looked at my patch nor at its description.

As a special service, I'll reiterate:

1. The new behaviour (match address and name) is only tried at all if
   user space passes in an AF_INET address. If userspace passes AF_INET
   and a bogus address, the lookup will fail, and 2. below will kick in.

2. If the new behaviour doesn't come up with an interface, because the
   address was wrong or not member of the AF_INET family, we just do it
   the old way (match just name).

If it breaks user land, show an honest example that my patch breaks. Any
objection is invalid without accompanying counter example.

(TCP/IP stack bug fingerprinting doesn't count.)

It's frustrating when people discuss patches they haven't even looked at
and then start flaming around randomly because someone wants to change
for portability. That's doing Linux a disservice.

-- 
Matthias Andree

O si tacuisses, poeta mansisses.
