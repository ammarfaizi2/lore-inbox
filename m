Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317541AbSG2Rz0>; Mon, 29 Jul 2002 13:55:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317591AbSG2Rz0>; Mon, 29 Jul 2002 13:55:26 -0400
Received: from fed1mtao01.cox.net ([68.6.19.244]:42928 "EHLO
	fed1mtao01.cox.net") by vger.kernel.org with ESMTP
	id <S317541AbSG2RzZ>; Mon, 29 Jul 2002 13:55:25 -0400
Date: Mon, 29 Jul 2002 11:15:37 -0700
From: Matt Porter <porter@cox.net>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org,
       linuxppc-dev@lists.linuxppc.org
Subject: Re: 3 Serial issues up for discussion (was: Re: Serial core problems on embedded PPC)
Message-ID: <20020729111537.A1420@home.com>
References: <20020729181702.E25451@flint.arm.linux.org.uk> <20020729174341.GA12964@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020729174341.GA12964@opus.bloom.county>; from trini@kernel.crashing.org on Mon, Jul 29, 2002 at 10:43:41AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2002 at 10:43:41AM -0700, Tom Rini wrote:
> 
> On Mon, Jul 29, 2002 at 06:17:02PM +0100, Russell King wrote:
> 
> 
> > 1. Serial port initialisation
> > -----------------------------
> >
> > Firstly, one thing to bear in mind here is that, as Alan says "be nice
> > to make sure it was much earlier".  I guess Alan's right, so we can get
> > oopsen out of the the kernel relatively easily, even when we're using
> > framebuffer consoles.
> >
> > I'm sure Alan will enlighten us with his specific reasons if required.
> >
> > There have been several suggestions around on how to fix this table:
> >
> > a. architectures provide a sub-module to 8250.c which contains the
> >    per-port details, rather than a table in serial.h.  This would
> >    ideally mean removing serial.h completely.  The relevant object
> >    would be linked into 8250.c when 8250.c is built as a module.
> 
> I think this would work best.  On PPC this would allow us to change the
> mess of include/asm-ppc/serial.h into a slightly cleaner Makefile
> (especially if we do the automagic <platforms/platform.h> or
> <asm/platform.h> bit that's been talked about in the past) magic and we
> could use that object file as well in the bootwrapper as well.

I think this would be the cleanest method as well.  Especially when we
recognize that the asm-ppc/serial.h situation will only get worse
over time.  Every embedded PPC board designer has a unique location
for his 16550 UART(s) and we just keep adding more preprocessor
cruft for each port.  This should let us keep this board-specific
info in our board port files...more abstraction=good.

Regards,
-- 
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.
