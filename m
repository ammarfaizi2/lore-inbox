Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750874AbWEPASx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750874AbWEPASx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 20:18:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750875AbWEPASx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 20:18:53 -0400
Received: from smtp.osdl.org ([65.172.181.4]:45449 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750871AbWEPASx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 20:18:53 -0400
Date: Mon, 15 May 2006 17:18:28 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Russell King <rmk+lkml@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       Andreas Mohr <andi@rhlx01.fht-esslingen.de>, florin@iucha.net,
       linux-kernel@vger.kernel.org, linux@dominikbrodowski.net
Subject: Re: pcmcia oops on 2.6.17-rc[12]
In-Reply-To: <1147738680.26686.231.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0605151715290.3866@g5.osdl.org>
References: <20060423192251.GD8896@iucha.net>  <20060423150206.546b7483.akpm@osdl.org>
  <20060508145609.GA3983@rhlx01.fht-esslingen.de>  <20060508084301.5025b25d.akpm@osdl.org>
  <20060508163453.GB19040@flint.arm.linux.org.uk> 
 <1147730828.26686.165.camel@localhost.localdomain> 
 <Pine.LNX.4.64.0605151459140.3866@g5.osdl.org>  <1147734026.26686.200.camel@localhost.localdomain>
  <Pine.LNX.4.64.0605151629350.3866@g5.osdl.org>  <Pine.LNX.4.64.0605151644090.3866@g5.osdl.org>
 <1147738680.26686.231.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 16 May 2006, Alan Cox wrote:
> 
> The reason they do it is also however because the ISA bus IRQ allocation
> scheme and IRQ probing scheme they use for auto detection relies upon
> other users marking the IRQ as exclusively used. The same is true for
> things like setserial and ISA ports.

The irq auto-detection should work with shared interrupts, but yes, it 
won't _detect_ them if they are already in use (but it's ok with them 
becoming shared later).

That said, true ISA cards obviously won't ever have a shared irq, in any 
normal circumstances.

Which is one reason why I think it would be silly to force such a driver 
to use a SA_SHIRQ flag, and would prefer to do it the other way instead 
(ie make drivers that fundamentally _require_ - as opposed to "in 
practice use" - an exclusive interrupt say so).

> PCMCIA doesn't seem to have too many offenders, and the number of
> drivers is low so it won't take long to go over them.

Yeah. 

		Linus
