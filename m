Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261514AbTIKVOq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 17:14:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261535AbTIKVOq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 17:14:46 -0400
Received: from lidskialf.net ([62.3.233.115]:26599 "EHLO beyond.lidskialf.net")
	by vger.kernel.org with ESMTP id S261514AbTIKVOp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 17:14:45 -0400
From: Andrew de Quincey <adq_dvb@lidskialf.net>
To: jbarnes@sgi.com (Jesse Barnes)
Subject: Re: [PATCH] deal with lack of acpi prt entries gracefully
Date: Thu, 11 Sep 2003 22:13:13 +0100
User-Agent: KMail/1.5.3
Cc: andrew.grover@intel.com, linux-kernel@vger.kernel.org
References: <20030909201310.GB6949@sgi.com> <200309112140.08967.adq_dvb@lidskialf.net> <20030911205310.GA26569@sgi.com>
In-Reply-To: <20030911205310.GA26569@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309112213.13263.adq_dvb@lidskialf.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 11 Sep 2003 9:53 pm, Jesse Barnes wrote:
> On Thu, Sep 11, 2003 at 09:40:08PM +0100, Andrew de Quincey wrote:
> > On Wednesday 10 Sep 2003 10:38 pm, Jesse Barnes wrote:
> > > On Wed, Sep 10, 2003 at 10:30:29PM +0100, Andrew de Quincey wrote:
> > > > So, exactly as your patch did, you just want it to drop back if there
> > > > were no PCI routing entries found by ACPI... sounds sensible enough.
> > > >
> > > > Can you confirm I have this right?
> > >
> > > Yep, that's it.  The code should do that, but we get there before the
> > > list has been initialized, so we just hang.
> >
> > I'm not sure if this is automatically fixed or not yet.
> >
> > With the new patch:
> >
> > 1) If ACPI fails to parse a table, it disables ACPI, and so disables any
> > attempt to use ACPI for PRT routing.
>
> That might work, though I'll be using the ACPI namespace to drive PCI
> discovery soon (hacking the PROM now).  Maybe I should add some MADT and
> _PRT entries while I'm at it?  The problem is that we don't support
> IOAPIC or IOSAPIC interrupt models/hw registers.

Which base architecture do you use? x86 and x86_64 ACPI now both support PIC 
based interrupt models.. as thats the only other option AFAIK (It tries 
IOAPIC first, then if that fails, it drops back to trying PIC mode).

> > 2) If ACPI is enabled, and enters the function you patched, code further
> > in checks if the routing tables have any entries. If not, it rejects the
> > attempt.
>
> That would work I guess.

Cool, well if it doesn't work, at least we know exactly what to fix.

