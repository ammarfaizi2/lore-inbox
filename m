Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265056AbUFGUyg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265056AbUFGUyg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 16:54:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265055AbUFGUyd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 16:54:33 -0400
Received: from fw.osdl.org ([65.172.181.6]:44964 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265051AbUFGUyc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 16:54:32 -0400
Date: Mon, 7 Jun 2004 13:54:08 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: David Woodhouse <dwmw2@infradead.org>
cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Thomas Gleixner <tglx@linutronix.de>,
       Greg Weeks <greg.weeks@timesys.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.4] jffs2 aligment problems
In-Reply-To: <1086640771.29255.57.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0406071351450.1637@ppc970.osdl.org>
References: <40C484F9.20504@timesys.com>  <200406071736.53101.tglx@linutronix.de>
  <Pine.LNX.4.58.0406070900010.6162@ppc970.osdl.org> 
 <20040607174147.I28526@flint.arm.linux.org.uk>  <1086635643.29255.46.camel@localhost.localdomain>
  <Pine.LNX.4.58.0406071218240.1637@ppc970.osdl.org>
 <1086640771.29255.57.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 7 Jun 2004, David Woodhouse wrote:
>
> On Mon, 2004-06-07 at 12:22 -0700, Linus Torvalds wrote:
> > I don't see it as a correctness issue, I see it as a performance issue.
> 
> In the case in question it's very much _not_ a performance issue. We're
> writing a buffer to FLASH memory. The time it takes to read the word
> from RAM is entirely lost in the noise compared with the time it takes
> to write it to the flash.

Not if you have to take an alignment fault, which is easily several 
thousand cycles.

Think of "get_unaligned()" as a worst-case limiter. It can make the best 
case be worse on architectures where it matters, but it can make the worst 
case go from thousands of cycles to just single cycles.

And your flash isn't _that_ slow. Thousands of cycles that can't even 
overlap with any flash IO _does_ show up.

Now, whether the unaligned case is common enough for people to even worry, 
I don't know.

			Linus
