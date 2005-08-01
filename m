Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262275AbVHAAou@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262275AbVHAAou (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 20:44:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262280AbVHAAou
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 20:44:50 -0400
Received: from rproxy.gmail.com ([64.233.170.198]:58468 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262275AbVHAAot convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 20:44:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tWK2cDtDmckZlfgNdXGoxMDVgLpcr4UJzOu34uiTmZpfxVwu3iziqJK4ky/XP2F0Te5DTq/hsMH/n4ioe7iA7VZUOZ1MUmF7scVAsrjtCvBlW9GbOd/adlJ88oQrm+CN16VUdvlUnNPz+wl5l8ZgoOUKfyeVAb/7hgQ5WiC+ri4=
Message-ID: <21d7e9970507311744261a3bb7@mail.gmail.com>
Date: Mon, 1 Aug 2005 10:44:45 +1000
From: Dave Airlie <airlied@gmail.com>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: revert yenta free_irq on suspend
Cc: Pavel Machek <pavel@ucw.cz>, ambx1@neo.rr.com,
       Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       Daniel Ritz <daniel.ritz@gmx.ch>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Len Brown <len.brown@intel.com>
In-Reply-To: <Pine.LNX.4.58.0507311709410.14342@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <2e00842e116e.2e116e2e0084@columbus.rr.com>
	 <Pine.LNX.4.58.0507311550400.14342@g5.osdl.org>
	 <20050731230507.GE27580@elf.ucw.cz>
	 <Pine.LNX.4.58.0507311622510.14342@g5.osdl.org>
	 <20050731232735.GF27580@elf.ucw.cz>
	 <Pine.LNX.4.58.0507311635360.14342@g5.osdl.org>
	 <21d7e9970507311659259e5560@mail.gmail.com>
	 <Pine.LNX.4.58.0507311709410.14342@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, 1 Aug 2005, Dave Airlie wrote:
> >
> > That still doesn't handle the case where a device has an interrupt
> > handler on a shared IRQ and another device on the chain interrupts it
> > after it has suspended its device,
> 
> I don't know why people bother arguing about this. Face the facts: we have
> to do things incrementally. Any design that breaks unmodified drivers is
> by _definition_ broken. You can't fix all drivers, and anybody who starts
> their arguments with "we should just fix drivers" is living in la-la-land.
> 
>

I'm not arguing at all I agree with you, but I think you are missing
the point I'm trying to make,

You said earlier we only should fix drivers that need fixing, but they
all need fixing, I'm trying to see which way they should be fixed,
either the PM people say we need request/free irq pairs or say we need
to put support code in the interrupt handlers,

I fail to see how I can fix this very well incrementally, on my
hardware I have a yenta, my patch fixes it to work, on Hughs hardware
he has his yenta sharing IRQs with another driver which doesn't do the
request/free and it breaks, it isn't the yenta drivers fault the other
driver causes the issue, so therefore in order to apply the yenta fix
I need to go around and fix all the other drivers that might share an
interrupt with it before I can get patch accepted so that I don't
break someones machine? this is irrelevant to whether the ACPI link
change is in or not, adding the request/free pairs to one driver can
show up issues in other drivers that share that IRQ..

This has nothing to do with the issues with highlevel PM interfaces
for shutting down hardware, this is do with fixing the drivers in the
kernel currently and what the correct way to do it is without breaking
someone elses hardware....

Dave.
