Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751157AbWHXLdn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751157AbWHXLdn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 07:33:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751158AbWHXLdn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 07:33:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:219 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751157AbWHXLdl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 07:33:41 -0400
From: Andi Kleen <ak@suse.de>
To: Suleiman Souhlal <ssouhlal@freebsd.org>
Subject: Re: [PATCH] Fix x86_64 _spin_lock_irqsave()
Date: Thu, 24 Aug 2006 13:32:40 +0200
User-Agent: KMail/1.9.3
Cc: Edward Falk <efalk@google.com>, linux-kernel@vger.kernel.org
References: <44ED157D.6050607@google.com> <p7364gifx8o.fsf@verdi.suse.de> <44ED87AC.8070106@FreeBSD.org>
In-Reply-To: <44ED87AC.8070106@FreeBSD.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608241332.40139.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 24 August 2006 13:04, Suleiman Souhlal wrote:
> Andi Kleen wrote:
> > Edward Falk <efalk@google.com> writes:
> > 
> > 
> >>Add spin_lock_string_flags and _raw_spin_lock_flags() to
> >>asm-x86_64/spinlock.h so that _spin_lock_irqsave() has the same
> >>semantics on x86_64 as it does on i386 and does *not* have interrupts
> >>disabled while it is waiting for the lock.
> > 
> > 
> > Did it fix anything for you?
> 
> I think this was to work around the fact that some buggy drivers try to 
> grab spinlocks without disabling interrupts when they should, which 
> would cause deadlocks when trying to rendez-vous every cpu via IPIs.

That doesn't help them at all because they could then deadlock later.

In theory it is just a quite cheesy way to make lock contended code
work a little better, but I was not aware of it actually helping 
in practice.

-Andi


> 
