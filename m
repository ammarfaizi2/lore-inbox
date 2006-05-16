Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750851AbWEPAF1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750851AbWEPAF1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 20:05:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750852AbWEPAF1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 20:05:27 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:11909 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750849AbWEPAF1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 20:05:27 -0400
Subject: Re: pcmcia oops on 2.6.17-rc[12]
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       Andreas Mohr <andi@rhlx01.fht-esslingen.de>, florin@iucha.net,
       linux-kernel@vger.kernel.org, linux@dominikbrodowski.net
In-Reply-To: <Pine.LNX.4.64.0605151644090.3866@g5.osdl.org>
References: <20060423192251.GD8896@iucha.net>
	 <20060423150206.546b7483.akpm@osdl.org>
	 <20060508145609.GA3983@rhlx01.fht-esslingen.de>
	 <20060508084301.5025b25d.akpm@osdl.org>
	 <20060508163453.GB19040@flint.arm.linux.org.uk>
	 <1147730828.26686.165.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0605151459140.3866@g5.osdl.org>
	 <1147734026.26686.200.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0605151629350.3866@g5.osdl.org>
	 <Pine.LNX.4.64.0605151644090.3866@g5.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 16 May 2006 01:17:59 +0100
Message-Id: <1147738680.26686.231.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2006-05-15 at 16:52 -0700, Linus Torvalds wrote:
> Even the ISA drivers that currently do not have SA_SHIRQ won't generally 
> _break_ when/if they were to get a shared interrupt. The reason they don't 
> have SA_SHIRQ isn't generally that they really really want an exclusive 
> interrupt, but simply because they never had a reason to say SA_SHIRQ.

The reason they do it is also however because the ISA bus IRQ allocation
scheme and IRQ probing scheme they use for auto detection relies upon
other users marking the IRQ as exclusively used. The same is true for
things like setserial and ISA ports.

Given the historical use of exclusive IRQ allocation as a resource
management API it appears to be easier just to beat up the PCMCIA
drivers where the resource element is not present (it is tracked
internally by the pcmcia core).

PCMCIA doesn't seem to have too many offenders, and the number of
drivers is low so it won't take long to go over them.

Alan

