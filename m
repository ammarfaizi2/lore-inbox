Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312411AbSDOD3I>; Sun, 14 Apr 2002 23:29:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312582AbSDOD3I>; Sun, 14 Apr 2002 23:29:08 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:43918 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S312411AbSDOD3H>;
	Sun, 14 Apr 2002 23:29:07 -0400
Date: Mon, 15 Apr 2002 13:28:53 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Stanislav Meduna <stano@meduna.org>
Cc: jt@hpl.hp.com, linux-kernel@vger.kernel.org
Subject: Re: Orinoco_plx, WEP and 0.7.6 fw
Message-ID: <20020415032853.GK24053@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Stanislav Meduna <stano@meduna.org>, jt@hpl.hp.com,
	linux-kernel@vger.kernel.org
In-Reply-To: <200204131921.g3DJLHw02324@meduna.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 13, 2002 at 09:21:17PM +0200, Stanislav Meduna wrote:
> Hello,
> 
> the file drivers/net/wireless/orinoco.c in 2.4.17 contains
> on the line 1424:
> 
>   priv->has_wep = (firmver >= 0x00008);
> 
> I have the Siemens I-GATE 11M PCI card, which is a PrismII based
> PCMCIA card in the PLX9052 PCI-PCMCIA adapter. This card has
> firmware version 0.7.6 and definitely supports WEP - I am using
> 128-bit WEP in Windows without problems.

The firmware supports WEP, but it is configured differently than
version 0.8 and later, and I've never managed to work out how to
properly activate it.

> If I change the line to enable the WEP for fw 7, I get mixed
> results in 2.4.19-pre6:
> 
> - I can ping, but I cannot telnet.
> - My dmesg is full of
>     eth1: Null event in orinoco_interrupt!

That's unrelated, due to a shared interrupt.

>   and ocassionally I get
>     eth1: Undecryptable frame on Rx. Frame dropped.
> - when I ping I seem to get double replies sometimes (depending
>   on who I ping - never for the access point, always for another
>   client) - either I am somehow seeing both the packet from
>   the client to the AP and from AP to me, or there is some
>   problem in the receiving routines
> 
> Does the driver support interrupt sharing? I have quite a lot
> devices on the PCI bus, the plx board is not able to get
> a dedicated interrupt and shares it with the USB controller.
> I have a SMP board, which can be a factor too.

Yes it does, except for that "Null event" message which is gone in
more recent versions (not yet pushed to Linus and Marcelo).  

> Anyway, if I can ping and see the traffic of another clients
> using tcpdump, the has_wep check is obviously too strict.
> I would suggest to either lower the requirement to firmware 7,
> or (if this is an exception and another cards are different)
> to add a module parameter to override it.

Yes, but the interface doesn't actually work properly.

-- 
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson
