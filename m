Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262817AbTEBACY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 20:02:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262811AbTEBACY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 20:02:24 -0400
Received: from zeus.kernel.org ([204.152.189.113]:49290 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262817AbTEBACS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 20:02:18 -0400
Subject: Re: [Patch] DMA mapping API for Alpha
From: "David S. Miller" <davem@redhat.com>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: hch@infradead.org, Marc Zyngier <mzyngier@freesurf.fr>, rth@twiddle.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <20030430000807.A731@localhost.park.msu.ru>
References: <wrp65oycvrw.fsf@hina.wild-wind.fr.eu.org>
	 <20030429150532.A3984@jurassic.park.msu.ru>
	 <wrpvfwx5xcq.fsf@hina.wild-wind.fr.eu.org>
	 <20030429162322.B5767@jurassic.park.msu.ru>
	 <20030429134100.A30251@infradead.org>
	 <20030430000807.A731@localhost.park.msu.ru>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1051786561.8772.4.camel@rth.ninka.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 01 May 2003 03:56:01 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-04-29 at 13:08, Ivan Kokshaysky wrote:
> Ok, for clean dma_* implementation on alpha (and others, I guess) we need
> to move root level IO controller data from struct pci_dev (pdev->sysdata)
> to struct dev. Actually, the latter already has such field (platform_data)
> but right now it's kind of parisc specific. ;-)
> I'll look into it after short vacation (4-5 days).

I don't know if this will really be all that nice Ivan.

The data is different for me on PCI vs. SBUS vs. whatever.
This knowledge of what the dev->platform_data type is has to come from
somewhere.

This means device->ops->dma_*(), a level of indirection I wish terribly
that we could avoid.  If a driver is PCI or SBUS only it should not eat
this overhead, I should just call call sbus_*() or pci_*() and this
vectors directly to the proper DMA routines.

Doing all of this generic crap is nice for writing generic drivers,
but terrible for what the generated code will look like.  This kind of
stuff tends to silently accumulate, and it's really hard to delete once
it's there.

-- 
David S. Miller <davem@redhat.com>
