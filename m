Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751379AbWHXNW3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751379AbWHXNW3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 09:22:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751381AbWHXNW3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 09:22:29 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:41903 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751379AbWHXNW2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 09:22:28 -0400
Subject: Re: [PATCH] Fix x86_64 _spin_lock_irqsave()
From: Arjan van de Ven <arjan@infradead.org>
To: Suleiman Souhlal <ssouhlal@FreeBSD.org>
Cc: Andi Kleen <ak@suse.de>, Edward Falk <efalk@google.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <44ED9CB4.7070302@FreeBSD.org>
References: <44ED157D.6050607@google.com> <p7364gifx8o.fsf@verdi.suse.de>
	 <44ED87AC.8070106@FreeBSD.org> <200608241332.40139.ak@suse.de>
	 <44ED9CB4.7070302@FreeBSD.org>
Content-Type: text/plain
Organization: Intel International BV
Date: Thu, 24 Aug 2006 15:21:58 +0200
Message-Id: <1156425718.3014.64.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-24 at 14:33 +0200, Suleiman Souhlal wrote:
> Andi Kleen wrote:
> > On Thursday 24 August 2006 13:04, Suleiman Souhlal wrote:
> > 
> >>Andi Kleen wrote:
> >>
> >>>Edward Falk <efalk@google.com> writes:
> >>>
> >>>
> >>>
> >>>>Add spin_lock_string_flags and _raw_spin_lock_flags() to
> >>>>asm-x86_64/spinlock.h so that _spin_lock_irqsave() has the same
> >>>>semantics on x86_64 as it does on i386 and does *not* have interrupts
> >>>>disabled while it is waiting for the lock.
> >>>
> >>>
> >>>Did it fix anything for you?
> >>
> >>I think this was to work around the fact that some buggy drivers try to 
> >>grab spinlocks without disabling interrupts when they should, which 
> >>would cause deadlocks when trying to rendez-vous every cpu via IPIs.
> > 
> > 
> > That doesn't help them at all because they could then deadlock later.
> 
> If the driver uses spin_lock() when it knows that the hardware won't 
> generate the interrupt that would need to be masked, and 
> spin_lock_irqsave() elsewhere, there shouldn't be any deadlocks unless 
> IPIs are involved.

this still is bad practice and lockdep will also scream about it

Can you point at ANY place that does this? 


