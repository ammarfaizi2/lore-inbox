Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261986AbVF0QBt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261986AbVF0QBt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 12:01:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262049AbVF0PUm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 11:20:42 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:32262 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S261774AbVF0Oze
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 10:55:34 -0400
Date: Mon, 27 Jun 2005 15:55:39 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: IDE - sensible probing for PCI systems
In-Reply-To: <1119702761.28649.2.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.61L.0506271519060.23903@blysk.ds.pg.gda.pl>
References: <1119356601.3279.118.camel@localhost.localdomain> 
 <Pine.LNX.4.61L.0506211422190.9446@blysk.ds.pg.gda.pl> 
 <1119363150.3325.151.camel@localhost.localdomain> 
 <Pine.LNX.4.61L.0506211535100.17779@blysk.ds.pg.gda.pl> 
 <1119379587.3325.182.camel@localhost.localdomain> 
 <Pine.LNX.4.61L.0506231903170.31113@blysk.ds.pg.gda.pl> 
 <1119566026.18655.30.camel@localhost.localdomain> 
 <Pine.LNX.4.61L.0506241217490.28452@blysk.ds.pg.gda.pl>
 <1119702761.28649.2.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Jun 2005, Alan Cox wrote:

> PC systems have serial at 0x3f8/0x2f8 (lpc bus), almost always PS/2 port

 Strange -- boxes have started to appear that have no connectors or at 
least PCB headers for them.  What's the point in removing connectors and 
leaving the (otherwise useful) hardware inaccessible?

> on the mainboard. Timers, interrupt controllers. 

 Indeed, but APICs make them redundant.  I recall ACPI has defined 
additional "board" timers as well, hasn't it?

> As I understand it both Windows XP and Linux x86 still require some of
> these ports. There is also a range of ports that are needed _before_ the

 Adjusting software to get rid of these requirements should be pretty 
straightforward -- there are really very few these days.  In Linux that is 
-- I can't comment the others, but Intel has recommended against using the 
PITs or the PICs as implemented by the PC/AT standard for some ten years 
now and "the others" follow these guidelines more closely it would seem.  
In particular for a "legacy-free" box I can't see any problem with leaving 
the firmware upon bootstrap with the APIC mode already set up.  Perhaps 
even in the protected mode.

> PCI bus can be used in order to bootstrap the system, configure ram
> timings etc and in some cases adjust the caches.

 Well, that should normally be done using PCI configuration(!) space (it's 
been invented for that purpose after all) of host bridges.  Some tasks may 
require poking at I2C mapped somewhere, but the space for that device may 
be properly handled with BARs.  Or it can be system-specific and disabled 
after initial setup -- I've seen systems with a minimal I2C controller 
wired directly to the CPU bus and a full-blown one available in a south 
bridge with the former being able to be disabled once unneeded.

> >  That is what surprises me and what my whole consideration is about.  
> > It's just I don't see a need for such a setup anymore and for a system 
> > with no ISA or EISA bridge I'd expect all that legacy to be gone leaving 
> > us with no need to handle implicit resources.  But has any manufacturer 
> > produced such an i386 system yet?
> 
> Whats the _economic_ incentive to do so ? There basically isnt one.

 One chip less?  Well, perhaps the cost of R&D for such a system would 
exceed the total cost of keeping that chip included in all boards 
manufactured during the term corporate planning is able to cover....

  Maciej
