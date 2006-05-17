Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751066AbWEQHfp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751066AbWEQHfp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 03:35:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751140AbWEQHfp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 03:35:45 -0400
Received: from ns1.sagem.com ([62.160.59.65]:38365 "EHLO mx1.sagem.com")
	by vger.kernel.org with ESMTP id S1750974AbWEQHfo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 03:35:44 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, Jeff Garzik <jeff@garzik.org>,
       linux-ide@vger.kernel.org, linux-ide-owner@vger.kernel.org,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [RFT] major libata update
MIME-Version: 1.0
Message-ID: <OFED10B103.942F56FA-ONC1257171.0028EEA3-C1257171.0029B954@sagem.com>
From: Matthieu CASTET <matthieu.castet@sagem.com>
Date: Wed, 17 May 2006 09:35:38 +0200
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2006-05-15 at 14:15 -0400, Jeff Garzik wrote:
> > which persists on Sil 311x on rare motherboards.  The rest are either 
> > addressed with the improved error handling, or are ATAPI + VIA AFAICS.

> ATAPI + VIA to that pattern is also showing up on pata_via cases as
> well, but only on via so far. Its as if there is a case where the IRQ of
> the first command is lost sometimes.
I investigated further the problem. For my pata case the interrupt go 
through idle_irq in ata_host_intr.
If I put a printk before ata_host_intr in ata_interrupt there no problem.

I bet "altstatus" or "main status" return ATA_BUSY and are not cleared 
enough fast by the hardware.

I will try others tests this evening.


Matthieu


