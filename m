Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261897AbVFJAPs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261897AbVFJAPs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 20:15:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261973AbVFJAPr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 20:15:47 -0400
Received: from fmr17.intel.com ([134.134.136.16]:40600 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S261897AbVFJAPj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 20:15:39 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [Penance PATCH] PCI: clean up the MSI code a bit
Date: Thu, 9 Jun 2005 17:12:55 -0700
Message-ID: <C7AB9DA4D0B1F344BF2489FA165E502408DF0142@orsmsx404.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Penance PATCH] PCI: clean up the MSI code a bit
Thread-Index: AcVtTVD4a1OBTzx1RDqbUurvdOG14gAAg4hQ
From: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
To: "Stefan Smietanowski" <stesmi@stesmi.com>, "Andi Kleen" <ak@suse.de>
Cc: "Greg KH" <gregkh@suse.de>, "Grant Grundler" <grundler@parisc-linux.org>,
       <linux-pci@atrey.karlin.mff.cuni.cz>, <linux-kernel@vger.kernel.org>,
       "Roland Dreier" <roland@topspin.com>,
       "Arjan van de Ven" <arjan@infradead.org>,
       "Andrew Vasquez" <andrew.vasquez@qlogic.com>,
       "Jeff Garzik" <jgarzik@pobox.com>,
       "David S. Miller" <davem@davemloft.net>
X-OriginalArrivalTime: 10 Jun 2005 00:12:57.0330 (UTC) FILETIME=[278DA520:01C56D51]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, June 09, 2005 4:49 PM Stefan Smietanowski wrote:
> pci_enable_msix(dev)
> {
>  if (is_dev_msi(dev))
>    pci_disable_msi(dev);
>  else if (is_dev_msix(dev))
>    return(ALREADY_MSIX);
>  else
>    return(MSIX_NOT_AVAILABLE);
>  if (!__pci_enable_msix(dev))
>    pci_enable_msi(dev);
>}
>
>That way noone needs to explicitly turn off msi as it's done
>automatically instead and the device will after this call
>always be in either MSIX, MSI or NORMAL IRQ mode, and
>always in the "best" mode the device, motherboard, bios, NB,
>whatever combination is available.

Your logic does not work because existing MSI/MSI-X code does not allow
a driver to switch back and forth between MSI mode and MSI-X mode. A
driver can switch interrupt mode between NORMAL IRQ mode and MSI mode or
between NORMAL IRQ mode and MSI-X mode but NOT between MSI mode and
MSI-X mode. A device driver should know well which MSI mode or MSI-X
mode it wants to run when its device supports both MSI and MSI-X
capability structures. Please read MSI-HOWTO before any attempt. If you
like to continue this path, then think of a better policy of how to
manage vector sources for MSI and MSI-X allocation before making
changes.

Thanks,
Long
