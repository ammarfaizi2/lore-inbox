Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263355AbTFKRe0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 13:34:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263394AbTFKReL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 13:34:11 -0400
Received: from host-64-213-145-173.atlantasolutions.com ([64.213.145.173]:51667
	"EHLO havoc.gtf.org") by vger.kernel.org with ESMTP id S263355AbTFKRcp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 13:32:45 -0400
Date: Wed, 11 Jun 2003 13:46:29 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] And yet more PCI fixes for 2.5.70
Message-ID: <20030611174629.GC31051@gtf.org>
References: <1055290315109@kroah.com> <1055335057.2083.14.camel@dhcp22.swansea.linux.org.uk> <20030611163837.GA24951@kroah.com> <1055351984.2419.23.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1055351984.2419.23.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 11, 2003 at 06:19:49PM +0100, Alan Cox wrote:
> On Mer, 2003-06-11 at 17:38, Greg KH wrote:
> > So that leaves only this file.  Jeff Garzik and I talked about removing
> > pci_present() as it's not needed, and I think for this one case we can
> > live without it.  Do you want me to make the pci_present() macro earlier
> > in this file, so it's readable again?  I don't want to put it back into
> > pci.h.
> 
> I still think it belongs in pci.h. Its an API and the API makes sense. The

Its an API that doesn't make sense.

99% of the uses can simply be eliminated (in 2.4, too).
They are entirely redundant.

The remaining two cases are really arch-specific checks that were
being done wrong anyway.  Note the history:  the definition morphed
in 2.4 from being "PCI BIOS seems to be present, so we'll assume a
PCI bus is present" to "PCI devices are present."  Neither definition
is correct for the question the remaining two cases want answered:
"Is a PCI bus present?"  Further, the IDE code calculating system
bus speed it should really be calling a PCI callback, not asking "Do
I have a PCI bus?" and making a guess...  a guess which seems wrong
in several cases, including my Dual Athlon box w/ 100% 66 Mhz PCI bus.

So, I conclude that pci_present() is wrong for all cases except one --
and that case is sparc64-specific and can be handled with arch-specific
code, I bet.

	Jeff



