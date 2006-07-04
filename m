Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932193AbWGDJwt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932193AbWGDJwt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 05:52:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932191AbWGDJwt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 05:52:49 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:14276 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932183AbWGDJws
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 05:52:48 -0400
Subject: Re: + edac-new-opteron-athlon64-memory-controller-driver.patch
	added to -mm tree
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andi Kleen <ak@muc.de>
Cc: Doug Thompson <norsk5@yahoo.com>, akpm@osdl.org,
       mm-commits@vger.kernel.org, norsk5@xmission.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060704092358.GA13805@muc.de>
References: <20060701150430.GA38488@muc.de>
	 <20060703172633.50366.qmail@web50109.mail.yahoo.com>
	 <20060703184836.GA46236@muc.de>
	 <1151962114.16528.18.camel@localhost.localdomain>
	 <20060704092358.GA13805@muc.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 04 Jul 2006 11:09:47 +0100
Message-Id: <1152007787.28597.20.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Maw, 2006-07-04 am 11:23 +0200, ysgrifennodd Andi Kleen:
> Regarding your buzzwords: I don't think mcelog is in any way
> less "manageable" or "consistent" than EDAC.

Its chip specific rather than generalised so you need awareness of it.

> > > Hmm, i haven't checked, but my understanding was that the newer
> > > Intel chipsets all forwarded the memory errors as machine 
> > > check anyways.
> > 
> > Quite a few still in use do not. We also have no idea where the future
> 
> New ones?  Would surprise me.

All the world is not x86. 

> Yes the machine check architecture doesn't try to handle all old systems,
> but then in practice error reporting on old x86 systems doesn't tend
> to work particularly well either.

Its pretty solid on the AMD 32bit chipsets and some of the older Intel
ones. 

> mce code also uses a consistent interface - it's even the same
> code in kernel space for all systems.

For the subset of cases it supports.

> We don't have a generic interface for logging some of the other errors
> (like PCI-E errors), but I don't see EDAC solving that. In some ways
> it's understandable because there is no generic PCI-E error handling
> code at all yet.

EDAC solves that for the PCI bus side. It's only solving the logging
side not the "ok it exploded, now what" question - although there are
some unrelated IBM patches in that area.

> > The ecc code predates the MCE bits by years. The re-doing occurred
> > rather earlier. Rather more useful would be to get the common interface
> 
> Earlier than the x86-64 machine check code?

Linux 1.2 I believe, certainly by 2.0

> Giving a consistent sysfs interface is a bit harder, but I suppose one 
> could change the code to provide pseudo banks for enable/disable too.
> However that would be system specific again, so a default "all on/all off" 
> policy might be quite ok.

I think we need the basic consistent sysfs case. Whether that is
provided by the mcelog code in the AMD64 case, or by an exported hook
from the MCE interfaces for AMD64 or duplicating the code in EDAC isn't
so important (avoiding duplication aside of course).


Alan

