Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261176AbVFHNbV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261176AbVFHNbV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 09:31:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261202AbVFHNbV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 09:31:21 -0400
Received: from mail.suse.de ([195.135.220.2]:55757 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261176AbVFHNbT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 09:31:19 -0400
Date: Wed, 8 Jun 2005 15:31:09 +0200
From: Andi Kleen <ak@suse.de>
To: Greg KH <gregkh@suse.de>
Cc: Jeff Garzik <jgarzik@pobox.com>, "David S. Miller" <davem@davemloft.net>,
       tom.l.nguyen@intel.com, roland@topspin.com,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       ak@suse.de
Subject: Re: [RFC PATCH] PCI: remove access to pci_[enable|disable]_msi() for drivers - take 2
Message-ID: <20050608133109.GQ23831@wotan.suse.de>
References: <20050607002045.GA12849@suse.de> <20050607202129.GB18039@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050607202129.GB18039@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2005 at 01:21:29PM -0700, Greg KH wrote:
> Hm, here's an updated patch that should have fixed the errors I had in
> my previous one where I wasn't disabling MSI for the devices that did
> not want it enabled (note, my patch skips the hotplug and pcie driver
> for now, those would have to be fixed if this patch goes on.)
> 
> However, now that I've messed around with the MSI-X logic in the IB
> driver, I'm thinking that this whole thing is just pointless, and I
> should just drop it and we should stick with the current way of enabling
> MSI only if the driver wants it.  If you look at the logic in the mthca
> driver you'll see what I mean.

The problem is then that we have to go through all drivers and
add the ugly logic there. Isnt it better to do it by default?

> Oh, and in looking at the drivers/pci/msi.c file, it could use some
> cleanups to make it smaller and a bit less complex.  I've also seen some
> complaints that it is very arch specific (x86 based).  But as no other
> arches seem to want to support MSI, I don't really see any need to split
> it up.  Any comments about this?

I think it would be better to have a clean split.

-Andi
