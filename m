Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263591AbTENSkA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 14:40:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263592AbTENSj7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 14:39:59 -0400
Received: from fmr05.intel.com ([134.134.136.6]:58087 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S263591AbTENSjS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 14:39:18 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: RFC Proposal to enable MSI support in Linux kernel
Date: Wed, 14 May 2003 11:51:59 -0700
Message-ID: <C7AB9DA4D0B1F344BF2489FA165E50241361E9@orsmsx404.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: RFC Proposal to enable MSI support in Linux kernel
Thread-Index: AcMaQFAPs4oMphdfTr6Xj6D7DCiQggACBI1A
From: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
To: "Greg KH" <greg@kroah.com>
Cc: <linux-kernel@vger.kernel.org>, "Saxena, Sunil" <sunil.saxena@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Carbonari, Steven" <steven.carbonari@intel.com>,
       "Sy, Dely L" <dely.l.sy@intel.com>
X-OriginalArrivalTime: 14 May 2003 18:52:00.0299 (UTC) FILETIME=[E6C327B0:01C31A49]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

I just learned that withdrawing email once it sent out never work. I posted it yesterday and wonder why it did not post. I then recalled and resend it; as a result, I learned a hard way. Please read the following responses to your questions:

Q: Hm, wierd indenting style, can you just follow Documentation/CodingStyle
and use tabs? 
A: Thank for your suggestion. We will look into the indenting style.

Q: Anyway, what code is supposed to use this function?  A PCI Hotplug
controller driver?  If so, do you have any patches to the current
drivers that show how it is used?
A: We have an engineer to work on PCI Hotplug controller, which calls the API remove_hotplug_vectors. Her name is Dely Sy. She is in the progress of posting her code.

Q: Also, why pass a void *?  That's usually forbidden in the kernel, and
since you are instantly casting it to a struct pci_dev *, why not just
use that? 
A: This is a very good suggestion. We will make change accordingly.

Thanks,
Tom

-----Original Message-----
From: Greg KH [mailto:greg@kroah.com]
Sent: Wednesday, May 14, 2003 10:45 AM
To: Nguyen, Tom L
Cc: linux-kernel@vger.kernel.org; Saxena, Sunil; Mallick, Asit K;
Nakajima, Jun; Carbonari, Steven
Subject: Re: RFC Proposal to enable MSI support in Linux kernel


Even though you are trying to withdraw this message (which is pointless
for something sent to a mailing list), I had a few small questions with
regards to PCI Hotplug devices:

> +/**
> + * msi_hp_free_vectors: reclaim all MSI previous assigned to this device
> + * argument: device pointer of type struct pci_dev 
> + *
> + * description: used during hotplug removed, from which device is
> hot-removed;

Oops, your patch wrapped, please try another email client, or change the
configuration options of your current one.

> + * PCI subsystem reclaims associated MSI to unused state, which may be used
> 
> + * later on.
> + **/ 
> +void remove_hotplug_vectors(void* dev_id)
> +{
> +     struct msi_desc_t *entry;
> +     struct pci_dev *dev = (struct pci_dev *)dev_id;
> +     int type;
> +     void *mask_entry_addr;
> +      unsigned int flags;

Hm, wierd indenting style, can you just follow Documentation/CodingStyle
and use tabs?

Anyway, what code is supposed to use this function?  A PCI Hotplug
controller driver?  If so, do you have any patches to the current
drivers that show how it is used?

Also, why pass a void *?  That's usually forbidden in the kernel, and
since you are instantly casting it to a struct pci_dev *, why not just
use that?

thanks,

greg k-h
