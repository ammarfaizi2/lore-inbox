Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130200AbRBCQxF>; Sat, 3 Feb 2001 11:53:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130205AbRBCQwz>; Sat, 3 Feb 2001 11:52:55 -0500
Received: from alcove.wittsend.com ([130.205.0.20]:8709 "EHLO
	alcove.wittsend.com") by vger.kernel.org with ESMTP
	id <S130200AbRBCQwo>; Sat, 3 Feb 2001 11:52:44 -0500
Date: Sat, 3 Feb 2001 11:51:41 -0500
From: "Michael H. Warfield" <mhw@wittsend.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Gregory Maxwell <greg@linuxpower.cx>, James Sutherland <jas88@cam.ac.uk>,
        jamal <hadi@cyberus.ca>, linux-kernel@vger.kernel.org
Subject: Re: ECN: Clearing the air (fwd)
Message-ID: <20010203115141.A2432@alcove.wittsend.com>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Gregory Maxwell <greg@linuxpower.cx>,
	James Sutherland <jas88@cam.ac.uk>, jamal <hadi@cyberus.ca>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010128144204.B13195@xi.linuxpower.cx> <E14O1aF-0002nY-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.2i
In-Reply-To: <E14O1aF-0002nY-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Wed, Jan 31, 2001 at 06:02:17PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 31, 2001 at 06:02:17PM +0000, Alan Cox wrote:
> > No. ECN is essential to the continued stability of the Internet. Without
> > probabilistic queuing (i.e. RED) and ECN the Internet will continue to have
> > retransmit synchronization and once congested stay congested until people get
> > frustrated and give it up for a little bit.

> Arguably so. In theory a vindictive probabilistic queueing is sufficient
> (do RED but then drop -every- frame from the same route as the packet chosen
>  from the queue)

	THAT actually sounds very similar to what some ATM switches are
doing when congestion results in lost cells in an IP datagram.  Some time
ago, a buddy up at Sandia National Laboratories was explaining the
problem with congestion and IP over ATM.  Once the congestion level
reachs a certain point, the probability of the ATM network dropping a
single cell out of the many cells comprising a complete IP datagram
exceeds unity.  All the transmitted cells, however, are contributing
to the congestion.  The datagram eventually gets retried and adds
even more to the congestion.  Net result is that once you pass this
congestion threshold, IP throughput completely collapses and retries
keep it there until higher layers fail.

	The answer for some intelligent ATM switches is to recognize the
higher layer IP traffic and, when dropping an ATM cell in the middle of
an IP datagram, to drop ALL the cells in a datagram if any of the cells
are going to be dropped.  That way the remaining cells are not contributing
to the congestion when the entire IP datagram is going to be retransmitted
anyways.  Purists MIGHT argue that this is a layering violation, but it
would seem to be a good one.  :-/

	You could call it vindictive, or maybe congestion with extreme
prejudice...  :-)

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
