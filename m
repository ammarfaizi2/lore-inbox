Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262643AbVFWSWL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262643AbVFWSWL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 14:22:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262647AbVFWSWL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 14:22:11 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:8203 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S262643AbVFWSWD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 14:22:03 -0400
Date: Thu, 23 Jun 2005 19:22:08 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: IDE - sensible probing for PCI systems
In-Reply-To: <1119379587.3325.182.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.61L.0506231903170.31113@blysk.ds.pg.gda.pl>
References: <1119356601.3279.118.camel@localhost.localdomain> 
 <Pine.LNX.4.61L.0506211422190.9446@blysk.ds.pg.gda.pl> 
 <1119363150.3325.151.camel@localhost.localdomain> 
 <Pine.LNX.4.61L.0506211535100.17779@blysk.ds.pg.gda.pl>
 <1119379587.3325.182.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jun 2005, Alan Cox wrote:

> >  How is the range defined -- is there a way for us to find it?  I'd assume 
> > in the absence of a PCI-ISA or PCI-EISA bridge all I/O port addresses 
> > belong to PCI.  Otherwise the usual rule of "(addr & 0x300) == 0" applies.  
> > Perhaps with the addition of "(addr & ~0xff) != 0" for safety as junk I/O 
> > is often not recorded properly in BARs, sigh...
> 
> No the low addresses belong to the chipset and motherboard. There is

 Well, that doesn't mean they can't be properly reported in a BAR.  

 Besides, does a modern i386 really require them?  DOS compatibility is no 
longer an issue for commodity hardware and the ISA bridge is gone.  
Apparently the only legacy device still not replaced by anything else is 
the RTC, which is rather surprising as there seems to be a lot of 
reasonable alternatives for I2C available these days and i386 boxes have 
had I2C for quite a while now.

> also magic then for video and IDE legacy port ranges. I suspect your

 Both IDE and video are distinct PCI devices these days, so there is no 
need for them to hide their decoded address ranges.  I've thought that has 
been sorted out.

> mips boxen might be a lot cleaner than the PC world.

 They are certainly cleaner, but if a lot, it depends on whether an (E)ISA 
bridge is there somewhere or not.  E.g. some PCI-ISA bridges positively 
decode some memory address ranges unconditionally which results in the 
corresponding range of RAM being unreachable from PCI.  And if there is no 
(E)ISA bridge, there may still be traces of legacy, like P2P bridges with 
an implicit special treatment of certain address ranges that traditionally 
used to be used for ISA.  Or APIC interrupt codes in messages sent over 
HT.

  Maciej
