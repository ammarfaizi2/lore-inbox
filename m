Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262308AbVAJQKT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262308AbVAJQKT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 11:10:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262310AbVAJQKT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 11:10:19 -0500
Received: from one.firstfloor.org ([213.235.205.2]:53951 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S262308AbVAJQKO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 11:10:14 -0500
To: brking@us.ibm.com
Cc: paulus@samba.org, benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] pci: Block config access during BIST (resend)
References: <200501101449.j0AEnWYF020850@d03av01.boulder.ibm.com>
From: Andi Kleen <ak@muc.de>
Date: Mon, 10 Jan 2005 17:10:12 +0100
In-Reply-To: <200501101449.j0AEnWYF020850@d03av01.boulder.ibm.com> (brking@us.ibm.com's
 message of "Mon, 10 Jan 2005 08:49:31 -0600")
Message-ID: <m14qhpxo2j.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

brking@us.ibm.com writes:

> Some PCI adapters (eg. ipr scsi adapters) have an exposure today in that 
> they issue BIST to the adapter to reset the card. If, during the time
> it takes to complete BIST, userspace attempts to access PCI config space, 
> the host bus bridge will master abort the access since the ipr adapter 
> does not respond on the PCI bus for a brief period of time when running BIST. 
> On PPC64 hardware, this master abort results in the host PCI bridge
> isolating that PCI device from the rest of the system, making the device
> unusable until Linux is rebooted. This patch is an attempt to close that
> exposure by introducing some blocking code in the PCI code. When blocked,
> writes will be humored and reads will return the cached value. Ben
> Herrenschmidt has also mentioned that he plans to use this in PPC power
> management.

I think it would be better to do this check higher level in the driver.
IMHO pci_*_config should stay lean and fast low level functions without
such baggage. 

-Andi
