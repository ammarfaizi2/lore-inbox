Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262624AbTCZXbu>; Wed, 26 Mar 2003 18:31:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262626AbTCZXbu>; Wed, 26 Mar 2003 18:31:50 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:55556
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S262624AbTCZXbr>; Wed, 26 Mar 2003 18:31:47 -0500
Date: Wed, 26 Mar 2003 15:39:52 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Lincoln Dale <ltd@cisco.com>
cc: Jeff Garzik <jgarzik@pobox.com>, Matt Mackall <mpm@selenic.com>,
       ptb@it.uc3m.es, Justin Cormack <justin@street-vision.com>,
       linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ENBD for 2.5.64
In-Reply-To: <5.1.0.14.2.20030327094236.0304ae90@mira-sjcm-3.cisco.com>
Message-ID: <Pine.LNX.4.10.10303261526500.25072-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Mar 2003, Lincoln Dale wrote:

> > > to traditional SAN storage and you're gatewaying into Fibre Channel).
> >
> >Why a SAN gateway switch, they are all LAN limited.
> 
> ?
> hmm, where to start:
> 
> why a SAN gateway?
> because (a) that's what is out there right now, (b) iSCSI is really the 
> enabler for people to connect to consolodated storage (that they already 
> have) at a cheaper price-point than FC.
> 
> LAN limited?
> 10GE is reality.  so is etherchannel where you have 8xGE trunked 
> together.  "LAN is limited" is a rather bold statement that doesn't support 
> the facts.
> 
> in reality, most applications do NOT want to push 100mbyte/sec of i/o -- or 
> even 20mbyte/sec.
> sure -- benchmarking programs do -- and i could show you a single host 
> pushing 425mbyte/sec using 2 x 2gbit/s FC HBAs -- but in reality, thats way 
> overkill for most people.

We agree this is even overkill for people like Pixar and the movie people.

> i know that your company is working on native iSCSI storage arrays; 
> obviously its in your interests to talk about native iSCSI access to disks, 
> but right now, i'll talk about how people deploy TB of storage today.  this 
> is most likely a different market segment to what you're working on (at 
> least i hope you think it is) - but a discussion on those merits are not 
> something that is useful in l-k.

Well we deploy ERL=1 or ERL=2(%80) today on 6TB platforms now.
So the democratization of SAN is now and today.

> > > handling multipathing in that manner is well beyond the scope of what an
> > > iSCSI driver in the kernel should be doing.
> > > determining the policy (read-preferred / write-preferred / round-robin /
> > > ratio-of-i/o / sync-preferred+async-fallback / ...) on how those paths are
> > > used is most definitely something that should NEVER be in the kernel.
> >
> >Only "NEVER" if you are depending on classic bloated SAN
> >hardware/gateways.  The very operations you are calling never, is done in
> >the gateways which is nothing more or less than an embedded system on
> >crack.  So if this is an initiator which can manage sequencing streams, it
> >is far superior than dealing with the SAN traps of today.
> 
> err, either you don't understand multipathing or i don't.
> 
> "multipathing" is end-to-end between an initiator and a target.
> typically that initiator is a host and multipathing software is installed 
> on that host.
> the target is typically a disk or disk-array.  the disk array may have 
> multiple controllers and those show up as multiple targets.

Agreed, and apply as series of head-to-toe target-initiator pairs and you
get multipathing support native from the super target.  This is all a SAN
gateway/switch does.  Not much more than LVM on crack and a six-pack.

> the thing about multipathing is that it doesn't depend on any magic in "SAN 
> hardware/gateways" (sic) -- its simply a case of the host seeing the same 
> disk via two interfaces and choosing to use one/both of those interfaces to 
> talk to that disk.

Well Storage is nothing by a LIE and regardless if one spoofs and ident
mode pages or not, they must track and manage the resource reporting
properly.

> [..]
> >What do you have for real iSCSI and no FC junk not supporting
> >interoperability?
> 
> ?
> no idea what you're talking about here.

Erm, shove a MacData and Brocade switch on the same FC network and watch
it turn into a degraded dog.

> >FC is dying and nobody who has wasted money on FC junk will be interested
> >in iSCSI.  They wasted piles of money and have to justify it.
> 
> lets just agree to disagree.  i don't hold that view.

Guess that is why NetAPP snaked a big share of EMC's marketspace with a
cheaper mousetrap.  Agreed to "agree to disagree" erm whatever I just
typed.

> > > not bad for a single TCP stream and a software iSCSI stack. :-)
> > > (kernel is 2.4.20)
> >
> >Nice numbers, now do it over WAN.
> 
> sustaining the throughput is simply a matter of:
>   - having a large enough TCP window
>   - ensuring all the TCP go-fast options are enabled
>   - ensuring you can have a sufficient number of IO operations outstanding
>     to allow SCSI to actually be able to fill the TCP window.
> 
> realistically, yes, this can sustain high throughput across a WAN.  but 
> that WAN has to be built right in the first place.

Well sell more of those high bandwidth switches to the world of
internet-ether to make it faster, I would be happier.

> i.e. if its moving other traffic, provide QoS to allow storage traffic to 
> have preference.
> 
> >Sweet kicker here, if you only allow the current rules of SAN to apply.
> >This is what the big dogs want, and no new ideas allowed.
> 
> i definitely don't subscribe to your conspiracy theories here.  sorry.

You should listen to more Art Bell at night, well morning for you.

> >PS poking back at you for fun and serious points.
> 
> yes - i figured.  i'm happy to have a meaningful technical discussion, but 
> don't have the cycles to discuss the universe.

I did the universe once as an academic, it was fun.

http://schwab.tsuniv.edu/t13.html

This was my last time of stargazing and I miss it too!

Cheers,

Andre Hedrick
LAD Storage Consulting Group

