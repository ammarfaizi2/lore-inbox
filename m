Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965066AbVINHsz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965066AbVINHsz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 03:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965071AbVINHsz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 03:48:55 -0400
Received: from mailout11.sul.t-online.com ([194.25.134.85]:15766 "EHLO
	mailout11.sul.t-online.com") by vger.kernel.org with ESMTP
	id S965066AbVINHsy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 03:48:54 -0400
Message-Id: <5.1.0.14.2.20050914092308.025ca630@pop.t-online.de>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 14 Sep 2005 09:48:31 +0200
To: Denis Vlasenko <vda@ilport.com.ua>
From: Margit Schubert-While <margitsw@t-online.de>
Subject: Re: 2.6.13/14 x86 Makefile - Pentiums penalized ?
Cc: chriswhite@gentoo.org, linux-kernel@vger.kernel.org,
       zwane@arm.linux.org.uk
In-Reply-To: <200509140959.05902.vda@ilport.com.ua>
References: <Pine.LNX.4.61.0509132345050.13185@montezuma.fsmlabs.com>
 <5.1.0.14.2.20050913075517.0259c498@pop.t-online.de>
 <200509141414.08343.chriswhite@gentoo.org>
 <Pine.LNX.4.61.0509132345050.13185@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
X-ID: JbQYSiZVgeZMYuQwgziF9fFSivtMMf0KOpDAeCk9oVaQQA0NOF7CEa
X-TOI-MSGID: cfb74a65-8cab-4430-8956-c73a24b94e82
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 09:59 14.09.2005 +0300, Denis Vlasenko wrote:
>On Wednesday 14 September 2005 09:48, Zwane Mwaikambo wrote:
> > On Wed, 14 Sep 2005, Chris White wrote:
> >
> > > That's correct, gcc 3.4 started the -mtune flag.  Chances are if you 
> really
> > > want the -mtune optimizations you're going to have to upgrade to gcc 
> 3.4 or
> > > greater.
> > >
> > > > This, of course, heavily penalizes P4's (the notorious inc/dec).
> > >
> > > Are you referring to cpu cycle counts?  Is there certain code that 
> causes the
> > > kernel to perform that unfavorably by a large scale?
> >
> > It's documented as being suboptimal to use inc/dec due to it modifying all
> > of eflags resulting in dependency related stalls. add/sub only modifies
> > one bit of eflags so is more optimal. However there is a problem of
>
>?! add/sub doesn't modify "only one bit in eflags", it modifies all.
>In fact, it's dec/inc which does not modify all bits.
>It doesn't touch 'carry' bit (IIRC).
>
>If inc/dec is slower on P4, it must be just another P4 quirk.
>
> > increased code size with add/sub.
> >
> > But i've never benchmarked all of this ;)
>
>I don't even have one to test this.


In the Intel Architecture Optimization document it specifically states 
(Chapter 2.6) :
"Avoid instructions that unnecessarily introduce dependence-related
stalls: inc and dec instructions, .....".
And again on page 2-11 :
"The inc and dec instructions should always be avoided. Using add and
sub instructions instead avoids data dependence and improves performance".
And on page 2-71 :
"The inc and dec instructions modify only a subset of flags in the flag 
register.
This creates a dependence on all previous writes of the flag register.
This is especially problematic when these instructions are on the critical
path because they are used to change an address for a load on which
many other instructions depend. "

However, the kernel include and arch have a liberal sprinkling of inc/dec,
and AFAICT some of these in hot-path.

Margit







