Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135275AbREBNUU>; Wed, 2 May 2001 09:20:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135276AbREBNUK>; Wed, 2 May 2001 09:20:10 -0400
Received: from smtp102.urscorp.com ([38.202.96.105]:56592 "EHLO
	smtp102.urscorp.com") by vger.kernel.org with ESMTP
	id <S135275AbREBNUE>; Wed, 2 May 2001 09:20:04 -0400
To: paulus@samba.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: isa_read/write not available on ppc - solution suggestions ??
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
From: mike_phillips@urscorp.com
Message-ID: <OFA57C1906.E60183EB-ON85256A40.00425F2E@urscorp.com>
Date: Wed, 2 May 2001 09:12:41 -0400
X-MIMETrack: Serialize by Router on SMTP102/URSCorp(Release 5.0.5 |September 22, 2000) at
 05/02/2001 09:15:48 AM,
	Serialize complete at 05/02/2001 09:15:48 AM
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> We can certainly do that, no problem.

> BUT that won't get a token ring pcmcia card working in the newer
> powerbooks, such as the titanium G4 powerbook, because the PCI host
> bridge doesn't map any cpu addresses to the bottom 16MB of PCI memory
> space.  This is not a problem as far as pcmcia cards are concerned -
> the pcmcia stuff just picks an appropriate address (typically in the
> range 0x90000000 - 0x9fffffff) and sets the pcmcia/cardbus bridge to
> map that to the card.  But it means that the physical addresses for
> the card's memory space will be above the 16MB point, so it is
> essential to do the ioremap.

This is where the multiple support issue comes in. In ibmtr_cs.c we do 
ioremap the addresses so pcmcia all works nicely. What we don't do at 
present is an ioremap in ibmtr.c for the non-pcmcia adapters (isa & mca). 
So, I suppose the real fix would be to implement the ioremap in ibmtr.c so 
that regular read/writes can be used everywhere in the driver. (This is 
half the battle with changes to the driver, it supports so many 
combinations that one change for one type of adapter can kill support for 
another adapter, and that's my bottom line with updates: No loss of 
functionality we already had.)

Or we could just tell people to use the cardbus token ring adapter on ppc 
instead ;)

Mike

