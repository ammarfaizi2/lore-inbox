Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261331AbVGLK2t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261331AbVGLK2t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 06:28:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261322AbVGLK0i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 06:26:38 -0400
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:6052 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S261320AbVGLKZV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 06:25:21 -0400
X-ORBL: [69.107.32.110]
Date: Tue, 12 Jul 2005 03:25:12 -0700
From: david-b@pacbell.net
To: rmk+lkml@arm.linux.org.uk
Subject: Re: [patch 2.6.13-git] 8250 tweaks
Cc: linux-kernel@vger.kernel.org
References: <200507111922.04800.david-b@pacbell.net>
 <20050712081943.B25543@flint.arm.linux.org.uk>
In-Reply-To: <20050712081943.B25543@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20050712102512.A7F30BF3C9@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Tue, 12 Jul 2005 08:19:43 +0100
> From: Russell King <rmk+lkml@arm.linux.org.uk>
>
> On Mon, Jul 11, 2005 at 07:22:04PM -0700, David Brownell wrote:
> > and stop
> > whining about certain non-errors (details in the patch comments).
>
> Please explain what the whining is (details were missing from the
> patch comments).

The kernel "recently" started issuing the second and third messages
after initializing the serial port on for example an OSK board:

    ttyS0 at MMIO 0xfffb0000 (irq = 46) is a ST16654
    serial8250 serial8250.0: unable to register port at index 1 (IO0 MEM0 IRQ47): -28
    serial8250 serial8250.0: unable to register port at index 2 (IO0 MEM0 IRQ15): -28

Of the three serial ports potentially available on that board, by default
only the UART1 is available, and the others are marked as unavailable
by zeroing the register pointers in that platform_data.  That makes it
easy to support setups where for example UART1/ttyS0 and UART3/ttyS2 are
wired, and the pins for ttyS1 are muxed to some other purpose like USB
or MMC, or similarly boards where only UART2 is wired up.

- Dave

