Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932310AbWGJJcT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932310AbWGJJcT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 05:32:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932290AbWGJJcT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 05:32:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:55247 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932310AbWGJJcS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 05:32:18 -0400
Date: Mon, 10 Jul 2006 02:31:46 -0700
From: Andrew Morton <akpm@osdl.org>
To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, nickpiggin@yahoo.com.au,
       dwmw2@infradead.org, tglx@linutronix.de, arjan@infradead.org,
       rmk+lkml@arm.linux.org.uk
Subject: Re: AVR32 architecture patch against Linux 2.6.18-rc1 available
Message-Id: <20060710023146.2b0b0f77.akpm@osdl.org>
In-Reply-To: <20060710110325.3b9a8270@cad-250-152.norway.atmel.com>
References: <20060706105227.220565f8@cad-250-152.norway.atmel.com>
	<20060706021906.1af7ffa3.akpm@osdl.org>
	<20060706120319.26b35798@cad-250-152.norway.atmel.com>
	<20060706031416.33415696.akpm@osdl.org>
	<20060710110325.3b9a8270@cad-250-152.norway.atmel.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jul 2006 11:03:25 +0200
Haavard Skinnemoen <hskinnemoen@atmel.com> wrote:

> On Thu, 6 Jul 2006 03:14:16 -0700
> Andrew Morton <akpm@osdl.org> wrote:
> 
> > OK, thanks.  Send me the whole lot when you think it's ready and
> > we'll get it into the pipeline.  Not for 2.6.18 though - we need to
> > give people time to look through it and send you nastygrams ;)
> 
> I've put up an updated patch at
> http://avr32linux.org/twiki/pub/Main/LinuxPatches/avr32-arch-3.patch

Thanks, I'll grab it.

> which fixes most of the issues people have pointed out. Thanks a lot
> to everyone for taking the time to look through this.
> 
> I've appended the changelog below, but first I'll mention the things I
> didn't fix and why:
> 
> There are three libgcc functions left, which handle the three possible
> variants of 64-bit shift. There's no easy way to eliminate these, but
> maybe our gcc maintainer can get gcc to emit the instructions inline
> instead. However, these functions are actually specified by the AVR32
> ABI, so they should be the same no matter which compiler you use.

Sure, if the compier doesn't inline 64-bit shift then you'll certainly need
the library function.

> The clk API is still exported as non-GPL. I don't feel very strongly
> one way or another, but since Russell is keeping them non-GPL on ARM,
> it makes most sense to keep them non-GPL on AVR32 as well.

OK.

> I've kept the volatiles in the arguments to the bitops functions as
> they are. I'm not sure if they're really needed, but as I understood
> from reading the recent thread about spinlocks, this doesn't fall in
> the category of "obviously bad" usage of volatile.

Nope.  i386 does it too, as does include/asm-generic/bitops/atomic.h
(wrongly, I suspect.  The volatile gets typecast away.)

