Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262861AbTFILEB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 07:04:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262918AbTFILEB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 07:04:01 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:55735 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262861AbTFILEA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 07:04:00 -0400
Date: Mon, 9 Jun 2003 12:17:39 +0100
From: Matthew Wilcox <willy@debian.org>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matthew Wilcox <willy@debian.org>, linux-kernel@vger.kernel.org,
       David Mosberger <davidm@hpl.hp.com>
Subject: Re: [PATCH] [3/3] PCI segment support
Message-ID: <20030609111739.GP28581@parcelfarce.linux.theplanet.co.uk>
References: <20030407234411.GT23430@parcelfarce.linux.theplanet.co.uk> <20030408203824.A27019@jurassic.park.msu.ru> <20030608164351.GI28581@parcelfarce.linux.theplanet.co.uk> <20030609140749.A15138@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030609140749.A15138@jurassic.park.msu.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 09, 2003 at 02:07:49PM +0400, Ivan Kokshaysky wrote:
> Looks good, but shouldn't we pass 'struct pci_bus *' instead
> of pci_dev to pci_domain_nr()?
> Because another place where the domain number must be checked on is
> pci_bus_exists().

hmm, yes, well.  There's a certain amount of sloppiness allowed with
it being a macro, in that bus->sysdata and dev->sysdata have the same
value so it works both ways.  Of course, this prohibits any architecture
from implementing it as a function, so we really should make up our minds
which it is to be.  It sounds like bus is more generally useful than dev,
so I'll make that explicit.

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
