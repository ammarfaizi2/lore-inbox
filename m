Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261721AbUJ1T6R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261721AbUJ1T6R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 15:58:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261866AbUJ1T6Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 15:58:16 -0400
Received: from adsl-67-117-73-34.dsl.sntc01.pacbell.net ([67.117.73.34]:22546
	"EHLO muru.com") by vger.kernel.org with ESMTP id S262885AbUJ1Tys
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 15:54:48 -0400
Date: Thu, 28 Oct 2004 12:54:45 -0700
From: Tony Lindgren <tony@atomide.com>
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] Serial 8250 OMAP support, take 2
Message-ID: <20041028195445.GI14884@atomide.com>
References: <20041028191826.GG14884@atomide.com> <20041028203157.B11436@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041028203157.B11436@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Russell King <rmk+lkml@arm.linux.org.uk> [041028 12:32]:
> 
> One of the things which previous changes have done is to move us away
> from "port types" towards "capabilities" for serial ports, so things
> like the FIFO, hardware flow control and so forth can be individually
> controlled, rather than having to rely on a table of features.
> 
> So, it appears that OMAP ports are like a TI752 port, but with a couple
> of extra features.  Can we use the existing TI75x feature support code
> for these ports?

Well last time I checked at least the autoconfig failed. I can look into it
a bit more.

> Also, these ports seem to use extra address space which isn't covered by
> a request_region/request_mem_region... that's something which should be
> fixed.

OK, I'll change that.

> The set of UART_FCR6_xxx definitions are only left here for compatibility -
> there are others which use this file.  Because the trigger levels is very
> dependent on the chip and sometimes which other features are enabled, I
> decided to provide new definitions:
> 
> #define UART_FCR_R_TRIG_00      0x00
> #define UART_FCR_R_TRIG_01      0x40
> #define UART_FCR_R_TRIG_10      0x80
> #define UART_FCR_R_TRIG_11      0xc0
> #define UART_FCR_T_TRIG_00      0x00
> #define UART_FCR_T_TRIG_01      0x10
> #define UART_FCR_T_TRIG_10      0x20
> #define UART_FCR_T_TRIG_11      0x30
> 
> with a table above which detail their effects.  I think it's silly creating
> lots of definitions for these bits, and then ending up with lots of macros
> definiting the same sort of thing.  Please use the above only.

OK, I'll change that too.

Tony
