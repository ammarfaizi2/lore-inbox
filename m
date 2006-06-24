Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964845AbWFXLx5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964845AbWFXLx5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 07:53:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964787AbWFXLxz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 07:53:55 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:30592 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S964782AbWFXLxy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 07:53:54 -0400
Date: Sat, 24 Jun 2006 07:53:32 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: "H. Peter Anvin" <hpa@zytor.com>
cc: Chuck Ebbert <76306.1226@compuserve.com>, linux-kernel@vger.kernel.org,
       mbligh@mbligh.org, Mattia Dongili <malattia@linux.it>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: fs/binfmt_aout.o, Error: suffix or operands invalid for  `cmp'
 [was Re: 2.6.1
In-Reply-To: <449C168F.30708@zytor.com>
Message-ID: <Pine.LNX.4.58.0606240747430.22321@gandalf.stny.rr.com>
References: <200606220238_MC3-1-C321-1AC2@compuserve.com> <449AB908.30002@zytor.com>
 <Pine.LNX.4.58.0606230456220.1145@gandalf.stny.rr.com> <449C168F.30708@zytor.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 23 Jun 2006, H. Peter Anvin wrote:

> Steven Rostedt wrote:
> >>>
> >> It's not (it's #APP, i.e. inline assembly); rather, it's an illegal
> >> constraint.
> >
> > It's GCC optimizing a little too much.
> >
>
> No, it's not...

Yes it is! Calm down, I didn't say it was GCC's fault!

> it's the author of the inline assembly who told gcc a
> lie at what it was allowed to optimize.  The constraint is "g"
> (equivalent to "rmi"), but "rm" is the correct constraint.

And this is why it over optimized.  It was the fault of the inline
assembly author.  He/she gave it the wrong constraint and this was
the reason for GCC over optimizing.  If it didn't over optimize than
it would have worked.  But the bug is with the code and not GCC.

>
> There is already a patch in Andrew's repo for this.

Then this is all OK.

>
>  >
> > #define __range_ok(addr,size) ({ \
> > 	unsigned long flag,sum; \
> > 	__chk_user_ptr(addr); \
> > 	asm("addl %3,%1 ; sbbl %0,%0; cmpl %1,%4; sbbl $0,%0" \
> > 		:"=&r" (flag), "=r" (sum) \
> > 		:"1" (addr),"g" ((int)(size)),"g" (current_thread_info()->addr_limit.seg)); \
> > 	flag; })
> >
> > What happened was that gcc optimized the
> > (current_thread_info()->addre_limit.seg to be a constant. Thus cmpl
> > failed.
> >
>
> ... perfectly legally so, given the "g" constraint.
>

I never said it wasn't legal.

-- Steve

