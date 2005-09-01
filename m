Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030487AbVIAWpO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030487AbVIAWpO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 18:45:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030489AbVIAWpN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 18:45:13 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:45979 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1030487AbVIAWpM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 18:45:12 -0400
Date: Thu, 1 Sep 2005 15:45:09 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Russell King <rmk@arm.linux.org.uk>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH 1/1] 8250_kgdb driver reworked
Message-ID: <20050901224509.GV3966@smtp.west.cox.net>
References: <20050901190251.GS3966@smtp.west.cox.net> <1125611874.15768.79.camel@localhost.localdomain> <20050901214720.GU3966@smtp.west.cox.net> <1125614685.15768.83.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1125614685.15768.83.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2005 at 11:44:44PM +0100, Alan Cox wrote:
> On Iau, 2005-09-01 at 14:47 -0700, Tom Rini wrote:
> > > > +	 * If  there is some other CPU in KGDB then this is a
> > > > +	 * spurious interrupt. so return without even checking a byte
> > > > +	 */
> > > > +	if (atomic_read(&debugger_active))
> > > > +		return IRQ_NONE;
> > > > +
> > > 
> > > Shared IRQ -> hung box. 
> > 
> > Can you elaborate a bit more please?  When we're actually in KGDB and
> > working on stuff we're polling so it's really just the
> > GDB-is-interrupting case.
> 
> If the IRQ source is level triggered and the device is the cause then as
> soon as you exit the IRQ handler, you'll be called again and again and
> again until the IRQ is cleared or 10,000 tries or so occur when the IRQ
> is disabled

But in the shared IRQ and other source is the other uart still
registered to the real 8250 driver, we'd luck out.  I know this has been
tested on a shared serial irq box, so it's not immediate and always
death at least...

> Does this only occur if there is a stray IRQ under delivery as kgdb is
> entered ? (ie you do something like

So digging back in CVS it seems this was added to fix a spurious
interrupt that occured on an (probably) an x86_64 box when NMI support
didn't work correctly.  I think it's safe enough to just drop this.

-- 
Tom Rini
http://gate.crashing.org/~trini/
