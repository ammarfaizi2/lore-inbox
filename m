Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263258AbVFXLwy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263258AbVFXLwy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 07:52:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263259AbVFXLwy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 07:52:54 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:44045 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S263258AbVFXLwk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 07:52:40 -0400
Date: Fri, 24 Jun 2005 12:52:10 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: IDE - sensible probing for PCI systems
In-Reply-To: <1119566026.18655.30.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.61L.0506241217490.28452@blysk.ds.pg.gda.pl>
References: <1119356601.3279.118.camel@localhost.localdomain> 
 <Pine.LNX.4.61L.0506211422190.9446@blysk.ds.pg.gda.pl> 
 <1119363150.3325.151.camel@localhost.localdomain> 
 <Pine.LNX.4.61L.0506211535100.17779@blysk.ds.pg.gda.pl> 
 <1119379587.3325.182.camel@localhost.localdomain> 
 <Pine.LNX.4.61L.0506231903170.31113@blysk.ds.pg.gda.pl>
 <1119566026.18655.30.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jun 2005, Alan Cox wrote:

> >  Besides, does a modern i386 really require them?  DOS compatibility is no 
> > longer an issue for commodity hardware and the ISA bridge is gone.
> 
> Untrue on both counts

 I really mean *commodity* -- I haven't seen a single DOS installation for 
a few years now.  For specialized uses special hardware can be used.  
Add-on boards with a PCI-ISA bridge and ISA slots do also exist for this 
very reason; well, I have even seen USB-ISA "bridges".

> > Apparently the only legacy device still not replaced by anything else is 
> > the RTC, which is rather surprising as there seems to be a lot of 
> > reasonable alternatives for I2C available these days and i386 boxes have 
> > had I2C for quite a while now.
> 
> DMA controller, floppy controller, keyboard, serial, mouse, parallel,
> some video ports, random other objects on the lpc bus, miscellaneous
> motherboard gunge.

 Well, keyboard and mouse are USB these days, serial and parallel are PCI, 
floppies are not used anymore and the ISA DMA controller would only be 
needed for them.  Video?  I've thought ISA implementations are gone -- 
what is all that AGP/PCI-E noise about then?  And no more ISA slots 
either.

 Other objects?  Do you mean the pre-i486 FPU error or the A20 line 
latches?  They are not really needed either, are they?  There's some NMI 
logic, though, which hasn't been moved elsewhere, indeed.  I think it 
really belongs to the PCI configuration space somewhere -- probably I/O 
APICs or host bridges.

 Of course if a manufacturer wants to put all the legacy in their system, 
it's their choice, but there is no need anymore.

> >  Both IDE and video are distinct PCI devices these days, so there is no 
> > need for them to hide their decoded address ranges.  I've thought that has 
> > been sorted out.
> 
> We still support older machines that are pre PCI even. Most PC systems

 Certainly we do and we will do for the forseeable future.

> also have ranges of non-PCI decoded space that appears in no PCI bar.

 That is what surprises me and what my whole consideration is about.  
It's just I don't see a need for such a setup anymore and for a system 
with no ISA or EISA bridge I'd expect all that legacy to be gone leaving 
us with no need to handle implicit resources.  But has any manufacturer 
produced such an i386 system yet?

  Maciej
