Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264610AbUFVQzr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264610AbUFVQzr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 12:55:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264936AbUFVPZ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 11:25:29 -0400
Received: from fmr05.intel.com ([134.134.136.6]:63626 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S264610AbUFVPYL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 11:24:11 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Question on using MSI in PCI driver
Date: Tue, 22 Jun 2004 08:24:02 -0700
Message-ID: <C7AB9DA4D0B1F344BF2489FA165E5024057E4E7B@orsmsx404.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Question on using MSI in PCI driver
Thread-Index: AcRX/8S8uEtvj2GhQsKg9uZYdCf8QQAbFc8g
From: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
To: "Roland Dreier" <roland@topspin.com>, <linux-kernel@vger.kernel.org>
Cc: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
X-OriginalArrivalTime: 22 Jun 2004 15:24:03.0342 (UTC) FILETIME=[F3375AE0:01C4586C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, June 21, 2004 Roland Dreier wrote:

> The problem is that if I follow the standard route in my driver and
> call pci_request_regions() during init (since I want to claim my whole
> device), the request_mem_region in msix_capability_init will fail.
> Now, for my device, the MSI-X table happens to fall in the middle of a
> BAR, and I need to access stuff on both sides of it in that BAR.  To
> make things even worse for me, my device has two more BARs I want to
claim.
>
> So it seems I am forced to turn my nice clean pci_request_regions()
> call into two calls to request_mem_region() (to get the beginning and
> end of the BAR with the MSI-X table in it) and two more calls to
> pci_request_region() (to get the other two BARs).
>

The PCI 3.0 specification has implementation notes that MMIO address
space for a device's MSI-X structure should be isolated so that the 
software system can set different page for controlling accesses to 
the MSI-X structure. The implementation of MSI patch requires the PCI
subsystem, not a device driver, to maintain full control of the MSI-X
table/MSI-X PBA and MMIO address space of the MSI-X table/MSI-X PBA. 
A device driver is prohibited from requesting the MMIO address space 
of the MSI-X table/MSI-X PBA. Otherwise, the PCI subsystem will fail 
enabling MSI-X on its hardware device when it calls the function 
pci_enable_msi(). 

Thanks,
Long
