Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262159AbVBAXBR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262159AbVBAXBR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 18:01:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262163AbVBAXBR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 18:01:17 -0500
Received: from gate.crashing.org ([63.228.1.57]:11702 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262159AbVBAXBG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 18:01:06 -0500
Subject: Re: [PATCH 1/1] pci: Block config access during BIST (resend)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Brian King <brking@us.ibm.com>, Greg KH <greg@kroah.com>,
       Andi Kleen <ak@muc.de>, Paul Mackerras <paulus@samba.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-pci@atrey.karlin.mff.cuni.cz
In-Reply-To: <20050201174758.GE10088@parcelfarce.linux.theplanet.co.uk>
References: <41ED27CD.7010207@us.ibm.com>
	 <1106161249.3341.9.camel@localhost.localdomain>
	 <41F7C6A1.9070102@us.ibm.com> <1106777405.5235.78.camel@gaston>
	 <1106841228.14787.23.camel@localhost.localdomain>
	 <41FA4DC2.4010305@us.ibm.com> <20050201072746.GA21236@kroah.com>
	 <41FF9C78.2040100@us.ibm.com>
	 <20050201154400.GC10088@parcelfarce.linux.theplanet.co.uk>
	 <41FFBDC9.2010206@us.ibm.com>
	 <20050201174758.GE10088@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Date: Wed, 02 Feb 2005 10:00:34 +1100
Message-Id: <1107298834.5624.15.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-02-01 at 17:47 +0000, Matthew Wilcox wrote:
> On Tue, Feb 01, 2005 at 11:35:05AM -0600, Brian King wrote:
> > >If we've done a write to config space while the adapter was blocked,
> > >shouldn't we replay those accesses at this point?
> > 
> > I did not think that was necessary.
> 
> We have to do *something*.  We can't just throw away writes.

I think we can in fact. Again, nobody outside of the driver has
legitimacy to write to the config space of a device, especially if the
device is "unreachable" (either doing a BIST or power managed).

> I see a few options:
> 
>  - Log all pending writes to config space and replay the log when the
>    device is unblocked.
>  - Fail writes to config space while the device is blocked.

I agree that returning an error in this case would be a good idea.

>  - Write to the saved config space and then blat the saved config space
>    back to the device upon unblocking.
> 
> Any other ideas?
> 
> BTW, you know things like XFree86 go completely around the kernel's PCI
> accessors and poke at config space directly?

Not anymore afaik. They use /proc/bus/pci

Ben.


