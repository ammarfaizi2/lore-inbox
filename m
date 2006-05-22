Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750772AbWEVL4o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750772AbWEVL4o (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 07:56:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750783AbWEVL4o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 07:56:44 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:13521 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750772AbWEVL4n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 07:56:43 -0400
Subject: Re: pcmcia oops on 2.6.17-rc[12]
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       Andreas Mohr <andi@rhlx01.fht-esslingen.de>, florin@iucha.net,
       linux-kernel@vger.kernel.org, linux@dominikbrodowski.net
In-Reply-To: <20060522115046.GA23074@bitwizard.nl>
References: <20060423192251.GD8896@iucha.net>
	 <20060423150206.546b7483.akpm@osdl.org>
	 <20060508145609.GA3983@rhlx01.fht-esslingen.de>
	 <20060508084301.5025b25d.akpm@osdl.org>
	 <20060508163453.GB19040@flint.arm.linux.org.uk>
	 <1147730828.26686.165.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0605151459140.3866@g5.osdl.org>
	 <1147734026.26686.200.camel@localhost.localdomain>
	 <20060522115046.GA23074@bitwizard.nl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 22 May 2006 13:10:04 +0100
Message-Id: <1148299804.17376.34.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2006-05-22 at 13:50 +0200, Rogier Wolff wrote:
> The question I'm stuck with is: When is it valid to ask for a non-shared
> IRQ, and get back a shared one. 

I don't think it is. The problem is that some PCMCIA drivers currently
assume they can do so. The rules changed a bit over time on the hardware
side. The real fix is to squash those. I sent out a patch which warns
when a shared IRQ is given and an exclusive one requested so that it is
possible to pin down offenders.

> I happen to know (ISA) hardware that CANNOT share an interrupt: It
> drives the IRQ line either high or low, and has a driver that will

You happen to be wrong. Some ISA boards use the correct diodes and
pulldowns and can share an IRQ line although being edge triggered you
must take great care to get it right.

Alan

