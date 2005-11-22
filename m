Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965140AbVKVTWa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965140AbVKVTWa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 14:22:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965137AbVKVTWa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 14:22:30 -0500
Received: from smtp.osdl.org ([65.172.181.4]:9857 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965136AbVKVTW2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 14:22:28 -0500
Date: Tue, 22 Nov 2005 11:21:50 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: David Woodhouse <dwmw2@infradead.org>
cc: David Howells <dhowells@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@elte.hu>,
       Matthew Wilcox <matthew@wil.cx>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>,
       Ian Molton <spyro@f2s.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 4/5] Centralise NO_IRQ definition
In-Reply-To: <1132686213.15117.135.camel@baythorne.infradead.org>
Message-ID: <Pine.LNX.4.64.0511221113390.13959@g5.osdl.org>
References: <Pine.LNX.4.64.0511220856470.13959@g5.osdl.org> 
 <E1Ee0G0-0004CN-Az@localhost.localdomain>  <24299.1132571556@warthog.cambridge.redhat.com>
  <20051121121454.GA1598@parisc-linux.org>  <Pine.LNX.4.64.0511211047260.13959@g5.osdl.org>
  <20051121190632.GG1598@parisc-linux.org>  <Pine.LNX.4.64.0511211124190.13959@g5.osdl.org>
  <20051121194348.GH1598@parisc-linux.org>  <Pine.LNX.4.64.0511211150040.13959@g5.osdl.org>
  <20051121211544.GA4924@elte.hu>  <17282.15177.804471.298409@cargo.ozlabs.ibm.com>
  <1132611631.11842.83.camel@localhost.localdomain> 
 <1132657991.15117.76.camel@baythorne.infradead.org> 
 <1132668939.20233.47.camel@localhost.localdomain>  <9497.1132684676@warthog.cambridge.redhat.com>
 <1132686213.15117.135.camel@baythorne.infradead.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="21872808-527230342-1132687310=:13959"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--21872808-527230342-1132687310=:13959
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT



On Tue, 22 Nov 2005, David Woodhouse wrote:
> 
> This is true. If we're suddenly going to start pretending that IRQ 0
> isn't a valid interrupt merely on the basis that "x86 doesn't use it"¹,
> then we can't really go making an exception to allow us to use IRQ 0 on
> i386.

Of _course_ "irq0" is a valid irq. On PC's, it's usually the timer 
interrupt.

It's the "dev->irq" _cookie_ zero that means it is does not have an irq.

If you have a physical "irq 0" that is bound to a device, it needs a 
cookie, and that cookie can't be 0, because that means the device has no 
interrupt.

How hard is that to understand? Why do people mix these up?

		Linus
--21872808-527230342-1132687310=:13959--
