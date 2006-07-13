Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030381AbWGMUuh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030381AbWGMUuh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 16:50:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030385AbWGMUug
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 16:50:36 -0400
Received: from [83.101.155.109] ([83.101.155.109]:28422 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S1030381AbWGMUuf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 16:50:35 -0400
From: Al Boldi <a1426z@gawab.com>
To: Frank van Maarseveen <frankvm@frankvm.com>
Subject: Re: [PATCH] x86: Don't randomize stack unless current->personality permits it
Date: Thu, 13 Jul 2006 23:51:04 +0300
User-Agent: KMail/1.5
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@suse.de>
References: <200607112257.22069.a1426z@gawab.com> <p73sll6n73t.fsf@verdi.suse.de> <20060713094402.GB2448@janus>
In-Reply-To: <20060713094402.GB2448@janus>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="windows-1256"
Content-Transfer-Encoding: 7bit
Message-Id: <200607132351.04721.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frank van Maarseveen wrote:
> On Wed, Jul 12, 2006 at 06:03:18PM +0200, Andi Kleen wrote:
> > Al Boldi <a1426z@gawab.com> writes:
> > > Frank van Maarseveen wrote:
> > > > Do not randomize stack location unless current->personality permits
> > > > it.
>
> [...]
>
> > > It still blips on my system.
> > >
> > > echo 0 > /proc/sys/kernel/randomize_va_space makes the blips go away.
> > >
> > > ???
> >
> > fs/binfmt_elf.c:randomize_stack_top would need the same check
>
> Actually, randomize_stack_top() checks
>
> 	if (current->flags & PF_RANDOMIZE) {
>
> and it's only called from load_elf_binary() right after this:
>
> 	if (!(current->personality & ADDR_NO_RANDOMIZE) && randomize_va_space)
> 		current->flags |= PF_RANDOMIZE;
>
> Further on create_elf_tables() is called and that one calls
> arch_align_stack() so maybe it is more appropriate to test (current->flags
> & PF_RANDOMIZE) in arch_align_stack() instead of recomputing it.

exec.c uses arch_align_stack() also for non-elf.

BTW, why does randomize_stack_top() mod against (8192*1024) instead of (8192) 
like arch_align_stack()?


Thanks!

--
Al

