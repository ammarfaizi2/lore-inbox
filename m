Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932156AbWDJW3L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932156AbWDJW3L (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 18:29:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932153AbWDJW3L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 18:29:11 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:49899
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932152AbWDJW3J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 18:29:09 -0400
Date: Mon, 10 Apr 2006 15:28:49 -0700 (PDT)
Message-Id: <20060410.152849.25734948.davem@davemloft.net>
To: benoit.boissinot@ens-lyon.org
Cc: mb@bu3sch.de, netdev@vger.kernel.org, bcm43xx-dev@lists.berlios.de,
       linux-kernel@vger.kernel.org, benh@kernel.crashing.org
Subject: Re: [RFC/PATCH] remove unneeded check in bcm43xx
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060410221359.GC27596@ens-lyon.fr>
References: <200604100628.01483.mb@bu3sch.de>
	<20060410134625.GA25360@tuxdriver.com>
	<20060410221359.GC27596@ens-lyon.fr>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benoit Boissinot <benoit.boissinot@ens-lyon.org>
Date: Tue, 11 Apr 2006 00:13:59 +0200

> On Mon, Apr 10, 2006 at 09:46:30AM -0400, John W. Linville wrote:
> > On Mon, Apr 10, 2006 at 06:28:00AM +0200, Michael Buesch wrote:
> > 
> > > To summerize: I actually added these messages, because people were
> > > hitting "this does not work with >1G" issues and did not get an error message.
> > > So I decided to insert warnings until the issue is fixed inside the arch code.
> > > I will remove them once the issue is fixed.
> > 
> > This sounds like the same sort of problems w/ the b44 driver.
> > I surmise that both use the same (broken) DMA engine from Broadcom.
> > 
> > Unfortunately, I don't know of any good solution to this.  There are
> > a few hacks in b44 that deal with the issue.  I don't like them,
> > although I am the perpetrator of at least one of them.  It might be
> > worth looking at what was done there?
> 
> The hacks i see there is reallocating a buffer with GFP_DMA, so that
> means that if the ppc dma_alloc_coherent did the same thing as the i386
> counterpart (adding GFP_DMA if dma_mask is less than 32bits) it should
> work, no ?

PowerPC doesn't have a seperate GFP_DMA page pool, so this won't work.
