Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261678AbTD2UKK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 16:10:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261686AbTD2UKK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 16:10:10 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:9733 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261678AbTD2UKJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 16:10:09 -0400
Subject: Re: [Patch] DMA mapping API for Alpha
From: James Bottomley <James.Bottomley@steeleye.com>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 29 Apr 2003 15:22:12 -0500
Message-Id: <1051647735.2501.45.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> Ok, for clean dma_* implementation on alpha (and others, I guess) we need
> to move root level IO controller data from struct pci_dev (pdev->sysdata)
> to struct dev. Actually, the latter already has such field (platform_data)
> but right now it's kind of parisc specific. ;-)
> I'll look into it after short vacation (4-5 days).

Well, it (platform_data) predates the parisc conversion to the dma_
API.  I just assumed that was what it was there fore.  I had to do it
this way because parisc has a rather nasty set up in that there are
usually two PCI (and several other busses) which connect to two
different IO-MMUs.  I use the platform_data field to cache the
particular IO-MMU the device is connected to.  I assume this is the same
in alpha?

Previously parisc was using the sysdata field of the pci_dev (and
constructing fake pci_devs for other busses).  The conversion wasn't
actually that complex (although it was made easier on parisc because the
IO-MMU lives above the PCI busses, so in the generic device model we can
simply now traverse parents to find it).

James


