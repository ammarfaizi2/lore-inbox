Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268750AbUJTRNa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268750AbUJTRNa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 13:13:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268701AbUJTRIy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 13:08:54 -0400
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:39860 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S268565AbUJTRHA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 13:07:00 -0400
From: David Brownell <david-b@pacbell.net>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: [ACPI] RE: PATCH/RFC: driver model/pmcore wakeup hooks (1/4)
Date: Wed, 20 Oct 2004 10:02:57 -0700
User-Agent: KMail/1.6.2
Cc: acpi-devel@lists.sourceforge.net, "Li, Shaohua" <shaohua.li@intel.com>,
       "Brown, Len" <len.brown@intel.com>, "Pavel Machek" <pavel@ucw.cz>,
       <linux-kernel@vger.kernel.org>
References: <16A54BF5D6E14E4D916CE26C9AD3057559A042@pdsmsx402.ccr.corp.intel.com> <200410192251.14740.dtor_core@ameritech.net>
In-Reply-To: <200410192251.14740.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410201002.58172.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 19 October 2004 20:51, Dmitry Torokhov wrote:
> On Tuesday 19 October 2004 04:11 am, Li, Shaohua wrote:
> > A final solution is device core adds an ACPI layer. That is we can link
> > ACPI device and physical device. This way, the PCI device can know which
> > ACPI is linked with it, so the PCI API can use specific ACPI method. 

The driver model core has platform_notify hooks for device add/remove,
and ACPI should kick in that way ... they might well need tweaks though.


> > You are right, we currently haven't a method to reach the goal. To match
> > a physical device and ACPI device, we need to know the ACPI device's
> > _ADR and bus.
> > I have a toy to link the PCI device and ACPI device, and some PCI
> > function can use _SxD method and _PSx method to get some information for
> > suspend/resume.
> > 
> 
> The only caveat is that PCI core should not depend on ACPI because it is not
> available on all platforms, not all world is x86.

RIght!  Maybe something like:

	int pci_enable_wake(pci_dev, on_or_off) {
		...
		if (dev->platform_data)
			platform_enable_wake(dev, on_or_off)
		...
	}

That'd call an acpi_enable_wake().  I guess OpenBoot would
do its thing, and embedded boards could do all kinds of stuff.

- Dave
