Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269679AbUJADkq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269679AbUJADkq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 23:40:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269685AbUJADkq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 23:40:46 -0400
Received: from gizmo10bw.bigpond.com ([144.140.70.20]:50404 "HELO
	gizmo10bw.bigpond.com") by vger.kernel.org with SMTP
	id S269679AbUJADkm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 23:40:42 -0400
From: Ross Dickson <ross@datscreative.com.au>
Reply-To: ross@datscreative.com.au
Organization: Dat's Creative Pty Ltd
To: "Maciej W. Rozycki" <macro@linux-mips.org>,
       Andy Currid <ACurrid@nvidia.com>
Subject: Re: nforce2 bugs?
Date: Fri, 1 Oct 2004 13:41:04 +1000
User-Agent: KMail/1.5.1
Cc: "Prakash K. Cheemplavam" <prakashkc@gmx.de>,
       Allen Martin <AMartin@nvidia.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       white phoenix <white.phoenix@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <8E5ACAE05E6B9E44A2903C693A5D4E8A01C45A1C@hqemmail02.nvidia.com> <Pine.LNX.4.58L.0409301705180.25286@blysk.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.58L.0409301705180.25286@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410011341.04506.ross@datscreative.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 01 October 2004 02:59, Maciej W. Rozycki wrote:
> On Thu, 30 Sep 2004, Andy Currid wrote:
> 
> > I'm taking a look at the patches discussed in other recent emails on the
> > list, but I'm curious about the timer issue that Maciej notes here. In
> > systems running in IOAPIC mode where this problem has been observed, is
> > ACPI enabled?
> 
>  One I can test a bit has indeed ACPI enabled.
> 
> > I strongly suspect that it is. Some BIOSes on nForce systems contain an
> > incorrect INT override for the timer interrupt in their ACPI tables,
> > indicating that in IOAPIC mode the timer interrupts on IRQ2 rather than
> > IRQ0. The kernel honors the override, then notices the timer interrupt
> > isn't working and subsequently rescues the situation by configuring the
> > timer in ExtInt mode. That recovers the timer interrupt but I suspect
> > that configuration may be responsible for the "noisy" behavior (it's a
> > faulty configuration).

It is indeed the other way around, the clock skew occurs on some Mobos
with timer interrupts routed to the IntIn0 and to my knowledge is not evident
in the ExtInt routing mode.
The downside of using the ExtInt routing mode is that you can no longer use
nmi_watchdog=1 because it only works on nforce2 boards with IntIn0 timer routing.

> 
>  The firmware (BIOS) reports I/O APIC interrupts correctly on this box --
> there's no override for IRQ0.  Timer interrupts work correctly in the
> ExtInt mode.  They only fail in the I/O APIC mode.
> 
>  Older reports from the list show exactly the same problem, e.g.  
> "http://www.uwsg.iu.edu/hypermail/linux/kernel/0404.1/0739.html", which is
> probably one of the earliest references to the clock skew problem with I/O
> APIC routing.  As I believe both the 8254 and 8259A and the I/O APIC are
> internal to the chipset, I doubt that can be a problem specific to board
> design; it may be a firmware fault, though, such as an initialization bug.  
> As Ross used to maintain temporary workarounds for nforce2 problems, he
> may be able to comment on what reports he received.  Ross?

An earlier Thread on the Topic of the time skew with I/O Apic routing:
http://linux.derkeiler.com/Mailing-Lists/Kernel/2004-01/3129.html

A couple of Skewing Mobos Involved:
Abit NF7-S V2.0 motherboard. 
A7N8X Deluxe mobo/Athlon

Maybe they are using the same revision of non GPU nforce2 silicon?
I personally never had any clock skew but I have only used Mobos with graphics
onboard, several Albatron KM18G and an Epox 8RGA+

-Ross



> 
>   Maciej
> 
> 
> 

