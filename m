Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262138AbVCPAFr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262138AbVCPAFr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 19:05:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262179AbVCPADQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 19:03:16 -0500
Received: from fmr17.intel.com ([134.134.136.16]:56753 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S262138AbVCOX7Z convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 18:59:25 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH 1/6] PCI Express Advanced Error Reporting Driver
Date: Tue, 15 Mar 2005 15:59:19 -0800
Message-ID: <C7AB9DA4D0B1F344BF2489FA165E5024080A54C1@orsmsx404.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 1/6] PCI Express Advanced Error Reporting Driver
Thread-Index: AcUpsXkYsTADRnVXQ/u3LlNFNBQSjgACGiqw
From: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
To: "Linas Vepstas" <linas@austin.ibm.com>,
       "long" <tlnguyen@snoqualmie.dp.intel.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-pci@atrey.karlin.mff.cuni.cz>,
       <greg@kroah.com>, "Nguyen, Tom L" <tom.l.nguyen@intel.com>
X-OriginalArrivalTime: 15 Mar 2005 23:59:20.0744 (UTC) FILETIME=[014E0280:01C529BB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tuesday, March 15, 2005 2:51 PM Linas Vepstas wrote:
>> +void hw_aer_unregister(void)
>> +{
>> +	struct pci_dev *dev = (struct pci_dev*)host->dev;
>> +	unsigned short id;
>> +
>> +	id = (dev->bus->number << 8) | dev->devfn;
>> +	
>> +	/* Unregister with AER Root driver */
>> +	pcie_aer_unregister(id);
>> +}
>
>I don't understand how this can work on a system with 
>more than one domain.  On any midrange/high-end system, 
>you'll have a number of devices with identical values
>for (bus->number << 8) | devfn)

Good catch! I forgot to encounter multiple segments. However, based on
LKML inputs for a common interface in the pci_driver data structure, it
appears that pcie_aer_register and pcie_aer_unregister are no longer
required.

Thanks,
Long
