Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932400AbWB1Sgh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932400AbWB1Sgh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 13:36:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932404AbWB1Sgh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 13:36:37 -0500
Received: from smtp.osdl.org ([65.172.181.4]:6590 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932400AbWB1Sgg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 13:36:36 -0500
Date: Tue, 28 Feb 2006 10:35:19 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: pavel@ucw.cz, randy_d_dunlap@linux.intel.com, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: [PATCH 2/13] ATA ACPI: debugging infrastructure
Message-Id: <20060228103519.20f9b277.akpm@osdl.org>
In-Reply-To: <440442A4.2090201@pobox.com>
References: <20060222133241.595a8509.randy_d_dunlap@linux.intel.com>
	<20060222135133.3f80fbf9.randy_d_dunlap@linux.intel.com>
	<20060228114500.GA4057@elf.ucw.cz>
	<44043B4E.30907@pobox.com>
	<20060228041817.6fc444d2.akpm@osdl.org>
	<440442A4.2090201@pobox.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> wrote:
>
> Andrew Morton wrote:
> > Jeff Garzik <jgarzik@pobox.com> wrote:
> > 
> >>Fine-grained 
> >> message selection allows one to turn on only the messages needed, and 
> >> only for the controller desired.
> > 
> > 
> > Except
> > 
> > - There's (presently) no way of making all the messages go away for a
> >   non-debug build.
> 
> They aren't supposed to go away.
> 

It is legitimate to elect to waste memory on every machine so as to make
the system more easily debugged by remote maintainers.  But that's an
unusual choice in the kernel context.

They can still get you by setting CONFIG_PRINTK=n ;)

> > - The code is structured as
> > 
> > 	if (ata_msg_foo(p))
> > 		printk("something");
> > 
> >   So if we later do
> > 
> > 	#define ata_msg_foo(p)	0
> > 
> >   We'll still get copies of "something" in the kernel image (may be fixed
> >   in later gcc, dunno).
> 
> We don't do that in net driver land, and I don't wish to do it for 
> libata either.  Its just a bit test, that jumps over code if the message 
> class isn't enabled (see link below).
> 
> We want users to be able to enable specific messages for specific 
> controllers, without recompiling their kernel.
> 
> grep for msg_enable in various net drivers.  ethtool(8) is used to 
> select specific controllers and messages to print.
> 

umm, that's unrelated to my point, but whatever.

> 
> > - The new debug stuff isn't documented.  One has funble around in the
> >   source to work out how to even turn it on.  Can it be altered at runtime?
> >   Dunno - the changelogs are risible.  What effect do the various flags
> >   have?
> 
> The model has always been documented:
> http://www.scyld.com/pipermail/vortex/2001-November/001426.html
> (scroll down a tad)

That's useless.
