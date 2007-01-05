Return-Path: <linux-kernel-owner+w=401wt.eu-S1750921AbXAEX6Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750921AbXAEX6Y (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 18:58:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750922AbXAEX6Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 18:58:24 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:50602 "EHLO
	pd2mo2so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750919AbXAEX6Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 18:58:24 -0500
Date: Fri, 05 Jan 2007 17:58:19 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: [PATCH] increment pos before looking for the next cap in
 __pci_find_next_ht_cap
In-reply-to: <fa.HKQ/+MClSV6hJeIdmFjKhgngCZQ@ifi.uio.no>
To: Brice Goglin <brice@myri.com>, linux-kernel <linux-kernel@vger.kernel.org>
Cc: Greg KH <gregkh@suse.de>, Michael Ellerman <michael@ellerman.id.au>
Message-id: <459EE61B.2070408@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <fa.HKQ/+MClSV6hJeIdmFjKhgngCZQ@ifi.uio.no>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brice Goglin wrote:
> Hi,
> 
> While testing 2.6.20-rc3 on a machine with some CK804 chipsets, we
> noticed that quirk_nvidia_ck804_msi_ht_cap() was not detecting HT
> MSI capabilities anymore. It is actually caused by the MSI mapping
> on the root chipset being the 2nd HT capability in the chain.
> pci_find_ht_capability() does not seem to find anything but the
> first HT cap correctly, because it forgets to increment the position
> before looking for the next cap. The following patch seems to fix it.
> 
> At least, this prooves that having a ttl is good idea since the
> machine would have been stucked in an infinite loop if we didn't
> have a ttl :)
> 
> The patch should go in 2.6.20 since this quirk was working fine in 2.6.19.

Yes, I saw this on my A8N-SLI Deluxe board as well. This is a regression 
since MSI is being disabled on the PCI Express slots when it wasn't before..

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

