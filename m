Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261361AbVE2RqN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261361AbVE2RqN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 13:46:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261365AbVE2RqN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 13:46:13 -0400
Received: from oldconomy.demon.nl ([212.238.217.56]:52918 "EHLO
	artemis.slagter.name") by vger.kernel.org with ESMTP
	id S261361AbVE2RqF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 13:46:05 -0400
Subject: Re: Playing with SATA NCQ
From: Erik Slagter <erik@slagter.name>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       Jens Axboe <axboe@suse.de>
In-Reply-To: <20050529172949.GA3578@havoc.gtf.org>
References: <20050526140058.GR1419@suse.de>
	 <1117382598.4851.3.camel@localhost.localdomain>
	 <4299EF16.2050208@pobox.com>
	 <1117385429.4851.8.camel@localhost.localdomain>
	 <4299F4E2.4020305@pobox.com>
	 <1117387432.4851.13.camel@localhost.localdomain>
	 <20050529172949.GA3578@havoc.gtf.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 29 May 2005 19:45:03 +0200
Message-Id: <1117388703.4851.21.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-05-29 at 13:29 -0400, Jeff Garzik wrote:
> On Sun, May 29, 2005 at 07:23:52PM +0200, Erik Slagter wrote:
> > On Sun, 2005-05-29 at 12:59 -0400, Jeff Garzik wrote:
> > > > My question was if there is a fundamental reason why the AHCI mode of
> > > > the ICH6/7 must be enabled by the BIOS, is there a reason why the kernel
> > > > doesn't do it, or can't do it?
> > > 
> > > The BIOS sets up PCI resources necessary to use AHCI mode.
> > 
> > Ok. So there's absolutely no way to do that afterwards? It'd really be a
> > pity :-(
> 
> It is technically possible.  BIOS is just software, just like the OS.
> 
> It's just a huge pain in the butt, because the kernel might accidentally
> stomp on some resources the BIOS secretly set up, or somesuch.

Ah, ok. I wasn't aware of this large role of the BIOS in setting up
hardware, nowadays. Grmbl.

> > On the same subject: is there a reason why ICH6 gets "BAR0-3 ignored"
> > and always gets the legacy i/o ports and IRQ's assigned? I'd say there
> > is absolutely no need to be compatible in this way, the PCI code can
> > assign the IRQ and I/O ports as with any other PCI device?
> 
> IDE is special.
> 
> This is due to how the BIOS sets up an IDE PCI device in legacy mode.
> BAR0-3 are set to zero, which is a signal to the OS that the IDE PCI
> device is in legacy mode (io 0x1f0+0x170, irq 14+15).  Since the IDE I/O
> ports are in ISA space not PCI space, the PCI BARs reflect nothing.

Goodie. So we will be stuck with MS/DOS compatibility until somewhere in
the next millenium.

I guess the only way to have, for example the ICH6, not using legacy
IRQ/ports, is to switch it to AHCI, which only the BIOS can do (if
implemented).

Thrilling.
