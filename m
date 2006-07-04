Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751233AbWGDJYC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751233AbWGDJYC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 05:24:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751250AbWGDJYC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 05:24:02 -0400
Received: from colin.muc.de ([193.149.48.1]:64271 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S1751233AbWGDJYA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 05:24:00 -0400
Date: 4 Jul 2006 11:23:58 +0200
Date: Tue, 4 Jul 2006 11:23:58 +0200
From: Andi Kleen <ak@muc.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Doug Thompson <norsk5@yahoo.com>, akpm@osdl.org,
       mm-commits@vger.kernel.org, norsk5@xmission.com,
       linux-kernel@vger.kernel.org
Subject: Re: + edac-new-opteron-athlon64-memory-controller-driver.patch added to -mm tree
Message-ID: <20060704092358.GA13805@muc.de>
References: <20060701150430.GA38488@muc.de> <20060703172633.50366.qmail@web50109.mail.yahoo.com> <20060703184836.GA46236@muc.de> <1151962114.16528.18.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1151962114.16528.18.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[moving to l-k - the discussion is how EDAC tries
to duplicate already existing interface including
a whole new duplicate polling machine check handler]

On Mon, Jul 03, 2006 at 10:28:34PM +0100, Alan Cox wrote:
> Ar Llu, 2006-07-03 am 20:48 +0200, ysgrifennodd Andi Kleen:
> > The only way to get the slot name <-> address mapping is 
> > to ask the BIOS.
> > 
> > I bet you hardcoded it for your systems right?
> 
> Why don't you read the code ? Wouldn't be hard to check now would it.

I'm pretty sure I'm right from the code, but I was asking for confirmation.

Ok hardcoding was perhaps the wrong word, but what they output
isn't useful to identify the broken DIMM if you don't have very detailed 
documentation of the motherboards which 99+% of all users don't.

> 
> > Can you describe in more detail why you think that's not the case?
> 
> I did that, you said "buzzwords" insulted me and deleted the argument
> then started this second discussion as if it never occurred. Not
> productive.

It was refering to Doug's assertation that the memory address
is not enough to identify the DIMM.

I bet it was only because they didn't use the SMBIOS information,
but again I was asking for confirmation.

Regarding your buzzwords: I don't think mcelog is in any way
less "manageable" or "consistent" than EDAC.


> > Hmm, i haven't checked, but my understanding was that the newer
> > Intel chipsets all forwarded the memory errors as machine 
> > check anyways.
> 
> Quite a few still in use do not. We also have no idea where the future

New ones?  Would surprise me.

Yes the machine check architecture doesn't try to handle all old systems,
but then in practice error reporting on old x86 systems doesn't tend
to work particularly well either.

> 
> > I also don't think it's very fortunate to put all the complicated
> > decoding code into kernel space. It works just fine in user space.
> > Can you explain what value add it gives over machine checks in
> > modern systems?
> 
> See my original email, it provides consistency and means that we have
> the same interface for different setups. That is very important just
> like not having "reiser4_open()" "ext3_open" and the like is.

mce code also uses a consistent interface - it's even the same
code in kernel space for all systems.


> It's also zero cost to people who don't chose to use the EDAC interface.
> The alternative is that every single monitoring and hardware management
> tool for Linux has to have its own set of glue interfaces for all the
> different processor and chip specific details.

At least for machine checks the mce interface is a single interface.

We don't have a generic interface for logging some of the other errors
(like PCI-E errors), but I don't see EDAC solving that. In some ways
it's understandable because there is no generic PCI-E error handling
code at all yet.

> 
> > > Sorry about that. I saved your email, but at that time got overwhelmed
> > > in other matters and just recently got back into EDAC. I apologize for
> > > not responding sooner.
> > 
> > Well you wasted a lot of time then redoing what's already done.
> 
> The ecc code predates the MCE bits by years. The re-doing occurred
> rather earlier. Rather more useful would be to get the common interface

Earlier than the x86-64 machine check code?

> provided by things like EDAC provided by the fairly CPU specific mce
> code for the newer chips with a clean interface between the two and the
> minimum of duplicated code.

You could convert the EDAC drivers to log pseudo events with mce_log() like Intel
thermal, AMD ecc threshold do. All the heavy decoding should be in user space
in mcelog.

Giving a consistent sysfs interface is a bit harder, but I suppose one 
could change the code to provide pseudo banks for enable/disable too.
However that would be system specific again, so a default "all on/all off" 
policy might be quite ok.

-Andi
