Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261865AbUKMQXH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261865AbUKMQXH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Nov 2004 11:23:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261866AbUKMQXH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Nov 2004 11:23:07 -0500
Received: from mms1.broadcom.com ([63.70.210.58]:33543 "EHLO mms1.broadcom.com")
	by vger.kernel.org with ESMTP id S261865AbUKMQXE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Nov 2004 11:23:04 -0500
X-Server-Uuid: 97B92932-364A-4474-92D6-5CFE9C59AD14
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: [PATCH] pci-mmconfig fix for 2.6.9
Date: Sat, 13 Nov 2004 08:22:50 -0800
Message-ID: <B1508D50A0692F42B217C22C02D849720312DED3@NT-IRVA-0741.brcm.ad.broadcom.com>
Thread-Topic: [PATCH] pci-mmconfig fix for 2.6.9
Thread-Index: AcTJYoiRrHvKGpDcQT2x19xNECHOTgAOBPwZ
From: "Michael Chan" <mchan@broadcom.com>
To: "Andi Kleen" <ak@suse.de>
cc: "Grant Grundler" <grundler@parisc-linux.org>, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, akpm@osdl.org, greg@kroah.com,
       "Durairaj, Sundarapandian" <sundarapandian.durairaj@intel.com>
X-WSS-ID: 6D88EB510ZG121190-01-01
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If I got the discussion so far correctly then the PCI-SGI spec does not
> guarantee that there is no posting, but you know that the chipset
> you are using right now doesn't do it.

Yes, that's my understanding of the spec. Grant Grundler does not agree and thinks that non-posting is the only compliant implementation. I wish he was right as it would be the easiest to deal with. We contacted Intel about the out-of-spec readl when writing to the PMCSR to change power state as they were the original author of the mmconfig code. Their solution was to remove the readl after confirming that mmconfig was non-posted on their chipsets.

> The problem with the explanation is that there will be very soon
> chipsets not from Intel that also implement PCI-Express. And also
> even systems with non Intel CPUs that also do PCI-Express and
> mmconfig.

I agree with you. Having the readl would be the safest and the most conservative approach. But it is out-of-spec to have a readl immediately following writel to the PMCSR when power state is changed. So should we have a relaxed version of pci_write_config_* with no flushing read for programming the PMCSR?
 
Michael


