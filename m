Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964892AbVJDSCo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964892AbVJDSCo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 14:02:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964891AbVJDSCo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 14:02:44 -0400
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:34511 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP id S964889AbVJDSCn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 14:02:43 -0400
X-ORBL: [69.107.75.50]
Date: Tue, 04 Oct 2005 11:02:37 -0700
From: David Brownell <david-b@pacbell.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH/RFC 0/2] simple SPI framework, refresh + ads7864 driver
Cc: spi-devel-general@lists.sourceforge.net, basicmark@yahoo.com,
       stephen@streetfiresound.com, dpervushin@gmail.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20051004180237.9B4FDEE8F2@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Following this will be two patches, refreshing the minimalist SPI stack
I've sent before.  Notable changes are:

  - Various updates to support real hardware, including reporting the
    IRQ associated with an SPI slave chip, providing void* handles for
    various flavors of board and controller state, dma_addr_t for I/O
    buffers, some control over protocol delays, and more.

  - New spi_alloc_master().  The driver model is happier if drivers
    don't allocate the class devices; this helps "rmmod" and friends,
    kind of handy for debugging drivers.  It allocates controller
    specific memory not unlike alloc_netdev().

  - Various cleanup, notably removing Kconfig for all those drivers
    that don't yet exist.  That was added purely to illustrate the
    potential scope of an SPI framework, when more folk were asking
    just why a Serial Peripheral Interface (*) was useful.

  - More kerneldoc.  No Documentation/DocBook/spi.html though.

  - Now there's a real ADS7864 touchscreen/sensor driver; lightly
    tested, but it emits the right sort of input events and gives
    syfs access to the temperature, battery, and voltage sensors.

This version seems real enough to integrate with.

One goal is promote reuse of driver code -- for SPI controllers and
slave chips connected using SPI -- while fitting them better into the
driver model framework.  Today, SPI devices only seem to get drivers
that are board-specific; there's a fair amount of reinvent-the-wheel,
and drivers that are unsuitable for upstream merging.

I can now report this seems to be working with real controllers and
real slave chips ... two of each to start with, but as yet there's no
mix'n'match (with e.g. that touchscreen driver being used with a PXA
SSP controller, not just OMAP MicroWire).  That should just take a
little bit of time and debugging.

- Dave

(*) And distinguish it from Singapore Paranormal Investigators.  ;)

