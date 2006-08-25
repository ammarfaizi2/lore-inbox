Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964815AbWHYGWZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964815AbWHYGWZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 02:22:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964840AbWHYGWZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 02:22:25 -0400
Received: from cantor2.suse.de ([195.135.220.15]:60312 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964815AbWHYGWY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 02:22:24 -0400
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Fix x86_64 _spin_lock_irqsave()
Date: Fri, 25 Aug 2006 08:21:44 +0200
User-Agent: KMail/1.9.3
Cc: Edward Falk <efalk@google.com>, linux-kernel@vger.kernel.org
References: <44ED157D.6050607@google.com> <p7364gifx8o.fsf@verdi.suse.de> <20060824213828.5504b4de.akpm@osdl.org>
In-Reply-To: <20060824213828.5504b4de.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200608250821.44620.ak@suse.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 25 August 2006 06:38, Andrew Morton wrote:
> On 24 Aug 2006 08:45:11 +0200
> Andi Kleen <ak@suse.de> wrote:
> 
> > Edward Falk <efalk@google.com> writes:
> > 
> > > Add spin_lock_string_flags and _raw_spin_lock_flags() to
> > > asm-x86_64/spinlock.h so that _spin_lock_irqsave() has the same
> > > semantics on x86_64 as it does on i386 and does *not* have interrupts
> > > disabled while it is waiting for the lock.
> > 
> > Did it fix anything for you?
> > 
> 
> It's the rendezvous-via-IPI problem.  Suppose we want to capture all CPUs
> in an IPI handler (TSC sync, for example).
> 
> - CPUa holds read_lock(&tasklist_lock)
> - CPUb is spinning in write_lock_irq(&taslist_lock)

But he didn't actually change the rwlocks, only the plain old spinlocks!

Anyways I applied the patch for now (and cleaned it up in the next patch), 
but I could have probably gotten away with not.

Edward, next time please add a Signed-off-by line.

-Andi
