Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263782AbRFNSfr>; Thu, 14 Jun 2001 14:35:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263994AbRFNSfh>; Thu, 14 Jun 2001 14:35:37 -0400
Received: from scl-ims.phoenix.com ([134.122.1.73]:58377 "EHLO
	scl-ims.phoenix.com") by vger.kernel.org with ESMTP
	id <S263782AbRFNSf2>; Thu, 14 Jun 2001 14:35:28 -0400
Message-ID: <D973CF70008ED411B273009027893BA401BE6B22@irv-exch.phoenix.com>
From: David Christensen <David_Christensen@Phoenix.com>
To: "'Alex Deucher'" <adeucher@UU.NET>, linux-kernel@vger.kernel.org,
        acpi@phobos.fachschaften.tu-muenchen.de
Subject: RE: [Acpi] APM, ACPI, and Wake on LAN - the bane of my existance
Date: Thu, 14 Jun 2001 11:35:22 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex,

Looking at the back of a Linksys EtherFast 10/100 manual I happen to have,
they describe two different remote wake-up events, Magic Packet and Link 
Change.  The first one is pretty obvious and is probably not related to 
your problems, but the second one may be.  The manual states ""Link Change
is a remote wake up event that is triggered by any change in the EtherFast
card's link state."  Plugging in a LAN cable is the example given that
would turn the system on.  You may have to look at the driver source to see
if this is enabled by default or you may have to modify the driver to 
disable this "feature" on the card.

Regarding the WOL cable, this was used for older motherboards before PCI
2.2,
though it is still present on newer motherboards to support older PCI cards.
A PCI 2.2 compliant motherboard and NIC use the #PME signal on the PCI bus
to signal the wake.

Dave

> 
> I have an athlon system with a iwill kk266 motherboard (via 
> kt133A).  I
> have a linksys 10/100 PCI ethernet card with wake on lan 
> capabilities. 
> Anyway, when I shut the PC down it turns off, but refuses to 
> stay off. 
> Within a minute or two, it turns itself on again.  If i run over and
> turn it off by hitting the power putton, it turns off, but then comes
> back on again at a later somewaht arbitrary time (1 minute to several
> hours later).  I originally got the WOL card so I could 
> remotely boot my
> PC, but at this point it has turned out to be more trouble than it's
> worth.  I tried to disable WOL inthe BIOS, but that didn't change
> anything.  So I removed the three pin cross connect that connects the
> card to the WOL header on the motherboard.  That fixed it for a few
> days, but now it's doing it again, even without the cable installed. 
> the only fix is to unplug the ethernet cable when I turn it off.  
> 
> I suspect the problem has something to do with WOL vs. resume on LAN. 
> the system should only turn on when it recieves a magic packet, but it
> seems that any packet may cause it to boot (or resume, but since it is
> in the "off" state, boot).  I've only been using APM, but perhaps acpi
> is required for this to work properly.  As far as why it does 
> this when
> the 3 pin WOL connector was not used, I'm not sure, maybe something to
> do with PCI 2.2.
