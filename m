Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137108AbRA1O1p>; Sun, 28 Jan 2001 09:27:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137126AbRA1O1e>; Sun, 28 Jan 2001 09:27:34 -0500
Received: from Cantor.suse.de ([194.112.123.193]:54282 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S137108AbRA1O11>;
	Sun, 28 Jan 2001 09:27:27 -0500
Date: Sun, 28 Jan 2001 15:27:25 +0100
From: Andi Kleen <ak@suse.de>
To: lkml <linux-kernel@vger.kernel.org>
Cc: leitner@fefe.de
Subject: Re: sendfile+zerocopy: fairly sexy (nothing to do with ECN)
Message-ID: <20010128152725.A13600@gruyere.muc.suse.de>
In-Reply-To: <3A726087.764CC02E@uow.edu.au> <200101271854.VAA02845@ms2.inr.ac.ru> <3A73AF7B.6610B559@uow.edu.au> <20010128143748.A9767@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010128143748.A9767@convergence.de>; from leitner@fefe.de on Sun, Jan 28, 2001 at 02:37:48PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 28, 2001 at 02:37:48PM +0100, Felix von Leitner wrote:
> What is missing here is a good authoritative web ressource that tells
> people which NIC to buy.
> 
> I have a tulip NIC because a few years ago that apparently was the NIC
> of choice.  It has good multicast (which is important to me), but AFAIK
> it has neither scatter-gather nor hardware checksumming.
> 
> Is there such a web page already?
> If not, I volunteer to create amd maintain one.

Here a try for FastEthernet. Corrections/additions welcome.

Currently the 3c9xx cards look like the best commonly affordable ones,
at least when you care about zero copy networking. The newer ones have
all the necessary toys for it. 
Don't use them with the 3com vendor driver though, their driver is crap. 

eepro100 seems to have mostly the same facilities, but Intel doesn't 
document it fully so it is not usable in the standard Linux driver. They have
an own driver available (e100.c) which does more, but it of course lags in
progress to the normal stack.

I don't know about starfire, but it seems to be hard to even buy them anyways.

Sun HME seems to be on similar level as 3c9xx, but near impossible to buy or
very expensive.

Realtek is ok for low cost and being relatively hazzle free, but they
miss lots of useful facilities and basically require a copy for RX.

SMC epic/100 is handicapped by not being able to receive to unaligned addresses,
requiring in linux a driver level copy (that may change in 2.5 though, zero
copy has the necessary infrastructure to only copy the header in this case,
not the whole packet) 

AMD pcnet afaik doesn't do hardware checksums.

Tulip doesn't do hardware checksum and is a bit constrained by the 
required long word alignment in RX (causing problems with misaligned IP 
headers, see above on epic100) 

Advantage of Tulip and AMD is that they perform much better in my experience
on half duplex Ethernet than other cards because they a modified 
patented backoff scheme. Without it Linux 2.1+ tends to suffer badly from
ethernet congestion by colliding with the own acks, probably because it 
sends too fast.

-Andi


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
