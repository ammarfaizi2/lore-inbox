Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964847AbWIKF0E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964847AbWIKF0E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 01:26:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964860AbWIKF0E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 01:26:04 -0400
Received: from gate.crashing.org ([63.228.1.57]:14501 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S964847AbWIKF0B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 01:26:01 -0400
Subject: Re: TG3 data corruption (TSO ?)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Chan <mchan@broadcom.com>
Cc: Segher Boessenkool <segher@kernel.crashing.org>, netdev@vger.kernel.org,
       "David S. Miller" <davem@davemloft.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <1551EAE59135BE47B544934E30FC4FC093FB2B@NT-IRVA-0751.brcm.ad.broadcom.com>
References: <1551EAE59135BE47B544934E30FC4FC093FB2B@NT-IRVA-0751.brcm.ad.broadcom.com>
Content-Type: text/plain
Date: Mon, 11 Sep 2006 15:25:48 +1000
Message-Id: <1157952348.31071.411.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-09-10 at 22:18 -0700, Michael Chan wrote:
> Benjamin Herrenschmidt wrote:
> 
> > I've added a wmb() in tw32_rx_mbox() and tw32_tx_mbox() and can still
> > reproduce the problem. I've also done a 2 days run without TSO enabled
> > without a failure (my test program normally fails after a couple of
> > minutes).
> > 
> 
> Hi Ben,
> 
> The code is a bit tricky.  It uses function pointers for the various
> register read/write methods.  For the 5780, I believe it will be
> assigned a simple writel() and not tg3_write32_tx_mbox().  Can you
> double check to make sure you have actually added the wmb()?
> 
> It's probably easiest to just add the wmb() in tg3_xmit_dma_bug()
> before the tw32_tx_mbox().

I've done:

#define tw32_rx_mbox(reg, val)	do { wmb(); tp->write32_rx_mbox(tp, reg, val); } while(0)
#define tw32_tx_mbox(reg, val)	do { wmb(); tp->write32_tx_mbox(tp, reg, val); } while(0)

Cheers,
Ben.


