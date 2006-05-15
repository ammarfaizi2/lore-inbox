Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750707AbWEOWrs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750707AbWEOWrs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 18:47:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750708AbWEOWrs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 18:47:48 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:11931 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750707AbWEOWrr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 18:47:47 -0400
Subject: Re: pcmcia oops on 2.6.17-rc[12]
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       Andreas Mohr <andi@rhlx01.fht-esslingen.de>, florin@iucha.net,
       linux-kernel@vger.kernel.org, linux@dominikbrodowski.net
In-Reply-To: <Pine.LNX.4.64.0605151459140.3866@g5.osdl.org>
References: <20060423192251.GD8896@iucha.net>
	 <20060423150206.546b7483.akpm@osdl.org>
	 <20060508145609.GA3983@rhlx01.fht-esslingen.de>
	 <20060508084301.5025b25d.akpm@osdl.org>
	 <20060508163453.GB19040@flint.arm.linux.org.uk>
	 <1147730828.26686.165.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0605151459140.3866@g5.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 16 May 2006 00:00:26 +0100
Message-Id: <1147734026.26686.200.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2006-05-15 at 15:02 -0700, Linus Torvalds wrote:
> Note that some PCMCIA architectures simply _will_not_ give you a private 
> IRQ. Ever. They may not have any ISA interrupts to give, even to old 
> 16-bit cards. So the choice may be "shared irq or nothing".

Yes I realise that, the test patches in my tree will hand back a shared
one but hand back the status so you know you asked for exclusive, got
shared and need to decide.

> So I would strongly argue that any driver that depends on getting an 
> exclusive IRQ is buggy, not the PCMCIA layer itself, and that it would be 
> a lot more productive to try to fix those drivers.

It would certainly be a lot cleaner than this sort of code in the pcmcia
core right now. Want me to send a patch which only allows for SA_SHIRQ
and WARN_ON()'s for any driver not asking for shared IRQ ?
