Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261800AbVFPTmm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261800AbVFPTmm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 15:42:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261802AbVFPTmm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 15:42:42 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:10246 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S261800AbVFPTmi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 15:42:38 -0400
Date: Thu, 16 Jun 2005 20:42:47 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Russ Anderson <rja@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Linux memory error handling
In-Reply-To: <200506152209.j5FM9HgD1464876@clink.americas.sgi.com>
Message-ID: <Pine.LNX.4.61L.0506161233560.9172@blysk.ds.pg.gda.pl>
References: <200506152209.j5FM9HgD1464876@clink.americas.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jun 2005, Russ Anderson wrote:

> >  This is highly undesirable if the same interrupt is used for MBEs.  A 
> > page that causes an excessive number of SBEs should rather be removed from 
> > the available pool instead.
> 
> As a practical point I think you are right that if there are enough 
> SBEs to cause a performance hit, migrating the data to a different 
> physical page would be a prudent thing to do.  But that functionality
> hasn't been implemented yet.

 There's another point actually -- if a memory location (here meaning a 
single entity covered by ECC; usually a 32-bit word or a 64-bit 
doubleword) is causing SBEs excessively, then a bit there probably 
somewhat less reliable due to wear, damage, etc.  But the normal memory 
error statistics apply to other bits at that location as usually, so now 
the probability of an MBE is greater.  So you'd better keep your data 
away.

> That may not always be the right setting for all customers.
> One possible way to deal with that would be to have different
> threshold settings for logging and page migration.  That would
> provide flexibility.

 Certainly.

> >                              Logging should probably take recent events 
> > into account anyway and take care of not overloading the system, e.g. by 
> > keeping only statistical data instead of detailed information about each 
> > event under load.
> 
> That's what the SBE thresholding does.  It avoids overloading the
> system by switching from interrupt mode to periodic polling
> mode, where detailed information can get dropped.

 But as I mentioned you have to be careful not to switch the MBE interrupt 
off as a side effect.  Actually the overhead for handling the interrupt 
shouldn't be that high, unless the error triggers in the handler itself.

> >  Note we have some infrastructure for that in the MIPS port -- we kill the 
> > triggering process, but we don't mark the problematic memory page as 
> > unusable (which is an area for improvement). 
> 
> Mips has some nice features when it comes to error recovery.

 Starting with synchronous reporting when possible. :-)

  Maciej
