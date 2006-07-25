Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932314AbWGYLid@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932314AbWGYLid (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 07:38:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932322AbWGYLid
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 07:38:33 -0400
Received: from ns2.suse.de ([195.135.220.15]:7143 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932314AbWGYLic (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 07:38:32 -0400
From: Andi Kleen <ak@suse.de>
To: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [PATCH for 2.6.18rc2] [1/7] i386/x86-64: Don't randomize stack top when...
Date: Tue, 25 Jul 2006 13:38:44 +0200
User-Agent: KMail/1.9.1
Cc: Arjan van de Ven <arjan@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
References: <200607250508_MC3-1-C604-C1C9@compuserve.com>
In-Reply-To: <200607250508_MC3-1-C604-C1C9@compuserve.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607251338.45215.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 25 July 2006 11:06, Chuck Ebbert wrote:
> In-Reply-To: <1153815124.8932.15.camel@laptopd505.fenrus.org>
>
> On Tue, 25 Jul 2006 10:12:04 +0200, Arjan van de Ven wrote:
> > > >  unsigned long arch_align_stack(unsigned long sp)
> > > >  {
> > > > -     if (randomize_va_space)
> > > > +     if (!(current->personality & ADDR_NO_RANDOMIZE) &&
> > > > randomize_va_space) sp -= get_random_int() % 8192;
> > > >       return sp & ~0xf;
> > > >  }
> > >
> > > I think this needs to be done always, at least on P4.  It really isn't
> > > 'randomization' at the same high level as the rest -- more like a small
> > > adjustment.  And the offset should be a multiple of 128 and < 7K (not
> > > 8K.) Something like this:
> >
> > the 8K was what Intel proposed for 2.4 quite a while ago and has been in
> > use in linux for years and years... Can you explain why you are saying
> > 7Kb? throwing away that 1Kb of cache associativity is unfortunate and
> > shouldn't be done unless there's a good reason, so I'm quite interested
> > in finding out your reason ;)
>
> Well that's what the Intel IA-32 optimization manual says:

The reason I allowed to disable it is that it is sometimes very useful
for debugging if you can get 100% reproducible addresses.

-Andi

