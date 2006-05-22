Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751278AbWEVWZI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278AbWEVWZI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 18:25:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751274AbWEVWZI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 18:25:08 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:49851 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751279AbWEVWZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 18:25:07 -0400
Subject: Re: pcmcia oops on 2.6.17-rc[12]
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       Andreas Mohr <andi@rhlx01.fht-esslingen.de>, florin@iucha.net,
       linux-kernel@vger.kernel.org, linux@dominikbrodowski.net
In-Reply-To: <20060522212724.GC9454@bitwizard.nl>
References: <20060423192251.GD8896@iucha.net>
	 <20060423150206.546b7483.akpm@osdl.org>
	 <20060508145609.GA3983@rhlx01.fht-esslingen.de>
	 <20060508084301.5025b25d.akpm@osdl.org>
	 <20060508163453.GB19040@flint.arm.linux.org.uk>
	 <1147730828.26686.165.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0605151459140.3866@g5.osdl.org>
	 <1147734026.26686.200.camel@localhost.localdomain>
	 <20060522115046.GA23074@bitwizard.nl>
	 <1148299804.17376.34.camel@localhost.localdomain>
	 <20060522212724.GC9454@bitwizard.nl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 22 May 2006 23:38:28 +0100
Message-Id: <1148337508.17376.147.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2006-05-22 at 23:27 +0200, Rogier Wolff wrote:
> Fine. I know hardware that /cannot/ share interrupts. So, my driver
> requesting an interrupt, and getting: "Can't allocate interrupt" is an
> indication of a hardware configuration error. Or software (you've been
> telling one of the drivers the wrong interrupt line). If you force
> "shared mode", my driver will cope (it works just great on the PCI
> version of the card, no problem). But will the hardware?

Depends on the backplane

> You guys maybe trying to fix very real problems in PCMCIA land, of
> which I have very little knowledge. But changing what "not passing
> SA_SHIRQ" means globlaly IMHO changes too much... 

PCMCIA doesn't need any big changes. The rules are simple. PCMCIA IRQs
today are shared, period. Because of the way the hardware works this
isn't an electrical issue. Drivers that ask for an exclusive PCMCIA IRQ
need to wake up and smell the coffee and get fixed.

Alan

