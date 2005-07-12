Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261340AbVGLLd3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261340AbVGLLd3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 07:33:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261347AbVGLLd3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 07:33:29 -0400
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:19124 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S261340AbVGLLcS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 07:32:18 -0400
X-ORBL: [69.107.32.110]
Date: Tue, 12 Jul 2005 04:32:12 -0700
From: david-b@pacbell.net
To: rmk+lkml@arm.linux.org.uk
Subject: Re: [patch 2.6.13-git] 8250 tweaks
Cc: linux-kernel@vger.kernel.org
References: <200507111922.04800.david-b@pacbell.net>
 <20050712081943.B25543@flint.arm.linux.org.uk>
 <20050712102512.A7F30BF3C9@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
 <20050712120825.E28413@flint.arm.linux.org.uk>
In-Reply-To: <20050712120825.E28413@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20050712113212.0C90EBF3D5@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >     ttyS0 at MMIO 0xfffb0000 (irq = 46) is a ST16654
> >     serial8250 serial8250.0: unable to register port at index 1 (IO0 MEM0 IRQ47): -28
> >     serial8250 serial8250.0: unable to register port at index 2 (IO0 MEM0 IRQ15): -28
>
> Thanks, that's exactly what I wanted to know.
>
> -28 is -ENOSPC which means that you've run out of available serial devices
> to register these others.

The idea is _not_ to register them on boards that only have a
single RS232 connector.  The fix was just having the 8250 code
understand that it should only register ports that are real.


> If you wish to have three ports in an plat_serial8250_port array, you'll
> need to ensure that CONFIG_SERIAL_8250_NR_UARTS is set to at least 3.

That is, there's no third way which (a) doesn't waste that memory,
and (b) doesn't produce annoying messages about non-error cases?

ISTR that having NR_UARTS bigger just produced different messages...

- Dave

