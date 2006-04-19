Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750984AbWDSRk1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750984AbWDSRk1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 13:40:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751005AbWDSRk1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 13:40:27 -0400
Received: from fmr20.intel.com ([134.134.136.19]:62377 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750984AbWDSRk0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 13:40:26 -0400
Date: Wed, 19 Apr 2006 10:36:34 -0700
From: Patrick Mochel <mochel@linux.intel.com>
To: "Moore, Robert" <robert.moore@intel.com>
Cc: "Accardi, Kristen C" <kristen.c.accardi@intel.com>,
       Prarit Bhargava <prarit@sgi.com>, Andrew Morton <akpm@osdl.org>,
       "Brown, Len" <len.brown@intel.com>, greg@kroah.com,
       linux-acpi@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, arjan@linux.intel.com,
       muneda.takahiro@jp.fujitsu.com, pavel@ucw.cz, temnota@kmv.ru
Subject: Re: [patch 1/3] acpi: dock driver
Message-ID: <20060419173634.GB14304@linux.intel.com>
References: <B28E9812BAF6E2498B7EC5C427F293A4200AD4@orsmsx415.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B28E9812BAF6E2498B7EC5C427F293A4200AD4@orsmsx415.amr.corp.intel.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2006 at 10:14:46AM -0700, Moore, Robert wrote:
> This is something to think about before we rip out all the ACPI
> core-style debug stuff.

Not sure which part you're referring to, but maybe these: 

> > > > --- /dev/null
> > > > +++ 2.6-git-kca2/drivers/acpi/dock.c
> > > > @@ -0,0 +1,652 @@
> > >
> > > > +#define ACPI_DOCK_COMPONENT 0x10000000
> > > > +#define ACPI_DOCK_DRIVER_NAME "ACPI Dock Station Driver"
> > > > +#define _COMPONENT		ACPI_DOCK_COMPONENT
> > >
> > > These aren't necessary for code that is outside of the ACPI-CA.
> > 
> > Originally I did not include these, but it turns out if you wish to
> use
> > the ACPI_DEBUG macro, you need to have these things defined.  I did go
> > ahead and use this macro in a couple places, mainly because I felt
> that
> > even though this isn't strictly an acpi driver (using the acpi driver
> > model), it does live in drivers/acpi and perhaps people might expect
> to
> > be able to debug it the same way.


Some of us have already thought about it. :-) 

We have standard debugging macros that are used in many driver subsystems
defined in include/linux/device.h (dev_printk(), dev_dbg(), dev_err(), and
friends). The ACPI drivers are not very different than other Linux driver
subsystems (at a very basic level). They are very Linux-specific (not 
portable like the CA), and should be using Linux-specific constructs as
much as possible to match the rest of the kernel. This makes it much 
eaiser for people to understand exactly what those drivers are doing.. 


	Pat
