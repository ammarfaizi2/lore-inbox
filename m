Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262728AbVA1UTv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262728AbVA1UTv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 15:19:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262739AbVA1UKr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 15:10:47 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:49419 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262748AbVA1UH1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 15:07:27 -0500
Date: Fri, 28 Jan 2005 20:07:13 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Grant Grundler <grundler@parisc-linux.org>, Jesse Barnes <jbarnes@sgi.com>,
       Jon Smirl <jonsmirl@gmail.com>, Greg KH <greg@kroah.com>,
       Jeff Garzik <jgarzik@pobox.com>, linux-pci@atrey.karlin.mff.cuni.cz,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Fwd: Patch to control VGA bus routing and active VGA device.
Message-ID: <20050128200713.A19657@flint.arm.linux.org.uk>
Mail-Followup-To: Matthew Wilcox <matthew@wil.cx>,
	Grant Grundler <grundler@parisc-linux.org>,
	Jesse Barnes <jbarnes@sgi.com>, Jon Smirl <jonsmirl@gmail.com>,
	Greg KH <greg@kroah.com>, Jeff Garzik <jgarzik@pobox.com>,
	linux-pci@atrey.karlin.mff.cuni.cz,
	lkml <linux-kernel@vger.kernel.org>
References: <9e47339105011719436a9e5038@mail.gmail.com> <200501270828.43879.jbarnes@sgi.com> <20050128173222.GC30791@colo.lackof.org> <200501281041.42016.jbarnes@sgi.com> <20050128193320.GB32135@colo.lackof.org> <20050128200010.GJ28246@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050128200010.GJ28246@parcelfarce.linux.theplanet.co.uk>; from matthew@wil.cx on Fri, Jan 28, 2005 at 08:00:10PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2005 at 08:00:10PM +0000, Matthew Wilcox wrote:
> I've been thinking for a while that we should mark the 10-bit aliases
> of ISA devices as used

ISTR that windows does this.

> Russell, would that allay your issues with the kernel io resource database?

It makes the situation a whole lot clearer from the point of working
out what is free and what isn't, making it less likely that we'll
trample over some magic port which your VGA card needs.

This, along with throwing in the ports found via ACPI (which Dominik
has hinted) should (maybe that's the wrong word) give us a complete
picture and allow things like PCMCIA to do reliable resource
allocation.  The same goes for Cardbus/PCI as well of course.

Maybe at this point the idea that you need to tell PCMCIA about which
resources it can validly use can finally be eliminated, which is a
big step towards eliminating it's dependence on userspace.

(I hope this is what you were talking about and I haven't just produced
a load of unrelated waffle!)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
