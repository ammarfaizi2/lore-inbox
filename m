Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422869AbWBASkx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422869AbWBASkx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 13:40:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422870AbWBASkx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 13:40:53 -0500
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:57796 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP
	id S1422869AbWBASkv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 13:40:51 -0500
X-ORBL: [67.117.73.34]
Date: Wed, 1 Feb 2006 10:40:38 -0800
From: Tony Lindgren <tony@atomide.com>
To: Erik Slagter <erik@slagter.name>
Cc: "Brown, Len" <len.brown@intel.com>, Andrew Morton <akpm@osdl.org>,
       Joerg Sommrey <jo@sommrey.de>, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org, arjan@infradead.org
Subject: Re: [PATCH] amd76x_pm: C3 powersaving for AMD K7
Message-ID: <20060201184038.GC15939@atomide.com>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005E907CA@hdsmsx401.amr.corp.intel.com> <1138817928.4449.49.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1138817928.4449.49.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Erik Slagter <erik@slagter.name> [060201 10:18]:
> On Wed, 2006-02-01 at 13:11 -0500, Brown, Len wrote:
> >  >>  This patch can also be found at
> > >>  http://www.sommrey.de/amd76x_pm/amd76x_pm-2.6.15-4.patch
> > >> 
> > >>  In this version more locking was added to make sure all or 
> > >>  no CPU enter C3 mode.
> > >> 
> > >>  Signed-off-by: Joerg Sommrey <jo@sommrey.de>
> > >
> > >Thanks.  I'll merge this into -mm and shall plague the ACPI 
> > >guys with it. 
> > >They have said discouraging things about board-specific drivers in the
> > >past.  We shall see.
> > 
> > Linux/ACPI has had generic supported SMP deep (> C1) C-states
> > for a few months now and AFAIK it is working fine.
> > Why is a platform specific driver needed for these boards?
> 
> Boards with this chipset tend to have some timing in the DSDT wrong
> which prevents ACPI te actually use the C2/C3 states. It seems that
> C2/C3 can only be used on amd76x boards with some extra setup code.
> Maybe it would be an idea to merge both pieces of code as much as
> possible?

Yes, in amd76x case it's just to enable the C states. Then at least
Fujitsu Lifebook p2120 needs patching of a register to stay in C2 
and C3 sleep, otherwise it just wakes up right away. These are just
some random machines I've been using, so there's probably quite a
few machines that could use some fixups.

What would be nice would be some hooks in ACPI to scan the north and
south bridges based on some fixup list during init, and then do the
necessary fixups would be nice. And then ACPI C states would just
work!

Regards,

Tony
