Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262312AbTELQkw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 12:40:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262316AbTELQkw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 12:40:52 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:38297 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262312AbTELQku
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 12:40:50 -0400
Date: Mon, 12 May 2003 17:53:31 +0100
From: Matthew Wilcox <willy@debian.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       willy@debian.org, davem@redhat.com
Subject: Re: Message Signalled Interrupt support?
Message-ID: <20030512165331.GZ29534@parcelfarce.linux.theplanet.co.uk>
References: <20030512163249.GF27111@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030512163249.GF27111@gtf.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 12, 2003 at 12:32:49PM -0400, Jeff Garzik wrote:
> Has anybody done any work, or put any thought, into MSI support?

Work -- no.  Thought?  A little.  Seems to me that MSIs need to be treated
as a third form of interrupts (level/edge/message).  The address that
the MSI will write to is clearly architecture dependent (may even be
irq-controller-dependent, depending on your architecture).  request_irq()
is an insufficient function to deal with this -- request_msi() may be
needed instead.  It'll need to return an address to pass to the card.
(We need a mechanism to decide whether it's a 32-bit or 64-bit address).

Oh, and don't make this too PCI-specific -- native PARISC interrupts
are MSI and you can see how handled it in arch/parisc/kernel/irq.c.

> Would things massively break if I set up MSI manually in the driver?

Might do, might not.

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
