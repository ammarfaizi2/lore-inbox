Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261667AbUKSWsK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261667AbUKSWsK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 17:48:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261669AbUKSWqc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 17:46:32 -0500
Received: from gate.crashing.org ([63.228.1.57]:16271 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261672AbUKSWpa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 17:45:30 -0500
Subject: Re: [PATCH 1/2] pci: Block config access during BIST
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Greg KH <greg@kroah.com>
Cc: brking@us.ibm.com, Paul Mackerras <paulus@samba.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20041119213232.GB13259@kroah.com>
References: <200411192023.iAJKNNSt004374@d03av02.boulder.ibm.com>
	 <20041119213232.GB13259@kroah.com>
Content-Type: text/plain
Date: Sat, 20 Nov 2004 09:45:09 +1100
Message-Id: <1100904309.3855.49.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-11-19 at 13:32 -0800, Greg KH wrote:
> On Fri, Nov 19, 2004 at 02:23:22PM -0600, brking@us.ibm.com wrote:
> > -static inline int pci_read_config_byte(struct pci_dev *dev, int where, u8 *val)
> > -{
> > -	return pci_bus_read_config_byte (dev->bus, dev->devfn, where, val);
> > -}
> 
> Well, as much as I despise this patch, you should at least get it
> correct :)
> 
> You need to block the pci_bus_* functions too, otherwise the parts of
> the kernel that use them will stomp all over your device, right?

The real issue is how to do the BIST write in fact once locked ... An
option would be to have an "atomic" write BIST & lock device, which
would do the whole operation with the spinlock.

I agree with Greg, the blocking should be done in the bus functions in
drivers/pci/access.c, and the helper that does the BIST thing should use
the low level callback directly within the lock.

Ben.

