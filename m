Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265298AbTFFEhW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 00:37:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265299AbTFFEhV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 00:37:21 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:21471 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265298AbTFFEhV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 00:37:21 -0400
Message-ID: <3EE01DA0.5080808@pobox.com>
Date: Fri, 06 Jun 2003 00:50:40 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: greg@kroah.com
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: move pci_present() into drivers/pci/search.c
References: <200306052322.h55NMmEg019146@hera.kernel.org>
In-Reply-To: <200306052322.h55NMmEg019146@hera.kernel.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux Kernel Mailing List wrote:
> ChangeSet 1.1317, 2003/06/05 12:04:33-07:00, greg@kroah.com
> 
> 	[PATCH] PCI: move pci_present() into drivers/pci/search.c
> 	
> 	This will let not have to export the pci_devices variable.


pci_present() should be killed.  It's left over from 2.0 or 1.2 days, 
and has no meaning anymore.

The old-kernel use was to determine if a PCI bus.  Drivers had to check 
if a PCI bus was present, before probing for a PCI device using the 
old-old find-by-slot-and-busid method of PCI bus probing.  As the 
now-old method of PCI bus probing (pci_find_device) and the current PCI 
API both provide correct behavior when no PCI bus is present, 
pci_present() itself no longer has any meaning and is entirely redundant.

At the very least, we should use the gcc "deprecated" attribute on 
pci_present definitions, both normal and no-op.

IMO pci_present should go before 2.6.0...  it's lived long enough.

	Jeff



