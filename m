Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270635AbTGNPQZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 11:16:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270644AbTGNPQY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 11:16:24 -0400
Received: from auth22.inet.co.th ([203.150.14.104]:47627 "EHLO
	auth22.inet.co.th") by vger.kernel.org with ESMTP id S270635AbTGNPPB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 11:15:01 -0400
From: Michael Frank <mflt1@micrologica.com.hk>
To: Russell King <rmk@arm.linux.org.uk>, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: 2.5.75-mm1 yenta-socket lsPCI IRQ reads incorrect
Date: Mon, 14 Jul 2003 23:18:07 +0800
User-Agent: KMail/1.5.2
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>,
       John Belmonte <jvb@prairienet.org>
References: <200307141333.03911.mflt1@micrologica.com.hk> <20030714150435.GB5118@gtf.org> <20030714162138.B31395@flint.arm.linux.org.uk>
In-Reply-To: <20030714162138.B31395@flint.arm.linux.org.uk>
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307142318.07232.mflt1@micrologica.com.hk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 14 July 2003 23:21, Russell King wrote:
> On Mon, Jul 14, 2003 at 11:04:35AM -0400, Jeff Garzik wrote:
> > On Mon, Jul 14, 2003 at 03:50:51PM +0100, Russell King wrote:

I'll give that patch a go tomorrow.

> > >  	yenta_allocate_resources(socket);
> > > +
> > > +	pci_save_state(dev, socket->saved_state);
> > >
> > >  	socket->cb_irq = dev->irq;
> >
> > This reminds me, PCI Express makes the PCI config area larger, going
> > from 256 bytes to either 4K or 64K IIRC.
> >
> > I wonder if we want new pci_{save,restore}_xstate functions?
> > Or change the pci_{save,restore}_state API now to work with larger
> > config areas?
>
> Maybe we really want an API where you can pass in the size of your
> buffer (which also determines how much gets saved) ?

Right, using the dword write function for 16 words or so is OK, but
rather clumsy for much more than that.

Regards
Michael
-- 
Powered by linux-2.5.75-mm1. Compiled with gcc-2.95-3 - mature and rock solid

My current linux related activities:
- 2.5 yenta_socket testing
- Test development and testing of swsusp for 2.4/2.5 and ACPI S3 of 2.5 kernel 
- Everyday usage of 2.5 kernel

More info on 2.5 kernel: http://www.codemonkey.org.uk/post-halloween-2.5.txt
More info on swsusp: http://sourceforge.net/projects/swsusp/

