Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262389AbUCHFDL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 00:03:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262390AbUCHFDL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 00:03:11 -0500
Received: from fmr02.intel.com ([192.55.52.25]:56768 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id S262389AbUCHFDJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 00:03:09 -0500
Subject: Re: Hyper-threaded pickle
From: Len Brown <len.brown@intel.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <4049F0EE.7060501@pobox.com>
References: <40480795.5000402@pobox.com>
	 <1078469072.12990.1742.camel@dhcppc4>  <4049F0EE.7060501@pobox.com>
Content-Type: text/plain
Organization: 
Message-Id: <1078722131.2336.39.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 08 Mar 2004 00:02:11 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Re: old systems -- we use dmi_scan to disable ACPI on systems by default
> > on systems older than 1/1/2001.
> 
> What happens for the no-DMI case?

When DMI is not present, dmi_scan is a no-op -- so ACPI will run in
whatever default the system is set to -- eg. "off" for FC1, and "on" for
FC2-test1.

We've found in practice that dmi_scan has been pretty effective at
identifying the set of systems new enough to have an ACPI enabled BIOS
but old enough that the ACPI implementation is hopeless.  Though we've
had many reports of 1/1/2001 being a bit *too* conservative -- disabling
ACPI on systems where ACPI works fine.  Indeed, there is a bugzilla
requesting a "white-list" to enable exceptions to this date.  I'm not
enthusiastic about that plan, however.  I figure there are more 3-year
old boxes that have been running Linux w/o ACPI than there are those
which have; and I'd rather spend my ergs on the current and upcoming
boxes where vendors are more willing to update a broken BIOS...

> > Re: opteron & !HT.  Andi showed me a patch today that disables X86_HT if
> > you build specifically for an AMD CPU that doesn't support HT.  This
> > looks like a good idea, and possibly should be expanded.
> 
> Cool.
> 
> My main worry/concern is breaking older systems, due to this change in 
> behavior.

2.4 and SuSE have deployed this way for some time.  The HT part of ACPI
was in RHL 8.0 and 9.0 by default as well -- and this is consistent with
that.

> An easy first step is to make CONFIG_X86_HT selectable again.

That wouldn't help the most importaht case though -- the distro who
wants the same kernel binary to run on a broad variety of platforms.

-Len


