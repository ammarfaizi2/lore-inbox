Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264983AbTIIWSU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 18:18:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264918AbTIIWPX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 18:15:23 -0400
Received: from hermes.py.intel.com ([146.152.216.3]:64453 "EHLO
	hermes.py.intel.com") by vger.kernel.org with ESMTP id S264894AbTIIWO2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 18:14:28 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: MSI fix for buggy PCI/PCI-X hardware
Date: Tue, 9 Sep 2003 15:14:19 -0700
Message-ID: <7F740D512C7C1046AB53446D3720017304AF29@scsmsx402.sc.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: MSI fix for buggy PCI/PCI-X hardware
Thread-Index: AcN3Af2kPa+4pLmfRZ+ny4cs/G+UbwAGBVQQ
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: "Jeff Garzik" <jgarzik@pobox.com>,
       "long" <tlnguyen@snoqualmie.dp.intel.com>
Cc: <linux-kernel@vger.kernel.org>, <greg@kroah.com>,
       "Nguyen, Tom L" <tom.l.nguyen@intel.com>, <zwane@linuxpower.ca>
X-OriginalArrivalTime: 09 Sep 2003 22:14:20.0540 (UTC) FILETIME=[B7A76BC0:01C3771F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff, Hi.

How about the default behavior? I'm not a fan of disable_msi(), because
we need to update the driver as we find problems, and we cannot predict
which PCI/PCI-X devices in the world have such a problem, although we
know some will. The workaround in drivers/pci/quirk.c is much better,
compared to modifying the driver, but we still need to update the file
(and rebuild the kernel) as we find problems.

In my opinion, we might want to use drivers/pci/quirk.c to blacklist PCI
Express devices if any (hope not). For PCI/PCI-X devices, we might want
to enable MSI once verified for it. To that end we can also use
drivers/pci/quirk.c to whitelist them (or it's abuse?). That way we can
avoid situations like "it hangs, it does not get interrupts", "disable
ACPI, oh no, MSI".

Thanks,
Jun

> -----Original Message-----
> From: Jeff Garzik [mailto:jgarzik@pobox.com]
> Sent: Tuesday, September 09, 2003 11:41 AM
> To: long
> Cc: linux-kernel@vger.kernel.org; greg@kroah.com; Nakajima, Jun;
Nguyen,
> Tom L; zwane@linuxpower.ca
> Subject: Re: MSI fix for buggy PCI/PCI-X hardware
> 
> On Tue, Sep 09, 2003 at 08:39:37AM -0700, long wrote:
> > The proposed solution is to provide a new API, named "int
> > disable_msi(struct pci_dev *dev)", to allow IHV's who have
> > shipped PCI/PCI-X hardware that does not work in MSI mode to update
> > their software drivers to request the kernel to switch the
> > interrupt mode from MSI mode back to IRQ pin-assertion mode.
> 
> No need for a new API.  We have drivers/pci/quirk.c where we add PCI
> devices with known bugs.  If there is commonality of the bugs across
> hardware, we can easily add a common "quirk" which fixes the
situation.
> 
> Individual drivers shouldn't need to bother with this, really.
> 
> As an aside, if you need to blacklist certain _systems_ rather than
> certain PCI devices, you should either modify drivers/pci/quirks.c or
> arch/i386/kernel/dmi_scan.c.
> 
> 	Jeff
> 
> 

