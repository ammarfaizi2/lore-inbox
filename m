Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750855AbWFQGbg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750855AbWFQGbg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jun 2006 02:31:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751086AbWFQGbg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jun 2006 02:31:36 -0400
Received: from cantor2.suse.de ([195.135.220.15]:28854 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750855AbWFQGbf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jun 2006 02:31:35 -0400
Date: Fri, 16 Jun 2006 23:28:40 -0700
From: Greg KH <greg@kroah.com>
To: Brice Goglin <brice@myri.com>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Whitelist chipsets supporting MSI and check Hyper-transport capabilities
Message-ID: <20060617062840.GD31645@kroah.com>
References: <4493709A.7050603@myri.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4493709A.7050603@myri.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2006 at 11:01:46PM -0400, Brice Goglin wrote:
> Several chipsets are known to not support MSI. Some support MSI but
> disable it by default. Thus, several drivers implement their own way to
> detect whether MSI works.
> 
> We introduce whitelisting of chipsets that are known to support MSI and
> keep the existing backlisting to disable MSI for other chipsets. When it
> is unknown whether the root chipset support MSI or not, we disable MSI
> by default except if pci=forcemsi was passed.
> 
> Whitelisting is done by setting a new PCI_BUS_FLAGS_MSI in the chipset
> subordinate bus. pci_enable_msi() thus starts by checking whether the
> root chipset of the device has the MSI or NOMSI flag set.

Whitelisting looks all well and good today, and maybe for the rest of
the year.  But what about 3 years from now when everyone has shaken all
of the MSI bugs out of their chipsets finally?  Do you really want to
add a new quirk for _every_ new chipset that comes out?  I don't think
that it is managable over the long run.

I do like your checks to see if MSI is able to be enabled or not, and
maybe we can just invert them to mark those chips that do not support
MSI today?

> I do not split this patch in multiple pieces since it is still small
> and this is just a RFC. I will split it for the actual submission.

Please do, you are doing a lot of different things in here.

thanks,

greg k-h
