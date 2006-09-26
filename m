Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751045AbWIZJsW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751045AbWIZJsW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 05:48:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751046AbWIZJsV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 05:48:21 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:61661 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S1751045AbWIZJsV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 05:48:21 -0400
Date: Tue, 26 Sep 2006 11:48:26 +0200
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: Andrew Victor <andrew@sanpeople.com>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] at91_serial: Introduction
Message-ID: <20060926114826.3f85b939@cad-250-152.norway.atmel.com>
In-Reply-To: <1159262891.24662.25.camel@fuzzie.sanpeople.com>
References: <11545303083273-git-send-email-hskinnemoen@atmel.com>
	<20060923211417.GB4363@flint.arm.linux.org.uk>
	<1159261584.24659.16.camel@fuzzie.sanpeople.com>
	<20060926112757.03dd8cbc@cad-250-152.norway.atmel.com>
	<1159262891.24662.25.camel@fuzzie.sanpeople.com>
Organization: Atmel Norway
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 26 Sep 2006 11:28:11 +0200
Andrew Victor <andrew@sanpeople.com> wrote:

> hi Haavard,
> 
> > Maybe we can agree on a platform_data format so
> > that we can remove the #ifdef altogether?
> 
> The platform_data structure is currently defined in
> include/asm-arm/arch-at91rm9200/board.h as:
> 
> struct at91_uart_data {
> 	short	use_dma_tx;	/* use transmit DMA? */
> 	short	use_dma_rx;	/* use receive DMA? */
> };
> 
> I don't think the DMA-support is currently in mainline, but is in the
> pending patches on http://maxim.org.za/AT91RM9200/2.6/

Are you going to submit it for 2.6.19? I want to try to slam a big
rename patch in without messing up too many not-yet-submitted patches...

> I guess we can just add another field:
> 	short	no_remap;	/* base address is already
> mapped */ (or something similar)

Or maybe even better:
	void __iomem *regs;	/* fixed mapping of base address */

to indicate the actual mapping (if it's NULL, it hasn't been mapped yet)

Haavard
