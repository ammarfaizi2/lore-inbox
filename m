Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261522AbVBNTGo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261522AbVBNTGo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 14:06:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261430AbVBNTGo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 14:06:44 -0500
Received: from mail.kroah.org ([69.55.234.183]:58852 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261522AbVBNTGl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 14:06:41 -0500
Date: Mon, 14 Feb 2005 11:06:19 -0800
From: Greg KH <greg@kroah.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: avoiding pci_disable_device()...
Message-ID: <20050214190619.GA9241@kroah.com>
References: <4210021F.7060401@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4210021F.7060401@pobox.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 13, 2005 at 08:42:55PM -0500, Jeff Garzik wrote:
> 
> Currently, in almost every PCI driver, if pci_request_regions() fails -- 
> indicating another driver is using the hardware -- then 
> pci_disable_device() is called on the error path, disabling a device 
> that another driver is using
> 
> To call this "rather rude" is an understatement :)
> 
> Fortunately, the ugliness is mitigated in large part by the PCI layer 
> helping to make sure that no two drivers bind to the same PCI device. 
> Thus, in the vast majority of cases, pci_request_regions() -should- be 
> guaranteed to succeed.
> 
> However, there are oddball cases like mixed PCI/ISA devices (hello IDE) 
> or cases where a driver refers a pci_dev other than the primary, where 
> pci_request_regions() and request_regions() still matter.

But this is a very small subset of pci devices, correct?

> As a result, I have committed the attached patch to libata-2.6.  In many 
> cases, it is a "semantic fix", addressing the case
> 
> 	* pci_request_regions() indicates hardware is in use
> 	* we rudely disable the in-use hardware
> 
> that would not occur in practice.
> 
> But better safe than sorry.  Code cuts cut-n-pasted all over the place.
> 
> I'm hoping one or two things will happen now:
> * janitors fix up the other PCI drivers along these lines
> * improve the PCI API so that pci_request_regions() is axiomatic

Do you have any suggestions for how to do this?

thanks,

greg k-h
