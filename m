Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264085AbUD0NyX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264085AbUD0NyX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 09:54:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264094AbUD0NyX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 09:54:23 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:37516 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S264085AbUD0NyV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 09:54:21 -0400
Date: Tue, 27 Apr 2004 15:53:35 +0200
From: Pavel Machek <pavel@suse.cz>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Pavel Machek <pavel@suse.cz>, seife@suse.de,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Nigel Cunningham <ncunningham@linuxmail.com>,
       Roland Stigge <stigge@antcom.de>, 234976@bugs.debian.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Bug#234976: kernel-source-2.6.4: Software Suspend doesn't work
Message-ID: <20040427135335.GP2595@openzaurus.ucw.cz>
References: <1080325072.2112.89.camel@atari.stigge.org> <20040426094834.GA4901@gondor.apana.org.au> <20040426104015.GA5772@gondor.apana.org.au> <opr6193np1ruvnp2@laptop-linux.wpcb.org.au> <20040426131152.GN2595@openzaurus.ucw.cz> <1083048985.12517.21.camel@gaston> <20040427102127.GB10593@elf.ucw.cz> <20040427102344.GA24313@gondor.apana.org.au> <20040427124837.GK10593@elf.ucw.cz> <20040427125402.GA16740@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040427125402.GA16740@gondor.apana.org.au>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > This should be better solution, could anyone test it? [It compiles,
> > and I'm out of time now].
> 
> Well it still doen't solve the non-PSE case since you're only copying the
> top-level page table.

Yes, right, but your patch does not solve that, too, right?
Someone else will have to do that one.

Rather than adding up-to 4M of nonsave pagetables, turning off
paging might be solution there. 
  
And this will actually help. If we move saving few statments before,
we'll have identity mapping so we can turn paging off...

> > --- tmp/linux/arch/i386/power/cpu.c	2003-09-28 22:05:30.000000000 +0200
> > +++ linux/arch/i386/power/cpu.c	2004-04-27 14:44:03.000000000 +0200
> > @@ -35,6 +35,9 @@
> >  unsigned long saved_context_esi, saved_context_edi;
> >  unsigned long saved_context_eflags;
> >  
> > +/* Special page directory for resume */
> > +char swsusp_pg_dir[PAGE_SIZE];
> > +
> 
> You forgot to mark this as nosave.

Hmmm, right. Well, it should work anyway because this is
same in new and old kernel, so I'd still like some testing.
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

