Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317484AbSFMHQD>; Thu, 13 Jun 2002 03:16:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317485AbSFMHQC>; Thu, 13 Jun 2002 03:16:02 -0400
Received: from firewall.esrf.fr ([193.49.43.1]:14033 "HELO out.esrf.fr")
	by vger.kernel.org with SMTP id <S317484AbSFMHQC>;
	Thu, 13 Jun 2002 03:16:02 -0400
Date: Thu, 13 Jun 2002 09:15:53 +0200
From: Samuel Maftoul <maftoul@esrf.fr>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: NAPI for eepro100
Message-ID: <20020613091553.B3142@pcmaftoul.esrf.fr>
In-Reply-To: <20020612.163344.31410429.davem@redhat.com> <Pine.LNX.4.33.0206122219100.1390-100000@presario>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2002 at 10:25:22PM -0400, Donald Becker wrote:
> On Wed, 12 Jun 2002, David S. Miller wrote:
> >    From: Jeff Garzik <jgarzik@mandrakesoft.com>
> >    Oh crap, you're right...   eepro100 in general does funky stuff with the
> >    way packets are handled, mainly due to the need to issue commands to the
> >    NIC engine instead of the normal per-descriptor owner bit way of doing
> >    things.
> 
> The eepro100 has a unique design in many different aspects.
> 
> > The question is, do the descriptor bits have to live right before
> > the RX packet data buffer or can other schemes be used?
> 
> With the current driver structure, yes, the descriptor words must be
> immediately before the packet data.  You can use other Rx and Tx
> structures/modes to avoid this, but they use less efficient memory access.
> For instance, the current Tx structure allows transmitting a packet with
> a single PCI burst, rather than multiple transfers.
Maybe a bit off topic, but we (at my work) are using plenty of eepro100
cards with both drivers ( e100 and eepro100 )(shipped with dell
machines, and others).
We have lot of problem with these card: from link autonegociation to the
really frequent cmd_timeout.
We expreienced some freezes, slowdowns, problems with copying from NFS
to a Firwire disk ( systematic cmd_timeout at about 250 MB).

Do you have any advice ? should I test eepro100 NAPI driver ? 
I've try to play with ethtool(chang some eepro100 bits , like the
"sleeping" one ...

I have quitely the same card at home wich doesn't make any problem ( I
noticed some cmd_timeout when I changed my hub).
Is this hub related ? Is there a standart way autonegociation is working
( we use mostly cisco switches, are they compliant?).

We are actually trying to force 10FD or 100FD any new installed card
because we think this is the best way to avoid performances problem ...

Thanks for any advice.
        Sam

