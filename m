Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261196AbULJNLp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261196AbULJNLp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 08:11:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261199AbULJNLp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 08:11:45 -0500
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:63755 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S261196AbULJNLn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 08:11:43 -0500
Date: Fri, 10 Dec 2004 13:11:17 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "Maciej W. Rozycki" <macro@mips.com>, Greg KH <greg@kroah.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Chris Dearman <chris@mips.com>
Subject: Re: [PATCH] Don't touch BARs of host bridges
In-Reply-To: <1102653999.22763.22.camel@gaston>
Message-ID: <Pine.LNX.4.58L.0412100448490.30913@blysk.ds.pg.gda.pl>
References: <Pine.LNX.4.61.0412092349560.6535@perivale.mips.com>
 <1102653999.22763.22.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Dec 2004, Benjamin Herrenschmidt wrote:

> >  BARs of host bridges often have special meaning and AFAIK are best left 
> > to be setup by the firmware or system-specific startup code and kept 
> > intact by the generic resource handler.  For example a couple of host 
> > bridges used for MIPS processors interpret BARs as target-mode decoders 
> > for accessing host memory by PCI masters (which is quite reasonable).  
> 
> Not very reasonable in fact imho but that happens on some embedded PPCs

 Well, some of these bridges may be used for peripheral devices (option
cards) built around a CPU, typically after reprogramming the class code to
something corresponding to their actual function.  Why should the address
decoder circuitry suddenly change in this case?

 Also even in the "host mode" another device may wish to examine what
resources have been reserved by the host bridge (unlikely, I admit, but 
in principle why not?).

> was well :) So I agree, that would be useful to skip them. I'm not sure
> about PCI_CLASS_NOT_DEFINED tho ...

 These are pre-2.0 PCI devices -- from before the detailed classification
was agreed upon.  AFAIK, just a couple of them exist -- I can name:  
Intel's 82424 and 82425 families of i486 host bridges, their 82375 family
of PCI-EISA bridges and their 82378/9 family of PCI-ISA bridges (also used
in a few DEC Alpha systems).  There are probably a handful of other chips,
all of them about ten years old.  Our i386 and ppc resource managers skip
over them as well and I suppose this is a safe default.  If any of them
needs BAR setup (none of these Intel ones), it can be added explicitly by
means of its vendor:device ID.

  Maciej
