Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131466AbQLVF0L>; Fri, 22 Dec 2000 00:26:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131490AbQLVF0B>; Fri, 22 Dec 2000 00:26:01 -0500
Received: from alcove.wittsend.com ([130.205.0.20]:36874 "EHLO
	alcove.wittsend.com") by vger.kernel.org with ESMTP
	id <S131466AbQLVFZr>; Fri, 22 Dec 2000 00:25:47 -0500
Date: Thu, 21 Dec 2000 23:55:02 -0500
From: "Michael H. Warfield" <mhw@wittsend.com>
To: Mike OConnor <kernel@pineview.net>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: No more DoS
Message-ID: <20001221235502.C18964@alcove.wittsend.com>
Mail-Followup-To: Mike OConnor <kernel@pineview.net>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <977453684.3a42c2744fbb7@ppro.pineview.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.2i
In-Reply-To: <977453684.3a42c2744fbb7@ppro.pineview.net>; from kernel@pineview.net on Fri, Dec 22, 2000 at 01:24:44PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 22, 2000 at 01:24:44PM +1100, Mike OConnor wrote:
> Hi 

> I would like to point who ever is in charge of the TCP stack for the linux 
> kernel at a site which claims to have a method of eliminate denial of service 
> (DoS) attacks

> http://grc.com/r&d/nomoredos.htm

> With my limited unstanding of TCP and DoS attacks this would seem to be the 
> answer, instead of a work around.

	Obviously written by someone with no real world experience with
DoS attacks.  He seems to think that the majority of DoS attacks are SYN
floods and disregards all the rest by saying this will eliminate
DoS attacks.  In fact, SYN floods have been largely ineffective for
some time now and comprise a very small percentage of attacks now.

	From all appearances, his approach would have no effect on attacks
like NAPTHA which try to take advantage of more advanced states in the TCP
state machine.

	He actually should take a look at the "Cookie Crumbs" attacks
against ISAKMP/IKE (IPSec) which suffer from the same first packet
saved state problem.  Those guys haven't solved that problem and that's
even a security protocol!  Maybe he could be some help there (or learn
something).

	We probably see more incidents of TIES bombing (sending packets
with "\r+++ATH0\r" in payloads) to hang up modems than we see SYN
flooding lately (IMHO).  I recently helped and ISP that was virtually
shut down by someone TIES bombing them with ping packets containing the
TIES hangup sequence.  Once we got THEIR modems fixed, the TIES bombs
were hanging up their customers modem's (the ICMP Echo Reply) and we
had to design a TIES Bomb packet that would reset the vulnerable
customer modems to a safe S register value...  Grrr...

	Quite frankly...  My favorite DoS attack is NISNuke (which
I researched and documented).  His approach would have exactly zero
effect in mitigating an NISNuke attack and I can take out and entire
network with it (all you need is NIS and finger on the same large network).
So he can NOT claim to eliminate DoS attacks since I have a small arsenal
of them which would be untouched by his approach.

	While some DDoS (Distributed Denial of Service) attacks do
incorporate SYN flooding, their most profound effect is in the bulk
attack areas such as Smurf flooding (ICMP echo to broadcast addresses
while spoofing the return address as the targeted party) and UDP data
overloads.  Those have other solutions (such as router filters which
prevent spoofing) which we can't even get implimented, much less
a tcp stack state machine redesign!

	He's got a solution (and an ineffective one at that) that's
really in search of a problem.  It's highly unlikely that it would even
make a miniscule dent in the DoS problem.  That's even assuming that
it would work (which others such as Dave Miller have stated that it
wouldn't).

	He gets a "nice try" but in the long run it boils down to the
expression in the IETF...  You vote with working code.  Let's see the
code in operation and see how it works and stands up.  If it works and
it more robust in the face of ongoing attacks, all hail!  Kudos for
all around.  If not, then don't tell us how it should be.  Demonstrate
with working code.  I didn't seen ANYTHING on that site but a description
of how he thought it should work.  Vote with working code...

> Cheers
>     Mike OConnor

	Mike
-- 
 Michael H. Warfield    |  (770) 985-6132   |  mhw@WittsEnd.com
  (The Mad Wizard)      |  (678) 463-0932   |  http://www.wittsend.com/mhw/
  NIC whois:  MHW9      |  An optimist believes we live in the best of all
 PGP Key: 0xDF1DD471    |  possible worlds.  A pessimist is sure of it!

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
