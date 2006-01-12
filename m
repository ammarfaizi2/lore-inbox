Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161248AbWALUeV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161248AbWALUeV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 15:34:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161243AbWALUeV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 15:34:21 -0500
Received: from smtp.osdl.org ([65.172.181.4]:40845 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161244AbWALUeU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 15:34:20 -0500
Date: Thu, 12 Jan 2006 12:32:53 -0800
From: Andrew Morton <akpm@osdl.org>
To: Reuben Farrelly <reuben-lkml@reub.net>
Cc: htejun@gmail.com, ric@emc.com, axboe@suse.de, neilb@suse.de, mingo@elte.hu,
       linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: Re: 2.6.15-mm2
Message-Id: <20060112123253.26ec3e5f.akpm@osdl.org>
In-Reply-To: <43C6AD72.2010101@reub.net>
References: <43C55B31.5000201@reub.net>
	<20060111194517.GE5373@suse.de>
	<20060111195349.GF5373@suse.de>
	<43C5D1CA.7000400@reub.net>
	<20060112080051.GA22783@htj.dyndns.org>
	<43C61598.7050004@reub.net>
	<20060112111846.GA19976@htj.dyndns.org>
	<43C645ED.40905@reub.net>
	<43C64C3B.5070704@emc.com>
	<43C64DF6.7060604@reub.net>
	<20060112135533.GA29675@htj.dyndns.org>
	<43C6AD72.2010101@reub.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reuben Farrelly <reuben-lkml@reub.net> wrote:
>
>  Indeed that seems to fix it.  I've just booted -mm3 and it came up with no 
>  problems at all.

whew.

What about all the other problems?  The oops under ata_device_add()?

And is it still saying this?

Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>
> On Iau, 2006-01-12 at 16:55 +1300, Reuben Farrelly wrote:
> > ata1: SATA max UDMA/133 cmd 0x0 ctl 0x2 bmdma 0x0 irq 0
> > ata2: SATA max UDMA/133 cmd 0x0 ctl 0x2 bmdma 0x8 irq 0
> > Unable to handle kernel NULL pointer dereference at virtual address 00000000
> 
> That is the critical bit. The SATA ports have no PCI resources assigned
> for bus mastering (BAR 4). libata should have driven the device PIO in
> this case but the resource should have been assigned.
