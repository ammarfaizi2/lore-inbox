Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261550AbTIKUxR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 16:53:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261551AbTIKUxR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 16:53:17 -0400
Received: from zok.SGI.COM ([204.94.215.101]:6539 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S261550AbTIKUxO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 16:53:14 -0400
Date: Thu, 11 Sep 2003 13:53:10 -0700
To: Andrew de Quincey <adq_dvb@lidskialf.net>
Cc: andrew.grover@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] deal with lack of acpi prt entries gracefully
Message-ID: <20030911205310.GA26569@sgi.com>
Mail-Followup-To: Andrew de Quincey <adq_dvb@lidskialf.net>,
	andrew.grover@intel.com, linux-kernel@vger.kernel.org
References: <20030909201310.GB6949@sgi.com> <200309102230.29794.adq_dvb@lidskialf.net> <20030910213821.GA17356@sgi.com> <200309112140.08967.adq_dvb@lidskialf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309112140.08967.adq_dvb@lidskialf.net>
User-Agent: Mutt/1.5.4i
From: jbarnes@sgi.com (Jesse Barnes)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 11, 2003 at 09:40:08PM +0100, Andrew de Quincey wrote:
> On Wednesday 10 Sep 2003 10:38 pm, Jesse Barnes wrote:
> > On Wed, Sep 10, 2003 at 10:30:29PM +0100, Andrew de Quincey wrote:
> > > So, exactly as your patch did, you just want it to drop back if there
> > > were no PCI routing entries found by ACPI... sounds sensible enough.
> > >
> > > Can you confirm I have this right?
> >
> > Yep, that's it.  The code should do that, but we get there before the
> > list has been initialized, so we just hang.
> 
> I'm not sure if this is automatically fixed or not yet.
> 
> With the new patch:
> 
> 1) If ACPI fails to parse a table, it disables ACPI, and so disables any 
> attempt to use ACPI for PRT routing.

That might work, though I'll be using the ACPI namespace to drive PCI
discovery soon (hacking the PROM now).  Maybe I should add some MADT and
_PRT entries while I'm at it?  The problem is that we don't support
IOAPIC or IOSAPIC interrupt models/hw registers.

> 2) If ACPI is enabled, and enters the function you patched, code further in 
> checks if the routing tables have any entries. If not, it rejects the 
> attempt.

That would work I guess.

> From your patch, I get the impression (1) is what you were patching for.. am I 
> right? In that case, there shouldn't be a problem.

We also use ACPI tables SLIT and SRAT for memory/proximity detection,
and fill in the proper FADT fields.

Thanks,
Jesse
