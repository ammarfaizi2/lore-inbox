Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751488AbWJMHwl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751488AbWJMHwl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 03:52:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751606AbWJMHwl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 03:52:41 -0400
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:47625 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751488AbWJMHwk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 03:52:40 -0400
Date: Fri, 13 Oct 2006 08:52:19 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Paul Mundt <lethal@linux-sh.org>
Cc: Matthias Fuchs <matthias.fuchs@esd-electronics.com>,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] Generic platform device IDE driver
Message-ID: <20061013075219.GA28654@flint.arm.linux.org.uk>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	Matthias Fuchs <matthias.fuchs@esd-electronics.com>,
	linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Jeff Garzik <jgarzik@pobox.com>
References: <20061004074535.GA7180@localhost.hsdv.com> <1159972725.25772.26.camel@localhost.localdomain> <20061005091631.GA8631@localhost.hsdv.com> <200610111450.41909.matthias.fuchs@esd-electronics.com> <20061012061348.GA7844@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061012061348.GA7844@linux-sh.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2006 at 03:13:48PM +0900, Paul Mundt wrote:
> On Wed, Oct 11, 2006 at 02:50:41PM +0200, Matthias Fuchs wrote:
> > Perhaps it is a good idea to update the pata platform driver to be able to 
> > handle both _IO and _MEM resources. The _IO resources be be handled 
> > as it is already done by your code and for _MEM resources the pata platform
> > driver can do the ioremapping as I currently do in my board setup.
>
> Yes, that's one thing I was thinking of as well.. Here's a patch that
> makes an attempt at that, can you give it a try and see if it works for
> you? This applies on top of the earlier patch. None of the ARM, SH, or
> H8300 cases need to do the remapping at least.

It's likely that ARM will switch over to using the MMIO resources if
this patch makes it in.  There's certain ARM platforms which would
benefit from this change (since inb() and friends are more complex
than they necessarily need to be.)

However, one issue needs to be solved before we could do that - how do
we handle the case where the IDE registers are on a 4 byte spacing
interval instead of the usual 1 byte?

I notice that this driver is calling ata_std_ports() which handles
the standard setup.  Maybe that needs to become a little more inteligent?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
