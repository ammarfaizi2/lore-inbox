Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262196AbULMCrM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262196AbULMCrM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 21:47:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262197AbULMCrM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 21:47:12 -0500
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:55301 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S262196AbULMCq5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 21:46:57 -0500
Date: Mon, 13 Dec 2004 02:46:51 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "Maciej W. Rozycki" <macro@mips.com>, Greg KH <greg@kroah.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Chris Dearman <chris@mips.com>
Subject: Re: [PATCH] Don't touch BARs of host bridges
In-Reply-To: <1102713904.5237.3.camel@gaston>
Message-ID: <Pine.LNX.4.58L.0412120528411.27824@blysk.ds.pg.gda.pl>
References: <Pine.LNX.4.61.0412092349560.6535@perivale.mips.com> 
 <1102653999.22763.22.camel@gaston>  <Pine.LNX.4.58L.0412100448490.30913@blysk.ds.pg.gda.pl>
 <1102713904.5237.3.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Dec 2004, Benjamin Herrenschmidt wrote:

> >  Well, some of these bridges may be used for peripheral devices (option
> > cards) built around a CPU, typically after reprogramming the class code to
> > something corresponding to their actual function.  Why should the address
> > decoder circuitry suddenly change in this case?
> 
> To stay in the PCI spec ? :) They would need at least a way to "lock"
> the BARs.

 What do you mean?  If used in an option card, you may want some of the
device's internal address space to be accessible from your host somehow,
e.g. as a way of interfacing the device's firmware, so you need a BAR to
map it somewhere in the PCI address space.

> >  These are pre-2.0 PCI devices -- from before the detailed classification
> > was agreed upon.  AFAIK, just a couple of them exist -- I can name:  
> > Intel's 82424 and 82425 families of i486 host bridges, their 82375 family
> > of PCI-EISA bridges and their 82378/9 family of PCI-ISA bridges (also used
> > in a few DEC Alpha systems).  There are probably a handful of other chips,
> > all of them about ten years old.  Our i386 and ppc resource managers skip
> > over them as well and I suppose this is a safe default.  If any of them
> > needs BAR setup (none of these Intel ones), it can be added explicitly by
> > means of its vendor:device ID.
> 
> Ok.

 And BTW, we fix it up for the 82375 as a quirk, by substituting the
"right" class code.  It can be done for others if there's a need.

  Maciej
