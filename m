Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750848AbWAUFsD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750848AbWAUFsD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 00:48:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750814AbWAUFsB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 00:48:01 -0500
Received: from smtp.osdl.org ([65.172.181.4]:31971 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750750AbWAUFsA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 00:48:00 -0500
Date: Fri, 20 Jan 2006 21:47:23 -0800
From: Andrew Morton <akpm@osdl.org>
To: Reuben Farrelly <reuben-lkml@reub.net>
Cc: stern@rowland.harvard.edu, linux-kernel@vger.kernel.org, jgarzik@pobox.com,
       greg@kroah.com, linux-usb-devel@lists.sourceforge.net,
       neilb@cse.unsw.edu.au, linux-acpi@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: 2.6.15-mm3 [USB lost interrupt bug]
Message-Id: <20060120214723.79111715.akpm@osdl.org>
In-Reply-To: <43D1C4E9.7030901@reub.net>
References: <Pine.LNX.4.44L0.0601152243330.1929-100000@netrider.rowland.org>
	<43D1C4E9.7030901@reub.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reuben Farrelly <reuben-lkml@reub.net> wrote:
>
> 
> 
> On 16/01/2006 4:46 p.m., Alan Stern wrote:
> > On Mon, 16 Jan 2006, Reuben Farrelly wrote:
> > 
> >>> From the information presented here, it looks like -mm1 correctly routes
> >>> the 1d.1 controller to IRQ 193 and the 1d.3 controller to IRQ 169, whereas
> >>> -mm3 incorrectly routes the 1d.3 controller to IRQ 193.  That would make 
> >>> it an ACPI problem.
> >> Is this likely to be the same or similar issue to the IRQ 0 problem I see quite 
> >> frequently on the SATA ports on later -mm releases?
> >> (see http://www.ussg.iu.edu/hypermail/linux/kernel/0601.1/1851.html)
> > 
> > I doubt they are at all related.  In the USB problem the resource is there 
> > but ACPI is routing it wrongly.  In the SATA problem the resource isn't 
> > there to begin with.
> > 
> > But then I know almost nothing about ACPI, so I could be wrong...
> > 
> > Alan Stern
> 
> Some good news.  I think it's fixed in 2.6.16-rc1-mm2.  In fact a whole boatload 
> of problems I was having are fixed in this -mm release, including a nasty libata 
> oops that seemed to have a few people scratching their heads.

OK, but probably that libata error-path bug is still in there.  It's just
that you're no longer taking the error paths.  And now we've lost our means
to reproduce it.

> I've now done in excess of 20 reboots with this code and haven't had either 
> problem show up at all.
> 
> So for now I'll keep a record of things for a bit longer, but I guess I've 
> reason to be fairly confident that both this USB/IRQ problem and my ATA/IRQ 
> problem are now fixed.
> 
> It does make me wonder if the ACPI update in rc1-mm2 fixed it, and was actually 
> the cause of most of my problems......it would be nice to know for sure.

We probably won't know.  Did you ever test 2.6.16-rc1 plus 2.6.16-rc1-mm1's
acpi.patch?  If that plays up we'd have confirmation.

