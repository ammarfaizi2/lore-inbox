Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750790AbWEOXiM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750790AbWEOXiM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 19:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750795AbWEOXiM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 19:38:12 -0400
Received: from smtp.osdl.org ([65.172.181.4]:7658 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750790AbWEOXiK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 19:38:10 -0400
Date: Mon, 15 May 2006 16:37:40 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Russell King <rmk+lkml@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       Andreas Mohr <andi@rhlx01.fht-esslingen.de>, florin@iucha.net,
       linux-kernel@vger.kernel.org, linux@dominikbrodowski.net
Subject: Re: pcmcia oops on 2.6.17-rc[12]
In-Reply-To: <1147734026.26686.200.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0605151629350.3866@g5.osdl.org>
References: <20060423192251.GD8896@iucha.net>  <20060423150206.546b7483.akpm@osdl.org>
  <20060508145609.GA3983@rhlx01.fht-esslingen.de>  <20060508084301.5025b25d.akpm@osdl.org>
  <20060508163453.GB19040@flint.arm.linux.org.uk> 
 <1147730828.26686.165.camel@localhost.localdomain> 
 <Pine.LNX.4.64.0605151459140.3866@g5.osdl.org> <1147734026.26686.200.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 16 May 2006, Alan Cox wrote:
> 
> It would certainly be a lot cleaner than this sort of code in the pcmcia
> core right now. Want me to send a patch which only allows for SA_SHIRQ
> and WARN_ON()'s for any driver not asking for shared IRQ ?

I think it's too late for that in the current series, but yes, we could do 
it for 2.6.18.

There are a few valid reasons for not using SA_SHIRQ, but they tend to be 
really special. Ie you'd better _know_ that you're either some system 
device, or you're physically in an ISA slot, not just based on some old 
ISA design. And PCMCIA is no longer an excuse, exactly because of some 
systems that will route even the 16-bit interrupts through a PCI irq.

So anything in arch/ is likely ok (for example, the vm86 interrupt 
handling on x86 had _better_ be an exclusive interrupt ;)

Doing a quick grep shows a surprising amount of drivers that pass in zero, 
but I guess that they truly _are_ old ISA sound/networking drivers.

		Linus
