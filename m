Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313537AbSE2HGP>; Wed, 29 May 2002 03:06:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313628AbSE2HGO>; Wed, 29 May 2002 03:06:14 -0400
Received: from berta.E-Technik.Uni-Dortmund.DE ([129.217.182.12]:21517 "HELO
	kt.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S313537AbSE2HGN>; Wed, 29 May 2002 03:06:13 -0400
Date: Wed, 29 May 2002 09:06:13 +0200
From: Wolfgang Wegner <ww@kt.e-technik.uni-dortmund.de>
To: David Gibson <david@gibson.dropbear.id.au>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.18 orinoco.c __orinoco_ev_rx question
Message-ID: <20020529090613.B28699@bigmac.e-technik.uni-dortmund.de>
In-Reply-To: <20020528160135.D24097@bigmac.e-technik.uni-dortmund.de> <20020529032822.GA16537@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,
On Wed, May 29, 2002 at 01:28:22PM +1000, David Gibson wrote:
> No it doesn't have to be done in the interrupt handler, it could be
> done in a bottom half.  However essentially every other network driver
> does all the Rx work (up to netif_rx()) in the hard irq, so I'm
> disinclined to do it otherwise.
well, you have a point here.
However, my observation shows that this blocks interrupts for quite a
long time (800us, compared to the 700us which i remember being shouted
at in another discussion some days ago), which is quite a lot. (IMHO)
Furthermore, airo.c either has a faster way of doing so or the Cisco
PCM-352 are faster by themselves. (Did not look into airo.c as close
as orinoco.c...)

It was just a question if it could be done.

I would like to try it, so another question (the rxfid stuff...):

Could I leave just getting the rxfid (rxfid = hermes_read_regn(hw, RXFID);)
in the interrupt handler and let the bottom half process something like
a list of FIDs filled by the interrupt handler, or is there any caveat
in doing so? Would it be better (if at all possible) to leave reading
in the head in the interrupt handler, such that the status could be
evaluated and do just the copying of data (which i suspect to be the most
time-consuming) from the bottom half?

Regards,
Wolfgang

