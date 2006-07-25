Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932096AbWGYIMk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932096AbWGYIMk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 04:12:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932110AbWGYIMk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 04:12:40 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:33701 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932096AbWGYIMj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 04:12:39 -0400
Subject: Re: [PATCH for 2.6.18rc2] [1/7] i386/x86-64: Don't randomize stack
	top when...
From: Arjan van de Ven <arjan@infradead.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Andi Kleen <ak@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <200607250348_MC3-1-C5FB-CC80@compuserve.com>
References: <200607250348_MC3-1-C5FB-CC80@compuserve.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Tue, 25 Jul 2006 10:12:04 +0200
Message-Id: <1153815124.8932.15.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-07-25 at 03:46 -0400, Chuck Ebbert wrote:
> In-Reply-To: <44c514a8.6HlRR82y133O2bd0%ak@suse.de>
> 
> On Mon, 24 Jul 2006 20:42:48 +0200, Andi Kleen wrote:
> > 
> > --- linux.orig/arch/i386/kernel/process.c
> > +++ linux/arch/i386/kernel/process.c
> > @@ -37,6 +37,7 @@
> >  #include <linux/kallsyms.h>
> >  #include <linux/ptrace.h>
> >  #include <linux/random.h>
> > +#include <linux/personality.h>
> >  
> >  #include <asm/uaccess.h>
> >  #include <asm/pgtable.h>
> > @@ -905,7 +906,7 @@ asmlinkage int sys_get_thread_area(struc
> >  
> >  unsigned long arch_align_stack(unsigned long sp)
> >  {
> > -     if (randomize_va_space)
> > +     if (!(current->personality & ADDR_NO_RANDOMIZE) && randomize_va_space)
> >               sp -= get_random_int() % 8192;
> >       return sp & ~0xf;
> >  }
> 
> I think this needs to be done always, at least on P4.  It really isn't
> 'randomization' at the same high level as the rest -- more like a small
> adjustment.  And the offset should be a multiple of 128 and < 7K (not
> 8K.) Something like this:

the 8K was what Intel proposed for 2.4 quite a while ago and has been in
use in linux for years and years... Can you explain why you are saying
7Kb? throwing away that 1Kb of cache associativity is unfortunate and
shouldn't be done unless there's a good reason, so I'm quite interested
in finding out your reason ;)

Greetings,
   Arjan van de Ven

