Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261537AbUKOHHi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261537AbUKOHHi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 02:07:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261539AbUKOHHi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 02:07:38 -0500
Received: from mms3.broadcom.com ([63.70.210.38]:12551 "EHLO mms3.broadcom.com")
	by vger.kernel.org with ESMTP id S261537AbUKOHHY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 02:07:24 -0500
X-Server-Uuid: 062D48FB-9769-4139-967C-478C67B5F9C9
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: [PATCH] pci-mmconfig fix for 2.6.9
Date: Sun, 14 Nov 2004 23:07:13 -0800
Message-ID: <B1508D50A0692F42B217C22C02D849720312DED5@NT-IRVA-0741.brcm.ad.broadcom.com>
Thread-Topic: [PATCH] pci-mmconfig fix for 2.6.9
Thread-Index: AcTK2HWxfKA0BgdSQi2vqMZEkf5hnwABXNwX
From: "Michael Chan" <mchan@broadcom.com>
To: "Grant Grundler" <grundler@parisc-linux.org>, "Andi Kleen" <ak@suse.de>
cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       akpm@osdl.org, greg@kroah.com,
       "Durairaj, Sundarapandian" <sundarapandian.durairaj@intel.com>
X-WSS-ID: 6D868A281TG3124110-01-01
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grant Grundler wrote:
 
> There are two tests in arch/i386/pci/mmconfig.c:pci_mmcfg_init() before
> the raw_pci_ops is set to &pci_mmcfg. Perhaps some additional crude tests
> could select a different set of pci_raw_ops to deal with posted writes
> to mmconfig space. Someone more familiar with those chipsets might
> find a more elegant solution.

Do you mean something like pci_mmcfg1 for Intel chipsets that implement non-posted mmconfig and pci_mmcfg2 for other chipsets that may implement posted mmconfig? pci_mmcfg2's write method will guarantee that the write has reached the target before returning. If pci_mmcfg2's write method uses read from the target to flush the write, we are back to the original problem of out-of-spec read when writing the PMCSR register. If the flush does not require reading from the target device, then it's fine.
 
Michael


 

