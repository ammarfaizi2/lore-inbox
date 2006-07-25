Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932453AbWGYEzq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932453AbWGYEzq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 00:55:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932455AbWGYEzq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 00:55:46 -0400
Received: from [212.70.37.245] ([212.70.37.245]:13576 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S932453AbWGYEzp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 00:55:45 -0400
From: Al Boldi <a1426z@gawab.com>
To: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [PATCH] x86: Don't randomize stack unless current->personality permits it
Date: Tue, 25 Jul 2006 07:57:04 +0300
User-Agent: KMail/1.5
Cc: Paulo Marques <pmarques@grupopie.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Frank van Maarseveen <frankvm@frankvm.com>
References: <200607242023_MC3-1-C5FE-CADA@compuserve.com>
In-Reply-To: <200607242023_MC3-1-C5FE-CADA@compuserve.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="windows-1256"
Content-Transfer-Encoding: 7bit
Message-Id: <200607250757.04664.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Ebbert wrote:
> On Mon, 24 Jul 2006 18:57:46 +0300, Al Boldi wrote:
> > > With your changes on:
> > >
> > > stock kernel, randomize_va_space=0, gcc.322 -Os tstExec.c,
> > > while :; do ./a.out; done
> > > &x = 0xbffff874, &y = 0xbffff86c   28   28
> > > &x = 0xbffff874, &y = 0xbffff86c   27   27
> > > &x = 0xbffff874, &y = 0xbffff86c   27   27
> > > &x = 0xbffff874, &y = 0xbffff86c   28   27
> > > &x = 0xbffff874, &y = 0xbffff86c   27   30
> > > &x = 0xbffff874, &y = 0xbffff86c   27   29
> > >
> > > stock kernel, randomize_va_space=1, gcc.322 -Os tstExec.c,
> > > while :; do ./a.out; done
> > > &x = 0xbfe2e614, &y = 0xbfe2e60c   29   28
> > > &x = 0xbfd6a104, &y = 0xbfd6a0fc   55   56
> > > &x = 0xbf91d454, &y = 0xbf91d44c   27   27
> > > &x = 0xbf941e84, &y = 0xbf941e7c   55   56
> > > &x = 0xbfa75834, &y = 0xbfa7582c   28   27
> > > &x = 0xbfb58634, &y = 0xbfb5862c   27   30
> >
> > After closer inspection, it looks like addresses ending with 3c,7c,bc,fc
> > cause a slowdown on P4, while addresses ending with
> > 1c,3c,5c,7c,9c,bc,dc,fc cause a slowdown on P2.
>
> Those addresses cause 'y' to span a cacheline (P4 = 64 bytes, P2 = 32.)
> Even when the kernel aligns to 128 bytes this could happen depending
> on how deeply you nest functions.
>
> > Any easy way to instruct the kernel to skip those addresses?
>
> First, I think you need to define locals in order of decreasing size.
> IOW 'x' and 'y' need to be first inside fn(), but that may not work
> when things get inlined.  So using the '-malign-double' GCC option,
> or forcing alignment with '__attribute__ ((aligned(8)))' for each variable
> might be better.
>
> Then you have to make sure the stack is aligned. See
> '-mpreferred-stack-boundary'.

This would imply a recompile, what about precompiled dists?  Do they compile 
the sources this way?

> I still think the kernel should be aligning the stack to 128 bytes anyway.

I think so too, but can you see how randomization aggravates the situation?


Thanks!

--
Al

