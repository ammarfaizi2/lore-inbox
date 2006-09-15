Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751517AbWIOOVK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751517AbWIOOVK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 10:21:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751519AbWIOOVK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 10:21:10 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:51132 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751516AbWIOOVI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 10:21:08 -0400
Subject: Re: [PATCH] piix: Use refcounted interface when searching for a
	450NX
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <450AB54F.5000905@ru.mvista.com>
References: <1158329678.29932.41.camel@localhost.localdomain>
	 <450AB54F.5000905@ru.mvista.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 15 Sep 2006 15:44:37 +0100
Message-Id: <1158331477.29932.69.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-09-15 am 18:14 +0400, ysgrifennodd Sergei Shtylyov:
> > -	while((pdev=pci_find_device(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82454NX, pdev))!=NULL)
> > +	while((pdev=pci_get_device(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82454NX, pdev))!=NULL)
> >  	{
> >  		/* Look for 450NX PXB. Check for problem configurations
> >  		   A PCI quirk checks bit 6 already */
> 
>     Shouldn't pci_put_dev() be called after the bridge device no longer needed?
> I assume it's not needed anymore after this function is finished...

pci_get_device gets called repeatedly to walk each device. Each call
drops the reference to the previous device (the one passed in).


