Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751302AbWDNWm4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751302AbWDNWm4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 18:42:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751297AbWDNWm4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 18:42:56 -0400
Received: from mga03.intel.com ([143.182.124.21]:32871 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751302AbWDNWmy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 18:42:54 -0400
X-IronPort-AV: i="4.04,121,1144047600"; 
   d="scan'208"; a="23385457:sNHT27336232"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [patch 1/3] acpi: dock driver
Date: Fri, 14 Apr 2006 18:42:49 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB6300EE2@hdsmsx411.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch 1/3] acpi: dock driver
Thread-Index: AcZgDeJEhNYAxa5bQCyoowmHcxvwMQAAkQBA
From: "Brown, Len" <len.brown@intel.com>
To: "Accardi, Kristen C" <kristen.c.accardi@intel.com>,
       "Andrew Morton" <akpm@osdl.org>
Cc: <greg@kroah.com>, <linux-acpi@vger.kernel.org>,
       <pcihpd-discuss@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
       <mochel@linux.intel.com>, <arjan@linux.intel.com>,
       <muneda.takahiro@jp.fujitsu.com>, <pavel@ucw.cz>, <temnota@kmv.ru>
X-OriginalArrivalTime: 14 Apr 2006 22:42:51.0381 (UTC) FILETIME=[C3000A50:01C66014]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
Re: indenting & white-space

Please run the whole thing through the latest Lindent.
It will delete the white space.
It will do a couple of stupid things with indenting --
such as with MODULE_AUTHOR --
feel free to hand tweak those by hand.

Re: acpi_os_free()
Please call kfree() instead, that wrapper is intended
just for the ACPICA core and although it appears symmetric,
it really shouldn't be used outside drivers/acpi/*/*.c

Re: ACPI_FUNCTION_TRACE()/return_VALUE()
Don't feel compelled to include these idioms unless
you think they will really be useful.

Re: ACPI_FAILURE()
just use printk(KERN_whatever_level_you_like "...") here.

Re: ACPI_DEBUG_PRINT()
note that these appear only with CONFIG_ACPI_DEBUG
(along with tracing).  So if you want it to go away
in the production kernel, this is okay.  but if you want
it to ship in the production kernel, use printk().


> > +config ACPI_DOCK
> > +	tristate "Dock"
> > +	default y
> > +	help
> > +	  This driver adds support for ACPI controlled docking stations
> 
> It doesn't depend upon anything else?

What happens if the acpi_ibm driver's docking support is enabled at the
same time.
Perhaps that should depend on not this?

-Len
