Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964877AbWGMJoF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964877AbWGMJoF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 05:44:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964881AbWGMJoF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 05:44:05 -0400
Received: from frankvm.xs4all.nl ([80.126.170.174]:31886 "EHLO
	janus.localdomain") by vger.kernel.org with ESMTP id S964877AbWGMJoE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 05:44:04 -0400
Date: Thu, 13 Jul 2006 11:44:02 +0200
From: Frank van Maarseveen <frankvm@frankvm.com>
To: Andi Kleen <ak@suse.de>
Cc: Al Boldi <a1426z@gawab.com>, Arjan van de Ven <arjan@infradead.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: Don't randomize stack unless current->personality permits it
Message-ID: <20060713094402.GB2448@janus>
References: <200607112257.22069.a1426z@gawab.com> <p73sll6n73t.fsf@verdi.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73sll6n73t.fsf@verdi.suse.de>
User-Agent: Mutt/1.4.1i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2006 at 06:03:18PM +0200, Andi Kleen wrote:
> Al Boldi <a1426z@gawab.com> writes:
> 
> > Frank van Maarseveen wrote:
> > >
> > > Do not randomize stack location unless current->personality permits it.
[...]
> > 
> > It still blips on my system.
> > 
> > echo 0 > /proc/sys/kernel/randomize_va_space makes the blips go away.
> > 
> > ???
> 
> fs/binfmt_elf.c:randomize_stack_top would need the same check

Actually, randomize_stack_top() checks

	if (current->flags & PF_RANDOMIZE) {

and it's only called from load_elf_binary() right after this:

	if (!(current->personality & ADDR_NO_RANDOMIZE) && randomize_va_space)
		current->flags |= PF_RANDOMIZE;

Further on create_elf_tables() is called and that one calls arch_align_stack()
so maybe it is more appropriate to test (current->flags & PF_RANDOMIZE) in
arch_align_stack() instead of recomputing it.

-- 
Frank
