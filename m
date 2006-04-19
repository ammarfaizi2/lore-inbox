Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751194AbWDSTSL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751194AbWDSTSL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 15:18:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbWDSTSK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 15:18:10 -0400
Received: from mga03.intel.com ([143.182.124.21]:37436 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751189AbWDSTSG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 15:18:06 -0400
X-IronPort-AV: i="4.04,136,1144047600"; 
   d="scan'208"; a="25145158:sNHT52056326"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [patch 1/3] acpi: dock driver
Date: Wed, 19 Apr 2006 12:17:49 -0700
Message-ID: <B28E9812BAF6E2498B7EC5C427F293A4200CB5@orsmsx415.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch 1/3] acpi: dock driver
Thread-Index: AcZj2FLq0fmpNPXRRBGbcaHkkKaOCQADFeUA
From: "Moore, Robert" <robert.moore@intel.com>
To: "Patrick Mochel" <mochel@linux.intel.com>
Cc: "Accardi, Kristen C" <kristen.c.accardi@intel.com>,
       "Prarit Bhargava" <prarit@sgi.com>, "Andrew Morton" <akpm@osdl.org>,
       "Brown, Len" <len.brown@intel.com>, <greg@kroah.com>,
       <linux-acpi@vger.kernel.org>, <pcihpd-discuss@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>, <arjan@linux.intel.com>,
       <muneda.takahiro@jp.fujitsu.com>, <pavel@ucw.cz>, <temnota@kmv.ru>
X-OriginalArrivalTime: 19 Apr 2006 19:17:50.0715 (UTC) FILETIME=[F34C1CB0:01C663E5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Whatever makes the most sense for the host OS.

I think the original linux/acpi drivers were developed and debugged at
the same time we were debugging the ACPICA core code, and it became very
convenient to use the ACPI tracing and debugging mechanism to grab
information about everything that was going on, ACPI-wise. This may or
may not be important today.

Also, there may come a time when we will decide to remove the tracing
mechanism in ACPICA. However, over the years, this mechanism has proven
very useful in finding problems. The execution trace is very helpful
because of the nature of the AML interpretation and internal state
changes.

Bob


> -----Original Message-----
> From: Patrick Mochel [mailto:mochel@linux.intel.com]
> Sent: Wednesday, April 19, 2006 10:37 AM
> To: Moore, Robert
> Cc: Accardi, Kristen C; Prarit Bhargava; Andrew Morton; Brown, Len;
> greg@kroah.com; linux-acpi@vger.kernel.org; pcihpd-
> discuss@lists.sourceforge.net; linux-kernel@vger.kernel.org;
> arjan@linux.intel.com; muneda.takahiro@jp.fujitsu.com; pavel@ucw.cz;
> temnota@kmv.ru
> Subject: Re: [patch 1/3] acpi: dock driver
> 
> On Wed, Apr 19, 2006 at 10:14:46AM -0700, Moore, Robert wrote:
> > This is something to think about before we rip out all the ACPI
> > core-style debug stuff.
> 
> Not sure which part you're referring to, but maybe these:
> 
> > > > > --- /dev/null
> > > > > +++ 2.6-git-kca2/drivers/acpi/dock.c
> > > > > @@ -0,0 +1,652 @@
> > > >
> > > > > +#define ACPI_DOCK_COMPONENT 0x10000000
> > > > > +#define ACPI_DOCK_DRIVER_NAME "ACPI Dock Station Driver"
> > > > > +#define _COMPONENT		ACPI_DOCK_COMPONENT
> > > >
> > > > These aren't necessary for code that is outside of the ACPI-CA.
> > >
> > > Originally I did not include these, but it turns out if you wish
to
> > use
> > > the ACPI_DEBUG macro, you need to have these things defined.  I
did go
> > > ahead and use this macro in a couple places, mainly because I felt
> > that
> > > even though this isn't strictly an acpi driver (using the acpi
driver
> > > model), it does live in drivers/acpi and perhaps people might
expect
> > to
> > > be able to debug it the same way.
> 
> 
> Some of us have already thought about it. :-)
> 
> We have standard debugging macros that are used in many driver
subsystems
> defined in include/linux/device.h (dev_printk(), dev_dbg(), dev_err(),
and
> friends). The ACPI drivers are not very different than other Linux
driver
> subsystems (at a very basic level). They are very Linux-specific (not
> portable like the CA), and should be using Linux-specific constructs
as
> much as possible to match the rest of the kernel. This makes it much
> eaiser for people to understand exactly what those drivers are doing..
> 
> 
> 	Pat
