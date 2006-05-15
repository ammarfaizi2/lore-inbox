Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751420AbWEOHZY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751420AbWEOHZY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 03:25:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751419AbWEOHZY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 03:25:24 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:25009 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751214AbWEOHZX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 03:25:23 -0400
Message-ID: <44682CDB.9080804@garzik.org>
Date: Mon, 15 May 2006 03:25:15 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: HighPoint Linux Team <linux@highpoint-tech.com>,
       Andrew Morton <akpm@osdl.org>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hptiop: HighPoint RocketRAID 3xxx controller driver
References: <200605122209.k4CM95oW014664@mail.hypersurf.com>	 <041901c677e7$fdd9fbf0$1200a8c0@GMM> <1147676215.3121.2.camel@laptopd505.fenrus.org>
In-Reply-To: <1147676215.3121.2.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.0 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.0 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Mon, 2006-05-15 at 14:22 +0800, HighPoint Linux Team wrote:
>> Could you give more explanation about pci posting flush? When (and why) do we need it?
> 
> pci posting is where the chipset internally delays (posts) writes (as
> done by writel and such) to see if more writes will come that can then
> be combined into one burst. While in practice these queues are finite
> (and often have a timeout) it's bad practice to depend on that. The
> simplest way to flush out this posting is to do a (dummy) readl() from
> the same device. (alternative is to do dma from the device to ram, but
> readl() is a lot easier ;)
> 
>> In an old posting (http://lkml.org/lkml/2003/5/8/278) said pci posting flush is unnecessary - is it correct?
> 
> no not really, not as a general statement.

ACK.

Generally speaking, readl() is the best way to ensure that all writes 
have been flushed across various layers of PCI bridges, etc.

It is particularly important to get this right if you are issuing a 
delay (i.e. udelay) after a write.  If the write is not guaranteed to be 
flushed at the time the delay begins, then you are no longer truly 
delaying for the time requested.

	Jeff



