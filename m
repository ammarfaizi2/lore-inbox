Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750903AbWHUTb3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750903AbWHUTb3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 15:31:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750896AbWHUTb3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 15:31:29 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:39841
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750890AbWHUTb2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 15:31:28 -0400
Date: Mon, 21 Aug 2006 12:31:42 -0700 (PDT)
Message-Id: <20060821.123142.08327833.davem@davemloft.net>
To: bunk@stusta.de
Cc: hch@infradead.org, James.Bottomley@SteelEye.com,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/scsi/wd33c93.c: cleanups
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060821192215.GL11651@stusta.de>
References: <20060821104357.GH11651@stusta.de>
	<20060821105344.GA28759@infradead.org>
	<20060821192215.GL11651@stusta.de>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Bunk <bunk@stusta.de>
Date: Mon, 21 Aug 2006 21:22:15 +0200

> On Mon, Aug 21, 2006 at 11:53:44AM +0100, Christoph Hellwig wrote:
> > On Mon, Aug 21, 2006 at 12:43:57PM +0200, Adrian Bunk wrote:
> > > This patch contains the following cleanups:
> > > - #include <linux/irq.h> for getting the prototypes of
> > >   {dis,en}able_irq()
> > 
> > nothing outside of arch code must ever include <linux/irq.h>
> 
> Why?
> It sounds rather strange that non-arch code should use asm headers.

It's an unfortunate side effect of how the generic IRQ layer was done.

The linux/irq.h head should only be used on platforms that make use of
the generic IRQ layer.

asm/irq.h is what should be included by drivers and the like that want
the IRQ interfaces.

I'm not saying this is a good situation, it's just the way it is.
