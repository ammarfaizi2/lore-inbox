Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265751AbTIJVck (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 17:32:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265767AbTIJVck
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 17:32:40 -0400
Received: from modemcable137.219-201-24.mtl.mc.videotron.ca ([24.201.219.137]:40066
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S265751AbTIJVcU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 17:32:20 -0400
Date: Wed, 10 Sep 2003 17:31:54 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Jeff Garzik <jgarzik@pobox.com>
cc: "Nakajima, Jun" <jun.nakajima@intel.com>,
       long <tlnguyen@snoqualmie.dp.intel.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Greg Kroah-Hartmann <greg@kroah.com>,
       "Nguyen, Tom L" <tom.l.nguyen@intel.com>
Subject: Re: MSI fix for buggy PCI/PCI-X hardware
In-Reply-To: <3F5E59AB.60500@pobox.com>
Message-ID: <Pine.LNX.4.53.0309101251390.9323@montezuma.fsmlabs.com>
References: <7F740D512C7C1046AB53446D3720017304AF29@scsmsx402.sc.intel.com>
 <3F5E59AB.60500@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Sep 2003, Jeff Garzik wrote:

> 5) Another option is to enable MSI only for devices which call 
> request_msi().  This idea follows the current model of 
> pci_enable_device():  PCI resources and interrupts are guaranteed to be 
> assigned and set up only after a successful call to pci_enable_device(). 
>   Then, later on, the driver will call request_irq(), which will unmask 
> the irq (if it's not already shared).  Continuing this model, a driver's 
> call to request_msi() would signal that MSI is to be enabled for that 
> device....  and ensure that the PCI core does not unconditionally enable 
> MSI for any device outside of request_msi() call.

Jun, i'm of the opinion that we can't be doing this in the kernel. The 
bugs are device specific so putting blacklists in the core kernel 
code sounds a bit wrong. What i would prefer is if this is done on a driver 
level via a flag (e.g. say it's a buggy batch upto a given pci revision). 
I don't believe we'd be "violating" the PCI 3.0 mandate if we only check 
revisions when making a decision on driving a device via the irq line or 
msi. So i'm actually agreeing with the request_msi/request_irq pair and 
using that as the interface a driver writer uses to enable the respective 
modes. I know it's kind of cheating and normally the communication path 
when doing this query should be the kernel informing the driver of 
capability and the driver working with the specified mode. But driver 
informing the kernel of specific preferred mode for a device should save 
some headaches. Workable?

Btw have there been some updates? I want to have another look.

Thanks,
	Zwane
