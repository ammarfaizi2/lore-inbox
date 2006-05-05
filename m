Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030335AbWEEFOR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030335AbWEEFOR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 01:14:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932469AbWEEFOR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 01:14:17 -0400
Received: from hqemgate02.nvidia.com ([216.228.112.143]:52780 "EHLO
	HQEMGATE02.nvidia.com") by vger.kernel.org with ESMTP
	id S932467AbWEEFOQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 01:14:16 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: pci_enable_msix throws up error
Date: Thu, 4 May 2006 22:14:09 -0700
Message-ID: <DBFABB80F7FD3143A911F9E6CFD477B00BA5E264@hqemmail02.nvidia.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: pci_enable_msix throws up error
Thread-Index: AcZv0L20V5tGWIESSc+462GPrAnCEgAMVbcg
From: "Ayaz Abdulla" <AAbdulla@nvidia.com>
To: <ravinandan.arakali@neterion.com>, <linux-kernel@vger.kernel.org>
Cc: "Ananda. Raju" <ananda.raju@neterion.com>, <netdev@vger.kernel.org>,
       "Leonid Grossman" <Leonid.Grossman@neterion.com>
X-OriginalArrivalTime: 05 May 2006 05:14:09.0448 (UTC) FILETIME=[BD47C280:01C67002]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed the same behaviour, i.e. can not use both MSI and MSIX without
rebooting.

I had sent a message to the maintainer of the MSI/MSIX source a few
months ago and got a response that they were working on fixing it. Not
sure what the progress is on it.

Ayaz

nvpublic
-----Original Message-----
From: netdev-owner@vger.kernel.org [mailto:netdev-owner@vger.kernel.org]
On Behalf Of Ravinandan Arakali
Sent: Thursday, May 04, 2006 4:16 PM
To: linux-kernel@vger.kernel.org
Cc: Ananda. Raju; netdev@vger.kernel.org; Leonid Grossman
Subject: pci_enable_msix throws up error


Hi,
I am seeing the following problem with MSI/MSI-X.

Note: I am copying netdev since other network drivers use
this feature and somebody on the list could throw light.

Our 10G network card(Xframe II) supports MSI and MSI-X.
When I load/unload the driver with MSI support followed
by an attempt to load with MSI-X, I get the following
message from pci_enable_msix:

"Can't enable MSI-X.  Device already has an MSI vector assigned"

I seem to be doing the correct things when unloading the
MSI driver. Basically, I do free_irq() followed by pci_disable_msi().
Any idea what I am missing ?

Further analysis:
Looking at the code, the following check(when it finds a match) in
msi_lookup_vector(called by pci_enable_msix) seems to throw up this
message:
if (!msi_desc[vector] || msi_desc[vector]->dev != dev ||
    msi_desc[vector]->msi_attrib.type != type ||
    msi_desc[vector]->msi_attrib.default_vector != dev->irq)

pci_enable_msi, on successful completion will populate the
fields in msi_desc. But neither pci_disable_msi nor free_irq
seems to undo/unpopulate the msi_desc table.
Could this be the cause for the problem ?

Thanks,
Ravi


-
To unsubscribe from this list: send the line "unsubscribe netdev" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
