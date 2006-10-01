Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932242AbWJATfS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932242AbWJATfS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 15:35:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932240AbWJATfR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 15:35:17 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:7833 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932242AbWJATfP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 15:35:15 -0400
Subject: Re: [-mm patch] aic7xxx: check irq validity (was Re: 2.6.18-mm2)
From: Arjan van de Ven <arjan@infradead.org>
To: Jeff Garzik <jeff@garzik.org>
Cc: Matthew Wilcox <matthew@wil.cx>, linux-scsi@vger.kernel.org,
       "Linux-Kernel," <linux-kernel@vger.kernel.org>,
       "J.A. Magall??n" <jamagallon@ono.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       Frederik Deweerdt <deweerdt@free.fr>
In-Reply-To: <452014C2.1050000@garzik.org>
References: <20060928014623.ccc9b885.akpm@osdl.org>
	 <20060929155738.7076f0c8@werewolf> <20060929143949.GL5017@parisc-linux.org>
	 <1159550143.13029.36.camel@localhost.localdomain>
	 <20060929235054.GB2020@slug>
	 <1159573404.13029.96.camel@localhost.localdomain>
	 <20060930140946.GA1195@slug> <451F049A.1010404@garzik.org>
	 <20061001142807.GD16272@parisc-linux.org>
	 <1159729523.2891.408.camel@laptopd505.fenrus.org>
	 <452014C2.1050000@garzik.org>
Content-Type: text/plain
Organization: Intel International BV
Date: Sun, 01 Oct 2006 21:34:50 +0200
Message-Id: <1159731290.2891.411.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-10-01 at 15:19 -0400, Jeff Garzik wrote:
> Arjan van de Ven wrote:
> > well... why not go one step further and eliminate the flags argument
> > entirely? And use pci_name() for the name (so eliminate the argument ;)
> > and always pass pdev as data, so that that argument can go away too....
> > 
> > that'll cover 99% of the request_irq() users for pci devices.. and makes
> > it really nicely simple and consistent.
> 
> Disagree.  That would involve rewriting a lot of drivers.
> 
> flags: may or may not need sample-random flag.

ok fair.. but I'd then almost call it "samplerandom" not "flags"...


> 
> name: is always the ethernet interface, for net drivers, or did you 
> forget from your irqbalance days?  ;-)

I'd say the "always" isn't quite true .. I remember that well.
If it's always the pci device at least irqbalance can look up the device
type in sysfs ;)


> data: in practice, is _rarely_ struct pci_dev.  It's usually a 
> driver-private structure which is the structure most frequently 
> accessed.  struct pci_dev* is rarely accessed inside the interrupt 
> handler, except maybe somewhere deep in an error handling path.

hmmm could put a pointer to the private data in the pci_dev at least...
that'd be generally useful, and then this can either just pass that,
or have the isr get to it that way (whichever makes more sense)

