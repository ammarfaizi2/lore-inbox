Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751474AbWEOPAM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751474AbWEOPAM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 11:00:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751471AbWEOPAM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 11:00:12 -0400
Received: from e-nvb.com ([69.27.17.200]:49796 "EHLO e-nvb.com")
	by vger.kernel.org with ESMTP id S1751450AbWEOPAK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 11:00:10 -0400
Subject: Re: [PATCH] hptiop: HighPoint RocketRAID 3xxx controller driver
From: Arjan van de Ven <arjan@infradead.org>
To: Jeff Garzik <jeff@garzik.org>
Cc: HighPoint Linux Team <linux@highpoint-tech.com>,
       Andrew Morton <akpm@osdl.org>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <44682CDB.9080804@garzik.org>
References: <200605122209.k4CM95oW014664@mail.hypersurf.com>
	 <041901c677e7$fdd9fbf0$1200a8c0@GMM>
	 <1147676215.3121.2.camel@laptopd505.fenrus.org>
	 <44682CDB.9080804@garzik.org>
Content-Type: text/plain
Date: Mon, 15 May 2006 16:59:28 +0200
Message-Id: <1147705188.3013.0.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-05-15 at 03:25 -0400, Jeff Garzik wrote:
> Arjan van de Ven wrote:
> > On Mon, 2006-05-15 at 14:22 +0800, HighPoint Linux Team wrote:
> >> Could you give more explanation about pci posting flush? When (and why) do we need it?
> > 
> > pci posting is where the chipset internally delays (posts) writes (as
> > done by writel and such) to see if more writes will come that can then
> > be combined into one burst. While in practice these queues are finite
> > (and often have a timeout) it's bad practice to depend on that. The
> > simplest way to flush out this posting is to do a (dummy) readl() from
> > the same device. (alternative is to do dma from the device to ram, but
> > readl() is a lot easier ;)
> > 
> >> In an old posting (http://lkml.org/lkml/2003/5/8/278) said pci posting flush is unnecessary - is it correct?
> > 
> > no not really, not as a general statement.
> 
> ACK.
> 
> Generally speaking, readl() is the best way to ensure that all writes 
> have been flushed across various layers of PCI bridges, etc.
> 
> It is particularly important to get this right if you are issuing a 
> delay (i.e. udelay) after a write.  If the write is not guaranteed to be 
> flushed at the time the delay begins, then you are no longer truly 
> delaying for the time requested.

another typical case is at io submission or when you disable irqs in the
hardware..


