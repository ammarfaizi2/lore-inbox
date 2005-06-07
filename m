Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262015AbVFGWZe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262015AbVFGWZe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 18:25:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262016AbVFGWZd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 18:25:33 -0400
Received: from fmr17.intel.com ([134.134.136.16]:42959 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S262015AbVFGWZZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 18:25:25 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [RFC PATCH] PCI: remove access to pci_[enable|disable]_msi() for drivers
Date: Tue, 7 Jun 2005 15:24:30 -0700
Message-ID: <C7AB9DA4D0B1F344BF2489FA165E502408D8D0C1@orsmsx404.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC PATCH] PCI: remove access to pci_[enable|disable]_msi() for drivers
Thread-Index: AcVrIAXzJzssGj+5Qx2zM/qkdqj+SQAjKe8w
From: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
To: "Greg KH" <gregkh@suse.de>, "Andrew Vasquez" <andrew.vasquez@qlogic.com>
Cc: "Jeff Garzik" <jgarzik@pobox.com>, "David S. Miller" <davem@davemloft.net>,
       <roland@topspin.com>, <linux-pci@atrey.karlin.mff.cuni.cz>,
       <linux-kernel@vger.kernel.org>, <ak@suse.de>,
       "Nguyen, Tom L" <tom.l.nguyen@intel.com>
X-OriginalArrivalTime: 07 Jun 2005 22:24:32.0027 (UTC) FILETIME=[AD43AEB0:01C56BAF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Monday, June 06, 2005 10:16 PM Greg KH wrote:
> On Mon, Jun 06, 2005 at 06:09:11PM -0700, Andrew Vasquez wrote:
> > * What if the driver writer does not want MSI enabled for their
> >   hardware (even though there is an MSI capabilities entry)?
Reasons
> >   include: overhead involved in initiating the MSI; no support in
some
> >   versions of firmware (QLogic hardware).

> Yes, a very good point.  I guess I should keep the pci_enable_msi()
and
> pci_disable_msi() functions exported for this reason.

That is one of the reason we like to have a driver to call explicitly
either pci_enable_msi() or pci_enable_msix() since its device may
support either or both MSI capability structure and MSI-X capability
structure. Once either MSI or MSI-X is enabled, the existing code does
not allow a driver to switch back and forth between MSI and MSI-X.

In addition, if you plan to enable MSI by default, then new function
pci_in_msi_mode is redundant because pci_enable_msi() always returns
zero if MSI was already enabled on a device. In this case, a driver must
use MSI, not MSI-X. As a result, I still prefer to have a driver to
explicitly call pci_enable_msi().

Thanks,
Long
