Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262983AbUKUANS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262983AbUKUANS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 19:13:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261651AbUKUALh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 19:11:37 -0500
Received: from gate.crashing.org ([63.228.1.57]:59290 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263195AbUKUAHh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 19:07:37 -0500
Subject: Re: [PATCH 1/2] pci: Block config access during BIST
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Brian King <brking@us.ibm.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Greg KH <greg@kroah.com>,
       Paul Mackerras <paulus@samba.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <419FD58A.3010309@us.ibm.com>
References: <200411192023.iAJKNNSt004374@d03av02.boulder.ibm.com>
	 <1100917635.9398.12.camel@localhost.localdomain>
	 <1100934567.3669.12.camel@gaston>
	 <1100954543.11822.8.camel@localhost.localdomain>
	 <419FD58A.3010309@us.ibm.com>
Content-Type: text/plain
Date: Sun, 21 Nov 2004 11:06:56 +1100
Message-Id: <1100995616.27157.44.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-11-20 at 17:38 -0600, Brian King wrote:
> Alan Cox wrote:
> > Some of the Intel CPU's are very bad at lock handling so it is an issue.
> > Also most PCI config accesses nowdays go to onboard devices whose
> > behaviour may well be quite different to PCI anyway. PCI has become a
> > device management API.
> 
> Does this following patch address your issues with this patch, Alan?
> 
> It still doesn't address Greg's issue about making this apply to the
> pci_bus_* functions as well, but I'm not sure of a good way to do that
> due to the reasons given earlier.

Looks good to me, I don't sure we actually have to deal with pci_bus_*
functions, do we ? When are they called ?

> +void pci_block_config_access(struct pci_dev *dev)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&pci_lock, flags);
> +	dev->block_cfg_access = 1;
> +	spin_unlock_irqrestore(&pci_lock, flags);
> +}

Shouldn't we save the config space here ?

Ben.


