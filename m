Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262431AbUDGJe4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 05:34:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262514AbUDGJe4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 05:34:56 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:25220 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S262431AbUDGJew (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 05:34:52 -0400
Date: Wed, 07 Apr 2004 18:34:48 +0900
From: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Subject: Re: [RFC] readX_check() - Interface for PCI-X error recovery
In-reply-to: <20040406115145.GA23258@parcelfarce.linux.theplanet.co.uk>
To: Matthew Wilcox <willy@debian.org>
Cc: Linux Kernel mailing list <linux-kernel@vger.kernel.org>,
       Linux IA64 Mailing List <linux-ia64@vger.kernel.org>,
       Hironobu Ishii <ishii.hironobu@jp.fujitsu.com>
Message-id: <0HVS005L4NY0JZ@fjmail505.fjmail.jp.fujitsu.com>
MIME-version: 1.0
X-Mailer: EdMax Ver2.85.5F
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7bit
References: <20040406115145.GA23258@parcelfarce.linux.theplanet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox <willy@debian.org> wrote:

> > 	list of recoverable physical address regions
> 
> Can't you just use the pci_dev->resource regions for this?

If there is a list separated usual one, driver can choice which region 
to check or not. However, in general, maybe almost all driver will regist 
all region it has.
Agree, I'll use the pci_dev->resource. This is a realistic approach.

> > 	pointer to host bridge of the device
> 
> Again, there's already ways of getting to this from the pci_dev.

I see, this wouldn't cost so much. I'll use.

> >     clear_pcix_errors(dev)
> 
> For consistency, how about naming these functions pci_clear_errors()
> and pci_check_errors()?  PCI-Express has similar error-checking abilities
> and I'd hate to see two extremely similar capabilities at war with each
> other over unacceoptable names ;-)

Sounds good. I think these naming are more better for peace porpose :-)

> >     readX_check(dev,vaddr)
> 
> I really don't think we want another readX variant.  Do we then also
> add readX_check_relaxed()?  Can't we just pretend the MCA is asynchronous
> on ia64?  I'm sure we'd get better performance.

On ia64, readX_check() will be used to make sure that there has no MCA before 
read_pcix_errors(). I think we could use original plain readX() in place of 
readX_check() if we ignore checking accuracy or if the driver takes care to 
all loaded data. But I don't know how about this on other architecture.

I think inside of readX_check() would be mostly arch specified codes.


Thanks,

H.Seto

