Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265099AbTBCXJs>; Mon, 3 Feb 2003 18:09:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265457AbTBCXJs>; Mon, 3 Feb 2003 18:09:48 -0500
Received: from chaos.analogic.com ([204.178.40.224]:64664 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S265099AbTBCXJq>; Mon, 3 Feb 2003 18:09:46 -0500
Date: Mon, 3 Feb 2003 18:22:31 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Cameron Goble <cgoble@salud.unm.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: SIS900 module detects two transceivers, picks the wrong one
In-Reply-To: <se3e8e6f.059@salud.unm.edu>
Message-ID: <Pine.LNX.3.95.1030203181040.7626A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Feb 2003, Cameron Goble wrote:

> >>> "Richard B. Johnson" root@chaos.analogic.com> 02/03/03 03:12PM >>
> 
> Thanks for the quick response, Richard!
>  
> > Perhaps dmesg will explain better:
> > 
> > eth0: AMD79C901 HomePNA PHY transceiver found at address 2.
> > eth0: AMD79C901 10BASE-T PHY transceiver found at address 3.
> > eth0: using transceiver found at address 2 as default
> > eth0: SiS 900 PCI Fast Ethernet at 0xec400, IRQ 11,
> 00:30:67:09:53:81.
> 
> >This looks as though your wire is just connected backwards, i.e.,
> >you have a reversed patch-cord.
> 
> The patch cable I've got has worked on other machines and hub set up
> for 10Base-T.
>  
> >Are you connected to a Hub? Does the LED on the hub show that
> >the wire is connected properly an does the LED on/near the connector
> on
> >your PC show that its connected correctly also?
>  
> Both the hub and the PC show link lights when connected, yes. The hub
> is 10Base-T also.
>

Hmmm. That shows that whatever is connected is connected okay.
 
> >If you really do have to such connectors, just use eth1 instead of
> >eth0, i.e., `ifconfig eth1 ip-address ...`
> 
> I will certainly give this a try. It's turning out to be quite an
> experience in how the Linux kernel thinks of devices. :) I don't really
> care which eth port it uses, as long as it works. 
>  
> So my ifconfig would be:
> ifconfig eth1 address 192.168.0.4  netmask 255.255.255.0 
> - right?
>  

That's what I'd try --for a start.

> I'm curious though - does ipconfig actually *create* the device ethx?
> Isn't that what the SIS900 module is doing -- detecting a device and
> mapping it onto eth0? dmesg does not reveal a similar report for eth1.
> In that case, how do I force it to use the transceiver at address 3 (see
> the dmesg above), or will it decide to use that one automatically? Sorry
> for my ignorance.
> 

Well most all the devices are virtual. Some ethernet drivers handle
multiple configurations as multiple devices, others do not. I'm
just guessing since I do not use the SIS900 module here.

What I see from the source is that the HomePNA is set because
the board reported a certain identification, 0x6b90. Now, that
doesn't mean too much because a further reading of the source shows....
"If no one link is on, select PHY whose types is HOME as default." sic

So, I would guess, that MAYBE you booted your machine without the
cable connected to your hub and that's why it defaulted to HomePNA?

Anyway, `rmmod sis900;ifconfig eth0 192.168.0.4 etc...` to remove and
reinstall to see if that fixes it...

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


