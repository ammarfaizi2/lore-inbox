Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S156612AbPIXVG6>; Fri, 24 Sep 1999 17:06:58 -0400
Received: by vger.rutgers.edu id <S156141AbPIXVGm>; Fri, 24 Sep 1999 17:06:42 -0400
Received: from BEAVER.JPRC.COM ([207.86.147.217]:4404 "EHLO beaver.jprc.com") by vger.rutgers.edu with ESMTP id <S156611AbPIXVEn>; Fri, 24 Sep 1999 17:04:43 -0400
To: linux-kernel@vger.rutgers.edu
Subject: Re: zero-copy TCP fileserving
References: <7sego8$1c5$1@palladium.transmeta.com> <E11UTH0-0004NE-00@the-village.bc.nu> <19990924094504.A15678@dancer.ca.sandia.gov> <199909241702.KAA06516@pizda.ninka.net>
X-Face: "5(T0tZd{6}pd~YzBG8O/*EW,.]6]@`m^e;fv65W^Y&=d"M\1H}>T~4_.kcDD.O~y3k)a6h R;Nmi>9|>Nm${2IpM0^RcUEa\jcq?KOP)C&~x51l~zCHTulL^_T|u0I^kB'z@]{`2YjQu
From: Karl Kleinpaste <karl@justresearch.com>
Date: 24 Sep 1999 17:04:37 -0400
In-Reply-To: "David S. Miller"'s message of "Fri, 24 Sep 1999 10:02:56 -0700"
Message-ID: <vxkln9wqavu.fsf@beaver.jprc.com>
User-Agent: Gnus/5.070096 (Pterodactyl Gnus v0.96) XEmacs/21.2 (Shinjuku)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-kernel@vger.rutgers.edu

"David S. Miller" <davem@redhat.com> writes:
> Because the csum_partial_copy_from_user done in the TCP transmit path
> gets the checksum at zero cost.  Just eliminating the checksum is
> going to buy little if anything (in fact on some cpus it's going to
> cost more to "avoid" the csum part of the copy), the real gain is
> avoiding the copy as well.

> You'd need to, in tcp sendmsg:
> 1) Lock down the data buffer
> 2) Add support to the skb's for iovecs
> 3) Put the TCP/IP/HW headers in the first iovec
> 4) Hook up the user data in subsequent iovecs

In the early '90s, this concept was very new, and we (at CMU) did a
lot of work on it.  Our final paper (from SIGCOMM'95) is under
http://www.acm.org/sigcomm/sigcomm95/sigcpapers.html, or I have a copy
at http://www.cs.cmu.edu/~karl/general/95sigcomm.ps.

At the time, 100Mbps ether didn't exist, and the 80386 was
simultaneously new and boring (due to being slow).  We worked with
DecStation 5000s and later early Alphas with a custom-built (by NSC)
HIPPI interface, off the DS5K & Alpha turbochannel.  Manufacturing a
new mbuf type which contained iovecs was exactly what we did.

--karl

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
