Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030459AbVIAWVA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030459AbVIAWVA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 18:21:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030460AbVIAWVA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 18:21:00 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:64956 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030455AbVIAWU7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 18:20:59 -0400
Subject: Re: [PATCH 1/1] 8250_kgdb driver reworked
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Russell King <rmk@arm.linux.org.uk>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>
In-Reply-To: <20050901214720.GU3966@smtp.west.cox.net>
References: <20050901190251.GS3966@smtp.west.cox.net>
	 <1125611874.15768.79.camel@localhost.localdomain>
	 <20050901214720.GU3966@smtp.west.cox.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 01 Sep 2005 23:44:44 +0100
Message-Id: <1125614685.15768.83.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-09-01 at 14:47 -0700, Tom Rini wrote:
> > > +	 * If  there is some other CPU in KGDB then this is a
> > > +	 * spurious interrupt. so return without even checking a byte
> > > +	 */
> > > +	if (atomic_read(&debugger_active))
> > > +		return IRQ_NONE;
> > > +
> > 
> > Shared IRQ -> hung box. 
> 
> Can you elaborate a bit more please?  When we're actually in KGDB and
> working on stuff we're polling so it's really just the
> GDB-is-interrupting case.

If the IRQ source is level triggered and the device is the cause then as
soon as you exit the IRQ handler, you'll be called again and again and
again until the IRQ is cleared or 10,000 tries or so occur when the IRQ
is disabled

Does this only occur if there is a stray IRQ under delivery as kgdb is
entered ? (ie you do something like

		write irq off to port
		read back if mmio (to avoid posting)
		atomic_inc(&debugger_active)

??

)
