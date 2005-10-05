Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965213AbVJEPSW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965213AbVJEPSW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 11:18:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965212AbVJEPSW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 11:18:22 -0400
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:61392 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP id S965211AbVJEPSU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 11:18:20 -0400
X-ORBL: [69.107.75.50]
Date: Wed, 05 Oct 2005 08:18:18 -0700
From: David Brownell <david-b@pacbell.net>
To: vwool@ru.mvista.com
Subject: Re: [PATCH/RFC 0/2] simple SPI framework, refresh + ads7864 driver
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20051005151818.338E1EA551@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > can you please describe the data flow in case of DMA transfer? Thanks!
> >
> > In the current model, the controller driver handles it (assuming
> > that it uses DMA not PIO):
> >
> >  - Use dma_map_single() at some point between the master->transfer()
> >    call and the time the DMA address is handed to DMA hardware.

> So that implies calling dma_map_single() for the memory allocated in stack?

Calling that for whatever is passed, certainly.

But the <linux/spi.h> header does have a comment right next to the
declarations of spi_transfer.tx_buf and rx_buf, saying that "buffers
must work with dma_*map_single() calls.

In general all APIs that use DMA will follow the rules listed under
"What memory is DMA'able?" in:

  linux/Documentation/DMA-mapping.txt

The rest of that file is a bit PCI-centric, but that section remains
the primary description of what can be DMA'd.  I had assumed that went
without saying; permaps wrongly.

- Dave

