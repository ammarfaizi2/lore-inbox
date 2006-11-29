Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758012AbWK2BUt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758012AbWK2BUt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 20:20:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758561AbWK2BUt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 20:20:49 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:47797 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1758012AbWK2BUt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 20:20:49 -0500
Date: Wed, 29 Nov 2006 01:26:56 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [rfc PATCH] ieee1394: ohci1394: delete bogus spinlock, flush
 MMIO writes
Message-ID: <20061129012656.601cdea1@localhost.localdomain>
In-Reply-To: <456CCB53.70208@s5r6.in-berlin.de>
References: <tkrat.9660c0c3e547e1fd@s5r6.in-berlin.de>
	<20061128215621.2e0ac9a6@localhost.localdomain>
	<456CCB53.70208@s5r6.in-berlin.de>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2006 00:50:43 +0100
Stefan Richter <stefanr@s5r6.in-berlin.de> wrote:

> Alan wrote:
> > On Tue, 28 Nov 2006 22:24:11 +0100 (CET)
> > Stefan Richter <stefanr@s5r6.in-berlin.de> wrote:
> >> All MMIO writes which were surrounded by the spinlock as well as the
> >> very last MMIO write of the IRQ handler are now explicitly flushed by
> >> MMIO reads of the respective register.
> > 
> > MMIO is ordered anyway on the bus, you just need mmiowb() to force
> > ordering to the bus controller in case you are on a big numa box.
> 
> The mmiowb is a checkpoint to ensure ordering between different threads
> of MMIO writes; i.e. it doesn't halt the thread until the write actually
> reached the device like a read would do, right?

It guarantees that no other mmio will sneak past it from another thread
but doesn't guarantee the previous I/O has hit the hardware. It's a much
weaker (and thus far faster) guarantee which is usually sufficient as it
can be combined with spin_unlock to enforce I/O ordering matching the
lock ordering.

Alan
