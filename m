Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932267AbWDRShz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932267AbWDRShz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 14:37:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932270AbWDRShz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 14:37:55 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:7857 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932267AbWDRShy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 14:37:54 -0400
Message-ID: <444531F8.3040109@garzik.org>
Date: Tue, 18 Apr 2006 14:37:44 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Stephen Hemminger <shemminger@osdl.org>
CC: Greg KH <greg@kroah.com>, Andi Kleen <ak@suse.de>,
       linux-pci@atrey.karlin.mff.cuni.cz, acurrid@nvidia.com,
       amartin@nvidia.com, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: MSI failure on Nvidia nForce
References: <20060418111944.6ed0505e@localhost.localdomain>
In-Reply-To: <20060418111944.6ed0505e@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.0 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.0 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Hemminger wrote:
> I got a report of sky2 driver irq test failing on x86_64 using
> the following configuration.  Is this a known problem?
> Should workaround be done at PCI layer?
> 
> What the driver does is setup MSI handler, then do a software generated
> IRQ and check that it was received (similar to tg3).  If IRQ test fails
> it falls back to INTx.

Please describe precisely -how- it fails.

pci_enable_msi() does not fail properly on systems that do not support 
MSI.  This is a major unresolved problem that is preventing MSI 
deployment, and causing every driver writer to include a does-MSI-work 
test in their driver.

We need to find a good generic test, or if that fails, adopt an 
ACPI-like rule:  whitelist systems with working MSI before $X date, and 
blacklist systems with broken MSI after $X date.

	Jeff


