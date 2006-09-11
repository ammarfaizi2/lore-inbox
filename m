Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964891AbWIKFwW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964891AbWIKFwW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 01:52:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964889AbWIKFwV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 01:52:21 -0400
Received: from gate.crashing.org ([63.228.1.57]:33957 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S964888AbWIKFwT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 01:52:19 -0400
Subject: Re: TG3 data corruption (TSO ?)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Chan <mchan@broadcom.com>
Cc: Segher Boessenkool <segher@kernel.crashing.org>, netdev@vger.kernel.org,
       "David S. Miller" <davem@davemloft.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <1551EAE59135BE47B544934E30FC4FC093FB2C@NT-IRVA-0751.brcm.ad.broadcom.com>
References: <1551EAE59135BE47B544934E30FC4FC093FB2C@NT-IRVA-0751.brcm.ad.broadcom.com>
Content-Type: text/plain
Date: Mon, 11 Sep 2006 15:52:05 +1000
Message-Id: <1157953925.31071.413.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-09-10 at 22:33 -0700, Michael Chan wrote:
> Benjamin Herrenschmidt wrote:
> 
> > I've done:
> > 
> > #define tw32_rx_mbox(reg, val)	do { wmb();
> tp->write32_rx_mbox(tp, reg, val); } while(0)
> > #define tw32_tx_mbox(reg, val)	do { wmb();
> tp->write32_tx_mbox(tp, reg, val); } while(0)
> > 
> 
> That should do it.
> 
> I think we need those tcpdump after all.  Can you send it to me?

Looks like adding a sync to writel does fix it though... I'm trying to
figure out which specific writel in the driver makes a difference. I'll
then look into slicing those tcpdumps.

Ben.


