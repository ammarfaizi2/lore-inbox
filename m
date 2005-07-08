Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262681AbVGHOvU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262681AbVGHOvU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 10:51:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262682AbVGHOvU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 10:51:20 -0400
Received: from host-84-9-201-131.bulldogdsl.com ([84.9.201.131]:4484 "EHLO
	aeryn.fluff.org.uk") by vger.kernel.org with ESMTP id S262681AbVGHOvT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 10:51:19 -0400
Date: Fri, 8 Jul 2005 15:50:59 +0100
From: Ben Dooks <ben-linux@fluff.org>
To: Andrew Victor <andrew@sanpeople.com>
Cc: linux-kernel@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>
Subject: Re: [RFC] Atmel-supplied hardware headers for AT91RM9200 SoC processor
Message-ID: <20050708145059.GA16299@home.fluff.org>
References: <1120730318.16806.75.camel@fuzzie.sanpeople.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1120730318.16806.75.camel@fuzzie.sanpeople.com>
X-Disclaimer: I speak for me, myself, and the other one of me.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 07, 2005 at 11:58:39AM +0200, Andrew Victor wrote:
> hi,
> 
> I am attempting to submit code for inclusion in the mainline kernel to
> support the Atmel AT91RM9200 SoC processor, and the various boards that
> use that processor.  Since it's based on an ARM9 core, I submitted the
> patches to Russell King.
> 
> While he seems generally happy with most of the code, he has doubts
> about merging the Atmel-supplied headers and suggested I post this to
> the linux-kernel list for a wider review.

I'm with rmk, I do not like this use of structs. There are IO access
functions defined for a number of reasons.
 
> While I agree that their usage of structs/coding-style is not the
> cleanest/Linux way of doing things, re-using their headers is useful
> since:
> 1) they are supplied by the hardware manufacturer.
> 2) Atmel automatically generates them from their chip design database,
> so they should be correct.

Yes, but how do you know GCC is actually correctly compiling this?

> 3) they are used by most AT91RM9200 developers, not just those using
> Linux.

I feel this argument is a dangerous, as it ends up with `well, we
did it that way in XXX, so why can't we do it in linux`? This'll
end up with bad quality code and implementations simply due to the
fact they exist. (IE, it was good enough for Microsoft, Linux should do
it the same way)

> This gives the benefit that there is a larger 'installed base', and
> Atmel has to take the responsibility that it is correct.  I don't
> believe that Atmel will change the format of their hardware headers
> specifically for Linux.

Yes, so converting them to a different format is a _once only_ issue.

> If the AT91RM9200+Linux community had to convert all the headers, bugs
> may be introduced in the conversion process and we would have to assume
> any maintenance responsibility.  What we have now may be slightly ugly,
> but it is atleast known to be correct.

And this is different from bugs in the way that structs are layed out
by the compiler, or code re-ordering? It is know to be correct for
at least the versions of GCC that you have tried it with.

The arguments that structs are compiler efficient are also dying with
newer GCCs getting better at factoring constants into registers.

> As suggested by Russell King, I even added a warning message that these
> headers should not be used as an example of how things should be done in
> new implementations.
> 
> 
> I've appended two of their headers as an example - the System
> peripherals (timer, interrupt controller, etc) and Ethernet.
> 
> Comments?
> 
> 
> For those who might be interested, the full AT91RM9200 patches are
> available from http://maxim.org.za/AT91RM9200/2.6/
> 
> Regards,
>   Andrew Victor


> --- linux-2.6.13-rc2.orig/include/asm-arm/arch-at91rm9200/AT91RM9200_EMAC.h	Thu Jan  1 02:00:00 1970
> +++ linux-2.6.13-rc2/include/asm-arm/arch-at91rm9200/AT91RM9200_EMAC.h	Thu Jul  7 09:41:13 2005

[snip]

> +typedef struct _AT91S_EMAC {
> +	AT91_REG	 EMAC_CTL; 	// Network Control Register
> +	AT91_REG	 EMAC_CFG; 	// Network Configuration Register
> +	AT91_REG	 EMAC_SR; 	// Network Status Register
> +	AT91_REG	 EMAC_TAR; 	// Transmit Address Register
> +	AT91_REG	 EMAC_TCR; 	// Transmit Control Register
> +	AT91_REG	 EMAC_TSR; 	// Transmit Status Register
> +	AT91_REG	 EMAC_RBQP; 	// Receive Buffer Queue Pointer
> +	AT91_REG	 Reserved0[1]; 	//

pretty difficult to verify these are actually being assigned the
correct address?

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
