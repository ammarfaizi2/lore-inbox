Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262035AbVCATgn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262035AbVCATgn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 14:36:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262036AbVCATgi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 14:36:38 -0500
Received: from fire.osdl.org ([65.172.181.4]:18359 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262035AbVCATg0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 14:36:26 -0500
Date: Tue, 1 Mar 2005 11:37:33 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Linas Vepstas <linas@austin.ibm.com>
cc: Matthew Wilcox <matthew@wil.cx>,
       Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-ia64@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       "Luck, Tony" <tony.luck@intel.com>
Subject: Re: [PATCH/RFC] I/O-check interface for driver's error handling
In-Reply-To: <20050301192711.GE1220@austin.ibm.com>
Message-ID: <Pine.LNX.4.58.0503011134470.25732@ppc970.osdl.org>
References: <422428EC.3090905@jp.fujitsu.com> <20050301144211.GI28741@parcelfarce.linux.theplanet.co.uk>
 <20050301192711.GE1220@austin.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 1 Mar 2005, Linas Vepstas wrote:
> 
> > > - Additionally adds special token - abstract "iocookie" structure
> > >   to control/identifies/manage I/Os, by passing it to OS.
> > >   Actual type of "iocookie" could be arch-specific. Device drivers
> > >   could use the iocookie structure without knowing its detail.
> > 
> > Fine.
> 
> Do we really need a cookie?

I think you do.

That pair might have to disable interrupts (if there are any issues about
concurrent accesses through a shared error bus). In that case, the cooke 
might be the old "flags" value.

> > But many drivers don't need to save/restore interrupts around IO accesses.
> > I think defaulting these to disable and restore interrupts is a very bad idea.
> > They should probably be no-ops in the generic case.
> 
> Yes, they should be no-ops. save/resotre interrupts would be a bad idea.

But they may be part of that the architecture wants to do (imagine a 
spinlock protecting a sub-segment of a bus - you need to disable 
interrupts to avoid deadlocks).

		Linus
