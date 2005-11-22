Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965115AbVKVTED@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965115AbVKVTED (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 14:04:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965116AbVKVTED
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 14:04:03 -0500
Received: from baythorne.infradead.org ([81.187.2.161]:46240 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S965115AbVKVTEA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 14:04:00 -0500
Subject: Re: [PATCH 4/5] Centralise NO_IRQ definition
From: David Woodhouse <dwmw2@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@elte.hu>,
       Matthew Wilcox <matthew@wil.cx>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>,
       Ian Molton <spyro@f2s.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <9497.1132684676@warthog.cambridge.redhat.com>
References: <Pine.LNX.4.64.0511220856470.13959@g5.osdl.org>
	 <E1Ee0G0-0004CN-Az@localhost.localdomain>
	 <24299.1132571556@warthog.cambridge.redhat.com>
	 <20051121121454.GA1598@parisc-linux.org>
	 <Pine.LNX.4.64.0511211047260.13959@g5.osdl.org>
	 <20051121190632.GG1598@parisc-linux.org>
	 <Pine.LNX.4.64.0511211124190.13959@g5.osdl.org>
	 <20051121194348.GH1598@parisc-linux.org>
	 <Pine.LNX.4.64.0511211150040.13959@g5.osdl.org>
	 <20051121211544.GA4924@elte.hu>
	 <17282.15177.804471.298409@cargo.ozlabs.ibm.com>
	 <1132611631.11842.83.camel@localhost.localdomain>
	 <1132657991.15117.76.camel@baythorne.infradead.org>
	 <1132668939.20233.47.camel@localhost.localdomain>
	 <9497.1132684676@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=UTF-8
Date: Tue, 22 Nov 2005 19:03:33 +0000
Message-Id: <1132686213.15117.135.camel@baythorne.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by baythorne.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-11-22 at 18:37 +0000, David Howells wrote:
> 
>  (3) Having to translate a cookie for a specific IRQ means that the IRQ
>      handling code will be slower and more complex, or is going to avoid the
>      issue and be naughty and not deal with irq == NO_IRQ properly:
> 
>      The x86 PIC reports it as IRQ 0 having happened. In which case, by your
>      argument, you _have_ to translate it: you're not allowed to pass NO_IRQ to
>      setup_irq(), and you're not allowed to pass it to the interrupt handler -
>      in this case timer_interrupt(). Doing otherwise is wrong, insane, etc...

This is true. If we're suddenly going to start pretending that IRQ 0
isn't a valid interrupt merely on the basis that "x86 doesn't use it"¹,
then we can't really go making an exception to allow us to use IRQ 0 on
i386.

-- 
dwmw2
¹ ...despite the fact that even that isn't true on legacy-free machines.

