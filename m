Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S155207AbPICSFp>; Fri, 3 Sep 1999 14:05:45 -0400
Received: by vger.rutgers.edu id <S155006AbPICSFM>; Fri, 3 Sep 1999 14:05:12 -0400
Received: from ppp-108-227.villette.club-internet.fr ([194.158.108.227]:1107 "EHLO localhost.localdomain") by vger.rutgers.edu with ESMTP id <S154901AbPICSEd> convert rfc822-to-8bit; Fri, 3 Sep 1999 14:04:33 -0400
Date: Fri, 3 Sep 1999 20:19:49 +0200 (MET DST)
From: Gerard Roudier <groudier@club-internet.fr>
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: David Schleef <ds@stm.lbl.gov>, Paul Ashton <lk@mailandnews.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.rutgers.edu
Subject: Re: Shared interrupt (lack of) handling
In-Reply-To: <Pine.LNX.3.95.990903074606.1016A-100000@chaos.analogic.com>
Message-ID: <Pine.LNX.3.95.990903194822.369A-100000@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: owner-linux-kernel@vger.rutgers.edu



On Fri, 3 Sep 1999, Richard B. Johnson wrote:

> On Thu, 2 Sep 1999, Gerard Roudier wrote:
> [SNIPPED]
> 
> > 
> > In PCI, INTERRUPT ARE NOT SYNCHRONISATION EVENTS!  Synchronisation
> > events are PCI TRANSACTIONS in the context of ordering rules defined by
> > the specs,....
> 
> This sounds like something written by a lawyer. In plan language, any

The specifications _are_ the laws conformant hardwares and softwares shall
follow, and nothing else. People that use them as toilet paper are not
doing the right thing, in my opinion. ;-) 

> hardware interrupt is a hardware request for some software to do
> something. The interrupt event, itself, does not convey any
> knowledge about the reason why the interrupt occurred. Software has
> to inspect the hardware to determine the reason for the interrupt.

The piece of software that inspects the device status registers (or
memory) that tell about things to do must not care about the reason for
which it has been called, and must do proper things to synchronyze
correctly with the device, since INTERRUPTS ARE NOT SYNCHRONISATIONS
EVENTS in PCI.

> With shared interrupts, it is mandatory that the software that handles
> an interrupt event (the ISR), not complain if it finds that it got
> control and, upon inspecting the hardware, finds there is nothing to
> do.

NOT A SYNCHRONISATION EVENT as I wrote.

> How the PCI controller, raises the maskable interrupt pin on the
> CPU make no difference at all. One doesn't care if it's a 'PCI
> TRANSACTION' or a 'PYROSYNCHROGEM'. If it happened fast enough so
> the event isn't stale, nobody cares --and if the software cares,
> it's broken.

Donnot know what a PYROSYNCHROGEM is, but the prefix PYRO may let think
you wanted to flame somebody. ;-)

Indeed a software based in "fast enough" sorts of considerations is way
broken and is just race-based. It must base its behaviour on ordering
rules.

The order in which the PCI controller deals with data and raises the
interrupt, and the way both the PCI device and the C code access shared
memory or IO registers makes a GREAT difference, especially when posted
transactions are used. 

Obviously, the PCI device must make available the data to the CPU prior
to raising the interrupt. But both the PCI device and the C code must
behave correctly in order not to stall and not to see inconsistent data. 

Gérard.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
