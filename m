Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261527AbVBNTN3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261527AbVBNTN3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 14:13:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261528AbVBNTN3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 14:13:29 -0500
Received: from [81.2.110.250] ([81.2.110.250]:14547 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S261527AbVBNTN0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 14:13:26 -0500
Subject: Re: avoiding pci_disable_device()...
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Greg KH <greg@kroah.com>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20050214190619.GA9241@kroah.com>
References: <4210021F.7060401@pobox.com>  <20050214190619.GA9241@kroah.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1108404478.23141.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 14 Feb 2005 18:08:01 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I'm hoping one or two things will happen now:
> > * janitors fix up the other PCI drivers along these lines
> > * improve the PCI API so that pci_request_regions() is axiomatic
> 
> Do you have any suggestions for how to do this?

One would be to keep an "enabler" count.

If the device is enabled at boot then set it to one (video, legacy IDE
etc) and it never gets back to zero. Otherwise set it to zero and it
goes up and down with the last [ab]user clearing it to zero and turning
it off. That also deals with the "who disables" question for power
mismanagement where the same problem occurs

Alan

