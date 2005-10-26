Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964887AbVJZUWF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964887AbVJZUWF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 16:22:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964905AbVJZUWF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 16:22:05 -0400
Received: from web50108.mail.yahoo.com ([206.190.38.36]:45453 "HELO
	web50108.mail.yahoo.com") by vger.kernel.org with SMTP
	id S964887AbVJZUWE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 16:22:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=IxHgBsQxuEGEwcM86ml4o+OKLiexB9yMItG6BCxPY4ETfNjhMEKw5cfjchdcX9yawuL/UNkWyadO/b7Ua7xQHhD7ChN8UEiKjuS+UYQ34njryrpPBvVcNG1Obj7Hv7VfnIX3m6GbzN0cFuqBXPkYVbcWGzkanYzPmdBREO2MFu8=  ;
Message-ID: <20051026202200.76915.qmail@web50108.mail.yahoo.com>
Date: Wed, 26 Oct 2005 13:22:00 -0700 (PDT)
From: Doug Thompson <norsk5@yahoo.com>
Subject: Re: EDAC (was: Re: 2.6.14-rc5-mm1)
To: sander@humilis.net
Cc: linux-kernel@vger.kernel.org, sander@humilis.net,
       Avuton Olrich <avuton@gmail.com>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20051026193800.GA15552@favonius>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- Sander <sander@humilis.net> wrote:

> Doug Thompson wrote (ao):
> > --- Sander <sander@humilis.net> wrote:
> > > Via Epia MII 10000, kernel 2.6.14-rc4-mm1:
>  
> > The EDAC scanning code first scans the STATUS
> register
> > of all the PCI devices in the system. This status
> > register reflects operations on the main bus.
> > Second, the code scans the SECONDARY STATUS
> register
> > of all bridge devices, which reflects operations
> on
> > the sub-bus.
> > 
> > This instance (0000:00:01.0) of output shows me
> the
> > VIA VT8633 is generating the parity bit. The
> default
> > poll interval if 1000 ms and the above output
> shows
> > this. This bridge is either having a parity error
> on
> > the main bus OR more likely is generating false
> > positives. How to determine which? More
> investigation
> > is needed.  
> 
> Anything I can do? 

To help? Keep an eye for other devices which post
parity errors.

To overcome this on your own system? If you don't want
so many message for the moment, turn off EDAC. Later
when the blacklist is avaliable, put this device in
the  blacklist.

> And will blacklisting make EDAC useless? 

No, just less closure, less complete.  If we were SURE
all devices followed the rules, then a parity event is
a BAD thing we could then count on. Since it is an
imperfect world, we gather the "blacklist" of cards
that don't follow the PCI spec, send them a blasting
letter, buy alternatives that do work and continue to
scan for parity errors.

This scanning of parity errrors allowed my company to
isolate data corruption between an interconnect in
nodes on a cluster. The fault? The riser card had
failings. With this parity scanner, we isolated the
borderline risers and replaced them. Saved alot of
time. Luckily, the card we had did NOT generate false
positives. We have another high speed interconnect
which does generate false positives, we told them
about it. Helped them reproduce the reporting via
script using 'setpci'. They finally ack'd they had a
firmware problem and will rev the FW in january -
yeah!

> If so, does it make more sense not to configure
EDAC?

depends on your requirements.

we have been living with systems with PCI devices for
a decade now. how many times have events occurred that
had no explaination and are simply dismissed? There
were no detectors.

We assume many things, even today.  How many desktops
with gigs of memory have no ECC? I have learned my
lesson while refactoring bluesmoke/edac that ECC is
very important.  ECC always in my machines for now on,
for me anyway.

For PCI devices, if you want to "know" data is being
transmitted correctly, then there needs to be
"detector" and "reporter" and "handler" agents of this
bad events to properly notice, report and process
them.

doug thompson


> 
> -- 
> Humilis IT Services and Solutions
> http://www.humilis.net
> 



"If you think Education is expensive, just try Ignorance"

"Don't tell people HOW to do things, tell them WHAT you
want and they will surprise you with their ingenuity."
                   Gen George Patton

